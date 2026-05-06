---
name: ai-inputs
description: Design and implement AI input patterns for products. Use this skill whenever
  the user wants to add an AI-powered input mechanism to their product, improve
  how users interact with AI features, decide which input pattern fits a use
  case, or audit existing AI input UX. Trigger on phrases like "how should users
  prompt this", "add AI input to", "let users control the AI with", "what input
  pattern should I use", "design an AI prompt experience", "how do I let users
  fill fields with AI", "add a regenerate button", "inline AI actions", or any
  request about how users should interact with or direct AI in the product.
  Always use this skill before designing or recommending any AI interaction
  surface.
---

# AI Inputs Skill

This skill covers the full taxonomy of AI input patterns: how users direct,
refine, and control AI in a product. Use it to decide which pattern fits a
given use case and how to implement it well.

## Pattern Taxonomy

There are 13 distinct input patterns. Start by identifying which category the
use case falls into, then read the relevant section below.

| Pattern | Core purpose | When to reach for it |
|---|---|---|
| Open Input | Free-form natural language prompt | Discovery, chat, exploration |
| Madlibs | Structured variables in a template | Repeatable tasks, team consistency |
| Auto-fill | AI populates fields from context | Repetitive data, spreadsheets, forms |
| Inline Action | Preset actions on selected content | Spot edits without leaving flow |
| Inpainting | AI edits a specific region in-place | Surgical changes to generated content |
| Regenerate | Re-run same prompt for a new result | When output is close but not right |
| Expand | Extend content from a seed | Draft-to-full, clip-to-video |
| Restructure | Change structure, keep substance | Condense, reorder, extract, segment |
| Restyle | Change surface style, keep structure | Tone, palette, voice, genre |
| Chained Action | Multi-step connected prompts | Workflows, pipelines, agentic flows |
| Auto-fill (bulk) | Loop prompt across many records | Batch enrichment, bulk generation |
| Describe | Reverse-engineer a generation | Debug, reproduce, understand output |
| Summary | Faithful compression of source | Recaps, digests, meeting notes |
| Synthesis | Interpret and connect across sources | Research, analysis, insight generation |

---

## Pattern Details

### 1. Open Input
Free-form text box that lets users converse with or direct the model.

**Forms:** Chat box · Inline composer · Command + parameters · Side panel composer

**Core design rules:**
- Set a clear default scope. After the first prompt, make what the AI is acting on explicit so users don't accidentally regenerate the whole document when they mean one section.
- Treat blank canvas as a UX problem. Most users can't prompt well from scratch. Support with templates, example galleries, and suggested follow-ups.
- Don't hide parameters. Model selection, tone controls, and mode toggles should stay accessible after the first prompt, not just on it.
- Handle limit errors constructively — tell users what's missing and offer a fix, not a generic failure state.

**Pair with:** Madlibs (guide novices), Parameters (precision), Inline Action (scoped edits)

---

### 2. Madlibs
Template-style input with named variables users fill in. The AI receives the assembled prompt.

**Best for:** PRDs, release notes, outreach emails, any repeatable structured generation.

**Core design rules:**
- Make critical vs. optional variables visually distinct. Don't make users fill in 12 fields when 3 do the work.
- Show the underlying prompt structure to power users. Hiding it feels magical but blocks learning.
- Design for reuse across a team. Variables should map to brand-level constants (tone, audience, product name) so they only need setting once.
- Think multi-step: a Madlibs brief can pass its output as a variable into the next step (outline → draft → email).

**Pair with:** Chained Action (carry variables forward), Templates (prompt library)

---

### 3. Auto-fill
AI runs a prompt across multiple fields or records at once, from a single instruction.

**Forms:**
- **Inline ghost text** — predictions as the user types
- **Prompt replication** — extends one prompt across rows (spreadsheet-style)
- **Form completion** — extracts from text into structured fields
- **Cross-surface transfer** — e.g., meeting transcript → action item tracker

**Core design rules:**
- Always show a sample before bulk-filling. Run 2–3 records first, let users verify, then apply to the rest.
- Never overwrite existing human-written content without confirmation.
- Visually distinguish AI-filled fields from manually written ones until the user accepts.
- For large fills, gate behind a verification step.

**Pair with:** Sample Response (preview before bulk run), Verification (human gate), Chained Action (as a workflow step)

---

### 4. Inline Action
Preset AI actions that appear when content is selected or highlighted.

**Types of inline actions:**
- Suggested prompts → open a new thread
- Restructuring actions → rewrite, reframe, adjust structure
- Restyling actions → change tone or aesthetic
- Transformational actions → change modality (text → audio)

