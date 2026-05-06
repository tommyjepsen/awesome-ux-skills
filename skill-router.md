---
name: skill-router
description: Route any UX, product, or AI design question to the right skill file. Use this
  skill first when the request is ambiguous or spans multiple skills, or when you need to
  identify which skill to apply. Acts as a decision tree across all 16 available skills.
---

# Skill Router

Use this file to select the right skill for any UX, product design, or AI feature request.
Read the trigger signals and route accordingly. Multiple skills can apply — when they do, note which to lead with.

---

## Quick-pick by trigger phrase

| If the user says… | Use this skill |
|---|---|
| "what research method should I use", "how do I study users", "qualitative vs quantitative" | `ux-research-methods` |
| "create a persona", "define our users", "turn interviews into profiles" | `ux-personas` |
| "create a journey map", "map the customer experience", "visualize a user flow" | `journey-mapping` |
| "create an empathy map", "synthesize these interviews", "says/thinks/does/feels" | `empathy-mapping` |
| "storyboard", "visualize a user scenario", "show how a user would use X" | `ux-storyboard` |
| "prioritize features", "what should we build first", "rank the backlog", "impact vs effort" | `feature-prioritization` |
| "review this UI", "heuristic audit", "is this good UX", "critique this design" | `ux-heuristics-review` |
| "reduce friction", "why aren't users converting", "improve this flow", "simplify this" | `cognitive-load-conversion` |
| "make this more engaging", "improve this CTA", "nudge users", "reduce drop-off" | `persuasive-ux` |
| "design process", "where do I start", "discovery phase", "ideation", "validate solution" | `double-diamond` |
| "users don't trust the AI", "keep users in control", "how do I show AI reasoning" | `ai-governors` |
| "what should we call our AI", "AI avatar", "AI color", "AI personality", "brand identity for AI" | `ai-identifiers` |
| "how should users prompt this", "add AI input", "what input pattern should I use" | `ai-inputs` |
| "add a disclaimer", "watermark AI outputs", "user consent for recording", "label AI content" | `ai-trust-builders` |
| "let users control the AI", "model switching", "prompt settings", "AI filters", "voice & tone" | `ai-tuners` |
| "users don't know what to type", "blank slate", "example prompts", "AI onboarding" | `ai-wayfinders` |

---

## Decision tree by domain

### Is the request about AI product design?

```
Does it involve…
├── How users first discover or get started with an AI feature?
│   └── → ai-wayfinders
│
├── How users direct, configure, or control AI output?
│   ├── Input mechanisms (text, templates, autofill, voice)? → ai-inputs
│   └── Configuration (models, filters, style, tone)?        → ai-tuners
│
├── Making AI feel safe, transparent, or trustworthy?
│   ├── Oversight, confirmation, undo, cost visibility?       → ai-governors
│   └── Caveats, consent, data ownership, disclosure, watermarks? → ai-trust-builders
│
└── Defining the visual/verbal identity of the AI?
    └── → ai-identifiers
```

### Is the request about UX research or strategy?

```
Does it involve…
├── Choosing a research method or planning research?          → ux-research-methods
├── Creating user personas from research data?               → ux-personas
├── Mapping how users move through a product or service?
│   ├── Linear journey with emotions + pain points?          → journey-mapping
│   ├── Collaborative team artifact from interviews?         → empathy-mapping
│   └── Visual narrative / scenario illustration?            → ux-storyboard
└── Structuring a design project or sprint?                  → double-diamond
```

### Is the request about improving an existing UI or flow?

```
Does it involve…
├── General heuristic audit or design critique?              → ux-heuristics-review
├── Reducing drop-off, simplifying forms, cutting friction?  → cognitive-load-conversion
└── Making users more likely to take an action or convert?   → persuasive-ux
```

### Is the request about deciding what to build?

```
→ feature-prioritization
```

---

## Skill combinations that often go together

| Situation | Lead skill | Supporting skill |
|---|---|---|
| Designing a new AI product from scratch | `double-diamond` | `ai-identifiers`, `ai-wayfinders` |
| Auditing an existing AI feature for trust | `ai-governors` | `ai-trust-builders` |
| Improving onboarding to an AI feature | `ai-wayfinders` | `cognitive-load-conversion` |
| Designing AI input/output interaction | `ai-inputs` | `ai-tuners` |
| Turning interviews into design artifacts | `ux-personas` | `empathy-mapping`, `journey-mapping` |
| Critiquing a live product flow | `ux-heuristics-review` | `cognitive-load-conversion`, `persuasive-ux` |
| Deciding what to research or build next | `ux-research-methods` | `feature-prioritization` |

---

## Full skill index

| File | Skill name | One-line summary |
|---|---|---|
| `ai-governors.md` | ai-governors | Human-in-the-loop patterns: oversight, confirmation, cost, undo |
| `ai-identifiers.md` | ai-identifiers | AI brand identity: name, avatar, color, iconography, personality |
| `ai-inputs.md` | ai-inputs | 13 input patterns for directing AI (open, madlibs, autofill, voice…) |
| `ai-trust-builders.md` | ai-trust-builders | 7 trust patterns: caveat, consent, disclosure, watermark, footprints… |
| `ai-tuners.md` | ai-tuners | 9 tuner patterns: attachments, connectors, filters, modes, parameters… |
| `ai-wayfinders.md` | ai-wayfinders | 8 onboarding patterns to reduce blank-slate anxiety |
| `cognitive-load-conversion.md` | cognitive-load-conversion | Audit UI to cut extraneous load and improve conversion |
| `double-diamond.md` | double-diamond | Guide teams through Discover → Define → Develop → Deliver |
| `empathy-mapping.md` | empathy-mapping | Create Says/Thinks/Does/Feels maps from user research |
| `feature-prioritization.md` | feature-prioritization | Rank features using a 2D weighted prioritization matrix |
| `journey-mapping.md` | journey-mapping | Map user actions, thoughts, and emotions across a timeline |
| `persuasive-ux.md` | persuasive-ux | Apply Fogg's 7 persuasive tools to increase engagement |
| `ux-heuristics-review.md` | ux-heuristics-review | Critique UI against Nielsen's 10 Usability Heuristics |
| `ux-personas.md` | ux-personas | Create research-grounded personas for product design |
| `ux-research-methods.md` | ux-research-methods | Select the right research method for the question and stage |
| `ux-storyboard.md` | ux-storyboard | Visualize user scenarios as panel-by-panel storyboards |
