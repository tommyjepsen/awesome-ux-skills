---
name: low-effort-high-reward
description: Turn a list of problems, bugs, complaints, or "things we should fix" into a ranked low-effort / high-reward plan, with effort estimated from the actual codebase rather than guessed. Use this skill whenever a user drops a backlog, a bug list, an audit result, a review, retro notes, a set of TODOs, or a single vague problem and asks what to fix first. Trigger on phrases like "what are the quick wins", "low hanging fruit", "what should I fix first", "prioritize this list", "which of these is cheapest", "biggest bang for the buck", "is this worth fixing", "triage this", "where do I start", "we don't have time for all of this", or when the user pastes findings from any audit or review skill and asks what to do about them. Also trigger when a previous skill just produced a list of issues and the user needs it turned into an ordered plan.
---

# Low Effort / High Reward

Take a pile of "things that need fixing" and turn it into an ordered plan, where **effort is measured against the code that actually exists**, not estimated in the abstract.

The whole value of this skill is that last part. Anyone can guess that "fix the empty states" is medium effort. Only something reading the repo can tell you it's a 20-minute change because there's already an `<EmptyState>` component and three call sites — or a two-week change because empty states are hand-rolled in 47 files.

---

## When to use this

- A backlog, bug list, retro, audit, or review produced more items than there is time for
- Someone asks "what should we do first" and the honest answer depends on the code
- A single problem is framed as urgent and you need to know if it's cheap
- Output from another skill (`accessibility`, `ux-heuristics-review`, `craft`, `cognitive-load-conversion`, `dieter-rams-principles`, `like-wish-what-if`) needs to become a plan

If the user wants a full weighted matrix with team voting and workshop facilitation, use `feature-prioritization` instead. This skill is the fast, code-grounded version for one person deciding what to do this week.

---

## Process

### 1. Split the input into atomic items

Rewrite whatever you were given as a flat list of discrete, independently shippable items.

- One item = one thing you could ship on its own. "Improve onboarding" is not an item; "remove the company-size field from signup" is.
- Split compound complaints. "The dashboard is slow and confusing" is two items, and they will land in different quadrants.
- If the user gave you one vague problem ("checkout feels bad"), first decompose it into candidate fixes, then rank those.
- Keep the user's original wording next to your rewrite so they can still recognise their own list.

Never silently drop an item. If something can't be scored, list it under **Needs more information** with the specific question that would unblock it.

### 2. Ground every item in the codebase — before scoring

This is mandatory and it is the step to spend time on. For each item, actually go look. Useful moves:

| Question | How to answer it |
|---|---|
| Where does this live? | Grep for the string, component name, route, or error message |
| How many places change? | Count call sites / imports / usages of the thing being changed |
| Does the abstraction already exist? | Search for an existing component, hook, util, token, or helper that does 80% of it |
| Is it config or structure? | A token, constant, feature flag, or copy string is minutes. A prop-drilled state change is days. |
| What breaks? | Check tests touching those files, and what else imports them |
| Has someone tried before? | `git log` / `git blame` on the file, plus TODO/FIXME comments nearby |
| Is it load-bearing? | Is this in the auth path, payment path, data model, or a shared layout? |

Record one concrete code fact per item — a file path, a call-site count, a component name. Every effort score must be traceable to something you actually saw.

If you genuinely cannot inspect the code (no repo access, design-only discussion), say so explicitly at the top of the output and mark all effort scores as **unverified estimates**. Do not quietly fake it.

### 3. Score effort (1–5), anchored in what you found

| Score | Means | Code signals |
|---|---|---|
| **1 — Trivial** | Under an hour | Copy, a constant, a token, one CSS rule, deleting a field, flipping a flag. 1–2 files. |
| **2 — Small** | Half a day | One component, existing abstraction covers it, few call sites, tests already exist |
| **3 — Medium** | A few days | New component or endpoint, 5–15 files touched, some tests to write |
| **4 — Large** | 1–2 weeks | Crosses layers (UI + API + data), migration needed, touches shared state |
| **5 — Structural** | Weeks+ | Schema change, auth/payments, dependency swap, rewrite of a core abstraction |