**Core design rules:**
- Show 3–5 high-value defaults (shorten, expand, translate, fix). Keep the list short and contextual.
- Actions should adapt to context — what's relevant in a code editor differs from a document editor.
- Always preview the result inline before overwriting. Require explicit acceptance.
- Support granular scope: word, sentence, paragraph, block.

**Pair with:** Inpainting (for richer region-based edits), Verification (accept/reject), Transform (modality shift)

---

### 5. Inpainting
User selects a region of content; AI edits only that region without touching the rest.

**Works across:** Text (highlight → edit), Images (brush → reprompt), Audio (time selector → regenerate section), Code (select function → replace)

**Core design rules:**
- Provide both rough (brush, auto-select) and precision (lasso, feathering) selection tools.
- Let users adjust the prompt, model, and parameters before committing.
- Blend edits with surrounding context. Let users widen or narrow the context window.
- Offer variations — the model may not nail it on the first try.
- Always verify before overwriting original content.

**Pair with:** Inline Action (trigger inpainting from selection), Verification (commit gate), Variations (compare options)

---

### 6. Regenerate
Re-runs the same prompt + context through the model to produce a new result.

**Modes:**
- **Overwrite** — replaces the previous output (common in chat)
- **Branching** — creates a parallel version (canvas tools, editors)

**Guided forms:**
- **Parameterized** — adjust a setting before rerunning (model, length, tone)
- **Seeded** — use a seed to control randomness and reproduce closely

**Core design rules:**
- Make it clear whether regeneration will overwrite or branch before the user clicks.
- Keep previous results recoverable (version history, variant cycling).
- For creative/exploratory work, support multiple simultaneous branches.
- For convergent work (coding, support), make it fast and single-click.
- Regenerate on error silently should be transparent — tell the user what happened.

**Pair with:** Variations (compare), Draft Mode (iterate cheaply), Randomize (unguided exploration)

---

### 7. Expand
Builds on an existing piece of content without replacing or altering the original seed.

**By medium:**
- **Images** — extend to new aspect ratio or artboard size
- **Video** — add frames to a clip using a script or artboard
- **Audio** — add intro/outro/section without touching existing track
- **Text** — deepen a draft or lengthen an outline
- **Code** — extend a function or add functionality from a snippet
- **Prompts** — turn a short instruction into a full, structured prompt

**Core design rules:**
- Keep the original seed visually intact and distinguished from the expansion.
- Let users scope expansion — a paragraph, a region, a clip segment — not just the whole thing.
- Show how much more is coming before it runs (word count, duration, size delta).
- Highlight what was added so users can diff at a glance.
- Surface compute/token cost early for large expansions.

**Pair with:** Variations (branch expansions), Draft Mode (cheap early iterations), Open Input (prompt the expansion)

---

### 8. Restructure
Changes the structural form of content while keeping its substance intact.

**Types:**
- **Condensing** — shorter while keeping key points (summarize, remove filler)
- **Expanding** — fuller with more detail or context
- **Reordering** — change sequence without changing content
- **Perspective shifting** — rewrite for a different audience or POV
- **Extraction** — pull specific elements (action items, quotes, data)
- **Aggregation** — combine multiple sources into a coherent structure
- **Segmentation** — break large content into smaller units
- **Substitution** — swap elements without rewriting the whole thing

**Core design rules:**
- Use preset labels ("Make shorter", "Extract action items") — don't make users construct restructure prompts from scratch.
- Support nuance with sliders where applicable (reading level, compression ratio).
- Show a diff or highlight what changed before committing.
- Keep stylistic tokens intact: restructure changes form, not voice.
- Allow undo or variant comparison.

**Pair with:** Inpainting (target to a region), Variations (compare before committing)

---

### 9. Restyle
Changes the surface style of content — tone, voice, palette, aesthetic — while leaving structure and meaning intact.

**By medium:**
- **Writing** — tone, register, brand voice
- **Images** — palette, style reference, artistic filter
- **Audio** — genre, vocal style, noise profile
- **Code/UI** — align to design tokens or linting rules

**Core design rules:**
- Keep a hard separation: restyle actions should not restructure. If they do both, that's Restructure.
- Offer preset styles with visual examples. Don't make users imagine what "cinematic" means.
- Provide intensity controls (slight / medium / strong), not binary on/off.
- Support style cloning — let users capture a style from one piece and apply it to another.
- For teams: expose style tokens in galleries to encourage sharing and consistency.

**Pair with:** Memory (persist style choices across sessions), Preset Styles (gallery), Transform (when modality needs to change too)

---

### 10. Chained Action
Connects multiple prompts, tools, and inputs in a structured sequence. Each step's output feeds the next.

**Forms:**
- **Linear chain** — A → B → C
- **Branching chain** — A → B + C (variants)
- **Convergent chain** — A + B → C (blend two inputs)
- **Side-by-side** — A → B and A → C in parallel for comparison
- **Cross-modal** — text → image → video

