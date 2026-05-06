---
name: ai-governors
description: Apply the Governors framework to design or audit human-in-the-loop features that keep users informed, in control, and safe as AI acts autonomously.
  Use this skill whenever someone is designing or reviewing AI product features involving oversight, trust, transparency, or control — including "how do I keep users in the loop", "how should I handle risky AI actions", "users don't trust the AI", "how do I prevent costly AI mistakes", "should I ask for confirmation before this action", "how do I show AI reasoning", "users are scared the AI will overwrite their data", "how do I handle AI memory and privacy", or any request about making an AI feature feel safe and controllable.
  Trigger even when the user doesn't say "governor" or "human-in-the-loop" — if they're designing any AI feature and the question touches on control, trust, transparency, cost, risk, or oversight, use this skill.
---

# Governors — Human-in-the-Loop Design Patterns

Governors are design patterns that keep users meaningfully in control as AI systems act on their behalf. They exist because autonomy without transparency erodes trust, and actions without oversight can cause irreversible harm.

## How to use this skill

When someone asks for guidance on AI oversight, transparency, or control:

1. **Understand the context**: What is the AI doing? How autonomous is it? What's the blast radius if something goes wrong?
2. **Identify the risks**: Use the Risk & Pattern Guide below to map the situation to the right patterns.
3. **Recommend specific patterns**: Give concrete, actionable guidance from the pattern reference.
4. **Flag tradeoffs**: Every Governor adds friction — help the user calibrate where oversight is worth the cost.

---

## Risk & Pattern Quick Guide

Use this to select the right Governor(s) for the situation:

| Situation | Recommended Pattern(s) |
|---|---|
| AI will take a long or expensive action | Action Plan + Verification + Cost Estimates |
| AI is acting autonomously in the background | Shared Vision + Stream of Thought + Controls |
| User needs to verify AI's intent before a destructive action | Verification + Sample Response |
| User is unsure what outcome they want yet | Variations + Branches + Draft Mode |
| AI cites or summarizes external/internal sources | Citations + References |
| AI remembers things across sessions | Memory |
| Generation will consume significant compute/credits | Cost Estimates + Draft Mode |
| AI acts in a multi-step workflow | Action Plan + Stream of Thought + Controls |
| User wants to explore multiple directions without committing | Branches + Variations |
| AI is running in agent/operator mode | Shared Vision + Verification + Stream of Thought |
| User wants to preview before full output | Sample Response + Draft Mode |

---

## The 13 Governor Patterns

### 1. Action Plan
**What it is**: AI lays out its intended steps before executing, giving users a chance to confirm or adjust.

**Two modes**:
- *Advisory*: Plan is shown in the stream of thought for orientation — no blocking confirmation required
- *Contractual*: Execution is gated on explicit user approval (use for high-compute or high-risk tasks)

**Key design guidance**:
- Show the plan before resources are committed — the right time to catch an error is before it runs
- Keep it skimmable: users should grasp intent in a few seconds
- Make it modifiable: let users fix errors in the plan without regenerating the whole thing
- Let experienced users bypass or collapse the plan
- Ensure fidelity between plan and execution — silent deviation destroys trust

**Real examples**: Replit pauses on a proposed sequence. Gamma generates an outline requiring confirmation. Cursor makes action plans optional in settings. Zapier shows a workflow outline in AI Drafting mode.

---

### 2. Branches
**What it is**: Multiple parallel paths of generation or exploration, each preserving the original context.

**Three forms**:
- *Text chat branches*: Split conversation into parallel threads
- *Variant branches*: Auto-generate multiple paths from the same source
- *Workflow branches*: Split a graph node so different parameter sets run side by side

**Key design guidance**:
- Maintain the source relationship — always provide a trail back to the origin
- Make branching a first-class action at obvious touchpoints (message actions, artifact tiles, nodes)
- Let each branch progress independently with a compact summary of inherited context
- Support lightweight merge patterns — "adopt this answer into main thread" — avoid destructive merges

**Real examples**: ChatGPT "Branch in new chat", TypingMind forked threads, FloraFauna visual canvas branches, Rivet convergent workflow branches, Midjourney variant exploration.

