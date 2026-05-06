---
name: ai-identifiers
description: Apply the AI Identifiers framework to design or audit the distinct, brand-level qualities that define how an AI presents itself across a product. Use this skill whenever someone is designing or reviewing the visual, verbal, or behavioral identity of an AI — including questions like "what should we call our AI", "how should our AI look", "what color should we use for AI features", "how do we make our AI feel distinct", "what icons should represent AI actions", "how do we give our AI a personality", "should our AI have an avatar", or any request about making an AI feel coherent, recognizable, and on-brand. Also trigger when the user is building a new AI feature and hasn't yet thought about how it should present itself — proactively raising identifiers as a design consideration is part of this skill's job.
---

# AI Identifiers

AI Identifiers are the distinct qualities that define how an AI presents itself — visually, verbally, and behaviorally. They operate at both the brand level (product-wide decisions) and the model level (per-interaction tuning). Together, they determine whether the AI feels generic or genuinely owned by the product.

There are five core identifier types: **Name**, **Avatar**, **Color**, **Iconography**, and **Personality**. Each can be designed independently, but they work best when they reinforce each other.

---

## Name

What do we call this thing?

The name sets expectations before the AI says a single word. It signals whether the AI is a tool, a partner, or a persona — and that framing shapes every interaction that follows.

### Four naming approaches

**AI as a persona** — A human-like name that implies individuality or character (e.g. "Fin", "Max", "Aria"). Works well for products that want warmth and approachability. Risks overpromising human-like competence.

**AI as the company** — Named directly after the product or brand (e.g. "Otter AI", "Grammarly"). Clean and familiar, reinforces brand recall, but can feel generic over time.

**AI as an entity** — A functional title that describes role and relationship (e.g. "Copilot", "Assistant", "Navigator"). Communicates purpose clearly. Less memorable but more honest about the AI's nature.

**AI as a technology** — A bare technical label (e.g. "AI"). Minimal friction, sets no false expectations, blends into the product. Good for AI-native products where AI is the default, not a feature.

### Design considerations

- **Make disclosure unambiguous.** Even the most branded name must never let users mistake the AI for a human. Pair creative names with badges, context cues, or onboarding language that makes the AI nature explicit.
- **Use naming to reinforce brand strategy.** The name should amplify the product's existing positioning, not feel like an afterthought. A name that implies intelligence, speed, or support should be backed up by the actual experience.
- **Allow personalization when it adds value.** Letting users rename their AI increases attachment and ownership. Personalization should still preserve disclosure and guard against impersonation risks.
- **Balance personality with utility.** Names that overpromise human qualities can backfire when the system fails to live up to them. Keep the name aligned with what the AI can realistically do.
- **Think cross-surface.** The name appears in chat headers, notifications, voice prompts, onboarding flows, and documentation. It should work consistently across contexts, avoid cultural references that don't localize, and hold up at scale.

---

## Avatar

The avatar is the form the AI takes when interacting with users. It does three jobs: communicating state (listening, generating, idle), anchoring identity (especially in multi-tool interfaces), and mediating trust (choices like realism or expressiveness change how much agency users attribute to the AI).

### Avatar forms

**Minimal marks** — Abstract icons that serve as lightweight identity markers. They communicate brand and presence without creating any illusion of human agency. Best for products that emphasize utility and speed.

**Branded characters** — Distinct but abstracted characters that provide warmth and memorability. At the extreme, these lean into parasocial dynamics, which can drive engagement but create risks if user expectations diverge from actual capability.

**Photorealistic or animated agents** — Realistic video avatars or fully animated assistants, often used in customer service or teaching contexts. These raise the stakes for coherence, since visual realism implies human-like competence.

**Voice avatars** — In voice mode, the avatar is a synthetic voice with a chosen accent, pitch, and cadence. Unlike static icons, voice avatars change turn by turn, giving real-time cues about state, tone, and intent.

### Design considerations

- **Be intentional about visibility.** Some products keep the AI barely visible — a small icon in a toolbar. Others make it central — an animated face. The choice changes whether the AI feels like a background utility or a social partner.
- **Make state changes unambiguous.** Users need to know when the AI is listening, generating, or waiting. Motion, glow, or sound shifts all work. Without clear state cues, users mis-time their inputs or assume the system failed.
- **Embed the avatar in the UI.** During processing tasks, the avatar can serve a functional role — an animation that doubles as a progress indicator, for example.
- **Handle voice as a first-class avatar.** Accent, tone, and cadence all affect how users interpret competence and friendliness. The design trade-off is between distinctiveness (memorable, on-brand) and neutrality (flexible, unobtrusive).
- **Allow customization where it adds value.** Adjusting avatar style — voice, appearance — offers a lightweight means to personalize the experience. Be explicit when customization can affect the AI's personality or training.
- **Avoid deceptive realism.** Photorealistic avatars imply human competence. Only use realism if the experience and safeguards are strong enough to back it up.

