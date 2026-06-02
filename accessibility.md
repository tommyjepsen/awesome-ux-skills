---
name: accessibility
description: Review screenshots, mockups, designs, and UI flows for accessibility using WCAG 2.1. Use when the user asks for an accessibility audit, WCAG review, inclusive design critique, contrast review, keyboard or screen reader concerns, form accessibility, accessible UI recommendations, or asks whether a design is accessible. Focus on practical WCAG 2.1 A and AA issues visible in the design, and clearly separate visual findings from implementation checks that require code or interaction testing.
---

# Accessibility Review

Review screenshots, mockups, and product designs using WCAG 2.1 as the baseline. Prioritize issues that block or degrade use for people with visual, motor, auditory, cognitive, or assistive technology needs.

Use WCAG's four principles as the review frame:

- **Perceivable**: users can perceive the information and UI.
- **Operable**: users can navigate and operate the interface.
- **Understandable**: users can understand content, controls, and errors.
- **Robust**: the interface can work reliably with assistive technologies.

Default to WCAG 2.1 Level A and AA. Mention AAA only as a recommendation, not a compliance requirement, unless the user asks for AAA.

## Screenshot Review Limits

When reviewing a screenshot or static mockup, be explicit about confidence:

- **Can assess visually**: contrast risk, text size, visible labels, layout, touch target size, focus affordance if shown, use of color, error copy, spacing, hierarchy, and likely reading order.
- **Cannot fully verify from screenshot alone**: keyboard access, focus order, semantic markup, accessible names, alt text, ARIA, live regions, screen reader behavior, responsive reflow, actual contrast values unless colors are known, and whether dynamic content is announced.

Do not claim WCAG conformance from a screenshot. Say "likely issue", "needs verification", or "passes visually" as appropriate.

## Output Format

Start with a short verdict:

- **Likely accessible foundation**
- **Accessibility risks to fix**
- **High accessibility risk**

Then use this structure:

```markdown
**Verdict:** Accessibility risks to fix

**Likely WCAG issues**
1. [Issue] - [WCAG criterion, level] - [why it matters]
2. ...

**Design fixes**
1. [Concrete visual/content change]
2. ...

**Needs implementation verification**
- [Keyboard/focus/semantic/screen reader check]
- ...

**Priority**
1. [Highest-impact fix]
2. [Next fix]
3. [Next fix]
```

Keep findings specific to the submitted design. Avoid generic accessibility lectures.

## Perceivable Checks

Focus on whether users can see, hear, or otherwise perceive the interface.

Review for:

- **Text alternatives (1.1.1 A)**: meaningful images, icons, charts, and controls need text equivalents. From a screenshot, flag items that likely need alt text or accessible labels.
- **Info and relationships (1.3.1 A)**: headings, groups, tables, form labels, and relationships must be programmatically determinable. In a mockup, check whether the visual structure implies a clear semantic structure.
- **Meaningful sequence (1.3.2 A)**: visual order should support a sensible reading and focus order.
- **Use of color (1.4.1 A)**: color must not be the only way to communicate state, status, category, or errors.
- **Contrast minimum (1.4.3 AA)**: normal text should meet 4.5:1; large text should meet 3:1. Flag low-contrast text, placeholder text, disabled-looking active controls, text on images, and subtle gray-on-white UI.
- **Resize text (1.4.4 AA)**: layout should tolerate 200% text zoom without loss of content or function.
- **Images of text (1.4.5 AA)**: avoid text baked into images unless essential.
- **Reflow (1.4.10 AA)**: content should work at narrow widths without two-dimensional scrolling for normal reading.
- **Non-text contrast (1.4.11 AA)**: icons, focus indicators, input borders, chart marks, and control states need at least 3:1 contrast against adjacent colors.
- **Text spacing (1.4.12 AA)**: designs should not break when users increase line height, paragraph spacing, letter spacing, or word spacing.
- **Hover/focus content (1.4.13 AA)**: tooltips, popovers, and hover content should be dismissible, hoverable, and persistent when needed.

Common screenshot findings:

- Text is too light or too small.
- Placeholder text is being used as the only label.
- Error state relies only on red.
- Icon-only actions lack visible labels or obvious accessible names.
- Important text appears over busy imagery.

## Operable Checks

Focus on whether users can operate the UI with keyboard, touch, switch devices, screen readers, and other input methods.

Review for:

- **Keyboard (2.1.1 A)**: all functionality must be operable by keyboard. From a design, identify custom controls that may need keyboard support.
- **No keyboard trap (2.1.2 A)**: modals, drawers, menus, and embedded widgets must allow users to leave with keyboard.
- **Pause, stop, hide (2.2.2 A)**: moving, blinking, auto-updating, or carousel content needs user control.
- **Bypass blocks (2.4.1 A)**: repeated navigation needs a way to skip to main content in implementation.
- **Page titled (2.4.2 A)**: each page/view needs a clear title.
- **Focus order (2.4.3 A)**: likely keyboard order should match visual and task order.
- **Link purpose (2.4.4 A)**: links and buttons should make sense from their label, not just surrounding context.
- **Multiple ways (2.4.5 AA)**: important pages or flows should not be reachable through only one fragile path.
- **Headings and labels (2.4.6 AA)**: headings and control labels should describe topic or purpose.
- **Focus visible (2.4.7 AA)**: keyboard focus must be clearly visible. If focus states are absent from design specs, flag them.
- **Pointer gestures (2.5.1 A)**: complex gestures need simple alternatives.
- **Pointer cancellation (2.5.2 A)**: actions should not trigger irreversibly on pointer down.
- **Label in name (2.5.3 A)**: accessible names should include the visible label, especially for voice control.
- **Motion actuation (2.5.4 A)**: motion-triggered actions need alternatives and disable controls.
- **Target size (2.5.5 AAA in WCAG 2.1)**: 44 by 44 CSS pixels is a strong design recommendation, especially for touch, even if AAA.

Common screenshot findings:

- Controls are too small or too close together.
- Custom dropdowns, tabs, cards, and modals lack defined focus states.
- Card-only click targets make the actual action unclear.
- Auto-advancing content has no pause control.
- Links use vague labels like "click here", "more", or "learn more" repeatedly.

## Understandable Checks

Focus on whether users can understand what to do and recover from mistakes.

Review for:

- **Language of page (3.1.1 A)** and **language of parts (3.1.2 AA)**: content language should be programmatically identified.
- **On focus (3.2.1 A)** and **on input (3.2.2 A)**: focusing or changing a field should not unexpectedly navigate, submit, or change context.
- **Consistent navigation (3.2.3 AA)** and **consistent identification (3.2.4 AA)**: repeated components should appear and behave consistently.
- **Error identification (3.3.1 A)**: errors should be clearly identified in text, not only color.
- **Labels or instructions (3.3.2 A)**: forms need persistent labels, helpful instructions, and expected formats.
- **Error suggestion (3.3.3 AA)**: error messages should explain how to fix the problem.
- **Error prevention (3.3.4 AA)**: legal, financial, data, and high-stakes submissions need review, confirmation, or reversal.

Common screenshot findings:

- Required fields are not marked clearly.
- Form fields rely on placeholder text instead of persistent labels.
- Error messages are generic or missing recovery instructions.
- Primary and secondary actions are visually ambiguous.
- The same icon or label appears to mean different things.

## Robust Checks

Focus on whether the design can be implemented in a way that works with assistive technologies.

Review for:

- **Parsing (4.1.1 A)**: valid structure and non-duplicated IDs are implementation checks.
- **Name, role, value (4.1.2 A)**: custom controls need correct accessible names, roles, states, and values.
- **Status messages (4.1.3 AA)**: loading, success, error, saved, and validation messages should be announced without moving focus when appropriate.

For screenshots, translate robust concerns into implementation requirements:

- "This custom segmented control needs proper role/state semantics."
- "This async status needs a live region."
- "This icon-only button needs an accessible name."
- "This modal needs focus trapping, initial focus, and focus return."

## Severity

Use practical severity:

- **Blocker**: prevents a user group from completing the task.
- **High**: creates major confusion, extra effort, or likely WCAG failure.
- **Medium**: causes friction or partial loss of information.
- **Low**: polish issue or best-practice improvement.

Prioritize blockers and high-impact AA failures first: contrast, labels, keyboard/focus, error recovery, semantic custom controls, and inaccessible critical actions.

## Good Recommendations

Make recommendations concrete:

- "Increase secondary text contrast to at least 4.5:1."
- "Keep a visible label above the input; do not rely on placeholder text."
- "Add text next to the icon or provide an accessible name in implementation."
- "Define keyboard focus states for every interactive element."
- "Add a non-color cue to the error state, such as icon + text."
- "Make destructive actions reversible or add a confirmation step."

Avoid recommendations that only say "make it accessible" or "check WCAG."

## Final Note

WCAG 2.1 is the baseline, not the whole user experience. A design can technically pass many criteria and still be hard to use. When relevant, call out inclusive design improvements beyond strict compliance, but clearly label them as recommendations rather than WCAG failures.