---

### 3. Citations
**What it is**: Connections from generated output back to its underlying source material.

**Four forms**:
- *Inline highlights*: Best for attached material like PDFs (Adobe Acrobat)
- *Direct quotations*: For transcripts and longer text (Granola)
- *Multi-source references*: For search/aggregation contexts (Perplexity)
- *Lightweight links*: For transparency-first use cases (Copy.ai)

**Key design guidance**:
- Point to exact passages when information is presented as factual; broader links when the goal is discovery
- Place citations where people expect them — inline for sentence-level claims, panels for long-form
- Offer hover preview so users can judge relevance without full navigation
- Make broken or missing citations explicit — never substitute filler content
- Let users rescope references after generation

**Real examples**: Adobe Acrobat paragraph-level citations, Granola transcript quotes on hover, Perplexity numbered inline sources, Sana popover with highlighted source passages.

---

### 4. Controls
**What it is**: UI mechanisms that let users stop, pause, and manage AI actions in flight.

**Common controls**:
- *Stop*: Ends the request immediately; work may be lost
- *Pause*: Stops without losing progress (essential for long-running coding agents)
- *Fast-forward*: Skip to end of long generations when the direction is clear
- *Queue*: Stack tasks for the AI to process sequentially

**Key design guidance**:
- Stop button should always be in the same place and remain clickable until generation completes
- Pause + resume is essential for long-running agentic tasks — don't force restarts
- Queue allows users to stay in the flow of work without canceling current tasks
- When regenerating, show the new version as an iteration — don't silently overwrite

**Real examples**: Claude's stop button, ChatGPT skip-to-end in research mode, Replit task queue, Perplexity interrupt-with-context while running, Julius step-by-step workflow runs.

---

### 5. Cost Estimates
**What it is**: Transparent display of compute/credit costs before and during generation.

**Key cost factors**: model size, prompt/context length, expected output length, steps in a workflow chain, inference loops.

**Credits vs. dollars**: Technical users prefer dollar values; non-technical users benefit from product-specific credit systems, but these lack cross-product comparability.

**Key design guidance**:
- Make the unit explicit (tokens, credits, seconds of video) and map to money where possible
- Show ranges for unknowns — present low/high estimates and update in real time during streaming
- Surface cost drivers (system prompt, context, tool calls, output) so users know what to trim
- Offer cheaper paths proactively: batch mode, draft mode, lower model tier
- Place estimates where decisions are made — inline at the prompt, per-step in builders, on action buttons

**Real examples**: Adobe Firefly credits beside generate button, ElevenLabs cost shown from input box, Krea credit estimate in builder sidebar, Udio live cost update as user configures.

---

### 6. Draft Mode
**What it is**: Lower-fidelity, lower-cost generation before committing to the full, expensive run.

**By modality**:
- *Image/video*: Lower-scaled previews (Midjourney, Runway)
- *Audio*: Short clips before full track (ElevenLabs)
- *Code/tools*: Plan previews or rough interfaces (Replit)
- *Text*: Outline before full document (Jasper, Gamma)
- *Presentations*: Slide outline before full deck (Chronicle, Gamma)

**Explicit vs. implicit drafting**:
- *Explicit*: A named "draft mode" — works well in visual media where quality reduction is visible and intentional
- *Implicit*: Fewer inference steps, snippet preview, or automatic cheaper model routing

**Key design guidance**:
- Never surprise users with lower quality — always signal that draft mode is active
- Describe what's reduced (model tier, steps, resolution, duration) alongside speed/cost impact
- Preserve seeds and parameters between draft and final — keep upgrade paths deterministic
- Keep "upgrade to full" one click away; design for rapid iteration loops
- Never silently route heavy tasks into draft quality without notice

---

### 7. Memory
**What it is**: AI retains and reuses information across sessions, creating continuity.

