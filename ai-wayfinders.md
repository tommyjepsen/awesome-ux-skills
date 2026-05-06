---
name: ai-wayfinders
description: Apply Wayfinder patterns to design or improve AI onboarding, discoverability,
  and first-interaction flows in any product. Use this skill whenever the user wants to add AI
  to a product surface, reduce blank-slate anxiety, help users discover what the AI can do,
  improve an initial CTA or prompt input, add suggestions or templates, design a gallery, add
  nudges, or generally reduce friction at the start of an AI interaction. Trigger even on vague
  requests like "make it easier to get started with AI", "users don't know what to type",
  "how do we show what the AI can do", "add some example prompts", or "improve onboarding to
  our AI feature". Wayfinders are: Initial CTA, Example Gallery, Suggestions, Templates,
  Nudges, Follow-ups, Prompt Details, and Randomize.
---

# AI Wayfinders Skill

Wayfinders help users discover what the AI can do, get started without fear, and progressively
build confidence. They solve the blank-slate problem — the moment a user faces an empty input
and has no idea what to type.

Use this skill to **recommend, design, or critique** any product surface where users interact
with AI for the first time or need guidance about what's possible.

---

## The 8 Wayfinder Patterns

### 1. Initial CTA
**What it is:** The primary entry point — usually a prominent input box — where users first
engage with the AI.

**The problem it solves:** A bare text box puts the full burden of prompt engineering on the
user. Most people don't know how to phrase what they want; a short prompt rarely captures
real intent.

**How to strengthen it:**
- Surround the input box with scaffolding: suggestions, galleries, templates, mode selectors,
  attachments
- **Action-First CTA** — for workflow-driven products, present AI alongside familiar actions
  and let it emerge at the moment of leverage (e.g. after a document or record exists)
- **Contextual CTA** — waits until there's data to act on (a transcript, a filled form, a
  report) then surfaces AI as the natural next step
- **Playful CTA** — random prompts, examples, or whimsy lower pressure and invite exploration

**Key principle:** Don't surface an empty AI box on an empty state. The most reliable path is
to keep the input at the center but surround it with scaffolding that shifts the work from
prompt engineering toward selection and refinement.

---

### 2. Example Gallery
**What it is:** A curated or community collection of sample generations that shows users
what the product can do.

**Variants:**
- **Curated** — hand-picked by the team, best for first impressions and brand direction
- **Community** — user-submitted, good for engagement and authenticity
- **Dynamic** — algorithmically surfaced by user profile or activity

**Key traits of effective galleries:**
- Clear previews (thumbnails, snippets) — users scan fast and choose on first impression
- Organized by use case, theme, or popularity with search and filters
- Actionable: "Start from this", "Remix", "See prompt" — one click to use
- Mix polished highlights with everyday practical examples
- Expose the prompt behind each example (see Prompt Details pattern)
- Attribution and context (who made it, how many times remixed)

**Key principle:** A gallery should both inspire and instruct. Make every tile an entry point,
not just a showcase.

---

### 3. Suggestions
**What it is:** 3–5 pre-written prompts that appear near the input and can be clicked to
pre-fill or trigger the interaction.

**Three forms:**
- **Static** — fixed starters, consistent for all users, good for onboarding
- **Contextual** — update based on what's on screen (open document, selected item, mode)
- **Adaptive** — evolve from user behavior and preferences over time

**Design rules:**
- Clicking a suggestion should immediately run it or fill the input — not open a dialog
- Show 3–6 max; rank by relevance; retire low-engagement options over time
- Scope when they appear: onboarding, new context, idle state — not everywhere always
- Draw from what's on screen when possible rather than a static list

**Key principle:** Suggestions are most effective when contextual. A suggestion tied to the
current content is far more useful than a generic "Ask me anything" starter.

---

### 4. Templates
**What it is:** Pre-built prompt structures with fillable fields (variables, dropdowns,
@-mentions) that let users construct complex prompts without writing them from scratch.

**Why they matter:** Some tasks require long, specific prompts to produce reliable output.
Templates replace that burden with a short form — fill in a few fields, not a paragraph.

**Design rules:**
- Use variables, dropdowns, and @-mentions to minimize manual input
- Chain templates together across workflow steps (each step feeds the next)
- Keep references to source material (citations, attached context) visible
- Don't force templates on simple tasks — only use when the task is complex or repeatable
- Give users the option to adjust after the template runs, not just before

**Key principle:** Templates work best when the task has a predictable shape. Any tool that
requires a long and specific prompt to get a reliable outcome is a strong candidate.

---

### 5. Nudges
**What it is:** Contextual hints, buttons, or banners that surface AI capabilities at the
moment they're most relevant — without requiring the user to seek them out.

**Three use cases:**
- **In-app clues** — inline AI buttons, suggestion banners, toolbar options that teach users
  what's possible as they work
- **Engagement flags** — appear after a threshold (e.g. enough content exists) to unlock
  richer AI capabilities that require context to be useful
- **Feature onboarding** — introduce new AI capabilities progressively as they become
  available or relevant to the user's current activity

