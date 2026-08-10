# Awesome UX Skills for Claude Code

A collection of UX and AI product design skills for [Claude Code](https://claude.ai/code). Install them and Claude will automatically apply the right framework when you ask design-related questions.

## Install

```bash
git clone https://github.com/tommyjepsen/awesome-ux-skills
cd awesome-ux-skills
./install.sh
```

Then restart Claude Code (or reload the window). That's it.

Re-install or update existing skills:

```bash
./install.sh --force
```

## Skills

### UX Research & Strategy

| Skill | What it does |
|---|---|
| `ux-research-methods` | Recommends the right research method (interviews, usability tests, surveys, A/B tests…) for the stage and question |
| `ux-personas` | Turns interview notes, surveys, or segments into structured, research-based personas |
| `empathy-mapping` | Creates Says / Thinks / Does / Feels maps from qualitative research |
| `journey-mapping` | Maps user actions, emotions, and pain points across a timeline |
| `ux-storyboard` | Visualizes a user scenario as a panel-by-panel storyboard |
| `double-diamond` | Guides teams through Discover → Define → Develop → Deliver |
| `like-wish-what-if` | Structures critique and retrospectives with the d.school's "I like, I wish, What if" feedback framework |

### UI Analysis & Improvement

| Skill | What it does |
|---|---|
| `design-analysis` | Screenshots a URL (or takes an image) and returns measured design data: typography, palette with area shares (hex + OKLCH), composition, imagery, spacing, shape, motion — then emits it as shadcn/ui tokens |
| `general-design-review` | Runs a compact UX, product, and AI design review across the existing frameworks |
| `accessibility` | Reviews screenshots, mockups, and flows against WCAG 2.1 accessibility guidelines |
| `ux-heuristics-review` | Audits any UI against Nielsen's 10 Usability Heuristics |
| `dieter-rams-principles` | Evaluates a digital product against Dieter Rams' 10 Principles of Good Design (honest, useful, as little design as possible…) |
| `craft` | Checks UI code and designs against 12 visual-craft rules: no gradients, no glow, no `transition: all`, no placeholder text, contained stacking contexts, and more |
| `cognitive-load-conversion` | Finds extraneous load in forms, flows, and layouts — and cuts it |
| `persuasive-ux` | Applies Fogg's 7 Persuasive Technology tools to improve engagement and conversion |
| `feature-prioritization` | Ranks features or backlog items using a weighted 2D prioritization matrix |
| `low-effort-high-reward` | Sorts a list of things to do into a low / medium / high effort vs. reward grid, using the codebase it's run in to judge the real effort |

### AI Product Design

| Skill | What it does |
|---|---|
| `ai-governors` | Designs human-in-the-loop patterns: action plans, verification, undo, cost estimates, memory, citations |
| `ai-identifiers` | Defines the brand identity of an AI: name, avatar, color, iconography, personality |
| `ai-inputs` | Picks and implements the right input pattern for AI (open text, madlibs, autofill, voice, templates…) |
| `ai-trust-builders` | Adds trust signals: caveats, consent, data ownership, disclosure, watermarks, footprints |
| `ai-tuners` | Lets users configure AI behavior: model switching, filters, modes, parameters, voice & tone |
| `ai-wayfinders` | Reduces blank-slate anxiety with onboarding patterns: example prompts, galleries, tooltips |

## How it works

Each `.md` file is a Claude Code skill — a prompt that loads into Claude's context when triggered. Claude detects from your request which skill applies and uses it automatically. You can also invoke any skill directly with `/skill-name`.

Skills live at `~/.claude/skills/<name>/SKILL.md` after install.

## Contributing

PRs welcome. Each skill is a single `.md` file with this structure:

```markdown
---
name: your-skill-name
description: One clear sentence on what the skill does. Then trigger phrases — 
  when should Claude activate this automatically? Be specific.
---

# Skill content here
```

The `description` field drives automatic activation — write it so Claude knows exactly when to reach for this skill.

---

Created by Tommy Jepsen — https://tommyjepsen.com
