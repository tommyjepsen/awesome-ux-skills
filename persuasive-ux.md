---
name: persuasive-ux
description: Apply BJ Fogg's 7 Persuasive Technology Tools (Captology) to UX analysis and design.
  Use this skill whenever the user wants to improve a UI, flow, or feature using persuasion
  principles — including prompts like "how can I make this more engaging", "why aren't users
  completing this flow", "improve this onboarding", "make this CTA better", "reduce drop-off",
  "nudge users toward X", or any open-ended "improve this UI/UX" request. Also trigger when
  the user shares a screenshot, mockup, or describes a feature and wants design recommendations.
  Always use this skill before giving UX improvement advice — even if the user doesn't
  explicitly mention persuasion, Fogg, or Captology.
---

# Persuasive UX Skill

Uses BJ Fogg's 7 Persuasive Technology Tools (from Captology) to audit a UI or flow and
return a prioritized list of actionable UX improvements.

## The 7 Tools — Quick Reference

| # | Tool | Core Mechanism |
|---|------|----------------|
| 1 | **Reduction** | Shrink effort — fewer steps, less friction, smart defaults |
| 2 | **Tunneling** | Guided path — remove irrelevant choices, wizard-style progression |
| 3 | **Tailoring** | Personalization — adapt content/UI to user context, goals, or history |
| 4 | **Suggestion** | Kairos — surface the right prompt at the right moment |
| 5 | **Self-Monitoring** | Real-time feedback — show users their progress or status |
| 6 | **Surveillance** | Social visibility — peer awareness, leaderboards, "last active" |
| 7 | **Conditioning** | Positive reinforcement — rewards, micro-celebrations, satisfying feedback |

Full definitions are in `references/tools.md`. Read it if you need depth on any tool.

---

## Workflow

### Step 1 — Understand the input

Accept any of the following input types:
- A **text description** of a feature, screen, or user flow
- A **screenshot or mockup** (analyze visually)
- An **open-ended prompt** like "improve this" or "why do users drop off here"

If the input is vague, ask ONE clarifying question: **"What behavior are you trying to drive?"**
(e.g. sign up, complete a task, return more often). Don't ask more than one question.

### Step 2 — Identify applicable tools

Mentally map the flow against all 7 tools. Ask:
- Where is **effort or complexity** creating friction? → Reduction
- Is the **path unclear or branchy**? → Tunneling
- Is the experience **generic when it could be personal**? → Tailoring
- Are suggestions **poorly timed** or missing entirely? → Suggestion
- Can users **see their own progress**? → Self-Monitoring
- Is there **social context** that could motivate? → Surveillance
- Are **desired actions being rewarded**? → Conditioning

Not every tool applies to every situation. Only surface what's genuinely relevant.

### Step 3 — Output format

Return a **short prioritized list** (2–4 recommendations max). More is noise.

For each recommendation:

```
**[Tool Name]** — [One-line summary of the issue]
→ [Concrete change to make, specific to the input]
Why it works: [1–2 sentences of rationale]
```

Order by **expected impact**, highest first. If two tools have similar impact, prefer
the one that requires less implementation effort.

---

## Principles to keep in mind

- **$B = MAP$** — Fogg's Behavior Model: Behavior happens when Motivation, Ability, and a
  Prompt converge. These 7 tools increase Ability (Reduction, Tunneling, Self-Monitoring)
  or sharpen the Prompt (Suggestion, Tailoring, Conditioning, Surveillance).
- **Don't recommend all 7** — a focused list of 2–4 is more useful than exhaustive coverage.
- **Be specific** — "add a progress bar" beats "use self-monitoring". Tie every recommendation
  to the actual UI or flow described.
- **Avoid dark patterns** — Surveillance and Conditioning in particular can tip into
  manipulation. Flag if a recommendation risks feeling coercive.

---

## Reference files

- `references/tools.md` — Full definitions, examples, and anti-patterns for all 7 tools.
  Read this when you need deeper context on a specific tool before recommending it.