Adjustments — apply and state them:
- **+1** if it touches auth, payments, billing, permissions, or the data model
- **+1** if there are no tests near the change and the code is non-obvious
- **+1** if it needs a migration, a backfill, or coordinated deploy
- **−1** if the exact pattern already exists elsewhere in the repo and can be copied

### 4. Score reward (1–5)

| Score | Means |
|---|---|
| **1** | One person noticed once |
| **2** | Mild annoyance, easy workaround exists |
| **3** | Recurring friction for a real segment, or a visible quality/craft gap |
| **4** | Blocks a core task, loses users at a known drop-off, or a real accessibility barrier |
| **5** | Users leave, lose money, lose data, or can't complete the primary job |

Adjustments:
- **+1** if it sits on the main path every user walks through
- **+1** if it unblocks or cheapens other items on the list (leverage)
- **+1** if it's a legal, safety, or accessibility compliance risk
- **−1** if the reward is assumed rather than observed — and mark it as an assumption

### 5. Place each item

```
High reward │  Big bets          │  ⭐ QUICK WINS
    (4–5)   │  (plan them)       │  (do this week)
   ─────────┼────────────────────┼─────────────────
Low reward  │  Don't             │  Fill-in work
    (1–3)   │  (delete the item) │  (batch or ignore)
            └────────────────────┴─────────────────
              Effort 3–5            Effort 1–2
```

Then order the quick-wins quadrant (low effort, high reward) by **reward ÷ effort**, highest first. Ties break toward whatever touches the least load-bearing code.

### 6. Call out the traps

The most useful thing this skill produces is often not the ranking — it's the two lists people get wrong:

- **Looks cheap, isn't.** "Just change the date format" → the format is duplicated in 12 files and one of them is a CSV export another team parses. Say exactly what makes it expensive.
- **Looks expensive, isn't.** "Full accessibility pass" → 80% of the findings are one shared `<Button>` and a missing `<label>` helper. Say exactly what makes it cheap.

Both come straight out of step 2. If step 2 was done properly, you will have at least one of each.

---

## Output format

Lead with the answer. The user wants to know what to do Monday morning.

```markdown
## Do these first

1. **[Item]** — effort 1, reward 4
   `path/to/file.tsx:88` — the label is hardcoded in one place, no tests depend on it.
   Why it pays: it's the first thing on the signup form and 3 support tickets name it.

2. ...

## Worth planning (high reward, real cost)

- **[Item]** — effort 4, reward 5 — touches `api/orders` + schema migration. Needs a real slot, not a spare afternoon.

## Traps

- **Looks cheap, isn't:** [item] — [the specific code reason]
- **Looks expensive, isn't:** [item] — [the specific code reason]

## Skip

- **[Item]** — low reward, and the fix touches [X]. Not worth it unless [condition changes].

## Needs more information

- **[Item]** — I can't score reward without [the specific missing fact].

## Full ranking

| # | Item | Effort | Reward | R/E | Where it lives |
|---|------|--------|--------|-----|----------------|
```

Rules for the write-up:
- Every effort score cites a file, a count, or a component name. No bare numbers.
- Keep "Do these first" to 3–7 items. A list of 20 quick wins is not a plan.
- If the user only wants the top item, give them the top item and stop.
- Offer to implement the top quick win at the end — don't start without being asked.

---

## Anti-patterns

- **Scoring from the description alone.** If you didn't open the code, you're guessing, and the user could have guessed too.
- **Averaging effort across an item you didn't split.** Compound items always score wrong.
- **Treating "low effort" as the only axis.** A cheap fix nobody benefits from is still waste — it belongs in *Fill-in*, not *Do first*.
- **Padding the list.** Items that should be deleted should be deleted, and you should say so.
- **Hiding uncertainty in a confident number.** Mark assumed reward as assumed and unverified effort as unverified.
- **Silently reordering by your own taste.** The ratio decides the order; if you override it, say why.
