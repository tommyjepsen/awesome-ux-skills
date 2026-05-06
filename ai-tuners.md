---
name: ai-tuners
description: Apply AI Tuner design patterns when adding or improving AI features in a product. Tuners are the controls that let users shape how AI interprets input and produces output — before, during, or after generation. Use this skill whenever the user wants to add AI configuration UI to a product, improve how users control AI behavior, design prompt controls, model selectors, filters, style systems, voice/tone settings, or any mechanism that lets users influence what the AI does. Trigger on phrases like "let users control the AI", "add model switching", "prompt settings", "AI configuration", "let users set tone or style", "negative prompting", "AI filters", "mode switching", "AI parameter controls", or any request to give users more agency over AI output. This skill covers eight tuner patterns: Attachments, Connectors, Filters, Model Management, Modes, Parameters, Preset Styles, Saved Styles, and Voice & Tone.
---

# AI Tuners — Design & Implementation Skill

Tuners are the controls that sit between a user's intent and the model's generation. They let users shape **how** the AI interprets input, weights different considerations, and commits to an output — without requiring them to understand prompt engineering or model internals.

This skill covers the full Tuner pattern family. Read the section(s) relevant to what you're building.

---

## Pattern Index

| Pattern | Core job | When to reach for it |
|---|---|---|
| [Attachments](#attachments) | Ground the AI in specific content | User needs to reference a file, image, URL, or selection |
| [Connectors](#connectors) | Link AI to live external systems | User needs AI to read/act on their own data (Drive, Slack, CRM…) |
| [Filters](#filters) | Restrict or exclude sources/tokens | User needs to scope what the AI considers |
| [Model Management](#model-management) | Let users switch models | Product uses multiple models; users need control or visibility |
| [Modes](#modes) | Bundle behavior into task presets | AI serves distinct use cases requiring different behavior |
| [Parameters](#parameters) | Expose fine-grained generation controls | Power users need sliders, toggles, or flags beyond presets |
| [Preset Styles](#preset-styles) | Curated, browsable style starting points | Users explore styles without knowing technical names |
| [Saved Styles](#saved-styles) | User-defined, reusable style profiles | Teams or individuals need consistent output across sessions |
| [Voice & Tone](#voice-and-tone) | Control how the AI sounds/writes | Outputs must match brand, audience, or personal voice |

---

## Attachments

### What it does
Allows users to provide specific content — files, images, URLs, quotes, canvas selections — that the AI uses as grounding context for its generation. Reduces ambiguity, counteracts hallucinations, and gives users direct control over what the AI references.

### Attachment methods to support
- **Direct upload** — paperclip/file picker in the input area
- **@ mention** — type `@filename` or `@tab` to reference open content
- **URL embed** — paste a link; AI fetches and treats as context
- **Inline text selection** — highlight text → inject as attachment (not into the raw input)
- **Canvas block** — pointer-select a node/div to focus AI on that region
- **Live capture** — screenshot, photo, or audio clip captured in-moment

### Two distinct use modes (design these differently)
1. **Style guide** — attachment shapes how the AI writes/generates (tone, structure, voice)
2. **Primary subject** — attachment IS the thing being analyzed, summarized, or transformed

Make this distinction visible. Midjourney's attachment pane is a good reference: users specify whether an attachment directs the prompt, style, or subject.

### Implementation checklist
- [ ] Allow attachments at any point (first prompt AND follow-ups)
- [ ] Support multiple input methods — not just file upload
- [ ] Show which tokens/signals the attachment is contributing (describe action)
- [ ] Provide citations back to attachment content in the response
- [ ] Visually distinguish style-guide attachments vs. primary-source attachments
- [ ] Encrypt in transit and at rest; never co-mingle with training pipelines by default

### Related patterns
- **Connectors** — for structured data from live systems rather than ad-hoc files
- **Filters** — to constrain which attached sources AI prioritizes
- **Voice & Tone / Saved Styles** — attachments can seed a style system

---

## Connectors

### What it does
Establishes persistent, authorized links between the AI and external systems (Drive, Slack, Notion, Jira, CRMs, wikis). Enables grounded answers from the user's own data and powers background actions without manual file upload each time.

### Three connector scopes
1. **Account-level sync** — index a source once, query it across all sessions
2. **App-side panel** — AI reads context from the suite the user is already in (email → compose reply)
3. **Enterprise connectors** — admin-configured, org-wide, compliance-aware

### Prompt injection risk (critical)
Connected content is untrusted. A calendar invite, email, or wiki page can embed hidden instructions. Design defenses:
- Parse and summarize retrieved content before any tool use
- Gate actions behind explicit user confirmation with a human-readable preview
- Let users exclude sources or switch a thread to read-only
- Show a "Using: Drive, Notion, Slack" chip per message; let users pause sources mid-flow
- Strip or escape prompt-like strings from retrieved content
- Log which sources influenced a proposed action

### Implementation checklist
- [ ] Let users scope connectors (specific workspace, folder, channel — not just "all of Drive")
- [ ] Give each connector a consistent visual identity (icon + label)
- [ ] Surface freshness: when was data last synced? Offer manual refresh
- [ ] Show graceful degradation: "Notion token expired" with Reconnect CTA — never silent failure
- [ ] Use deep links in citations so users can verify in the source system
- [ ] Provide a per-session kill switch to revoke a connector instantly

### Related patterns
- **Filters** — limit which connectors AI draws from for a given query
- **Attachments** — one-off references when a connector doesn't exist
- **Citations** — surface connector-sourced content as verifiable references

---

## Filters

### What it does
Lets users control which sources, tokens, or inputs the AI prioritizes or avoids. Acts as a governor on what the AI considers before producing output.

### Two filter types

**Source filters** — restrict *where* AI draws from:
- "Only academic sources"
- "Ignore blog posts"
- "Search only this workspace"
- "Limit to tickets filed after Q3"

**Token filters** — down-weight *what* the AI generates (negative prompting):
- Image/video: "no blur, no watermark, no text"
- Writing: block brand-inappropriate terms, jargon, or off-topic sections
- Code: exclude deprecated libraries or insecure function patterns

### Implementation checklist
- [ ] Make active filters visible — always show what's constraining the AI
- [ ] Support natural language filter input ("ignore blog posts") not just dropdowns
- [ ] Design recovery: if a filter yields no results, show options to relax constraints — never silent failure
- [ ] Remember user preferences as defaults, but allow per-session override
- [ ] If filters reduce context to the point of low-confidence, nudge the user
- [ ] Combine filters with attachments — filters exclude; attachments include

### UI patterns
- **Dropdown near input** — source category picker (Perplexity model)
- **Inline flag** — `--no [token]` typed directly in prompt (Midjourney model)
- **Sidebar panel** — grouped filter options for complex retrieval systems
- **Mode-linked defaults** — "research mode" automatically applies scholarly-only filter

### Related patterns
- **Connectors** — filter by connector to limit AI to internal vs. external data
- **Modes** — modes can activate filter presets automatically
- **Attachments** — use when you want the AI to rely on a specific resource, not just exclude others

---

## Model Management

### What it does
Gives users visibility into which model is running their generation and the ability to switch between models, balancing accuracy, cost, speed, and capability based on the task.

### Why users switch models
- Accuracy / hallucination rate differences
- Recency of training data
- Cost (prototype on cheap, scale on premium)
- Aesthetic differences (image models have distinct "looks")
- Remixing (generate in one model, refine in another)
- Security / compliance (enterprise may restrict certain models)
- Benchmarking (researchers run same task across models)

### Model tier design
| Tier | Typical user need | Design implication |
|---|---|---|
| Free / lite | Exploration, prototyping | Visible as default, clear upgrade path |
| Pro | Quality-sensitive tasks | Show what's gained vs. free |
| Enterprise | Compliance, governance | Admin-configurable, user-locked |
| Domain-specialized | Coding, legal, medical | Surface alongside general models with task guidance |

### Implementation checklist
- [ ] **Always show the active model** at the point of generation — never hide it
- [ ] Describe models in human terms: accuracy, recency, cost, speed — not just model names
- [ ] Allow mid-conversation model switching without losing context or re-uploading files
- [ ] Offer auto-routing with manual override (don't force one or the other)
- [ ] Show cost/token implications *before* model selection, not after
- [ ] Support cost-aware prototyping: make it easy to drop to a lighter model for drafts
- [ ] In enterprise: admin controls to restrict which models users can access

### Related patterns
- **Parameters** — model selection is itself a parameter; pair with other generation controls
- **Modes** — some modes default to specific models
- **Filters** — model selection can filter the AI's knowledge source by recency

---

## Modes

### What it does
Lets users switch the AI into distinct operational states — changing behavior, output type, enabled features, and cost profile in one action. Each mode represents a "contract" with the user about what the AI will do and how.

### Common mode types
- **Open conversation** — default, flexible back-and-forth
- **Deep research** — longer compute, synthesized citations, more rigorous sourcing
- **Study / tutor** — step-by-step scaffolded explanation, optimized for learning
- **Copilot / build** — canvas or IDE collaboration on an asset
- **Creative** — stylistic variance, less factual constraint
- **Agentive** — AI takes initiative and executes steps autonomously
- **Domain-specific** — "legal brief", "code review", "data analysis" — narrow and tuned

### What a mode change actually affects
- Model config (context length, system prompt, reasoning depth)
- Output structure (citations in research mode; free-form in creative)
- Available features (attachments, plugins, connectors enabled/hidden per mode)
- Token / compute cost
- User expectation ("research mode means rigor and traceability")

### Implementation checklist
- [ ] Treat modes as contracts — behavior must match the mode's promise consistently
- [ ] Design clear entry AND exit paths — mode state must always be visible
- [ ] Reconfigure the surface when mode changes: show relevant controls, hide irrelevant ones
- [ ] Define inheritance rules: what carries across mode switches (memory, attachments) vs. what resets (tone, format)
- [ ] Offer a safe versatile default + optional auto-routing + manual override
- [ ] Preview compute/cost implications before entering expensive modes
- [ ] Allow modes to be toggled within an existing conversation, not just at the start

### UI placement options
- **Tabs on the input CTA** (Perplexity model — most prominent)
- **Dropdown near model selector** (ChatGPT model)
- **Toggle inside conversation** (Claude model — mid-chat switching)
- **Settings panel** for user-defined custom modes (Superwhisper model)

### Related patterns
- **Model Management** — use modes to abstract model differences into task presets
- **Parameters** — expose parameters alongside modes for power users
- **Filters** — modes can activate filter presets automatically

---

## Parameters

### What it does
Exposes the knobs that control how the AI interprets input, weights considerations, and commits to an output. Parameters operate between the prompt and the generation — they shape behavior rather than rewriting intent.

### Parameter form types

| Form | Best for | Example |
|---|---|---|
| **Inline flags** | Power users, CLI-like products | `--no blur`, `--v 6`, `--ar 16:9` |
| **Toggles** | Binary choices | Formal ↔ Casual, Speed ↔ Quality |
| **Sliders** | Continuous ranges | Temperature, creativity, detail level |
| **Dropdowns** | Discrete options | Reading level, output length, aspect ratio |
| **2×2 matrix** | Two related axes | Voice × Formality (Figma Slides model) |

### Visibility strategy
- **Always visible** — parameters that affect cost, speed, or output format (aspect ratio, length, model tier)
- **Panel / drawer** — advanced parameters that most users won't touch
- **Progressive disclosure** — reveal advanced options when they become contextually relevant
- **Inline flags** — for power users who want precision without leaving the input field

### Implementation checklist
- [ ] Make defaults sensible and transparent — never feel like a black box
- [ ] Bundle complexity: offer presets/modes that wrap multiple parameters into one clear choice
- [ ] Keep advanced parameters in drawers/panels, not in the primary UI
- [ ] Treat AI autonomy as an explicit parameter: suggest / ask / execute — never hidden
- [ ] Label expensive parameters clearly before the user runs them
- [ ] Anticipate edge cases: warn when temperature is so high it risks nonsense output
- [ ] Show which parameters a preset or mode is applying under the hood

### Related patterns
- **Modes** — modes wrap multiple parameters into a labeled preset
- **Preset Styles / Saved Styles** — styles are parameters bundled into a portable profile
- **Controls** — parameters shape the run; controls let users stop, pause, or rerun it

---

## Preset Styles

### What it does
Provides a curated, browsable gallery of styles users can apply without writing prompts or knowing model internals. Acts as an onboarding bridge between "I have no idea what to type" and deep customization.

### Applies across modalities
- **Image / video** — visual aesthetic: cinematic, hand-drawn, photorealistic, minimalist
- **Writing** — tone and voice: formal, witty, academic, empathetic
- **Audio** — pacing, warmth, accent, formality
- **Code** — style conventions: commenting style, naming schemes, indentation

### Implementation checklist
- [ ] Organize the gallery around how users actually search (by mood, medium, task — not by model internals)
- [ ] Show realistic previews: thumbnails, audio clips, or inline text samples — not just names
- [ ] Support "audition" — temporarily apply a style without overwriting the current work
- [ ] Show what a preset controls (which parameters it sets under the hood)
- [ ] Allow blending multiple presets or layering with manual edits
- [ ] Support community / team presets alongside system defaults
- [ ] Tag presets with model version and show compatibility warnings when models change
- [ ] Expose a "strength" or "blend" slider so presets adapt rather than overwrite

### Discovery patterns
- Filter by category (medium, mood, creator, use case)
- Search with autocomplete
- Sort by recency, popularity, or staff picks
- Show creator attribution for community styles

### Progression path
Preset Styles → Saved Styles (user remixes a preset into their own)

### Related patterns
- **Saved Styles** — allow remixing from the preset gallery to create personal styles
- **Parameters** — expose parameter controls alongside presets for fine-tuning
- **Voice & Tone** — presets are often the entry point to the voice/tone system

---

## Saved Styles

### What it does
Lets users create, name, and save their own reusable style profiles — so they can produce consistently branded or personally-voiced outputs across sessions without rebuilding prompts each time.

### Applies across modalities
- **Writing styles** — voice, tone, depth, technicality, formatting conventions
- **Audio voices** — pacing, emotional projection, character traits, inferred age
- **Visual styles** — custom art direction: parameters + references + prompt fragments + seeds bundled together
- **Video treatments** — camera, grade, look — consistent across multiple clips
- **Code conventions** — indentation, naming, commenting, error-handling patterns

### Style definition components
- Natural language description of the style (always visible and editable)
- Contextual attachments — sample images, voice clips, reference files
- Negative prompts — tokens or words to avoid
- Fixed tokens — specific pronunciations, character visuals, brand terms
- Parameter settings — emotion, pacing, composition, detail level
- Temperature / adherence setting — strict interpretation vs. creative drift

### Creating new styles
1. Start from a **preset** (remix/clone) — lower effort, visible baseline
2. Define from **scratch** using the components above
3. Train a **LoRA / fine-tuned model** — for teams needing style embedded in model behavior, not just prompts (advanced)

### Implementation checklist
- [ ] Make saved styles accessible from the prompt input — not buried in settings
- [ ] Show previews: sample output, voice clip, thumbnail — not just a name
- [ ] Add usage notes and context hints for team settings
- [ ] Show the active style near the input with its scope (personal / team / system)
- [ ] Support blending styles with each other or with additional references
- [ ] Allow styles to be shared within a team or organization
- [ ] Version styles and show compatibility with current model

### Related patterns
- **Preset Styles** — presets are the discovery surface; saved styles are the personal/team library
- **Parameters** — allow parameter adjustment after a saved style is applied
- **Voice & Tone** — saved styles are the persistence layer for the voice/tone system

---

## Voice and Tone

### What it does
Gives users and teams a system for defining how the AI sounds and writes — ensuring outputs feel on-brand, on-audience, and consistent across multiple users or sessions.

### Key distinction
**Voice & Tone ≠ AI personality.** Personality comes from training (how the AI talks to the user). Voice & Tone shapes how the AI reflects the user back in its outputs. Users care about the latter far more.

### Configurable traits
- General tone and perspective (formal, casual, witty, empathetic, academic)
- Vocabulary (preferred terms, banned terms, jargon level)
- Sentence length and structure (concise vs. elaborate)
- Depth of detail (executive summary vs. deep technical)
- Formatting conventions (headings, bullet use, code commenting style)
- Visual aesthetic (for image-generating products)
- Audio qualities (accent, pacing, pitch, warmth)
- Coding conventions (indentation, naming, documentation style)
- Instructional stance (coach, critic, neutral explainer)
- Cultural / regional variants (US vs. UK, metric vs. imperial)

### Scoping voice settings
| Scope | Use case | Risk |
|---|---|---|
| Global / user | Personal voice applied everywhere | Wrong tone leaks into professional contexts |
| Project / workspace | Team brand voice within a project | More setup; clearer boundaries |
| Per-generation | Quick override at point of use | No persistence; must re-apply |

Design for the scope your users actually need. If you support multiple scopes, always show which voice is active and why.

### Implementation checklist
- [ ] Surface lightweight voice controls at the point of generation (not just in settings)
- [ ] Provide a dedicated "brand kit / voice kit" space for full definition
- [ ] Include previews showing how outputs will sound/look with this voice
- [ ] Make scope explicit — "Using: Team Brand Voice" label near the input
- [ ] Handle conflicts: show which voice wins when personal default and team voice differ
- [ ] Always provide a "Reset to default" action so users feel safe experimenting
- [ ] Pair with memory: store recurring vocabulary, depth preferences, and formatting choices

### Entry points
1. **Lightweight selector** — "make this more formal / casual" inline action (lowest friction)
2. **Voice panel** — richer definition: rules, phrases to use/avoid, tonal markers
3. **Import from example** — paste a writing sample; AI infers the voice
4. **Team settings** — admin-managed brand voice applied org-wide

### Related patterns
- **Saved Styles** — voice definitions are saved as reusable style profiles
- **Memory** — voice settings persist across sessions via memory
- **Model Management** — sometimes switching models is simpler than configuring voice

---

## Design Principles Across All Tuners

These apply regardless of which pattern you're implementing:

1. **Make the active state visible.** Users should always know which model, mode, filter, style, or voice is running. Hidden state = broken trust.

2. **Progressive disclosure.** Most users won't touch advanced controls. Design for the 80% first; put power controls in drawers.

3. **Support natural language.** "Only use academic sources" beats a dropdown with 12 radio buttons.

4. **Bundle complexity into presets.** Modes, presets, and saved styles are all ways of wrapping multi-parameter complexity into a single legible choice.

5. **Design for recovery.** Empty states, failed connectors, over-filtered results — all need graceful fallbacks and next actions, not silent failures.

6. **Show cost implications upfront.** Token use, latency, credit consumption — surface before the user commits.

7. **Never hide what the AI is doing.** Prompt rewrites, source selection, model routing — all should be reviewable and reversible.

8. **Treat autonomy as explicit.** Never let the AI's level of initiative be ambiguous. Let users set whether it suggests, asks, or acts.
