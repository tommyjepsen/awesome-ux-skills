---
name: general-design-review
description: Run a compact UX, product, and AI design review by combining the existing UX skills into one lighter guide. Use when reviewing a UI, flow, feature idea, AI product experience, research artifact, onboarding, prioritization decision, or design process. Focus on the highest-impact issues and recommendations, not exhaustive framework detail.
---

# Design Review

Use this as the single combined review lens across the UX and AI product design skills in this repository.

The goal is not to exhaust every framework. The goal is to quickly identify what matters, explain why it matters, and recommend the smallest set of changes that will most improve the user experience.

## Default Review Shape

Start with a short verdict:

- **Solid**: mostly sound, only targeted refinements needed
- **Needs work**: clear issues that may affect usability, trust, or conversion
- **High risk**: likely to fail, confuse, mislead, or harm users without redesign

Then structure the review as:

1. **Top issues**: 3-5 findings, ordered by severity or impact.
2. **Why it matters**: the user, business, or trust consequence.
3. **Recommended changes**: concrete design actions, not vague advice.
4. **Open questions**: only where missing context materially changes the recommendation.
5. **Next step**: the most useful artifact, test, or decision to make next.

Prefer judgment over completeness. Skip lenses that do not apply.

## First Pass: What Kind Of Problem Is This?

Use the request to pick the strongest review lens:

| Situation | Lead lens |
|---|---|
| Existing UI, screen, or product flow | Usability, cognitive load, conversion |
| Accessibility, WCAG, contrast, keyboard, or screen reader concerns | Accessibility |
| New product or ambiguous design challenge | Double Diamond, research, problem framing |
| User segments or research notes | Personas, empathy maps, journey maps |
| Backlog, roadmap, or feature choice | Prioritization |
| AI feature or agentic workflow | AI inputs, trust, governance, tuners, wayfinding |
| AI brand presence | AI identifiers |
| Users do not know how to start | Wayfinding, onboarding, examples |
| Users do not trust the system | Trust builders, governors, disclosure |

When multiple lenses apply, lead with the one closest to the user's immediate goal.

## Core UX Review Lens

For any UI or flow, check:

- **Clarity**: Can users tell what this is, what state it is in, and what to do next?
- **Language**: Does the interface use the user's terms instead of internal jargon?
- **Control**: Can users undo, cancel, exit, recover, or change their mind?
- **Consistency**: Do components, labels, icons, and interaction patterns behave predictably?
- **Error prevention**: Are risky actions constrained before mistakes happen?
- **Recognition**: Are choices, context, and prior inputs visible instead of held in memory?
- **Efficiency**: Are there shortcuts or faster paths for repeated or expert use?
- **Focus**: Does the visual hierarchy match the task hierarchy?
- **Recovery**: Are errors specific, human-readable, and actionable?
- **Help**: Is guidance contextual and close to the moment of need?

Do not list all ten areas by default. Mention only the ones that reveal a real issue or decision.

## Accessibility Lens

For screenshots and UI designs, include a short WCAG 2.1 A/AA pass when relevant. Keep it focused on likely user impact, not full compliance.

Check:

- **Perceivable**: text contrast, text size, color-only meaning, labels, readable hierarchy.
- **Operable**: visible focus states, target size, keyboard-friendly controls, no gesture-only actions.
- **Understandable**: clear labels, instructions, errors, required fields, predictable behavior.
- **Robust**: likely needs for accessible names, semantic controls, status announcements, modal focus handling.

Be clear about limits: screenshots can reveal visual accessibility risks, but cannot prove keyboard access, screen reader behavior, semantic markup, alt text, or actual WCAG conformance.

## Cognitive Load And Conversion

Conversion usually fails when users spend mental effort on things that do not help them complete the task.

Look for:

- **Visual clutter**: redundant elements, competing CTAs, decorative content that does not clarify value.
- **Mental model mismatch**: unfamiliar layouts, surprising button behavior, labels users would not use.
- **Unnecessary decisions**: choices the product could recommend, default, infer, or defer.
- **Memory burden**: information users must carry between steps instead of seeing in context.
- **Manual work**: typing, calculating, comparing, or re-entering data the product could handle.

Useful tests:

- **Squint test**: What stands out first? Is it the right thing?
- **Three-second test**: Would a first-time user know what to do?
- **Subtraction test**: If this element disappears, does anything important break?
- **Memory test**: Is the user forced to remember something the UI could show?

Do not remove all friction. Keep friction when it prevents irreversible, costly, or harmful mistakes.

## Persuasive UX

Use persuasion carefully: increase user ability and timely prompting without manipulation.

Review for:

- **Reduction**: Can the task be made shorter or easier?
- **Tunneling**: Is there a guided path when users need one?
- **Tailoring**: Can the experience adapt to the user's context or goal?
- **Suggestion**: Are prompts shown at the right moment, not just anywhere?
- **Self-monitoring**: Can users see progress, status, or improvement?
- **Social visibility**: Would social context help, or would it feel coercive?
- **Reinforcement**: Are desired actions acknowledged in a useful, lightweight way?

Recommend only the persuasive patterns that genuinely fit the behavior the product wants to drive.

## Research And Strategy

If the problem is not well understood, do not jump straight to UI recommendations. Clarify what the team needs to learn.

Choose research by question type:

| Question | Better methods |
|---|---|
| Why is this happening? | Interviews, field studies, usability tests |
| What are users actually doing? | Analytics, observation, A/B tests, usability tests |
| How many users are affected? | Surveys, analytics, benchmarking |
| Does this structure make sense? | Card sorting, tree testing |
| Does this specific flow work? | Moderated or unmoderated usability testing |
| Which solution performs better? | A/B test or benchmark on a stable product |

Match the method to the product stage:

- **Discover**: understand people, context, needs, and pain points.
- **Define**: turn findings into a sharp, user-centered problem statement.
- **Develop**: generate, prototype, and test solution directions.
- **Deliver**: refine, ship, QA, and measure real-world outcomes.

Common warning: what users say and what users do often diverge. Use behavioral evidence when behavior matters.

## Personas, Empathy, Journeys, And Storyboards

Use these artifacts only when they clarify design decisions.

### Personas

Personas should be research-grounded user archetypes, not imagined demographics. Keep:

- Goals
- Frustrations
- Current behaviors
- Context of use
- Design-relevant constraints

Cut details that would not change a product decision.

### Empathy Maps

Use empathy maps to synthesize qualitative research:

- **Says**: user language and quotes
- **Thinks**: beliefs, doubts, assumptions
- **Does**: observable behavior
- **Feels**: emotional state and reason

The most useful insights often come from contradictions, such as users saying they are satisfied while behaving as if they are frustrated.

### Journey Maps

Use journey maps for a specific actor trying to accomplish a specific goal over time. Include:

- Actor
- Scenario and expectation
- Phases
- Actions
- Mindsets
- Emotional highs and lows
- Opportunities

One journey map should represent one point of view. If there are multiple user types, create separate maps.

### Storyboards

Use storyboards when the team needs a visual sequence of a user scenario. Keep them narrow:

- One persona
- One scenario
- One path
- A few panels showing action, context, and emotion

Low fidelity is fine. The story matters more than polished art.

## Prioritization

When deciding what to build or fix first, use a simple 2D matrix. Pick two criteria that reflect project goals, such as:

- User impact vs. effort
- Business value vs. feasibility
- Frequency of use vs. complexity
- Strategic alignment vs. cost

Output:

- **Do first**: high value, low effort or high feasibility
- **Plan carefully**: high value, high effort
- **Quick wins**: lower value, low effort
- **Deprioritize**: low value, high effort

Avoid criteria chosen to justify a favorite solution. The matrix is a decision tool, not proof that the team was already right.

## AI Product Review

AI features need all normal UX checks plus additional checks for scope, trust, control, and accountability.

Start with these questions:

- What is the AI acting on?
- What can it change, send, delete, spend, remember, or reveal?
- What is the worst case if it is wrong?
- Can the user understand, steer, stop, undo, and verify the AI?
- Is the AI clearly disclosed as AI?

### AI Inputs

Pick the input pattern that fits the task:

| User need | Good pattern |
|---|---|
| Explore freely | Open input |
| Repeat a structured task | Template or madlibs |
| Fill many fields or records | Auto-fill with preview |
| Edit selected content | Inline action or inpainting |
| Try again | Regenerate with recoverable versions |
| Build from a seed | Expand |
| Change structure | Restructure |
| Change style | Restyle |
| Run a workflow | Chained action |
| Compress source material | Summary |
| Interpret across sources | Synthesis |

Universal rules:

- Make scope explicit before running.
- Preview changes before committing.
- Preserve undo/version history.
- Mark AI-generated or AI-edited content until accepted.
- Show cost for bulk, long-running, or chained work.

### AI Wayfinding

Blank AI inputs are rarely enough. Help users understand what is possible.

Use:

- **Initial CTAs** that are specific, not "ask anything."
- **Suggestions** tied to the current context.
- **Examples and galleries** that show useful outcomes.
- **Templates** for complex repeatable tasks.
- **Nudges** only when they match the user's current state.
- **Follow-ups** after generation to refine, extend, or act.
- **Prompt details** when users can learn from or remix good outputs.
- **Randomize** for creative exploration, not serious high-stakes tasks.