**Core design rules:**
- Educate through copy. Show users how to inject references and variables at each step. Most users don't know how to chain prompts.
- Make onboarding hands-on. Let users build a working multi-step chain during onboarding, not just read about it.
- Show compute cost per step and in total. Model changes affect cost — make this visible.
- Support lightweight test runs at the step level and the whole-flow level before going live.
- Allow natural language to build chains: "I want to summarize customer feedback and turn it into a feature brief."
- Show errors with context — not just "generation failed" but which step, why, and what to try.

**Pair with:** Madlibs (inject variables at each step), Sample Response (test before publishing), Verification (gate steps on human review)

---

### 11. Describe
User-invoked action that reverse-engineers a generated output into its likely prompt, parameters, and tokens.

**Typical triggers:** Right-click menu · Side panel button · `/describe` command

**Core design rules:**
- If the original prompt is stored, show that first — don't infer when the exact data exists.
- Default to a compact view; let power users expand to see full parameter logs.
- Return 3–4 materially different descriptions, not a long list of near-duplicates.
- Include only parameters that actually change reproduction in your system.
- Make descriptions immediately actionable: one click to send a description into the prompt field as a new generation.

**Pair with:** Prompt Enhancer (iterate on described prompts), Prompt Details (surface details proactively in galleries)

---

### 12. Summary
Faithfully condenses source material to make it easier to understand and act on. No new interpretation introduced.

**Difference from Synthesis:** Summary = compression. Synthesis = interpretation + patterns across sources.

**Core design rules:**
- Prioritize fidelity over brevity. Shorter must still mean true.
- Make scope explicit — users need to know what's included and what's not.
- Use automatic summaries cautiously for opinionated content (news, social) — they can distort tone.
- Offer granularity presets: "short", "detailed", "key points only".
- Attach citations inline so users can verify without leaving the summary view.
- In legal/scientific contexts, offer a "quote and condense" mode that preserves exact phrasing.

**Pair with:** Citations (verify source mapping), References (link to originals), Follow-ups (next steps from the summary)

---

### 13. Synthesis
Combines data from multiple sources and extracts patterns, themes, or insights. Introduces AI reasoning — this is the key distinction from Summary.

**Variants:**
- **Aggregated** — gathers + rephrases without deep interpretation (closest to summary)
- **Comparative** — aligns, contrasts, reconciles multiple viewpoints or datasets
- **Thematic** — extracts underlying patterns from a set (customer feedback, research notes)
- **Generative** — builds new interpretations or implications from references

**Core design rules:**
- Treat synthesis as a transparent process, not a polished result. Show grouping logic, evidence used, and how conclusions connect.
- Separate factual statements from inferred insights visually — different sections, different colors, different labels.
- Expose uncertainty. Use indicators like "limited support" or "conflicting data" rather than presenting all conclusions at equal confidence.
- For thematic synthesis, let users override groupings and labels before they're committed.
- For generative synthesis (most hallucination-prone), expose the full chain of reasoning steps.

**Pair with:** Stream of Thought (show reasoning), Citations (link claims to sources), Summary (when no interpretation is needed)

---

## Choosing the Right Pattern

Use this decision flow when the use case isn't immediately obvious:

```
Is the user starting from scratch or working on existing content?
├── Starting from scratch → Open Input, Madlibs, or Chained Action
└── Working on existing content →
    What scope?
    ├── Whole document/record → Regenerate, Restructure, Restyle, Summary, Synthesis
    ├── Specific region → Inpainting, Inline Action
    ├── Multiple fields/records → Auto-fill
    └── Building from a seed → Expand

Does the task repeat?
├── Yes, same structure → Madlibs or Auto-fill
└── No, one-off → Open Input or Inline Action

Is the goal to change structure or style?
├── Structure (condense, reorder, extract) → Restructure
├── Style (tone, palette, voice) → Restyle
└── Both → Restructure first, then Restyle

Is the user analyzing sources or compressing them?
├── Compressing faithfully → Summary
└── Interpreting and finding patterns → Synthesis
```

---

## Universal Implementation Principles

Regardless of which pattern you use:

1. **Always preview before committing.** For any action that modifies existing content, show a ghost/diff state that requires explicit accept — never overwrite silently.
2. **Mark AI-generated content distinctly.** Use a visual indicator (icon, color, label) on AI-generated values until the user confirms them.
3. **Make scope explicit.** Always communicate what the AI is acting on — a word, a field, a record, a document — before running.
4. **Show cost for bulk or chained actions.** When a pattern processes many records or steps, surface an estimate before running.
5. **Undo is non-negotiable.** Every AI input action that modifies content must be reversible.
