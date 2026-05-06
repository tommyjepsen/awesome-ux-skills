---
name: cognitive-load-conversion
description: Audit UI designs, flows, copy, and layouts to reduce cognitive load and maximize conversion. Apply this skill whenever a user shares a screen, mockup, flow, form, landing page, onboarding step, or any UI element and asks how to improve it — even if they don't say "cognitive load" or "conversion". Trigger on phrases like "why aren't users converting", "improve this flow", "reduce friction", "simplify this", "make this easier to use", "review this UI", "why do users drop off", "improve this form", "critique this design", "make this clearer", or any open-ended "improve this" request about a product surface. Always use this skill before giving UX or conversion improvement advice.
---

# Cognitive Load → Conversion Skill

Users abandon flows not because they don't want to convert — but because thinking is tiring. Every unnecessary decision, unfamiliar pattern, or piece of visual noise drains the finite mental budget users arrive with. When that budget runs out, they leave.

This skill provides a structured audit process to eliminate cognitive waste and protect the mental energy users need to actually complete the task.

---

## Core Model

There are two kinds of cognitive load. Only one is your problem to solve.

**Intrinsic load** — the unavoidable thinking required to understand the offer or complete the task. This is why the user showed up. Don't try to eliminate it; just don't add to it.

**Extraneous load** — everything else. Processing that consumes mental resources without helping the user get closer to their goal. This is where conversion dies. Your job is to find it and cut it.

---

## The Audit: 3 Levers

### Lever 1 — Cut Visual Clutter

Clutter isn't just about aesthetics. Every redundant element forces the brain to evaluate it before discarding it. That evaluation costs something.

**Ask of every element on screen:**
- Does this help the user understand what to do or why to do it?
- If removed, would anything important be lost?

**High-cost clutter patterns:**
- Redundant navigation links that go to the same place
- Decorative images that don't clarify or reinforce the value proposition
- Typography variation (size, weight, color) applied without semantic meaning — it signals hierarchy that isn't there, so the brain has to reconcile the mismatch
- Multiple competing CTAs at the same decision point
- Legal/compliance copy surfaced at the wrong moment (present it when it's relevant, not by default)

**Conversion principle:** Every element you remove that isn't earning its place is a free cognitive budget increase for the elements that matter.

---

### Lever 2 — Build on Existing Mental Models

Users arrive with expectations shaped by every other product they've used. When your interface matches those expectations, they don't have to learn — they just do. When it doesn't, they pause to figure it out. Pauses kill momentum. Momentum drives conversion.

**Patterns users already know (use them):**
- Primary action = most visually prominent button
- Destructive actions (delete, cancel) = less prominent, often text links
- Form fields = labeled above or inside the field, not beside it
- Errors = red, warnings = yellow, success = green
- Progress = left to right, or top to bottom
- Trust signals (security badges, testimonials) = near the point of commitment

**Questions to identify mental model mismatches:**
- Is the label for this element what users would call it?
- Is the primary action where users would expect to find it?
- Does this layout pattern match what users have seen on comparable products?
- Are we using interaction patterns (hover states, modals, accordions) in conventional ways?

**Conversion principle:** Familiarity is a feature. Novelty in UI adds cognitive cost without adding value. Innovate on the product; be conventional about the interface.

---

### Lever 3 — Offload Tasks from the User

Every moment a user has to remember something, calculate something, or make a decision they didn't come here to make is a moment they might leave. The question isn't just "is this clear?" — it's "do they even have to do this?"

**Task offloading opportunities:**

| User task | Offloaded alternative |
|---|---|
| Remember what they entered earlier | Re-display it on confirmation/summary screens |
| Choose from options they don't understand | Use a smart default; let them override |
| Type something that can be inferred | Auto-fill from context (location, account data, previous input) |
| Read to understand | Show an image or example instead |
| Decide between equally unfamiliar options | Recommend one — "Most popular", "Best for your situation" |
| Count or calculate | Do the math for them (show totals, savings, comparisons) |
| Remember what step they're on | Show a progress indicator |

**Questions to identify offloading opportunities:**
- Is there any information we already have that we're asking users to re-enter?
- Are there decisions in this flow that we could make for most users?
- Is there math, comparison, or calculation happening in the user's head?
- Is the user holding anything in memory between steps?

**Conversion principle:** The best form field is the one that doesn't exist. The best decision is the one the user doesn't have to make.

---

## Audit Format

When reviewing a UI, flow, or screen, structure your output as:

### 1. Extraneous Load Found
List specific elements or patterns that are adding cognitive cost without helping the user. Be specific — name the element, explain the cost it's creating.

### 2. Mental Model Gaps
Identify any places where the interface departs from convention in a way that requires users to stop and learn. Flag label mismatches, unexpected interaction patterns, or layout choices that conflict with established expectations.

### 3. Offloading Opportunities
Call out moments where the user is being asked to do something the product could do for them. Rank by conversion impact if possible.

### 4. Priority Recommendations
Give 3–5 concrete changes in priority order. Each recommendation should:
- Name the specific element or step
- Describe the change
- Explain the cognitive cost it removes
- Note the expected conversion impact (high / medium / low)

---

## Decision Heuristics

Use these to quickly triage a design under review:

- **The squint test**: Squint at the screen. What do you see first? Is that what the user needs to act on?
- **The first-time test**: Would a user seeing this for the first time know what to do within 3 seconds?
- **The subtraction test**: Remove one element. Does anything important break? If not, remove it.
- **The phone call test**: Could a user describe this screen to someone on the phone without confusion? If not, it's too complex.
- **The memory test**: At any point in the flow, is the user carrying information forward in their head that we could display for them instead?

---

## What Not to Cut

Not all friction is bad. Some cognitive load is intrinsic — it's the thing the user came to think about.

- **Don't simplify the offer** — if the product is genuinely complex, the goal is to present it clearly, not to hide that complexity
- **Don't remove confirmation steps** for high-stakes, irreversible actions — friction here is a feature (it prevents errors)
- **Don't default-select** in ways that could mislead or harm — smart defaults must be honest defaults

---

## Notes on Copy

Cognitive load isn't just visual — it's linguistic. When reviewing copy:

- **Shorter sentences reduce parsing load** — break long sentences into shorter ones
- **Active voice is processed faster** than passive voice
- **Plain words over technical terms** — unless the audience is expert and jargon carries precision value
- **Front-load the key information** — put the action or benefit first, conditions second
- **Avoid negatives** — "Don't miss out" requires parsing; "Offer ends tonight" is direct
