---
name: ux-storyboard
description: Create UX storyboards from scratch, from user research, or from existing journey maps.
  Use this skill whenever a user wants to create a storyboard, visualize a user scenario,
  illustrate how a user interacts with a product, or communicate a UX story to a team or
  stakeholders. Also trigger when the user asks to "sketch a user flow", "show how a user
  would use X", "create a scenario illustration", "map out a use case visually", or wants
  to present research findings in a visual, narrative format. Even if the user doesn't say
  "storyboard" explicitly — if they want to show a sequence of steps a user takes, trigger
  this skill.
---

# UX Storyboard Skill

A skill for creating structured, effective UX storyboards that communicate user stories
through visual sequences — for teams, stakeholders, or ideation sessions.

---

## What Is a Storyboard (UX Context)?

A storyboard communicates a story through images displayed in a sequence of panels that
chronologically maps the story's main events. In UX, storyboards provide context about how
a user experiences a product or flow — making it quick to understand and easy to remember.

---

## The 3 Required Components

Every storyboard must have these three elements:

1. **Scenario** — A persona + short description of the situation. Clear enough to understand
   before looking at the visuals. E.g. *"Corporate buyer James needs to replenish office supplies."*

2. **Visuals** — A sequence of panels (sketches, illustrations, photos, or screen mockups).
   Each step represented once. Images show: environment, device, facial expressions/body
   language, speech bubbles, UI screens as relevant.

3. **Captions** — One or two bullet points per panel max. Describe: user action, emotional
   state, environment, device. Concise — the image is primary.

---

## Step-by-Step Process

### 1. Gather Input
Ask the user for (or extract from context):
- Available data: user interviews, usability test findings, site metrics — or is this ideation?
- The persona or user role
- The scenario or user story to illustrate

If no data is available yet, storyboards can still be used as **ideation artifacts** — just
flag that they should be treated as conversation starters, not lasting prioritization tools.

### 2. Determine Fidelity & Output Format

| Audience | Fidelity | Format |
|---|---|---|
| Internal team brainstorm | Low — sticky notes, stick figures | Text outline or simple SVG |
| Usability test debrief | Medium — photos/stills + captions | Structured panels with quotes |
| Stakeholder presentation | High — detailed illustrations | Polished visual artifact |

Ask the user who the audience is if unclear.

### 3. Define the Basics
- One persona per storyboard
- One specific path per storyboard (not a flowchart — it's a storyline)
- If the scenario has multiple branches → create separate storyboards per path (1:1 rule)

### 4. Plan the Steps
Before drawing or writing panels:
1. Write out each step in plain text
2. Connect with arrows to confirm sequence
3. Label each step with an **emotional state icon**: 😊 😐 😟 😤 etc.

This surfaces which moments matter most emotionally before committing to layout.

### 5. Create Panels
For each step produce:
- **Visual description** (or actual visual if generating one): what the user is doing,
  where they are, what they see on screen, relevant body language
- **Caption** (max 2 bullets): action taken + emotional/contextual note

### 6. Output Format
Default output is a structured storyboard written out as:

```
STORYBOARD: [Title]
Persona: [Name + role]
Scenario: [One sentence description]

─────────────────────────────────────────
Panel 1: [Step name]
[Visual description]
• [Caption bullet 1]
• [Caption bullet 2 if needed]
Emotion: 😊 / 😐 / 😟

Panel 2: ...
─────────────────────────────────────────
```

If the user wants a rendered visual, use the `show_widget` visualizer tool to create an
SVG storyboard layout with panels, icons, and captions.

---

## Storyboard Use Cases

| Use Case | Notes |
|---|---|
| **Usability test debrief** | Include direct user quotes; use photos/stills where possible |
| **Augmenting a journey map** | Add storyboard panels for key stages to show physical/device context |
| **Feature prioritization** | Use emotional state per step to identify which pain points to tackle first |
| **Ideation** | Sketch hypothetical flows; label clearly as speculative, iterate fast |

---

## Storyboard vs. Journey Map (Quick Reference)

| Storyboard | Journey Map |
|---|---|
| Imagery first, minimal text | Text-rich, extensive annotations |
| Covers a fragment of the journey | Big-picture, end-to-end overview |
| Narrow use — specific team or problem | Broad use — cross-department alignment |
| Informal, fast to create | Often a formal organizational artifact |

Use storyboards *within* or *alongside* journey maps — not instead of them.

---

## Quality Checklist

Before delivering a storyboard, verify:
- [ ] One persona clearly named
- [ ] Scenario is specific and single-path
- [ ] Each panel has a visual description AND caption
- [ ] Captions are ≤ 2 bullet points
- [ ] Emotional state marked for each step
- [ ] Fidelity matches audience
- [ ] Ideation storyboards are labeled as speculative

---

## Tips

- **Stick figures are fine.** The story matters, not the art quality.
- **Quote real users.** If from usability data, include verbatim quotes in speech bubbles.
- **Keep it modifiable.** Low-fidelity = easier to iterate. Don't over-invest in visuals
  until the story is validated.
- **One step = one panel.** Don't cram multiple actions into one frame.
- **Start with emotions.** If you're stuck on visuals, map emotional states first — they'll
  tell you what the visual needs to convey.
