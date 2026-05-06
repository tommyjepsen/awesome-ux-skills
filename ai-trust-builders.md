---
name: ai-trust-builders
description: Apply AI Trust Builder design patterns to give users confidence that an AI product's results are ethical, accurate, and trustworthy. Use this skill whenever a designer, PM, or developer wants to make their AI product feel safer, more transparent, or more accountable. Trigger on: "make users feel safe", "add a disclaimer", "handle user data", "label AI-generated content", "privacy mode", "disclose AI is being used", "watermark AI outputs", "make the AI more transparent", "audit trail for AI", "user consent for recording", or any request touching AI accountability, privacy, explainability, or honest representation of what AI is doing. Also use when auditing an existing AI product for trust signals or when building new AI features into a non-AI-native product. Covers seven patterns: Caveat, Consent, Data Ownership, Disclosure, Footprints, Incognito Mode, and Watermark.
---

# AI Trust Builders

Trust is foundational to any AI product. Users who don't trust the system won't engage deeply with it, and those who over-trust it may be harmed by it. Trust Builder patterns are the design tools that close that gap — they communicate what the AI is doing, acknowledge its limitations, protect user data, and keep humans meaningfully in the loop.

This skill covers seven patterns. Each addresses a different dimension of trust. They are most powerful when combined.

---

## How to use this skill

When a user brings you a trust-related challenge, identify which of the seven patterns apply, explain the pattern clearly, and recommend specific design implementations. Don't recommend all seven patterns at once unless the situation warrants a full audit. Lead with the most relevant 1–3 patterns, explain the tradeoffs, and let the user decide.

Think about context: a consumer chatbot has different trust requirements than an enterprise document editor or a healthcare assistant. Match the pattern intensity to the stakes.

---

## The Seven Patterns

### 1. Caveat

**What it is:** A visible message that reminds users the AI may be wrong, incomplete, or biased.

**When to use it:** Almost always — especially in consumer-facing AI where outputs influence decisions. Required whenever users might act on AI-generated content without checking it first.

**Common placements:**
- A line beneath the chat input: "AI can make mistakes. Check important info."
- A note above generated sections in documents
- An inline flag when the AI flags low confidence
- A spoken disclaimer before or after voice agent results

**Design guidance:**
- Place caveats at the moment of decision, not buried in a footer or shown once at login
- Use plain language. "Check dates for accuracy" beats "This system may produce inaccurate outputs"
- Make caveats specific to context where possible — targeted warnings work better than blanket ones
- Don't treat caveats as sufficient on their own. Pair them with Citations, Footprints, or Wayfinders to actually help users verify and course-correct
- Assume caveats will often be ignored due to habituation. Run evals to catch hallucinations and bias proactively — don't offload all responsibility to a disclaimer

**Pitfall:** Caveats are nearly ubiquitous, which means users are increasingly blind to them. A caveat is a warning label, not a support system. Use it, but don't rely on it.

---

### 2. Consent

**What it is:** Explicitly requesting permission from users — and in some cases, third parties — before recording, analyzing, or processing data with AI.

**When to use it:** Whenever an AI feature captures audio, video, conversation, or biometric data. Especially critical when recording involves people other than the primary user (meeting participants, bystanders, subjects of photos).

**Three domains of consent:**
- **Personal data** — can conversations be recorded, analyzed, or used for training?
- **Organizational data** — does the user's employer permit sharing proprietary content with third-party AI?
- **Other people's data** — are non-primary users being recorded, cloned, or trained on?

**Consent variations:**
- **Opt-in disclosure** — users actively agree before recording begins. Strongest approach.
- **Silent by default** — recording happens without notifying others. Use only when legally permissible and clearly justified.
- **Post-hoc alerts** — participants are notified after recording has started. Use cautiously.
- **Training consent** — separate and explicit permission to use data for model fine-tuning.

**Design guidance:**
- Default to opt-in, not opt-out. Silence is not consent
- Make consent visible and persistent — not a one-time checkbox at signup
- Treat recording consent, training consent, and sharing consent as separate decisions with independent controls
- In group contexts (meetings, calls), notify all participants — not just the session initiator
- Make withdrawal easy, reversible, and immediate. Show users what happens in real time when they revoke consent
- In voice or wearable contexts, use audio, light, or vibration to signal active recording when screens aren't available
- Clarify what declining consent means for product functionality — users should be able to refuse training without losing core features

**Pitfall:** Burying consent in terms of service or making it a condition of using the product. This erodes trust and may violate emerging AI regulations.

---

### 3. Data Ownership

**What it is:** User-facing settings that give people control over how their data is stored, retained, and used — especially for AI model training.

**When to use it:** Any AI product that stores conversations, generates personalized outputs, or trains on user data. Should be surfaced in product settings for all users who interact with AI.

