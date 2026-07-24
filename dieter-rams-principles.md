---
name: dieter-rams-principles
description: Evaluate and improve digital product design using Dieter Rams' 10 Principles of Good
  Design, translated for software, apps, and UI. Use this skill whenever a user wants a principled
  critique of a screen, flow, feature, or whole product — or wants guidance on making something
  feel more considered, restrained, and timeless. Trigger on phrases like "is this good design",
  "critique this using Rams", "10 principles of good design", "make this more minimal", "review my
  UI against design principles", "does this feel over-designed", "is this honest design", "how do
  I simplify this product", or any request to judge a digital product against a durable standard of
  design quality. Also trigger when a user shares a mockup, screenshot, or shipped screen and asks
  whether it is well designed. Always use this skill to structure principle-based critique instead
  of giving unanchored opinions.
---

# Dieter Rams' 10 Principles of Good Design — for Digital Products

Dieter Rams distilled decades of industrial design into ten principles of what makes design *good*. They were written for physical objects, but they translate directly to software — where they are a defense against feature bloat, dark patterns, trend-chasing, and decoration masquerading as design.

Use them as a lens: score a product against each principle, name the strongest violation, and give a concrete change.

---

## The 10 principles, translated for software

### 1. Good design is innovative
Innovation follows real advances in technology and understanding — it is never novelty for its own sake.
- **Digital:** New capability (AI, real-time sync, on-device compute) should unlock a genuinely better job-to-be-done, not just a new visual gimmick or a trend copied from a competitor.
- **Smell:** "AI" bolted on with no user benefit; animations that impress in a demo but slow the daily path.

### 2. Good design makes a product useful
Design serves the primary function first; everything else is subordinate. Aesthetics never override utility.
- **Digital:** The core task should be the fastest, clearest path in the product. Secondary features must not crowd it.
- **Smell:** The main action buried under upsells, promos, or engagement bait.

### 3. Good design is aesthetic
Well-made things are pleasant to use; beauty and usability are inseparable, not a trade-off.
- **Digital:** Consistent spacing, restrained type scale, deliberate color, real content — craft the user *feels* even if they can't name it.
- **Smell:** Arbitrary spacing, competing font sizes, decoration with no function.

### 4. Good design makes a product understandable
The product explains itself. At best it is self-explanatory; the structure makes the function clear.
- **Digital:** Clear information hierarchy, honest labels, obvious affordances, states that communicate what happened and what's next. No manual required.
- **Smell:** Mystery-meat icons, ambiguous CTAs, users guessing what a control does.

### 5. Good design is unobtrusive
Products are tools, not decoration or self-expression. Design leaves room for the user's own purpose.
- **Digital:** The interface recedes so the user's content and task take the foreground. Restraint over showmanship.
- **Smell:** Attention-grabbing UI, needless motion, interruptions that serve the business, not the user.

### 6. Good design is honest
It does not make a product seem more innovative, powerful, or valuable than it is. It makes no promises it can't keep.
- **Digital:** No fake urgency, no disguised ads, no dark patterns, no manipulative defaults. Loading and progress reflect reality. This is the principle most often violated in software.
- **Smell:** Countdown timers that reset, "1 left in stock" fabrications, pre-checked opt-ins, roach-motel cancellation.

### 7. Good design is long-lasting
It avoids being fashionable and therefore never appears antiquated. It lasts for years.
- **Digital:** Favor durable patterns and a system over trend-driven styling (skeuomorphism, then flat, then glassmorphism…). Design tokens and clear structure age better than a look.
- **Smell:** A redesign chasing the current trend that will feel dated in two years.

### 8. Good design is thorough down to the last detail
Nothing is arbitrary or left to chance. Care and accuracy show respect for the user.
- **Digital:** Empty states, error states, loading states, edge cases, long strings, zero/one/many, focus order, keyboard paths — all designed, not defaulted.
- **Smell:** Polished happy path, broken empty state; "lorem ipsum" shipped; untranslated error codes.

### 9. Good design is environmentally friendly
It conserves resources and minimizes physical and visual pollution.
- **Digital:** Performance and efficiency — small payloads, fewer requests, less battery and data. Also *attention-friendly*: it doesn't pollute the user's focus with noise and notifications.
- **Smell:** Bloated bundles, autoplay everything, notification spam competing for attention.

### 10. Good design is as little design as possible
Less, but better — concentrate on the essential, so the product is not burdened with non-essentials. Back to purity, back to simplicity.
- **Digital:** Remove before you add. Every feature, field, option, and pixel must earn its place. The strongest edit is usually a deletion.
- **Smell:** Settings no one uses, five ways to do one thing, a dashboard of vanity metrics.

---

## Process

### Reviewing a digital product against the principles

1. **Establish the job.** What is this product/screen primarily *for*? Principles 2 and 10 depend on knowing the core task.
2. **Score each principle** — Strong / Adequate / Weak. Don't force all ten; note which are most relevant to what you're reviewing.
3. **Name the top 2–3 violations** — the principles where fixing it would most improve the product. Honesty (6), understandability (4), and "as little as possible" (10) are the most common failures in software; check them first.
4. **Give a concrete change per violation** — not "simplify this" but "remove the three secondary CTAs so the primary action is the only filled button".
5. **Name what to keep** — call out where the product already honors a principle, so it isn't lost in the next iteration.

---

## Output format

Always present a Rams review in this structure:

```
DIETER RAMS REVIEW — [Product / Screen]
Core job: [what this is primarily for]

SCORECARD
 1. Innovative          [Strong / Adequate / Weak] — [one line]
 2. Useful              [ … ]
 3. Aesthetic           [ … ]
 4. Understandable      [ … ]
 5. Unobtrusive         [ … ]
 6. Honest              [ … ]
 7. Long-lasting        [ … ]
 8. Thorough            [ … ]
 9. Efficient/clean     [ … ]
10. As little as possible [ … ]

⚠ TOP VIOLATIONS
1. [Principle] — [what's wrong] → [concrete change]
2. [Principle] — [what's wrong] → [concrete change]

✓ KEEP
• [what already honors the principles]

▶ THE ONE EDIT
[If you change one thing, change this — usually a deletion.]
```

---

## Using the principles generatively (not just for critique)

When designing something new, run the principles forward:
- **Start from 2 and 10:** what is the essential job, and what is the least design that does it?
- **Pressure-test with 6:** would any part of this embarrass us if the user understood the business incentive behind it? Remove it.
- **Budget with 8:** list every state (empty, loading, error, edge) before calling a feature done.
- **Defend with 7:** choose a system and durable patterns over the current trend.

---

## Quality checks

Before delivering a Rams-based review, verify:
- [ ] The core job of the product is stated first
- [ ] Honesty (dark patterns), understandability, and minimalism were explicitly checked
- [ ] Each violation names a *concrete* change, not a vague instruction
- [ ] At least one "keep" is identified, not only problems
- [ ] Principles that don't apply to this artifact were skipped rather than forced
- [ ] The review ends with a single highest-leverage edit

---

## When to use Rams vs. other review skills

| Situation | Best fit |
|---|---|
| Judge overall design quality against a durable standard | **dieter-rams-principles** |
| "Is this over-designed / dishonest / bloated?" | **dieter-rams-principles** |
| Systematic usability audit of a flow | `ux-heuristics-review` |
| Cut friction and lift conversion on a specific screen | `cognitive-load-conversion` |
| Accessibility / WCAG compliance | `accessibility` |
| Visual-craft code rules (gradients, glow, transitions) | `craft` |

Rams is the "is this *good*?" lens — reach for it when the question is about design integrity and restraint, not a checklist audit of one flow.