**Three scopes**:
- *Global memory*: Applies across all surfaces (ChatGPT's viewable memory)
- *Scoped memory*: Retained within a workspace, project, or conversation (Perplexity Spaces)
- *Ephemeral memory*: Session-only, no persistence (incognito-style)

**Risk**: Without clear controls, AI may misremember, overgeneralize, or accumulate incorrect details — a kind of "AI psychosis" from flawed recollections.

**Key design guidance**:
- Memory must never be a black box — show when new memories are added with a lightweight chip ("Saved to memory")
- Differentiate preferences (communication style) from facts (who the user is) — these may have different scopes
- Allow code switching: personal vs. work memory should not bleed into each other
- Make memories editable and deletable; support a clean "reset memory" option
- Support "memory off" / incognito mode for sensitive work

**Real examples**: ChatGPT inline memory capture notification, Gemini user-managed memory store.

---

### 8. References
**What it is**: The external materials AI retrieves and uses to shape output, made visible and manageable.

**Three layouts**:
- *Panel*: References grouped prominently beside content — best when sources are central to the user's goal
- *Hidden aside*: References in a tab or drawer — best when focus belongs on the answer (Perplexity, Notion)
- *Nested*: Sources grouped at top/bottom of content block with limited metadata — best in compact surfaces

**Key design guidance**:
- Make references easy to locate — place them consistently
- Match prominence to intent: panels for research tasks, drawers for answer-first contexts
- Show just enough metadata (favicon, title, maybe description) — balance detail with scannability
- Give users control over references after generation (add, remove, rescope to specific domains)
- Handle broken or missing sources explicitly — never substitute filler

**Real examples**: ChatGPT DeepResearch side panel, Perplexity inline citations + sources drawer, Notion hidden reference drawer, Glean nested sources in chat, Dia references hidden panel.

---

### 9. Sample Response
**What it is**: A full-quality, lightweight proof-of-concept output before committing to the full, costly run.

**Context-appropriate samples**: A single row in a table, a 30-second audio clip, a thumbnail image, a short paragraph before a full draft.

**Key distinction from Draft Mode**: A sample is full-quality on a small subset (confirms intent); Draft Mode is reduced-quality on the full scope (reduces cost).

**Key design guidance**:
- Show final-quality intent — the sample proves the AI understood the prompt correctly
- Let users skip the sample for subsequent runs once they trust the prompt
- Show cost-per-record and total run cost alongside the sample
- Default to sampling when risk or blast radius is high (many records, irreversible changes)
- Display the sample in a panel or overlay — don't write over existing content

**Real examples**: Notion's "try on this view" before full database autofill, Zapier single-record test before automation runs at scale.

---

### 10. Shared Vision
**What it is**: Ambient affordances that let users passively monitor and intervene in AI activity without disrupting its flow.

**Physical world analogies**: Tesla Autopilot LED indicators, GM Super Cruise steering wheel colors — subtle cues about AI state that don't demand attention.

**Key design guidance**:
- Warn users proactively: have the AI review needed permissions up-front, not mid-task, so interventions don't feel like surprises
- Don't let users conflate oversight with full security — prompt injection and other attack vectors still apply
- Let users constrain scope — limit shared view to a specific tab or frame, not full system access
- Signal boundaries visually and persistently with overlays, colored outlines, or tooltips showing the AI's field of view
- Include screenshots and specifics in the AI's stream of thought so users can audit retroactively

**Real examples**: Perplexity Comet tab glow when AI is active, ChatGPT Operator Mode live browser panel inside the conversation, Zapier human-in-the-loop workflow approval steps, Relay approval step types.

---

### 11. Stream of Thought
**What it is**: The visible trace of how the AI moved from input to answer — plans formed, tools called, decisions made.

**Three expressions**:
- *Human-readable plans*: What the AI intends to do (before)
- *Execution logs*: Tool calls, code run, results returned (during)
- *Compact summaries*: Logical reasoning, insights, decisions (after)

**Key design guidance**:
- Show the plan before acting — editable, with costs and required permissions surfaced early
- Separate plan, execution, and evidence — keep three views synchronized: will happen / happened / supports the result
- Tailor visibility to context: simple chat needs little; agentic coding or research tasks need full traces
- Make steps into states: queued → running → waiting for approval → completed / error
- Respect modality — in text, link outputs back to the step that created them; in voice, summarize the current action in one sentence

**Real examples**: ChatGPT inline reasoning trace, Perplexity steps tab above results, Lovable real-time action log, V0 inline logic then left-drawer build progress.

---

### 12. Variations
**What it is**: Multiple permutations of the AI's output for the user to compare and choose from.

**Three forms**:
- *Branched variations*: Multiple outputs from the same seed, shown in a grid (Midjourney, Krea, Adobe Firefly) — common for image/video
- *Convergent variations*: Inline alternatives where the user selects one to merge into the main content (GitHub Copilot, Copy.ai)
- *Preset variations*: Pre-defined transformations applied to the same content (Grammarly, Writer.com tone/length options)

**Key design guidance**:
- Keep follow-up actions close at hand — let users branch, select, or merge directly from the variant
- Allow additional generation from the same starting point if the first set misses
- Use parameters to give users control over variance (seed consistency, number of variants)
- Never overwrite the original without explicit confirmation — variations extend the workspace

**Real examples**: Adobe Firefly grid of variants with dropdown actions, Copy.ai inline variant selector, Writer.com preset transformations, FloraFauna canvas-based branching variations.

---

### 13. Verification
**What it is**: A required human approval step before the AI takes an action with meaningful negative consequences.

**When verification is warranted** (potential for real harm):
- Loss of reputation (poorly written email sent on behalf of the user)
- Loss of money (errant purchase or unexpected compute cost)
- Loss of security (shared personal or corporate data)
- Loss of work (overwritten records)
- Loss of time (errors requiring manual cleanup)

**When verification is not warranted**: Simple, low-risk, easily reversible tasks (running a search, drafting a message). Verification there creates prompt fatigue and becomes meaningless.

**Types of verification**:
- *Simple go/no-go*: Confirm an action plan or sample response before proceeding
- *Proactive platform rules*: System-enforced halts at sensitive moments (OpenAI Operator pauses before payment data)
- *User-configured rules*: User-defined conditions for when to stop — similar to Zapier/Relay human-approval workflow steps

**Key design guidance**:
- Match friction to risk: high-impact + irreversible = strong confirmation; routine = light check or post-hoc notification
- Use opt-out settings ("never show again") for repeated low-stakes confirmations
- Make clear when verification is skipped — show affordances and allow opt-back-in at any time
- Alert the user when action is needed — route approvals via Slack, email, or SMS to minimize stall time

**Real examples**: Cofounder agent "Always Ask" toggle with prominent red warning when disabled, Notion inline verification for data overwrites, Chronicle outline approval before presentation build, Replit action plan confirmation before build, Dovetail insight verification before research synthesis.

---

## Pattern Relationships

Governors work together. Common pairings:

- **Action Plan → Stream of Thought**: Plan sets expectation; stream tracks fidelity during execution
- **Action Plan → Verification**: Gate high-stakes plans behind explicit confirmation
- **Draft Mode → Cost Estimates**: Drafts save compute; show users exactly how much
- **Sample Response → Verification**: Confirm a sample before cascading it across many records
- **Shared Vision → Controls**: Users observing an agent need the ability to stop or intervene at any moment
- **Citations + References**: Citations point inline; References organize the full source set
- **Memory → Verification**: Before saving sensitive data to persistent memory, consider a confirmation step

---

## Calibrating friction vs. speed

The temptation is to add Governors everywhere. Resist it. Every confirmation adds friction, and prompt fatigue causes users to click through approvals reflexively — defeating their purpose.

Calibrate with two questions:
1. **What's the worst case if this goes wrong?** (reversible vs. irreversible, low-stakes vs. high-stakes)
2. **How often will this action occur?** (one-time vs. repeated, novel vs. familiar)

- High-stakes + infrequent → strong verification, visible stream of thought
- Low-stakes + frequent → passive indicators (shared vision) or skip governors entirely  
- High-stakes + frequent → provide opt-out settings after first confirmed run
- Low-stakes + infrequent → light check or confirmation after the fact