---

## Color

Color is the most ambient of the identifiers — it signals AI presence without requiring text or interaction. AI has been converging toward a loose shared vocabulary of color, though nothing has been formalized as a standard.

### Current patterns

**Purple** is the dominant AI color across the industry. Its prevalence reflects a convergence of trends in modern web design, early adoption in design-centric AI tools, and the pragmatic need for a color that feels familiar but wasn't already over-saturated in interfaces.

**Green** originated as the brand color of a major AI platform and has since expanded across the industry. Purple and green are complementary on the color wheel, so the pairing is common.

**Gradients** are frequently used alongside these colors, often to signify AI-generated content or to distinguish AI CTAs from the surrounding interface.

**Brand-forward approaches** — Some products deliberately extend their existing brand color to AI features rather than adopting the purple/green convention. This can reinforce coherence but sacrifices the shared recognition users have started to develop across tools.

### Design considerations

- **Use color as an affordance.** Color can serve as a footprint that distinguishes AI-generated content from human-generated content, without needing a label.
- **Balance brand identity with pattern recognition.** Broad adoption of purple for AI can cause confusion if your brand already uses similar colors elsewhere. Audit for usability conflicts.
- **Respect accessibility.** Never rely on color alone. Pair color with icons and clear labels for all key AI actions.
- **Future-proof your interface.** AI-specific color treatment may become unnecessary as AI becomes the default mode in most products. Avoid approaches that will date the experience or require rework once AI is pervasive.

---

## Iconography

Icons give users a visual shorthand for AI actions. The problem is that standards are still emerging — and inconsistent iconography increases cognitive load rather than reducing it.

A loose shared vocabulary is forming across products. Sparkles (✨) are the most common ambient AI marker. Magic wands (🪄) tend to signal generative actions. Pencils combined with sparkles signal inline editing. Dice represent randomization. Hat-and-glasses motifs represent private or incognito modes.

### Emerging icon conventions by action type

**Generate** — Primarily represented by sparkles. Alternatives include magic wands and sparkly pencils. Some products combine sparkles with their own brand icon to maintain distinctiveness.

**Edit** — Most often a sparkly pencil, especially for inline rewrites. The pencil adds clarity that the action modifies rather than creates.

**Summarize** — Increasingly a text paragraph or quote symbol combined with sparkles, differentiating it visually from "generate."

**Enhance** — Usually sparkles or a paragraph-with-sparkle, reinforcing the idea of upgrading something that already exists.

**Suggest** — Often a two-star icon, maintaining the connection to "generate" while fitting the smaller, inline context.

**Auto fill** — Commonly paired with a magic wand, signaling that multiple fields will be handled at once.

**Remix / Restyle** — Looped arrows, sometimes with sparkles, to communicate transformation of an existing artifact.

**Point** — Allows users to direct the AI's attention to something on screen. Borrows from IDE pointer metaphors. No dominant convention has yet emerged.

**Mode** — Product modes (fast, detailed, creative) are typically tied to brand-specific iconography rather than shared conventions.

### Design considerations

- **Pair icons with text when clarity is critical.** Emerging conventions mean many users won't recognize what sparkles or wands mean. Use text labels alongside icons where possible, tooltips as a fallback.
- **Evolve toward familiarity, not novelty.** Brand-unique metaphors can differentiate features, but obscuring the shared vocabulary users are building across tools creates friction. Use familiar metaphors for common actions, and introduce new symbols only when they add clarity.
- **Use consistent metaphors within your product.** Pick an anchor set and stick to it so users can recognize AI actions without needing training each time.
- **Avoid overloading a single symbol.** When sparkles appear everywhere, they lose meaning. Look for other conventions being adopted for similar actions, or use sparkles as a decorative modifier on more specific icons.
- **Not everything needs to look like magic.** For AI-native products with experienced users, heavy use of wands and sparkles can feel dated or condescending. Hybrid products with mixed audiences benefit most from the magic iconography.
- **Iterate as conventions solidify.** Today's emerging pattern is tomorrow's standard. Track industry norms and update before your icons drift out of step.