**Design rules:**
- Nudges must be contextual — "Summarize" on an empty page is noise; on a long document
  it's immediately valuable
- Never show a blanket list of all AI features — prioritize by relevance to the current state
- Don't make nudges feel like upsells — if a feature is gated, say so upfront
- Use nudges to build user skills over time, not permanent dependence

**Key principle:** A good nudge is tied to user intent and content state. Too many nudges
crowd the surface and reduce trust. Prioritize the actions most likely to be relevant right now.

---

### 6. Follow-ups
**What it is:** Prompts, questions, or inline actions that help users refine or extend their
initial interaction — picking up where the first generation left off.

**When to use:**
- **Open-ended tasks** — probe deeper into user needs before generating
- **Compute-heavy tasks** — clarify intent *before* a long generation to avoid wasted effort
- **After generation** — suggest what to do next with the result

**Forms:**
- Conversation extenders — what else to explore
- Clarifying questions — "Do you want results for Europe only?"
- Depth probes — "Should I expand the budget section or just summarize it?"
- Action nudges — "Want me to draft an email from this?"
- Export nudges — "Generate a slide from this summary?"

**Design rules:**
- Anchor follow-ups in what just happened — reference the last output specifically
- Show why the follow-up is relevant (not arbitrary automation)
- Keep the list small (2–4); mix "zoom in" and "zoom out" options
- Let users regenerate the suggestion list to explore other directions
- Visually separate follow-ups from the main output

**Key principle:** A well-timed follow-up communicates that the AI is working *alongside*
the user rather than making them start over.

---

### 7. Prompt Details
**What it is:** Making the prompt (and parameters) that produced a result visible alongside
the output — in galleries, feeds, or shared views.

**Why it matters:** Users can learn by reverse-engineering what worked. They can remix, copy,
and build on prompts rather than starting from scratch.

**What to expose:**
- The prompt itself
- Negative prompts (if applicable)
- Model name/version
- Key parameters (length, format, style, seed)
- Referenced attachments with their purpose labeled

**Design rules:**
- Make prompt text one-click to copy or send to input
- Default to visible in discovery and community contexts
- Give creators control to hide their prompts
- Group parameters separately from the prompt text
- Make details interactive — clicking a token or tag adds it to the input

**Key principle:** In a generative setting, prompt details can be action triggers themselves,
not just informational. Visibility accelerates learning and reduces the "I don't know what
to type" problem for new users.

---

### 8. Randomize
**What it is:** A one-click action (often a dice icon) that fills the input with a random
prompt, seed, or style — lowering the bar to entry through play.

**When it's useful:**
- Creative or generative tools where exploration is the goal
- Onboarding moments where users feel blocked or anxious
- Demonstrating the range and personality of what the product can produce

**Design rules:**
- Constrain the random set — curate what's possible so results are delightful, not harmful
- Make it one click, no setup required
- Apply it beyond prompts: randomize styles, parameters, or suggestions
- Use it as a warm-up on-ramp, then guide users toward templates for reliable output

**Key principle:** Delight can be scaffolding too. Randomize turns curiosity into confident
iteration without requiring the user to know anything about prompt engineering.

---

## Decision Framework: Which Wayfinder(s) to Use?

| Situation | Recommended patterns |
|---|---|
| Empty state, user has nothing yet | Initial CTA + Suggestions + Gallery |
| User has content/data but hasn't used AI | Nudges (contextual) + Follow-ups |
| Complex task requiring structured input | Templates |
| User doesn't know what's possible | Gallery + Prompt Details + Nudges |
| After first AI output | Follow-ups + Suggestions |
| Onboarding a new user | Suggestions (static → contextual) + Templates |
| Creative or exploratory tool | Randomize + Gallery + Prompt Details |
| Returning power user | Adaptive Suggestions + Follow-ups |

---

## Universal Principles

1. **Wait for context.** Don't surface AI on an empty state. Let it emerge when there's
   something to act on — content, data, a document, a selection.

2. **Prefer contextual over static.** Wayfinders tied to what's currently on screen are
   always more useful than generic starters.

3. **Reduce, don't overwhelm.** Show fewer, more targeted options — not a menu of every
   capability. Cognitive load is the enemy of first use.

4. **Teach through doing.** Every nudge and suggestion should model what a good prompt
   looks like so users build their own prompting intuition over time.

5. **Expose the reasoning.** Prompt details and follow-up context help users trust outputs
   by understanding how they were produced.

6. **Spend compute wisely.** Structure the input and scaffolding so the system isn't forced
   to guess at vague intent — compute should refine, not search.

---

## Output Format

When applying this skill, produce:

1. **Pattern recommendation** — which wayfinder(s) fit the situation and why
2. **Concrete UI copy** — actual suggestion text, nudge labels, template field names,
   follow-up options
3. **Placement guidance** — where on the screen or in the flow to surface it
4. **Anti-patterns to avoid** — what not to do on this specific surface
5. **Implementation notes** (if requested) — component structure, interaction behavior,
   state conditions that trigger the pattern