**Key dimensions:**
- **Opt-in vs. opt-out** — does data sharing for training default to on or off?
- **Retention vs. training** — separate controls for "keep my data for service reasons" vs. "use my data to train models"
- **Free vs. paid** — premium users often get stronger privacy controls; be transparent about this
- **Consumer vs. enterprise** — enterprise admins may set org-wide policies; individual users should still receive personal confirmation

**Design guidance:**
- Default to the most privacy-protective setting. Let users opt into sharing, not opt out
- Separate training from retention in the UI — they're distinct decisions and users deserve separate controls for each
- State the default clearly in the settings panel, not just in a linked policy document
- Explain both sides: what the user gets by sharing data, what they give up. Some users will happily share if they understand the benefit
- If your product doesn't train on user data at all, say so explicitly in the settings area — the absence of the toggle can be confusing otherwise
- In enterprise contexts, place data governance settings in admin controls but still surface a personal acknowledgment to individual users when AI is active

**Pitfall:** Defaulting to data sharing because it benefits the company, without offering users a clear, friction-free way to opt out. As AI regulations mature, this will increasingly create legal and reputational risk.

---

### 4. Disclosure

**What it is:** Clear labeling that lets users know when they're interacting with AI — or when content was created or edited by AI.

**When to use it:** Wherever AI generates, edits, summarizes, or responds on behalf of a product. Especially important in blended products where AI content is mixed with human content, in customer support contexts, and in agentic AI products where the AI takes actions.

**Disclosure contexts:**
- **AI-native products** (e.g., a dedicated AI chat tool) — baseline disclosure is implicit, but users still benefit from knowing which parts are human-referenced vs. AI-generated
- **Blended products** (e.g., a document editor with AI writing features) — clearly label AI-generated or AI-edited sections so users can decide what to keep, revise, or discard
- **AI agents and bots** — persistently identify the AI as non-human in any communication channel
- **All cases** — proactively inform users when data is being captured and they cannot fully opt out

**Disclosure forms:**
- **Bot/assistant labeling** — names, avatars, badges, or persistent headers that identify the non-human actor
- **Feature-level labels** — inline chips like "AI Assist" or "Summarized with AI" that signal AI actions
- **Output attribution** — watermarks or badges like "AI-generated" or "AI-edited" on produced content

**Design guidance:**
- Name the actor every time — use a consistent label (name + indicator) across all surfaces and handoffs
- Use verbs in your labels: "Summarized with AI" is more informative than just "AI." Tell users what was done, not just that AI was involved
- Use distinct visual styling for AI-generated content — a subtle background, lower-opacity text, or a persistent header. Ensure this treatment is never confused with human-authored content
- Don't fake human interaction. In support contexts especially, always make it clear when a user is talking to AI and make it easy to reach a human
- For realistic synthetic media (deepfakes, AI-generated video), disclosure should be required by default — not optional
- Give users a way to opt out of AI interaction by requiring a disclosure or announcement before AI begins working

**Pitfall:** Using a vague company name for the AI (e.g., "Assistant") without any indicator that it's non-human. This creates confusion and erodes trust when users eventually figure it out.

---

### 5. Footprints

**What it is:** Visible and machine-readable traces that show where and how AI participated in creating, editing, or deciding something — across both the interface and system levels.

**When to use it:** In any product where users need to verify AI outputs, audit decisions, understand how a result was reached, or reproduce a previous generation. Especially valuable in enterprise, creative, developer, and compliance contexts.

**Two modes:**
- **Generative mode** — footprints act as trails that let users branch, replay, or reuse earlier prompts and outputs. Support non-linear exploration in otherwise linear surfaces
- **Verifying mode** — footprints expose how the AI processed inputs, what sources it used, and what steps it took. Support debugging, auditing, and compliance

**Three levels:**
- **Interface footprints** — badges, inline markers, expandable panels, and annotations visible to the user in real time
- **System footprints** — logs and metadata capturing model version, parameters, safety modes, sources, approvals, costs, and latency. Primarily for admins and auditors
- **Media footprints** — credentials, watermarks, or edit histories that persist when content is exported, copied, or republished

**Design guidance:**
- Build footprints at both the interface and system level. Users need what's visible; admins and auditors need what's logged
- Make footprints discoverable and consistent — use clear iconography and affordances that appear in the same way across the product
- Support branching and replay — let users click a prior footprint to auto-populate a prompt, regenerate an output, or explore a new branch
- Protect sensitive footprints — encrypt logs, restrict access, and provide data retention controls
- Treat footprints as first-class data — expose them via API, make them queryable, and integrate with analytics and compliance tools
- Watch for inadvertent footprints — AI-generated content often carries telltale stylistic markers (overused em-dashes, certain sentence constructions, purple-saturated visuals) that undermine credibility when shared unedited

**Pitfall:** Building footprints only for the interface without system-level logging, or failing to persist provenance data when content is exported. Both create accountability gaps.

