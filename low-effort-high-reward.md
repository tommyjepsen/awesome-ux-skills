---
name: low-effort-high-reward
description: Rank a list of things to do by effort (low / medium / high) against reward (low / medium / high), so it's obvious what to do first. Run it inside a codebase and it uses the actual code to judge how much work each item really is. Use this skill whenever someone drops a backlog, a bug list, an audit result, retro notes, a set of TODOs, or a vague pile of "things we should fix" and wants it ordered. Trigger on phrases like "what are the quick wins", "low hanging fruit", "what should I fix first", "prioritize this list", "which of these is cheapest", "biggest bang for the buck", "is this worth doing", "triage this", "where do I start", "we don't have time for all of this", or when someone pastes findings from any audit or review and asks what to do about them.
---

# Low Effort / High Reward

Take a list of things to do and sort it into a simple grid: how much work is it, and how much does it pay off. Then say what to do first.

Run inside a codebase, it looks at the real code before judging effort — because "add empty states" is ten minutes if there's already an empty-state component, and a week if there isn't.

---

## Process

### 1. Make it a clean list

Rewrite whatever you were given as separate items, one thing per line. Split anything compound — "the dashboard is slow and confusing" is two items and they'll score differently. Don't drop anything; if something can't be scored, park it at the bottom with the one question that would unblock it.

### 2. Take a look at the code

If you're in a codebase, spend a minute on each item before guessing at effort:

- Where does this live? Search for the text, the component, the screen.
- Does something like it already exist that you could copy or reuse?
- How many places would change — one file, or forty?
- Is it a copy/config/styling change, or does it touch how the app actually works?
- Does it touch anything scary — login, payments, data, permissions?

You don't need to be exhaustive. One honest look per item is enough to stop the effort scores from being fiction.

If there's no codebase to look at, just say so at the top and score from experience.

### 3. Score effort: low / medium / high

| | Roughly | Looks like |
|---|---|---|
| **Low** | Hours | Copy, colors, spacing, a setting, removing something, one small component. Reuses what's already there. |
| **Medium** | Days | A new component or screen, several files, some new logic, needs testing. |
| **High** | Weeks | Touches the data model, login, payments, or spreads across the whole app. Needs a migration or a rethink. |

Bump an item up a level if it touches login, payments, or data — those are never as small as they look.

### 4. Score reward: low / medium / high

| | Means |
|---|---|
| **Low** | One person mentioned it once. Nice, not needed. |
| **Medium** | Recurring annoyance, or a visible quality gap. There's a workaround. |
| **High** | Blocks people from doing the main thing, loses users or money, or is a real accessibility problem. |

Bump an item up a level if it's on the path every single user walks through, or if doing it makes several other items on the list cheaper.

### 5. Put it in the grid

```
              LOW EFFORT      MEDIUM EFFORT     HIGH EFFORT

HIGH REWARD   ⭐ Do first      Do next          Plan it in

MED REWARD    Do next         Maybe later      Skip

LOW REWARD    Fill-in work    Skip             Skip
```

Order within each group by reward first, then by whichever is least risky to touch.

### 6. Flag the surprises

Two things people always get wrong, and both come out of step 2:

- **Looks easy, isn't** — say plainly why. "That text appears in nine places, one of them is an email template."
- **Looks hard, isn't** — say plainly why. "Almost all of it is one shared button component."

If you looked at the code properly you'll usually have at least one of each. They're often the most useful thing in the whole answer.

---

## Output

Keep it short and skimmable. Lead with what to do first.

```markdown
## Do first — low effort, high reward

1. **[Thing]** — an hour. [One plain sentence: where it lives / why it's small.]
   Pays off because: [one sentence].
2. ...

## Do next

- **[Thing]** — low effort, medium reward — [one line]
- **[Thing]** — medium effort, high reward — [one line]

## Plan it in — worth it, but it's real work

- **[Thing]** — high effort, high reward — [one line on what makes it big]

## Surprises

- **Looks easy, isn't:** [thing] — [why]
- **Looks hard, isn't:** [thing] — [why]

## Skip

- **[Thing]** — [one line on why it's not worth it]

## Everything, at a glance

| Thing | Effort | Reward | Verdict |
|---|---|---|---|
```

Rules:
- Plain language. No jargon, no scores out of five, no formulas.
- One or two sentences per item, maximum.
- Keep "Do first" to 3–7 things. Twenty quick wins isn't a plan.
- Say when you're guessing rather than dressing a guess up as a fact.
- Offer to do the top item at the end — but don't start until asked.

---

## Avoid

- Guessing effort without looking at the code when the code is right there.
- Scoring a compound item instead of splitting it.
- Treating cheap as the same thing as worth doing — cheap and pointless is still fill-in work.
- Keeping items on the list out of politeness. If it should be dropped, say so.