Prefer contextual guidance over generic onboarding.

### AI Tuners

Tuners let users shape AI behavior without becoming prompt engineers.

Useful tuner families:

- **Attachments**: ground the AI in specific files, URLs, selections, or examples.
- **Connectors**: link AI to live systems such as Drive, Slack, Notion, CRM, or code.
- **Filters**: restrict sources or exclude unwanted terms, styles, or content.
- **Model management**: expose active model and allow switching when useful.
- **Modes**: bundle behavior into understandable presets like research, creative, tutor, or agent.
- **Parameters**: expose advanced knobs only when users need them.
- **Preset styles**: curated style choices with previews.
- **Saved styles**: reusable personal or team style profiles.
- **Voice and tone**: control how generated output sounds, separate from the AI's own personality.

Review principle: active state must always be visible. Hidden model, mode, source, style, or autonomy level damages trust.

### AI Governors

Governors keep users meaningfully in control as AI becomes more autonomous.

Use stronger governors when actions are expensive, irreversible, public, security-sensitive, or hard to clean up.

Patterns to consider:

- **Action plan**: show intended steps before execution.
- **Verification**: require approval before risky actions.
- **Controls**: stop, pause, resume, queue, or cancel.
- **Cost estimates**: show credits, time, tokens, or money before committing.
- **Draft mode**: cheap lower-fidelity run before final output.
- **Sample response**: full-quality preview on a small subset.
- **Citations and references**: connect claims to source material.
- **Stream of thought**: show plan, execution state, tool calls, and evidence.
- **Memory controls**: show what is remembered and allow edit/delete/off.
- **Branches and variations**: explore without overwriting the original.
- **Shared vision**: show what the AI can currently see or access.

Calibrate friction:

- High-stakes and infrequent: strong confirmation.
- Low-stakes and frequent: passive indicators or undo.
- High-stakes and frequent: rules, preferences, and configurable approval.

### AI Trust Builders

Trust means users neither under-trust nor over-trust the system.

Review for:

- **Caveats**: clear, specific limits near the moment of decision.
- **Consent**: explicit permission for recording, analysis, training, or sharing.
- **Data ownership**: clear controls for retention, training, deletion, and export.
- **Disclosure**: label AI actors, AI actions, and AI-generated content.
- **Footprints**: visible and logged traces of prompts, sources, models, approvals, costs, and edits.
- **Incognito mode**: private sessions that do not affect memory, training, or history.
- **Watermarking/provenance**: durable origin signals for shared synthetic content.

Do not rely on disclaimers alone. Pair warnings with evidence, controls, and recoverability.

### AI Identifiers

AI identity should be coherent with the product and honest about capability.

Review:

- **Name**: Does it set the right expectation? Is AI disclosure still clear?
- **Avatar**: Does it communicate state without implying false human competence?
- **Color**: Does it distinguish AI affordances accessibly and consistently?
- **Iconography**: Are common AI actions recognizable, or are icons decorative noise?
- **Personality**: Does the tone serve the task without over-validating, misleading, or encouraging unhealthy attachment?

The identity should help users understand the AI's role, not turn it into a novelty layer.

## Design Process Review

Use the Double Diamond as a lightweight process check:

- **Discover**: Do we understand the people, context, and problem space?
- **Define**: Is there a clear user-centered problem statement?
- **Develop**: Have multiple solutions been explored and tested?
- **Deliver**: Is there a plan for build quality, launch readiness, and measurement?

If the team is stuck, identify the phase they are actually in and recommend the next useful artifact: interview guide, research plan, problem statement, prototype, usability test, launch checklist, or measurement plan.

## Final Recommendation Format

For most design reviews, keep the response compact:

```markdown
**Verdict:** Needs work

**Top issues**
1. [Issue] — [why it matters]
2. [Issue] — [why it matters]
3. [Issue] — [why it matters]

**Recommended changes**
1. [Concrete design change]
2. [Concrete design change]
3. [Concrete design change]

**Next step**
[Most useful artifact, test, or decision]
```

If accessibility is relevant, add only the highest-impact items:

```markdown
**Accessibility risks**
- [Contrast/label/focus/keyboard/semantic issue]
- [Needs verification in implementation]
```

If reviewing an AI feature, add:

```markdown
**AI-specific risks**
- Scope:
- Trust:
- Control:
- Data:
- Cost:
```

Keep the review specific to the user's product. The frameworks are scaffolding; the output should feel like senior design judgment, not a checklist dump.
