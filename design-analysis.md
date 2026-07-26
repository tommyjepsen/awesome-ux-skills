---
name: design-analysis
description: Analyze the design of an image, screenshot, or live website and return structured data about it — typography, color palette, layout and composition, imagery, spacing, shape, and motion. Takes a screenshot automatically when given a URL, samples real pixels for exact hex values, and reads computed styles from the DOM. Use this skill whenever the user shares an image or link and asks what the design is made of: "analyze this design", "break down this landing page", "what fonts and colors is this site using", "extract the design system from this", "what's the color palette", "reverse-engineer this UI", "how is this composed", "give me the design tokens for this page", "what makes this look premium", "compare these two designs", or drops a screenshot with "thoughts on this design?". Use it before any critique skill when the design's actual properties have not been measured yet.
---

# Design Analysis

You are acting as a design forensics analyst. Given an image or a URL, your job is to **describe what the design is made of, with measured values** — not to judge it.

Extraction first, opinion second. A user who asks "what's going on in this design" wants the specimen labelled: the type scale, the exact hexes, the grid, the elevation language. If they also want a verdict, give it at the end, briefly, or hand off to a critique skill (see [Handoffs](#handoffs)).

**Never guess a hex code, a font size, or a spacing value that you could have measured.** Two scripts below do the measuring. Run them.

---

## Step 1 — Identify the input

| Input | What to do |
|---|---|
| Image file path (`.png`, `.jpg`, `.webp`, `.avif`) | Skip to Step 3, then Step 4 |
| Image pasted into the conversation | View it, then Step 4. Ask for a file path or URL if exact hexes matter — you cannot sample pixels from a pasted image |
| URL | Step 2 (capture) → Step 3 (pixels) → Step 4 (look) |
| Figma link | Use the Figma tooling if available; otherwise ask for an exported PNG |
| Local dev server / running app | Same as URL — `http://localhost:3000` works |
| Multiple inputs | Analyze each, then add a **Comparison** section that puts the dimensions side by side |

Also settle **scope** before capturing: one page, one component, or a whole flow. If the request is vague ("analyze my site"), analyze the page they gave you and say which page you analyzed.

---

## Step 2 — Capture (URL inputs)

Write this to `/tmp/design-analysis/capture.mjs` and run it. It screenshots desktop (1440×900, plus full-page) and mobile (390×844) at 2× density, and harvests computed styles — the ground truth for typography, color, spacing, shape, and motion.

```js
// Usage: node capture.mjs <url> <outdir>
import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { mkdirSync, writeFileSync } from 'node:fs';
import path from 'node:path';

// Resolve playwright from the project, then from the global npm root.
const require = createRequire(import.meta.url);
function loadPlaywright() {
  const names = ['playwright', '@playwright/test', 'playwright-core'];
  for (const n of names) { try { return require(n); } catch {} }
  let root = ''; try { root = execSync('npm root -g', { encoding: 'utf8' }).trim(); } catch {}
  for (const n of names) { try { return require(path.join(root, n)); } catch {} }
  console.error('Playwright not found. Install it with: npm i -D playwright && npx playwright install chromium');
  process.exit(2);
}
const { chromium } = loadPlaywright();

const url = process.argv[2];
const out = process.argv[3] || '.';
if (!url) { console.error('usage: node capture.mjs <url> <outdir>'); process.exit(1); }
mkdirSync(out, { recursive: true });

const browser = await chromium.launch();
const shots = [];

for (const vp of [
  { tag: 'desktop', width: 1440, height: 900 },
  { tag: 'mobile', width: 390, height: 844, mobile: true },
]) {
  const ctx = await browser.newContext({
    viewport: { width: vp.width, height: vp.height },
    deviceScaleFactor: 2,
    isMobile: !!vp.mobile,
    hasTouch: !!vp.mobile,
  });
  const page = await ctx.newPage();
  await page.goto(url, { waitUntil: 'networkidle', timeout: 60000 }).catch(() =>
    page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 }));
  await page.waitForTimeout(1200);
  // settle lazy content, then return to top
  await page.evaluate(async () => {
    for (let y = 0; y < document.body.scrollHeight; y += window.innerHeight) {
      window.scrollTo(0, y); await new Promise(r => setTimeout(r, 120));
    }
    window.scrollTo(0, 0);
  });
  await page.waitForTimeout(600);

  const fold = path.join(out, `${vp.tag}-fold.png`);
  await page.screenshot({ path: fold });
  shots.push(fold);
  if (vp.tag === 'desktop') {
    const full = path.join(out, 'desktop-full.png');
    await page.screenshot({ path: full, fullPage: true });
    shots.push(full);
    writeFileSync(path.join(out, 'styles.json'), JSON.stringify(await harvest(page), null, 2));
  }
  await ctx.close();
}
await browser.close();
console.log(JSON.stringify({ shots, styles: path.join(out, 'styles.json') }, null, 2));

async function harvest(page) {
  return page.evaluate(() => {
    const px = v => Math.round(parseFloat(v) || 0);
    // Any CSS color -> sRGB, resolved by the engine via relative color syntax.
    // Modern stylesheets compute to oklch()/lab()/color(display-p3) — shadcn is all
    // oklch — and those never match a regex on rgb(). `rgb(from X r g b)` serializes
    // to `color(srgb ...)` floats, which also exposes out-of-gamut channels.
    const probe = document.createElement('div');
    probe.style.display = 'none'; document.body.appendChild(probe);
    const srgb = v => {
      if (typeof v !== 'string') return null;
      const str = v.trim();
      if (!str || /^(none|transparent|currentcolor)$/i.test(str)) return null;
      if (/gradient|url\(|image\(/i.test(str)) return null; // not a flat color
      probe.style.color = 'rgb(1, 2, 3)';                     // sentinel
      probe.style.color = `rgb(from ${str} r g b / alpha)`;    // ignored if unparseable
      const out = getComputedStyle(probe).color;
      if (out === 'rgb(1, 2, 3)' && !/1,\s*2,\s*3|#010203/.test(str)) return null;
      let m = out.match(/color\(srgb ([-\d.e]+) ([-\d.e]+) ([-\d.e]+)(?:\s*\/\s*([\d.e]+))?\)/);
      let ch, a = 1;
      if (m) { ch = m.slice(1, 4).map(Number); if (m[4] !== undefined) a = +m[4]; }
      else {
        m = out.match(/rgba?\(([^)]+)\)/);
        if (!m) return null;
        const parts = m[1].split(/[,/ ]+/).filter(Boolean).map(Number);
        ch = parts.slice(0, 3).map(n => n / 255);
        if (parts[3] !== undefined) a = parts[3];
      }
      const outOfGamut = ch.some(n => n < -0.001 || n > 1.001);
      const bytes = ch.map(n => Math.max(0, Math.min(255, Math.round(n * 255))));
      const hex = '#' + bytes.map(n => n.toString(16).padStart(2, '0')).join('');
      return { hex, alpha: a, outOfGamut, rgb: bytes };
    };
    // Backwards-compatible string form: '#rrggbb', or '#rrggbb @ 0.5' when translucent.
    const toHex = v => {
      const c = srgb(v);
      if (!c) return v;
      return c.alpha < 1 ? `${c.hex} @ ${+c.alpha.toFixed(3)}` : c.hex;
    };
    const bump = (m, k) => k && m.set(k, (m.get(k) || 0) + 1);
    const top = (m, n = 14) => [...m.entries()].sort((a, b) => b[1] - a[1]).slice(0, n)
      .map(([value, count]) => ({ value, count }));
    // sRGB -> OKLCH (Ottosson), validated against Chromium's own relative-color
    // resolution; paste-ready as shadcn v4 token values.
    const oklch = h => {
      const m = h.match(/^#(\w\w)(\w\w)(\w\w)/); if (!m) return null;
      const [R, G, B] = m.slice(1).map(x => { const v = parseInt(x, 16) / 255;
        return v <= 0.04045 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; });
      const l_ = Math.cbrt(0.4122214708 * R + 0.5363325363 * G + 0.0514459929 * B);
      const m_ = Math.cbrt(0.2119034982 * R + 0.6806995451 * G + 0.1073969566 * B);
      const s_ = Math.cbrt(0.0883024619 * R + 0.2817188376 * G + 0.6299787005 * B);
      const L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_;
      const A = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_;
      const Bb = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_;
      const C = Math.hypot(A, Bb);
      let Hh = Math.atan2(Bb, A) * 180 / Math.PI; if (Hh < 0) Hh += 360;
      return C < 0.002 ? `oklch(${+L.toFixed(3)} 0 0)`
                       : `oklch(${+L.toFixed(3)} ${+C.toFixed(3)} ${+Hh.toFixed(1)})`;
    };
    // Keep the authored value, add sRGB hex, and add OKLCH. When the page already
    // computes to oklch() that string is used verbatim: shadcn's --destructive sits
    // outside sRGB, so re-deriving it from a clamped hex would shift the token.
    const withColor = arr => arr.map(e => {
      const c = srgb(e.value);
      if (!c) return e;
      const authored = String(e.value).trim();
      return {
        ...e,
        hex: c.alpha < 1 ? `${c.hex} @ ${+c.alpha.toFixed(3)}` : c.hex,
        oklch: /^oklch\(/i.test(authored) ? authored : oklch(c.hex),
        ...(c.outOfGamut ? { outOfGamut: true } : {}),
      };
    });

    const fonts = new Map(), sizes = new Map(), weights = new Map(), tracking = new Map();
    const fg = new Map(), bg = new Map(), border = new Map();
    const radius = new Map(), shadow = new Map(), gaps = new Map(), pads = new Map(), grids = new Map();
    const transitions = new Map(), animations = new Map();
    const type = []; // representative text runs, largest first

    const nodes = [...document.querySelectorAll('*')].filter(el => {
      const r = el.getBoundingClientRect();
      const s = getComputedStyle(el);
      return r.width > 0 && r.height > 0 && s.visibility !== 'hidden' && s.display !== 'none' && +s.opacity > 0.05;
    });

    for (const el of nodes) {
      const s = getComputedStyle(el);
      const text = [...el.childNodes].filter(n => n.nodeType === 3).map(n => n.textContent.trim()).join(' ').trim();
      if (text) {
        const fam = s.fontFamily.split(',')[0].replace(/["']/g, '').trim();
        bump(fonts, fam); bump(sizes, `${px(s.fontSize)}px`); bump(weights, s.fontWeight);
        bump(tracking, s.letterSpacing); bump(fg, s.color);
        const w = Math.round(el.getBoundingClientRect().width);
        // Widest rendered line box, not the container: a short label in a wide
        // block measures short, and a wrapped paragraph measures its real column.
        const range = document.createRange(); range.selectNodeContents(el);
        const rects = [...range.getClientRects()].filter(r => r.width > 0);
        const lineWidth = rects.length ? Math.round(Math.max(...rects.map(r => r.width))) : w;
        type.push({
          tag: el.tagName.toLowerCase(), size: px(s.fontSize), weight: +s.fontWeight,
          family: fam, lineHeight: s.lineHeight === 'normal' ? 'normal' : px(s.lineHeight),
          letterSpacing: s.letterSpacing, transform: s.textTransform, color: toHex(s.color),
          blockWidth: w, lineWidth, lines: rects.length,
          // measure in characters: ~0.5em average advance width for Latin text
          measureCh: Math.round(lineWidth / (px(s.fontSize) * 0.5)),
          sample: text.slice(0, 70),
        });
      }
      const bgc = s.backgroundColor;
      if (bgc && bgc !== 'rgba(0, 0, 0, 0)' && bgc !== 'transparent') bump(bg, bgc);
      if (s.backgroundImage !== 'none' && /gradient/.test(s.backgroundImage)) bump(bg, s.backgroundImage.slice(0, 90));
      if (px(s.borderTopWidth) > 0) bump(border, `${s.borderTopWidth} ${s.borderTopStyle} ${toHex(s.borderTopColor)}`);
      if (px(s.borderTopLeftRadius) > 0) bump(radius, s.borderTopLeftRadius);
      if (s.boxShadow !== 'none') bump(shadow, s.boxShadow);
      if (/flex|grid/.test(s.display) && s.gap !== 'normal' && px(s.gap) > 0) bump(gaps, s.gap);
      // computed grid templates resolve to px — column counts and widths, for free
      if (s.display.includes('grid') && s.gridTemplateColumns !== 'none') {
        const cols = s.gridTemplateColumns.split(' ').length;
        bump(grids, `${cols} cols: ${s.gridTemplateColumns}`);
      }
      for (const p of ['paddingTop', 'paddingLeft']) if (px(s[p]) > 0) bump(pads, `${px(s[p])}px`);
      if (s.transitionDuration !== '0s') {
        const props = s.transitionProperty.split(', '), durs = s.transitionDuration.split(', '),
              eases = s.transitionTimingFunction.split(/, (?![^(]*\))/);
        props.forEach((p, i) => bump(transitions,
          `${p} ${durs[i % durs.length]} ${eases[i % eases.length]}`));
      }
      if (s.animationName !== 'none') bump(animations, `${s.animationName} ${s.animationDuration} ${s.animationIterationCount}`);
    }

    const imgs = [...document.images].filter(i => i.width > 24 && i.height > 24).map(i => ({
      w: i.width, h: i.height, ratio: +(i.width / i.height).toFixed(2),
      alt: i.alt || null, src: /^data:/.test(i.currentSrc || i.src) ? (i.currentSrc || i.src).split(';')[0] : (i.currentSrc || i.src).slice(0, 120),
      radius: getComputedStyle(i).borderRadius, fit: getComputedStyle(i).objectFit,
    }));
    const svgs = document.querySelectorAll('svg').length;
    const videos = document.querySelectorAll('video').length;

    // container width: widest common block width among direct wrappers
    const widths = new Map();
    for (const el of nodes) {
      const r = el.getBoundingClientRect();
      if (r.width > 320 && r.width < innerWidth) bump(widths, `${Math.round(r.width)}px`);
    }

    const vars = {}, breakpoints = new Set();
    let prefersColorScheme = false;
    const walk = rules => {
      for (const r of rules) {
        if (r.style && (r.selectorText === ':root' || r.selectorText === 'html')) {
          for (const p of r.style) if (p.startsWith('--')) vars[p] = r.style.getPropertyValue(p).trim();
        }
        if (r.media) { const t = r.conditionText || r.media.mediaText;
          if (/prefers-color-scheme/.test(t)) prefersColorScheme = true;
          (t.match(/\d+(\.\d+)?(px|em|rem)/g) || []).forEach(v => breakpoints.add(v)); }
        if (r.cssRules) walk([...r.cssRules]);
      }
    };
    for (const sheet of [...document.styleSheets]) {
      try { walk([...sheet.cssRules]); } catch {}
    }
    const webfonts = [...new Set([...document.fonts].map(f =>
      `${f.family} ${f.weight} ${f.style} (${f.status})`))];
    const bodyBg = getComputedStyle(document.body).backgroundColor;

    // Is this a shadcn/ui token system? Its variable names are distinctive.
    const SHADCN = ['--background', '--foreground', '--card', '--card-foreground',
      '--popover', '--popover-foreground', '--primary', '--primary-foreground',
      '--secondary', '--secondary-foreground', '--muted', '--muted-foreground',
      '--accent', '--accent-foreground', '--destructive', '--border', '--input',
      '--ring', '--chart-1', '--chart-2', '--chart-3', '--chart-4', '--chart-5',
      '--sidebar', '--sidebar-foreground', '--sidebar-primary', '--sidebar-accent',
      '--sidebar-border', '--sidebar-ring', '--radius'];
    const matched = SHADCN.filter(v => v in vars);
    const sample = matched.map(v => vars[v]).find(Boolean) || '';
    const shadcn = {
      detected: matched.length >= 6,
      matchedTokens: matched,
      missingTokens: matched.length >= 6 ? SHADCN.filter(v => !(v in vars)) : [],
      // v4 ships raw oklch(); v3 shipped bare HSL channel triplets read via hsl(var(--x))
      valueFormat: /oklch/i.test(sample) ? 'oklch (Tailwind v4 era)'
        : /^\s*[\d.]+\s+[\d.]+%\s+[\d.]+%/.test(sample) ? 'hsl channel triplets (Tailwind v3 era)'
        : /^#/.test(sample) ? 'hex' : 'unknown',
      radius: vars['--radius'] || null,
      darkModeStrategy: document.querySelector('.dark, [data-theme="dark"]') ? 'class on element'
        : prefersColorScheme ? 'prefers-color-scheme media query' : 'not detected in this render',
    };

    return {
      page: { title: document.title, url: location.href, viewport: innerWidth + 'x' + innerHeight,
              scrollHeight: document.body.scrollHeight, folds: +(document.body.scrollHeight / innerHeight).toFixed(1),
              viewportMeta: document.querySelector('meta[name=viewport]')?.content || null },
      typography: { families: top(fonts), sizes: top(sizes, 20), weights: top(weights), letterSpacing: top(tracking, 6),
                    scale: [...new Set(type.map(t => t.size))].sort((a, b) => b - a),
                    runs: type.sort((a, b) => b.size - a.size).slice(0, 22) },
      color: { text: withColor(top(fg)), backgrounds: withColor(top(bg)), borders: top(border, 8) },
      shape: { radii: top(radius, 8), shadows: top(shadow, 6) },
      space: { gaps: top(gaps, 10), paddings: top(pads, 12), commonWidths: top(widths, 6), gridTemplates: top(grids, 8) },
      motion: { transitions: top(transitions, 10), animations: top(animations, 5) },
      media: { images: imgs.slice(0, 24), imageCount: imgs.length, svgCount: svgs, videoCount: videos },
      cssVariables: vars,
      breakpoints: [...breakpoints].sort((a, b) => parseFloat(a) - parseFloat(b)),
      webfonts,
      theme: { bodyBackground: toHex(bodyBg),
               colorScheme: getComputedStyle(document.documentElement).colorScheme || 'normal' },
      shadcn,
    };
  });
}
```

```bash
mkdir -p /tmp/design-analysis/out
node /tmp/design-analysis/capture.mjs "https://example.com" /tmp/design-analysis/out
```

**When capture fails:**

- `Playwright not found` → `npm i -D playwright && npx playwright install chromium`. On managed/sandboxed environments Chromium is often pre-installed — try `NODE_PATH=$(npm root -g)` and skip the download.
- Login wall, paywall, or bot block → say so and ask the user for a screenshot. Do not analyze the block page as if it were the design.
- Cookie banner covering the fold → note it, and use `desktop-full.png` for the layout read.
- `403`/`407`/tunnel errors → egress is blocked by policy. Report the blocked host; do not work around it.
- Page needs auth → ask whether they can export a screenshot instead.

---

## Step 3 — Sample the pixels

Computed styles tell you what the CSS *says*. Pixels tell you what the design *is* — actual area shares, whitespace, and visual balance. This script also handles plain image inputs, where pixels are all you have.

Write to `/tmp/design-analysis/palette.mjs`. It decodes through Chromium, so it needs no image libraries and reads PNG/JPEG/WebP/AVIF/GIF/SVG.

```js
// Usage: node palette.mjs <image> [maxColors]
// Prints JSON: palette (hex + area share + role), color summary, composition metrics.
import { createRequire } from 'node:module';
import { execSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import path from 'node:path';

const require = createRequire(import.meta.url);
function loadPlaywright() {
  const names = ['playwright', '@playwright/test', 'playwright-core'];
  for (const n of names) { try { return require(n); } catch {} }
  let root = ''; try { root = execSync('npm root -g', { encoding: 'utf8' }).trim(); } catch {}
  for (const n of names) { try { return require(path.join(root, n)); } catch {} }
  console.error('Playwright not found: npm i -D playwright && npx playwright install chromium');
  process.exit(2);
}
const { chromium } = loadPlaywright();

const file = process.argv[2];
const maxColors = +(process.argv[3] || 10);
if (!file) { console.error('usage: node palette.mjs <image> [maxColors]'); process.exit(1); }
const ext = path.extname(file).slice(1).toLowerCase();
const mime = { png: 'image/png', jpg: 'image/jpeg', jpeg: 'image/jpeg', webp: 'image/webp',
               gif: 'image/gif', avif: 'image/avif', svg: 'image/svg+xml' }[ext] || 'image/png';
const dataUri = `data:${mime};base64,${readFileSync(file).toString('base64')}`;

const browser = await chromium.launch();
const page = await browser.newPage();
const result = await page.evaluate(async ({ dataUri, maxColors }) => {
  const img = new Image(); img.src = dataUri; await img.decode();
  const W = Math.min(img.naturalWidth, 1200);
  const H = Math.max(1, Math.round(img.naturalHeight * (W / img.naturalWidth)));
  const c = document.createElement('canvas'); c.width = W; c.height = H;
  const ctx = c.getContext('2d', { willReadFrequently: true });
  ctx.drawImage(img, 0, 0, W, H);
  const { data } = ctx.getImageData(0, 0, W, H);
  const at = (x, y) => { const i = 4 * (y * W + x); return [data[i], data[i + 1], data[i + 2]]; };

  const hex = ([r, g, b]) => '#' + [r, g, b].map(v => v.toString(16).padStart(2, '0')).join('');
  const lin = v => { v /= 255; return v <= 0.03928 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; };
  const lum = ([r, g, b]) => 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b);
  const contrast = (a, b) => { const [x, y] = [lum(a), lum(b)].sort((p, q) => q - p); return +((x + 0.05) / (y + 0.05)).toFixed(2); };
  const hsl = ([r, g, b]) => {
    const R = r / 255, G = g / 255, B = b / 255;
    const mx = Math.max(R, G, B), mn = Math.min(R, G, B), d = mx - mn, l = (mx + mn) / 2;
    let h = 0, s = 0;
    if (d) { s = d / (1 - Math.abs(2 * l - 1));
      h = mx === R ? ((G - B) / d) % 6 : mx === G ? (B - R) / d + 2 : (R - G) / d + 4;
      h = Math.round(h * 60); if (h < 0) h += 360; }
    return { h, s: Math.round(s * 100), l: Math.round(l * 100) };
  };
  // sRGB -> OKLCH (Ottosson). Validated against Chromium's own
  // `oklch(from <color> l c h)` over 400 random colors: L and C agree to
  // <0.0001, hue to <0.2 deg above C=0.01 (below that hue is meaningless and
  // can differ ~0.5 deg). Paste-ready as shadcn v4 token values.
  const oklch = ([r, g, b]) => {
    const f = v => { v /= 255; return v <= 0.04045 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4; };
    const [R, G, B] = [f(r), f(g), f(b)];
    const l_ = Math.cbrt(0.4122214708 * R + 0.5363325363 * G + 0.0514459929 * B);
    const m_ = Math.cbrt(0.2119034982 * R + 0.6806995451 * G + 0.1073969566 * B);
    const s_ = Math.cbrt(0.0883024619 * R + 0.2817188376 * G + 0.6299787005 * B);
    const L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_;
    const A = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_;
    const Bb = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_;
    const C = Math.hypot(A, Bb);
    let H = Math.atan2(Bb, A) * 180 / Math.PI; if (H < 0) H += 360;
    // shadcn writes achromatic colors as `oklch(1 0 0)` — hue is meaningless at C≈0
    return C < 0.002 ? `oklch(${+L.toFixed(3)} 0 0)`
                     : `oklch(${+L.toFixed(3)} ${+C.toFixed(3)} ${+H.toFixed(1)})`;
  };
  // chroma = max-min in 0-255. Robust "is this actually colorful" test at any lightness.
  const chroma = ([r, g, b]) => Math.max(r, g, b) - Math.min(r, g, b);
  const temp = h => (h >= 15 && h < 75) ? 'warm' : (h >= 75 && h < 165) ? 'green'
    : (h >= 165 && h < 255) ? 'cool' : (h >= 255 && h < 315) ? 'violet' : 'red';
  const role = rgb => {
    const ch = chroma(rgb), { l } = hsl(rgb);
    if (ch < 10) return l > 92 ? 'near-white' : l < 12 ? 'near-black' : 'neutral';
    if (ch < 26) return l > 90 ? 'tinted-white' : l < 18 ? 'tinted-black' : 'muted';
    if (ch < 90) return 'chromatic';
    return l > 45 ? 'vivid' : 'deep';
  };

  const hist = new Map();
  let total = 0, sumL = 0, sumC = 0;
  const bands = new Array(10).fill(0);
  for (let i = 0; i < data.length; i += 4) {
    if (data[i + 3] < 128) continue;
    const rgb = [data[i], data[i + 1], data[i + 2]];
    const k = ((rgb[0] >> 3) << 10) | ((rgb[1] >> 3) << 5) | (rgb[2] >> 3);
    const e = hist.get(k) || [0, 0, 0, 0];
    e[0] += rgb[0]; e[1] += rgb[1]; e[2] += rgb[2]; e[3]++;
    hist.set(k, e);
    const { l } = hsl(rgb);
    sumL += l; sumC += chroma(rgb); bands[Math.min(9, Math.floor(l / 10))]++; total++;
  }
  const dist = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1], a[2] - b[2]);
  const merged = [];
  for (const [r, g, b, n] of [...hist.values()].sort((a, b) => b[3] - a[3])) {
    const rgb = [Math.round(r / n), Math.round(g / n), Math.round(b / n)];
    const near = merged.find(m => dist(m.rgb, rgb) < 40);
    if (near) { near.n += n; continue; }
    merged.push({ rgb, n });
    if (merged.length >= 64) break;
  }
  merged.sort((a, b) => b.n - a.n);
  const palette = merged.slice(0, maxColors).map(m => {
    const { h, s, l } = hsl(m.rgb);
    return { hex: hex(m.rgb), hsl: `hsl(${h} ${s}% ${l}%)`, oklch: oklch(m.rgb),
             share: +(100 * m.n / total).toFixed(1),
             chroma: chroma(m.rgb), role: role(m.rgb), temperature: chroma(m.rgb) < 6 ? 'achromatic' : temp(h) };
  });
  const dominant = merged[0].rgb;
  const accents = palette.filter(p => p.chroma >= 26);

  const pairs = [];
  for (let i = 0; i < palette.length; i++) for (let j = i + 1; j < palette.length; j++) {
    const A = palette[i].hex.match(/\w\w/g).map(x => parseInt(x, 16));
    const B = palette[j].hex.match(/\w\w/g).map(x => parseInt(x, 16));
    pairs.push({ pair: `${palette[i].hex} on ${palette[j].hex}`, ratio: contrast(A, B) });
  }

  // ---- composition: where is the ink? ----
  // Threshold stays tight: on a dark UI, panel surfaces sit only ~20 away from
  // the page background, and a loose threshold counts every panel as empty field.
  const isBg = rgb => dist(rgb, dominant) < 12;
  const grey = ([r, g, b]) => (r + g + b) / 3;
  let ink = 0, edges = 0;
  const ROWS = 24, COLS = 24;
  const rowInk = new Array(ROWS).fill(0), colInk = new Array(COLS).fill(0);
  const step = Math.max(1, Math.round(Math.min(W, H) / 400));
  let sampled = 0;
  for (let y = 0; y < H; y += step) for (let x = 0; x < W; x += step) {
    const rgb = at(x, y); sampled++;
    if (!isBg(rgb)) { ink++; rowInk[Math.min(ROWS - 1, Math.floor(ROWS * y / H))]++; colInk[Math.min(COLS - 1, Math.floor(COLS * x / W))]++; }
    // local gradient: detail density, independent of which color is the background
    const g0 = grey(rgb);
    if (x + step < W && Math.abs(g0 - grey(at(x + step, y))) > 12) edges++;
    else if (y + step < H && Math.abs(g0 - grey(at(x, y + step))) > 12) edges++;
  }
  const norm = a => { const mx = Math.max(...a) || 1; return a.map(v => +(v / mx).toFixed(2)); };
  const grid = [];
  for (let gy = 0; gy < 3; gy++) { const row = [];
    for (let gx = 0; gx < 3; gx++) {
      const h2 = new Map();
      for (let y = Math.floor(gy * H / 3); y < (gy + 1) * H / 3; y += step)
        for (let x = Math.floor(gx * W / 3); x < (gx + 1) * W / 3; x += step) {
          const rgb = at(x, y); const k = ((rgb[0] >> 4) << 8) | ((rgb[1] >> 4) << 4) | (rgb[2] >> 4);
          const e = h2.get(k) || [0, 0, 0, 0]; e[0] += rgb[0]; e[1] += rgb[1]; e[2] += rgb[2]; e[3]++; h2.set(k, e);
        }
      const [r, g, b, n] = [...h2.values()].sort((p, q) => q[3] - p[3])[0];
      row.push(hex([Math.round(r / n), Math.round(g / n), Math.round(b / n)]));
    }
    grid.push(row); }
  const colN = norm(colInk), rowN = norm(rowInk);
  const centroid = a => { const t = a.reduce((x, y) => x + y, 0) || 1;
    return +(a.reduce((x, v, i) => x + v * (i + 0.5) / a.length, 0) / t).toFixed(2); };
  const mirror = a => { const rev = [...a].reverse();
    return +(1 - a.reduce((x, v, i) => x + Math.abs(v - rev[i]), 0) / a.length).toFixed(2); };

  return {
    source: { file: 'see argv', width: img.naturalWidth, height: img.naturalHeight, sampled: `${W}x${H}`,
              aspect: +(img.naturalWidth / img.naturalHeight).toFixed(2) },
    palette,
    color: {
      key: (sumL / total) > 62 ? 'light' : (sumL / total) < 38 ? 'dark' : 'mid',
      averageLightness: Math.round(sumL / total),
      averageChroma: Math.round(sumC / total),
      neutralShare: +palette.filter(p => p.chroma < 26).reduce((a, p) => a + p.share, 0).toFixed(1),
      accentShare: +accents.reduce((a, p) => a + p.share, 0).toFixed(1),
      accentHexes: accents.map(p => p.hex),
      temperatures: [...new Set(palette.filter(p => p.chroma >= 6).map(p => p.temperature))],
      lightnessDeciles: bands.map(b => +(100 * b / total).toFixed(1)),
      dominant: hex(dominant),
    },
    contrastPairs: pairs.sort((a, b) => b.ratio - a.ratio).slice(0, 8),
    composition: {
      inkCoverage: +(100 * ink / sampled).toFixed(1),
      backgroundShare: +(100 - 100 * ink / sampled).toFixed(1),
      edgeDensity: +(100 * edges / sampled).toFixed(1),
      rowDensity: rowN,
      colDensity: colN,
      horizontalCentroid: centroid(colInk),
      verticalCentroid: centroid(rowInk),
      mirrorSymmetry: mirror(colN),
      balance: (() => { const c = centroid(colInk);
        return c < 0.45 ? 'weighted left' : c > 0.55 ? 'weighted right' : 'horizontally centered'; })(),
      gridDominantColors: grid,
    },
  };
}, { dataUri, maxColors });
result.source.file = file;
await browser.close();
console.log(JSON.stringify(result, null, 2));
```

```bash
node /tmp/design-analysis/palette.mjs /tmp/design-analysis/out/desktop-fold.png 10
```

Run it on the **fold** shot for the palette that greets a visitor, and on the **full-page** shot for the palette of the whole page. On a plain image input, run it on the image.

**How to read the composition numbers:**

| Field | Meaning |
|---|---|
| `inkCoverage` / `backgroundShare` | Share of pixels that differ from / match the dominant background color. Measured reference points: an airy marketing page ≈ 17% ink, a panelled dashboard ≈ 32%, a full-bleed photograph ≈ 70%. On a light page `backgroundShare` is roughly whitespace; on a dark UI it is the field the panels sit on, which is not the same thing — don't call it whitespace there |
| `edgeDensity` | Share of pixels on a hard tonal edge. This is a *detail* measure, not a fullness measure: text-heavy layouts and textured photography push it up, while large flat fields keep it low even when the screen is packed. A dense dashboard of flat panels can score below an airy marketing page. Use it to separate "detailed" from "flat", and `inkCoverage` to separate "full" from "empty" |
| `rowDensity` | 24 horizontal bands, normalized. Zeros are breathing room; runs of high values are content blocks. This is the page's vertical rhythm |
| `colDensity` | 24 vertical bands. Peaks are content columns; flat edges are margins |
| `horizontalCentroid` | 0.5 = visual weight centered, <0.45 left, >0.55 right |
| `mirrorSymmetry` | 1.0 = perfectly mirrored layout, below ~0.7 = deliberately asymmetric |
| `gridDominantColors` | Dominant color per third — catches dark bands, split-screen layouts, colored hero blocks |
| `lightnessDeciles` | Tonal distribution. A spike in the top decile means a light UI on white; two spikes means a hard light/dark split |

---

## Step 4 — Look at the image

**Always view the screenshot yourself before writing the report.** The JSON knows every font size on the page but cannot see that the H1 is competing with a badge, that the eye lands on the illustration first, or that the layout is a two-column split. Numbers plus eyes; neither alone.

Read the images in this order: `desktop-fold.png` (what a visitor meets), `desktop-full.png` (structure and rhythm), `mobile-fold.png` (what survives the squeeze).

Squint test: blur the page in your mind's eye. What is still legible is the real hierarchy — compare it against the type scale in the JSON. When the largest type is not the strongest visual element, say what is winning instead (a photo, a colored block, a bright button).

---

## The eight dimensions

Report on these. Skip a dimension when the input genuinely has nothing to say about it (a logo has no motion), and never pad a section to look complete.

### 1. Typography

- **Families and roles**: which face for display, body, UI, mono. Classify each: geometric sans, grotesque, humanist sans, transitional/old-style serif, didone, slab, mono, script, display. Name the actual family from `typography.families` and `webfonts` — and flag when the rendered family is a system fallback rather than the intended webfont (a `(unloaded)` status or a bare `Arial`/`Helvetica` on a designed page is the tell).
- **Scale**: list the sizes actually used, largest to smallest, and the ratio between steps (`64 / 40 / 24 / 16` ≈ 1.5–1.6, a major-third-ish scale). Say whether it is a tight scale (3–5 steps, disciplined) or sprawling (12 near-duplicate sizes, no system).
- **Weights**: how many, and how hierarchy is carried — by weight, size, color, or case.
- **Line height and measure**: line-height ratios per level (display ~1.0–1.2, body ~1.4–1.6) and the body measure from `runs[].measureCh` (~45–75ch is comfortable; over ~90ch is a wall). `measureCh` comes from the widest rendered line box, so a short label in a wide container reads short and a wrapped paragraph reads its true column; it assumes a 0.5em average advance, so treat it as ±10%. `runs[].lines` tells you how many line boxes a run occupies — a display headline wrapping to three lines is a layout fact worth reporting.
- **Tracking and case**: negative tracking on display type, positive tracking on small caps/eyebrows, `text-transform: uppercase` usage.
- **Pairing logic**: does the pairing contrast on classification (serif display + sans UI) or vary within one family? Is it a single-family system?

### 2. Color

- **Palette with roles**, using measured hexes: page background, surface/card, ink (primary text), muted text, border/hairline, primary accent, secondary accent, semantic (success/warning/danger). Every measured color carries an `oklch` value too, so the palette can be emitted as design tokens without hand conversion — see [Aligning to shadcn/ui tokens](#aligning-to-shadcnui-tokens). If `styles.json` reports `shadcn.detected`, name the system and read its tokens rather than inferring roles.
- **Area shares** from `palette[].share` — this is what separates "a green brand" from "a white page with a green button." Report the accent share explicitly.
- **Key and temperature**: light / mid / dark, warm / cool / neutral, and whether the neutrals are tinted (a warm off-white and warm grays is a deliberate choice worth naming).
- **Harmony**: monochrome, analogous, complementary, split-complementary, triadic, or neutral-plus-one-accent (the most common product-design answer).
- **Saturation strategy**: `averageChroma` plus whether accents are vivid or desaturated.
- **Contrast**: use `contrastPairs` for the real ratios of the dominant pairings, and name any body-text pairing under 4.5:1 or large-text pairing under 3:1. Keep it to a flag, not a full audit — hand off to the `accessibility` skill for that.
- **Gradients**: whether present, and whether they are brand-level or applied decoratively to buttons and cards.

### 3. Layout and composition

- **Container and grid**: content width from `space.commonWidths`, column structure from `space.gridTemplates` (computed styles resolve `repeat(4, 1fr)` to real px widths, so this gives both the count and the ratio — a `216px 1128px` template is a sidebar shell, `4 cols: 273px 273px 273px 273px` is a KPI row), gutters from `space.gaps`.
- **Structure**: the fold's anatomy (nav / eyebrow / headline / support / CTA / media) and the page's section sequence from `rowDensity`.
- **Alignment and balance**: left-aligned vs centered, `horizontalCentroid`, `mirrorSymmetry`, and whether asymmetry looks intentional.
- **Density and rhythm**: `inkCoverage`, section padding values, whether the vertical rhythm alternates (dense/airy) or repeats identically.
- **Focal path**: the order a viewer's eye takes, and what earns first fixation. Say what creates it — scale, isolation, color, or a face/direction in the imagery.
- **Fold economics**: what is above 900px, `page.folds` for total scroll depth.
- **Responsive behavior**: what changes between desktop and mobile — reflow, hidden elements, type scaling — and the `breakpoints` list. If `page.viewportMeta` is null, the mobile screenshot is a scaled desktop layout, not a mobile design; say so.

### 4. Imagery and media

- **Type**: photography, 3D render, vector illustration, product screenshot, screenshot-in-device-frame, abstract gradient/mesh, iconography, video, or none.
- **Treatment**: crop and aspect ratios from `media.images[].ratio`, corner radius, `object-fit`, duotone or color grading, cutout vs full-bleed vs contained, drop shadows, masks.
- **Subject and role**: does the imagery show the product, the user, a metaphor, or decoration? Does it carry information or fill space?
- **Text/image balance**: image count vs text volume; whether images anchor sections or interrupt them.
- **Iconography**: `svgCount`, stroke vs filled, corner and stroke weight consistency, whether icons share the type's weight.
- **Alt text**: how many images have real alt text (`media.images[].alt`) — a content-quality signal even in a design read.

### 5. Space and scale

- **Base unit**: infer from `space.gaps` and `space.paddings` — a clean 4/8px system shows up as clustered multiples; one-off values like `13px` and `27px` mean it was eyeballed.
- **Scale in use**: the actual ladder (`8 / 16 / 24 / 32 / 48 / 64 / 96`).
- **Inner vs outer**: component padding against section spacing. Grouping only reads when the gap inside a group is visibly smaller than the gap between groups.
- **Section rhythm**: vertical padding per section and whether it is consistent.

### 6. Shape, depth, and texture

- **Radii**: the values from `shape.radii` and whether they form a scale (`6 / 12 / 999`) or a scatter. Sharp, soft, or pill.
- **Elevation language**: hairline borders, shadows, both, or flat. Read `shape.shadows` — soft low-alpha layered shadows read as craft; a single `0 4px 20px rgba(0,0,0,0.5)` reads as a default.
- **Borders**: widths, colors, whether hairlines come from one neutral ramp.
- **Texture**: noise, grain, paper, blur/glass (`backdrop-filter`), patterns, or completely flat.

### 7. Motion (URL inputs)

From `motion`: which properties transition, durations, easings, and any keyframe animations with iteration counts. Note whether durations cluster in the 120–250ms UI range, whether `transition: all` appears (an intent smell), whether anything loops infinitely, and whether transitions animate `transform`/`opacity` or layout properties.

### 8. Voice and content design

Brief, from the text you can see: headline length and whether it makes a claim or a category statement, reading level, CTA label specificity ("Start a trial" vs "Submit"), sentence case vs Title Case, use of numbers and proof, and any placeholder text still in place. Design and copy set the tone together; a typography read that ignores the words is half a read.

---

## Output format

Structure the report like this. Lead with the signature so the user gets the gist in one line.

```markdown
## Design analysis — [what was analyzed]

**Style signature**: [one sentence — e.g. "Editorial serif display over a warm off-white,
neutral-plus-one-green palette, generous 12-column whitespace, no decoration."]

**Genre**: [e.g. Swiss/editorial · brutalist · neo-brutalist · glassmorphic · corporate SaaS ·
consumer playful · luxury minimal · developer/technical · retro/nostalgic · maximalist]

| Dimension | Reading |
|---|---|
| Typography | Georgia display + Helvetica UI · 8-step scale · 400/600 only |
| Color | Light key, warm neutrals, one green accent at 11% area |
| Layout | 1120px container · 3-col cards · centered · 83% whitespace |
| Imagery | One vector illustration, 16px radius, contained |
| Space | 8px base · 24/32/48/64/96 ladder |
| Shape/depth | 12px radius, hairline borders, one 1px shadow |
| Motion | 160ms ease on background-color and transform |

### Typography
[measured detail — sizes, weights, line heights, measure, classification]

### Color
[palette table: hex · role · share · contrast notes]

### Layout & composition
[grid, focal path, rhythm, responsive behavior]

### Imagery & media
### Space & scale
### Shape, depth & texture
### Motion
### Voice & content design

### Design tokens
[JSON or CSS custom properties — see below]

### What makes it work / what's inconsistent
[Max 3 bullets each. Observations, not a full critique.]

### Confidence & limits
[What was measured vs inferred; what the input couldn't show]
```

**Palette tables** should carry the hex, a swatch-friendly role name, the area share, and the source (sampled vs computed style):

| Hex | Role | Share | Source |
|---|---|---|---|
| `#fbfaf7` | Page background (warm off-white) | 69.5% | sampled |
| `#16211c` | Ink (green-tinted near-black) | 0.5% | computed |
| `#2f6f4e` | Primary accent | 10.1% | both |

### Design tokens

Close with a paste-ready token block when the user is likely to rebuild something — always for "extract the design system", "give me the tokens", or "recreate this". Only include values you measured.

```css
:root {
  --color-bg: #fbfaf7;
  --color-surface: #ffffff;
  --color-ink: #16211c;
  --color-muted: #6b7a72;
  --color-border: #e4e2dc;
  --color-accent: #2f6f4e;

  --font-display: Georgia, serif;
  --font-ui: Helvetica, Arial, sans-serif;
  --text-display: 64px/1.05;
  --text-h2: 40px/1.15;
  --text-lede: 20px/1.6;
  --text-body: 15px/1.6;
  --text-meta: 13px/1.4;

  --space-1: 8px;  --space-2: 16px; --space-3: 24px;
  --space-4: 32px; --space-6: 48px; --space-8: 64px;

  --radius-md: 12px;
  --radius-lg: 16px;
  --shadow-sm: 0 1px 2px rgb(22 33 28 / 0.12);
  --container: 1120px;
  --ease-ui: 160ms ease;
}
```

If the page exposes its own `cssVariables`, report those instead of inventing names — the author's token names are better evidence than yours.

---

## Aligning to shadcn/ui tokens

shadcn/ui is the most common destination for extracted color data, so when the user's project uses it — or they ask for shadcn tokens, Tailwind theme values, or "drop this into my app" — emit its token contract rather than invented names.

**First, check whether you're already looking at shadcn.** `styles.json` carries a `shadcn` block: `detected` (six or more of its distinctive variable names present), `matchedTokens`, `missingTokens`, `valueFormat`, `radius`, and `darkModeStrategy`. When it reports `detected: true`, the page's own values are the answer — read them out of `cssVariables` instead of inferring anything. `valueFormat` tells you which era you're in:

| `valueFormat` | Era | Values look like | Consumed as |
|---|---|---|---|
| `oklch (Tailwind v4 era)` | Current | `--primary: oklch(0.205 0 0)` | `bg-primary` via `@theme inline` |
| `hsl channel triplets (Tailwind v3 era)` | Legacy | `--primary: 0 0% 9%` | `hsl(var(--primary))` in `tailwind.config` |

**Inside a repo, read the project's own setup before generating anything**: `components.json` (style, baseColor, `cssVariables` true/false), and the CSS file it points at (`app/globals.css` or `src/index.css`). Match the format and the exact token set already there. Never introduce a token the project doesn't use, and never rename one it does.

### Role → token mapping

| Measured role | shadcn token |
|---|---|
| Page background | `--background` |
| Primary text / ink | `--foreground` |
| Card and panel surface | `--card` + `--card-foreground` |
| Menu, dialog, tooltip surface | `--popover` + `--popover-foreground` |
| Primary action fill — **the brand color** | `--primary` + `--primary-foreground` |
| Low-emphasis button fill | `--secondary` + `--secondary-foreground` |
| Subtle fill (badges, wells) / secondary text | `--muted` / `--muted-foreground` |
| Hover and active tint on rows and items | `--accent` + `--accent-foreground` |
| Error, delete, danger | `--destructive` |
| Hairlines and dividers | `--border` |
| Form control border | `--input` |
| Focus ring | `--ring` |
| Data-viz series | `--chart-1` … `--chart-5` |
| Nav or sidebar shell | `--sidebar`, `--sidebar-foreground`, `--sidebar-primary`, `--sidebar-accent`, `--sidebar-border`, `--sidebar-ring` |
| Corner radius base | `--radius` |

**The trap worth naming: `--accent` is not the brand accent.** In shadcn's defaults it is a neutral hover tint — the same near-grey as `--muted` and `--secondary`. A design's brand color belongs in `--primary`. Mapping a vivid brand hue to `--accent` turns every hover state into a flood of brand color. When you report a "primary accent" from the palette, say explicitly that it maps to `--primary`.

Since shadcn's stock `--primary` is near-black, any brand-colored design must override both `--primary` and `--primary-foreground`, and check the pair's contrast.

### Emitting the theme

Give both blocks, using measured values. Light mode from the design as captured; dark mode only if you actually captured a dark variant — otherwise say the dark block is derived, not measured, and mark it as a starting point.

```css
:root {
  --radius: 0.625rem;

  --background: oklch(0.985 0.004 91.4);   /* #fbfaf7 measured */
  --foreground: oklch(0.235 0.018 165.2);  /* #16211c */
  --card: oklch(1 0 0);
  --card-foreground: oklch(0.235 0.018 165.2);
  --popover: oklch(1 0 0);
  --popover-foreground: oklch(0.235 0.018 165.2);
  --primary: oklch(0.49 0.085 158.4);      /* #2f6f4e — the brand green */
  --primary-foreground: oklch(0.985 0.004 91.4);
  --secondary: oklch(0.97 0 0);
  --secondary-foreground: oklch(0.235 0.018 165.2);
  --muted: oklch(0.97 0 0);
  --muted-foreground: oklch(0.565 0.022 162.4); /* #6b7a72 */
  --accent: oklch(0.97 0 0);               /* neutral hover tint, not the brand */
  --accent-foreground: oklch(0.235 0.018 165.2);
  --destructive: oklch(0.577 0.245 27.325);
  --border: oklch(0.913 0.008 91.5);       /* #e4e2dc */
  --input: oklch(0.913 0.008 91.5);
  --ring: oklch(0.49 0.085 158.4);
  --chart-1: oklch(0.49 0.085 158.4);
  --chart-2: oklch(0.712 0.124 61.6);      /* #d98f4a */
}

.dark {
  --background: oklch(0.145 0 0);
  --foreground: oklch(0.985 0 0);
  --card: oklch(0.205 0 0);
  --primary: oklch(0.62 0.11 158);         /* lifted for contrast on dark */
  --primary-foreground: oklch(0.205 0 0);
  --border: oklch(1 0 0 / 10%);            /* shadcn's dark convention */
  --input: oklch(1 0 0 / 15%);
}
```

Four conventions to respect, all taken from shadcn's own theme rather than guessed:

1. **Radius derives by multiplication.** The CLI writes `--radius-sm: calc(var(--radius) * 0.6)`, `md: * 0.8`, `lg: var(--radius)`, `xl: * 1.4`, then `2xl: * 1.8`, `3xl: * 2.2`, `4xl: * 2.6`. So pick `--radius` from the measured radius the design uses most for cards, and check the multipliers reproduce the smaller ones. Worked example: measured radii of `10px` and `8px` are exactly `--radius: 0.625rem` (10px) with `md` at 8px — one base value reproduces both.
2. **Dark borders are translucent white**, `oklch(1 0 0 / 10%)` for `--border` and `/ 15%` for `--input`, not a solid grey. The harvest reports these as `#ffffff @ 0.1`.
3. **Every `*-foreground` is a contrast promise.** Check each pair against its surface with `contrastPairs` and state the ratio for `--primary-foreground` on `--primary` at minimum. Below 4.5:1 for body text, adjust the foreground rather than shipping the pair.
4. **`--chart-1` … `--chart-5` are a categorical ramp**, not five shades of one hue. Feed them from the design's distinct accents, and if the design has fewer than five, say so rather than inventing three more.

For a legacy v3 project, the same values become bare HSL channel triplets — `--primary: 149 41% 31%;` for `#2f6f4e` — consumed as `hsl(var(--primary))`, with radius derived as `calc(var(--radius) - 2px)` and `- 4px`. Use the `hsl` field in the palette output, dropping the `hsl(` wrapper.

### The gamut caveat

Authored OKLCH can sit outside sRGB: shadcn's own `--destructive: oklch(0.577 0.245 27.325)` has a negative green channel and rasterizes to `#e7000b`. The harvest flags these with `outOfGamut: true` and keeps the authored string verbatim in the `oklch` field, because re-deriving it from the clamped hex would shift the token.

So the two sources answer different questions, and you should say which you used:

- **`styles.json` colors** are the authored tokens — correct for reproducing a theme.
- **`palette.json` colors** are sampled pixels, already clamped to sRGB — correct for what users actually see, and the only option for image inputs.

---

## Modes

| User asks | Do this |
|---|---|
| "What colors is this using?" | Palette only. Run Step 3, skip the rest. Two minutes, not twenty |
| "Analyze this design" | Full eight-dimension report |
| "Extract the design system" / "recreate this" | Full report, weighted to tokens and the type/space scales |
| "Give me shadcn tokens" / project uses shadcn | Measure, then map roles to the shadcn contract and emit `:root` + `.dark` in the project's existing format |
| "Compare these two" | Analyze both, then one comparison table per dimension and a note on where they diverge in strategy, not just values |
| "What makes this look expensive/cheap?" | Full capture, but write it as the 3–5 properties driving that read: type discipline, neutral tuning, whitespace, restraint in accent share, elevation consistency |
| "Is this design good?" | Measure first, then hand off to a critique skill — see Handoffs |

## Accuracy rules

1. **Measured beats eyeballed.** If a script produced the value, use the script's value. If you inferred it, mark it `(inferred)`.
2. **Never fabricate a hex.** For pasted images you cannot sample, describe the color in words ("desaturated forest green") and say an exact value needs a file or URL.
3. **Computed font ≠ intended font.** `typography.families` shows the first family in the stack, which may not be what rendered. Cross-check `webfonts` for load status.
4. **Counts are element counts, not visual weight.** A color used on one element can dominate the page; area share is the honest measure.
5. **Pixel palettes include photography.** A photo's colors show up in the palette alongside UI colors. Separate them: compare palette hexes against `color.backgrounds`/`color.text` from the DOM, and attribute the leftovers to imagery.
6. **Full-page shots skew shares** toward the longest section. Report which screenshot each number came from.
7. **One viewport is not responsive behavior.** Do not describe how a design adapts unless you captured both viewports.
8. **Authored is not always rendered.** Wide-gamut tokens (`oklch`, `lab`, `display-p3`) can fall outside sRGB; the harvest marks these `outOfGamut: true`. Quote the authored value when reproducing a theme and the sampled value when describing what users see — and say which one you used.
9. **Say what you could not see**: hover and focus states, dark mode, logged-in views, keyboard behavior, real content variation, animation on scroll. Screenshots are a still of one state.

## Handoffs

This skill describes. When the user wants judgment, continue into the right lens:

- `craft` — pixel- and CSS-level polish: gradients, glow, `transition: all`, elevation discipline
- `accessibility` — real WCAG audit of contrast, focus, targets, semantics
- `general-design-review` — combined UX, product, and AI review
- `cognitive-load-conversion` — the design is measured but the page is not converting
- `dieter-rams-principles`, `ux-heuristics-review`, `persuasive-ux` — specific critique frameworks

Say which handoff you recommend and why, in one line. Do not run a full critique unasked.
