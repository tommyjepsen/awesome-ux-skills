---
name: like-wish-what-if
description: Give and structure feedback using the "I like, I wish, What if" (IL/IW/WI) design
  critique framework from the Stanford d.school. Use this skill whenever a user wants constructive
  feedback on a design, prototype, feature, flow, document, or team process — or wants to run a
  feedback session or retrospective. Trigger on phrases like "give me feedback", "critique this
  design", "what do you think of this", "review this prototype", "run a retro", "I like I wish",
  "how can we improve this", or when a user shares work-in-progress and asks for reactions.
  Also trigger when a user has raw feedback from others and wants it organized into something
  actionable. Always use this skill to structure critique instead of giving unorganized opinions.
---

# I Like, I Wish, What If Skill

"I like, I wish, What if" (IL/IW/WI) is a feedback framework from the Stanford d.school. It structures critique into three sentence starters that keep feedback constructive, personal, and forward-looking — praise what works, name what falls short, and open new possibilities instead of just pointing out flaws.

---

## The three starters

### I like…
Specific, genuine positives. What works and should be kept or amplified.
- Point at concrete elements, not vague vibes ("I like that the primary action is the only filled button" — not "I like the design")
- Positives are information: they tell the team what *not* to change

### I wish…
Constructive criticism, phrased as a personal desire rather than an objective verdict.
- "I wish the error message told me how to fix the problem" — not "the error handling is bad"
- The first-person framing lowers defensiveness and admits the feedback is one perspective
- Every wish should be actionable — the receiver should know what to do differently

### What if…?
Ideas and provocations that go beyond fixing the current version.
- Suggestions, wild ideas, alternative directions ("What if onboarding happened inside the empty state instead of a modal?")
- Not commitments — invitations to explore
- Great "what ifs" often reframe the problem rather than patch the solution

---

## Why the framing matters

| Unstructured feedback | IL/IW/WI equivalent | Effect |
|---|---|---|
| "This is confusing." | "I wish the pricing table showed the difference between tiers." | Specific and actionable |
| "It's fine, I guess." | "I like the tone of the copy. I wish the CTA stood out more." | Forces specificity |
| "You should do X." | "What if we tried X?" | Suggestion, not command |

The framework works because it is first-person, always constructive, and balances appreciation with critique — receivers stay open instead of defensive.

---

## Process

### Giving feedback on shared work

When a user shares a design, prototype, flow, or document for critique:

1. **Understand the goal first.** What is this trying to achieve? Who is it for? What stage is it at? Early concepts need directional feedback; polished work needs detail.
2. **Generate "I like" items** — at least 2–3 genuine, specific positives. Never fabricate praise; find what actually works.
3. **Generate "I wish" items** — the substantive critique. Each wish must be specific and actionable.
4. **Generate "What if" items** — 1–3 ideas that open new directions, including at least one that challenges an assumption rather than polishing the current approach.
5. **Rank within each bucket** — most important first.

### Organizing raw feedback from others

When a user brings unstructured feedback (comments, meeting notes, review threads):

1. Sort every piece of feedback into Like / Wish / What if
2. Rewrite verdicts as wishes ("navigation is broken" → "I wish I could get back to the dashboard from any screen")
3. Merge duplicates and note how many people raised each point
4. Flag contradictions between reviewers explicitly
5. End with a suggested priority order for the wishes

---

## Output format

Always present IL/IW/WI feedback in this structure:

```
I LIKE / I WISH / WHAT IF — [Subject]
Context: [what was reviewed, what stage it's at]

👍 I LIKE
• [specific element that works and why]
• [specific element that works and why]

🙏 I WISH
• [actionable, first-person critique]
• [actionable, first-person critique]

💡 WHAT IF
• [idea or provocation — new direction, not just a fix]
• [idea that challenges an assumption]

▶ SUGGESTED NEXT STEPS
1. [highest-priority wish to address]
2. [what-if worth a quick exploration]
```

---

## Facilitating a team session

If the user wants to run an IL/IW/WI session (design critique, sprint review, retrospective):

1. **Before**: Share the work (or the sprint scope) in advance. Timebox to 15–30 minutes.
2. **Frame the rules**: Every comment must start with one of the three phrases. No rebuttals — presenters only listen and say "thank you"; clarifying questions come after.
3. **Capture**: One sticky note or line per comment, sorted into three columns. Silent individual writing first, then round-robin sharing to avoid anchoring.
4. **Balance check**: If a column is empty, prompt for it explicitly — sessions naturally skew toward wishes.
5. **Close**: Cluster themes, dot-vote the wishes, pick 1–2 "what ifs" to prototype. Assign owners.

### As a retrospective

IL/IW/WI works on process, not just artifacts: "I like that we demoed early", "I wish handoff had fewer surprises", "What if design joined sprint planning?". Same rules, same format — the subject is the team's way of working.

---

## Quality checks

Before delivering any IL/IW/WI feedback, verify:
- [ ] Every item starts with (or clearly maps to) one of the three phrases
- [ ] "I like" items are specific and genuine — no filler praise
- [ ] Every "I wish" is actionable, not just a complaint
- [ ] At least one "What if" challenges the framing, not just the execution
- [ ] Feedback is phrased in first person, not as objective verdicts
- [ ] Buckets are reasonably balanced (no empty columns)
- [ ] A suggested priority order or next step is included

---

## When to use IL/IW/WI vs. other critique formats

| Situation | Best fit |
|---|---|
| Work-in-progress needing safe, constructive critique | **I like, I wish, What if** |
| Team retrospective on process | **I like, I wish, What if** |
| Systematic usability audit against known principles | `ux-heuristics-review` |
| Compliance-style accessibility check | `accessibility` |
| Broad multi-framework design review | `general-design-review` |

IL/IW/WI is a conversation and framing tool — reach for it when the goal is honest feedback that keeps momentum, not an exhaustive audit.