---

### 6. Incognito Mode

**What it is:** A private interaction mode where prompts, outputs, and files are excluded from memory, training, and persistent logs — giving users a session that leaves no trace.

**When to use it:** Whenever users need to interact with AI without that interaction influencing their personalized experience, being stored, or being accessible to others. Valuable for exploration, sensitive drafting, vendor evaluation, and enterprise compliance.

**Common use cases:**
- Testing prompts without contaminating AI recommendations
- Drafting sensitive content before moving it into a governed workspace
- Corporate users keeping proprietary information out of stored histories
- Vendor trials where data residency and training exclusions are contractually required

**Variations:**
- **Local-private** — everything is device-local; nothing is stored on the server
- **Ephemeral session** — prompts and outputs exist on the server during the session but are automatically purged after a short period
- **Scoped-private** — the session is private by default; users can deliberately publish outputs to memory or shared spaces
- **Incognito-by-context** — AI features are automatically suppressed when the user is already in a private browsing session
- **Enterprise-governed** — private mode with admin controls defining retention rules, export allowances, and audit hooks

**Design guidance:**
- Make the active mode unmistakable — use strong, persistent visual indicators (dark header, unique icon, watermarked background) plus a plain-language statement like "Nothing here is remembered or shared"
- Exclude all prompts, files, and outputs from memory and training — private sessions must be truly sealed; nothing should influence personalization or fine-tuning afterward
- Limit integration scopes in private mode — connectors, APIs, and enterprise data integrations should load with reduced or null permissions. Show users what has been temporarily disabled
- Provide an easy toggle in a prominent location; private mode shouldn't require digging through settings

**Pitfall:** Creating "incognito mode" that still logs data server-side without telling users. This destroys trust if discovered and may violate privacy commitments.

---

### 7. Watermark

**What it is:** A signal embedded in or attached to AI-generated content to identify its synthetic origin — ranging from visible labels to invisible machine-readable fingerprints.

**When to use it:** Whenever AI generates content that will be shared, published, or used outside the product — including images, video, audio, and text. Also when the product receives user-uploaded content and needs to verify its origin.

**Watermark types:**
- **Overlay watermarks** — visible symbols or text added as a post-processing step. Easy to apply, easy to remove
- **Steganographic watermarks** — imperceptible patterns embedded in the content structure. More persistent, but can be degraded by minor modifications
- **Machine learning watermarks** — AI-readable keys embedded by another model. Strongest approach, but can degrade as content is modified
- **Statistical watermarks** — randomized patterns injected by the generator itself. Resistant to casual removal

**Content provenance (alternative/complementary):** Embeds a digital fingerprint into the content's metadata, tracking the full history of creation and edits. Requires platform cooperation but survives across platforms that support the standard.

**Regulatory context:** Multiple governments are moving toward watermarking mandates. The EU AI Act, US Executive Orders, and similar regulations are creating requirements — especially for realistic synthetic media. Designing for watermarking now reduces future compliance burden.

**Design guidance:**
- Match visibility to the audience — consumers may need clear overlays or labels; creators and researchers may prefer metadata-level tracers
- Combine visible and invisible watermarking — visible labels deter casual misuse, invisible tracers provide forensic accountability
- When surfacing watermarks, provide context: source model, generation time, edits applied, verified publisher
- Standardize where watermark details appear (e.g., a "Content Info" panel) so users build a consistent mental model
- Where regulation mandates disclosure, comply fully. Where it doesn't, give creators options while maintaining baseline consumer protection
- Pair watermarks with Prompt Details or Citations to make the full generative process legible — watermarks authenticate origin, these patterns explain process

**Pitfall:** Relying on a single watermark type in isolation. Overlay watermarks are trivially removed. A defense-in-depth approach using multiple methods provides more durable provenance.

---

## Pattern Relationships

These patterns work together. A strong trust architecture typically combines several:

| Challenge | Recommended patterns |
|---|---|
| Users don't know AI is in the product | Disclosure + Caveat |
| AI outputs might be wrong or incomplete | Caveat + Footprints + Citations |
| Recording or transcription involves others | Consent + Disclosure |
| Users worry their data is being trained on | Data Ownership + Consent |
| Need to audit AI decisions later | Footprints (system level) |
| Users want to explore without consequences | Incognito Mode |
| AI content is being shared outside the product | Watermark + Footprints (media level) |
| Enterprise compliance requirements | Data Ownership + Footprints + Incognito Mode |

---

## Output format

When applying these patterns, structure your response with:
1. **Which pattern(s) apply** and why
2. **Specific implementation recommendations** (placement, copy, interaction behavior)
3. **What to avoid** (the most common pitfall for each pattern)
4. **How the patterns connect** to each other in this context

Always ground recommendations in the user's specific product context — a consumer chatbot, an enterprise tool, and a creative platform have meaningfully different trust requirements.