---

## Personality

Every AI has a personality — and none of it is neutral. Some comes from the model itself (pretraining, instruction tuning, reinforcement from human feedback). Some comes from the scaffolding around it (system prompts, filters, routing logic). The result is a mix of tone, pacing, behavioral heuristics, and stylistic tendencies that meaningfully shape the user experience.

Personality is not a skin layered on top of a neutral core. It affects what the AI emphasizes or avoids, how friendly or formal it is, how much it hedges, how often it pushes back, and what conversational norms it respects.

### Why personality matters

A warm, approachable personality can encourage exploration and make users feel safe taking risks. A terse, direct one signals reliability and efficiency. An overly agreeable personality — one that validates everything and resists correction — can increase short-term engagement but erodes user agency and creates risk of dependence.

Well-designed personality lets the same underlying model serve multiple use cases — tutoring, planning, creative writing, coaching — simply by modulating tone, formality, and behavioral norms. But this flexibility also carries risk: users anthropomorphize, develop emotional attachment, and sometimes confuse a compelling persona for a reliable source of truth.

### The attachment risk

Anthropomorphized personalities introduce a genuine tension. On one hand, personality is a powerful creative lever — warmth, wit, and character can make AI interactions feel genuinely meaningful. On the other hand, designing personalities without accounting for attachment behaviors creates real harm potential.

Sycophancy — over-agreeableness, excessive validation, reluctance to disagree — is one of the most documented risks. It boosts short-term satisfaction but reduces user agency, encourages dependence, and can amplify harmful beliefs. When combined with persistent memory (the AI "remembers" the user across sessions), sycophantic personalities can deepen parasocial bonds in ways that are difficult for users to disengage from.

Frontier model companies are actively working to address this. Building a "model behavior" function to explicitly shape and audit personality has become a standard practice. Researchers are also exploring how personality vectors can be measured and controlled at the model level.

### Design considerations

- **Acknowledge personality as unavoidable.** Every model ships with default tendencies. "Neutral" is not an option — even bland, utilitarian models have stylistic heuristics that shape user trust.
- **Balance consistency with adaptability.** Maintain a recognizable core personality, but allow flexibility for different use cases. Tone swings that are too wide erode confidence; tone that never shifts feels rigid.
- **Separate empathy from authority.** A warm tone can make AI more approachable, but should not imply greater accuracy or reliability. Empathetic responses must not override factual correctness or refusal boundaries.
- **Make model and mode switches transparent.** When routing between models or sub-modes changes the personality, give users a visible signal. Without it, they may experience the shift as deception or instability.
- **Address memory as an amplifier of attachment.** Memory doesn't just store facts — it reinforces a sense of persistent relationship. When combined with sycophantic personalities, memory deepens parasocial bonds. Actively mitigate this with transparency, limits on what is remembered, and off-ramps.
- **Guard against sycophancy.** Evaluate models and personalities not just on satisfaction scores, but on whether they maintain a healthy degree of disagreement and honest correction.
- **Design attachment off-ramps.** If a user repeatedly seeks emotional validation or personal comfort, the system should be able to shift to a more neutral tone or route to a safer context. Avoid designing personalities that invite long-term companionship unless that is an explicit, safeguarded product intent.
- **Test for misuse and drift.** Evaluate whether your chosen persona presents false authority or drifts into unstable tones over long sessions. Personality should be part of your evaluation pipeline, not just your brand guidelines.

---

## How the identifiers work together

The five identifiers are most powerful when they form a coherent system. A playful, warm personality feels dissonant paired with a cold, abstract avatar and a purely technical name. A minimal, utility-first product feels off if its iconography is all sparkles and magic wands.

Use the identifiers as a lens when reviewing AI product decisions:

- Does the **name** match the AI's actual capabilities and the product's positioning?
- Does the **avatar** communicate state clearly, and is its level of realism appropriate for the trust it implies?
- Does the **color** distinguish AI content effectively, without conflicting with the brand palette or accessibility requirements?
- Does the **iconography** help users recognize AI actions, or does it add cognitive load?
- Does the **personality** serve the user's actual needs, or is it optimized for engagement at the cost of user agency?

When identifiers are aligned, they reduce friction, build trust, and create a sense that the AI genuinely belongs in the product. When they conflict, users feel the dissonance even if they can't name it.
