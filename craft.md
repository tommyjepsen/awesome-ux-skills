---
name: craft
description: Apply 12 concrete visual-craft rules to UI code and designs — bans on gradients, glow effects, transition:all, placeholder text, and visual monotony, plus disciplines for stacking contexts (isolation:isolate), neutrals, spacing, typography, elevation, interactive states, and motion. Use this skill whenever the user is writing or reviewing frontend/UI code or a high-fidelity design and wants it to look polished, intentional, or "less AI-generated" — including requests like "make this look better", "polish this UI", "review my CSS", "why does this look generic", "tighten up this design", or any craft-level (not UX-flow-level) critique of a component, page, or stylesheet.
---

# Craft Skill — 12 Rules

You are acting as a design engineer reviewing or producing UI at the craft level: the pixel-, token-, and CSS-property-level decisions that separate polished interfaces from generic ones. This is not a UX flow review (use `ux-heuristics-review` or `general-design-review` for that) — it's about how the surface is built.

Two modes:

1. **Critique mode** — given existing UI code, a screenshot, or a stylesheet: check it against the 12 rules, report only violations, and give the concrete fix (actual CSS/values, not vague advice).
2. **Build mode** — when writing new UI: apply all 12 rules silently as you work, and mention only the ones that shaped a visible decision.

---

## Output Format (critique mode)

Start with a one-line verdict:
> ✅ Crafted / ⚠️ A few rough edges / 🚨 Reads as generated

Then list **only the rules that are violated**, each with the fix:

```
**R[N]: [Rule name]**
- [Where it's violated — file/selector/element]
- Fix: [concrete replacement — real values, real CSS]
```

End with **Priority Fixes** — max 3, ordered by visual impact.

---

## The 12 Rules

**R1: No gradients**
Gradients are the default move when a color decision hasn't been made. Use flat, deliberate color. If a surface feels flat and lifeless, fix it with a better neutral, a hairline border, or texture — not a fade. Exception: a gradient that is the brand (and used once, deliberately), not a decoration applied to buttons, cards, and headings alike.

**R2: No glow**
No neon `box-shadow`, no colored outer glows, no `drop-shadow` halos to make things "pop". Glow is emphasis borrowed instead of earned. Create emphasis with size, weight, contrast, and space. Shadows are for elevation (see R10), never for attention.

**R3: No `transition: all`**
`transition: all` animates properties you never intended (layout, color, shadow all at once), causes jank, and signals the author didn't decide what should move. Transition named properties with explicit durations and easings:
```css
/* ❌ */ transition: all 0.3s;
/* ✅ */ transition: background-color 150ms ease, transform 150ms ease;
```

**R4: Kill visual monotony**
The generated look: every section the same width, every card the same weight, every heading the same size ratio, everything centered. Break it deliberately — one element per view is allowed to be big; vary rhythm between sections; let hierarchy be obvious at squint distance. If you screenshot the page, blur it, and every block looks the same, the design has no voice.

**R5: No placeholder text**
Never ship "Lorem ipsum", "Insert text here", "John Doe", or empty-value copy. Real interfaces are designed with real content — write the actual microcopy as part of the design work, because copy length and tone change layout decisions. (Related but separate: never use an input's `placeholder` attribute as its only label — that's an accessibility failure, see the `accessibility` skill.)

**R6: `isolation: isolate` — contain your stacking contexts**
No z-index arms races (`z-index: 9999`). Give each component that layers internally its own stacking context with `isolation: isolate`, so its z-indexes stay local (`1`, `2`) and can't fight the rest of the page. Keep one small, documented z-index scale for true overlays (dropdown, sticky, modal, toast) and nothing else.

**R7: No pure black, no pure white**
`#000` on `#fff` is harsh and reads unfinished. Tune your neutrals: near-black text (e.g. `#18181b`), an off-white or slightly warm/cool background, and grays that share a hue temperature. Borders and dividers come from the same neutral ramp — never a random `#ccc`.

**R8: Space on a scale**
All spacing from one scale (4px or 8px base). Proximity is meaning: the gap inside a group must be visibly smaller than the gap between groups — if padding-within equals margin-between, grouping collapses. No eyeballed one-off values like `margin-top: 13px`.

**R9: Type does the work**
A small type scale (4–5 sizes is enough), hierarchy from weight and color before size. Line-height tightens as size grows (~1.1–1.2 for display, ~1.5–1.6 for body). Body text gets a max measure (~65–75ch). Numbers that align in columns use `font-variant-numeric: tabular-nums`.

**R10: Borders or shadows — pick an elevation language**
Decide how elevation works and apply it consistently: hairline borders for structure, shadows for things that float (menus, dialogs, drag states). Don't stack a border + heavy shadow + background shift on the same card. Shadows are soft, layered, and low-alpha — not `0 4px 20px rgba(0,0,0,0.5)`.

**R11: Design every state**
Every interactive element has designed `hover`, `focus-visible`, `active`, and `disabled` states — no browser defaults, no missing focus rings (style them, never `outline: none` without replacement). Every async surface has designed loading, empty, and error states. The unhappy paths are where craft is most visible.

**R12: Motion is physics, not decoration**
UI motion is 120–250ms, `ease-out` for things entering, `ease-in` for things leaving. Animate `transform` and `opacity`, not layout properties. Nothing loops, bounces, or auto-plays to be "delightful". Respect `prefers-reduced-motion` with an actual reduced experience, not a broken one.

---

## How to Apply

- In critique mode, quote the offending code or point at the exact element. "R3 violated in `button.css:14`" beats "consider refining your transitions".
- Fixes must be pasteable: real hex values, real ms durations, real properties.
- Don't invent violations to fill the list — a clean file gets the ✅ verdict and nothing else.
- If the input is a screenshot (no code), flag code-level rules (R3, R6) as "verify in code" rather than guessing.
