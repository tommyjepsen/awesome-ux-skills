---
name: ux-research-methods
description: Guide selecting the right UX research method for a given situation. Use this skill whenever the user asks which research method to use, how to plan UX research, what research to do at a given product stage, how to study user behavior vs. attitudes, how to pick between qualitative and quantitative approaches, or whether to run interviews, usability tests, surveys, A/B tests, or any other UX research technique. Also trigger when the user describes a research question and wants a recommendation, or when they ask about the tradeoffs between specific methods. Trigger even if the user just says "what research should I do" or "how do I learn more about my users" without naming specific methods.
---

# UX Research Methods Advisor

## Purpose
Help teams choose the right UX research method based on their situation. Recommendations are driven by three dimensions: **attitudinal vs. behavioral**, **qualitative vs. quantitative**, and **context of product use** — plus the **phase of product development**.

---

## Step 1: Understand the Situation

Before recommending, clarify the following (ask if not stated):

1. **What question are you trying to answer?**
   - Why is something happening / how to fix it → qualitative
   - How many / how much → quantitative
   - What users say they think/want → attitudinal
   - What users actually do → behavioral

2. **What stage is the product in?**
   - Strategize (early, finding direction)
   - Design (improving a specific flow or feature)
   - Launch & Assess (measuring performance, comparing)

3. **Do you need users interacting with the product?**
   - Natural use (observing real behavior)
   - Scripted use (specific tasks/flows)
   - Limited/abstracted (concepts, IA, card sorting)
   - No product (brand perception, concept validation)

4. **What constraints exist?**
   - Timeline and budget
   - Access to participants
   - Remote vs. in-person

---

## Step 2: Apply the Three-Dimensional Framework

### Attitudinal ↔ Behavioral

| Want to know... | Lean toward |
|---|---|
| What users believe, prefer, or say they'd do | **Attitudinal** (surveys, interviews, focus groups) |
| What users actually do with the product | **Behavioral** (A/B testing, analytics, eyetracking) |
| Both | **Mixed** (usability testing, field studies) |

### Qualitative ↔ Quantitative

| Want to know... | Lean toward |
|---|---|
| Why something happens, insights, nuance | **Qualitative** (interviews, field studies, usability testing) |
| How many, how often, statistical confidence | **Quantitative** (surveys, A/B testing, analytics) |
| Both | Card sorting, concept testing, unmoderated testing |

### Context of Product Use

| Context | When to use | Example methods |
|---|---|---|
| Natural use | Understand real behavior without interference | Field studies, analytics, intercept surveys |
| Scripted use | Evaluate specific flows or features | Usability testing, benchmarking |
| Limited/abstracted | Test IA, concepts, or design alternatives | Card sorting, tree testing, participatory design |
| No product | Brand or concept perception | Focus groups, desirability studies |

---

## Step 3: Match to Product Development Phase

### 🔍 Strategize — Find directions and opportunities
**Goal:** Understand users, discover needs, generate ideas

Best methods:
- **Field studies** — observe users in their real environment
- **Diary studies** — longitudinal, user-recorded behavior/attitudes
- **Interviews** — in-depth one-on-one exploration
- **Surveys** — discover and measure attitudes at scale
- **Participatory design** — co-create with users
- **Concept testing** — validate whether an idea meets a need

### 🎨 Design — Improve usability and design quality
**Goal:** Identify and fix problems in the experience

Best methods:
- **Card sorting** — define or validate information architecture
- **Tree testing** — verify navigation structure
- **Usability testing** (moderated) — observe task completion, find friction
- **Remote moderated testing** — same as above, done remotely
- **Unmoderated testing** — scalable task-based testing without a moderator

### 📊 Launch & Assess — Measure and compare performance
**Goal:** Benchmark against prior versions or competitors

Best methods:
- **Usability benchmarking** — precise performance metrics across participants
- **Unmoderated testing** — scalable summative evaluation
- **A/B testing** — scientifically test design variants on live traffic
- **Analytics / Clickstream analytics** — measure actual behavior at scale
- **Surveys** — measure satisfaction and attitudes post-launch

---

## Step 4: Method Reference

| Method | Attitudinal/Behavioral | Qual/Quant | Best phase |
|---|---|---|---|
| Usability testing | Both | Qualitative | Design |
| Field studies | Both | Qualitative | Strategize |
| Contextual inquiry | Both | Qualitative | Strategize |
| Participatory design | Attitudinal | Qualitative | Strategize |
| Focus groups | Attitudinal | Qualitative | Strategize |
| Interviews | Attitudinal | Qualitative | Strategize |
| Eyetracking | Behavioral | Qualitative/Quant | Design |
| Usability benchmarking | Behavioral | Quantitative | Launch & Assess |
| Remote moderated testing | Both | Qualitative | Design |
| Unmoderated testing | Both | Both | Design / Launch |
| Concept testing | Attitudinal | Both | Strategize |
| Diary studies | Both | Qualitative | Strategize |
| Customer feedback | Attitudinal | Both | Any |
| Desirability studies | Attitudinal | Both | Design |
| Card sorting | Attitudinal | Both | Design |
| Tree testing | Behavioral | Quantitative | Design |
| Analytics | Behavioral | Quantitative | Launch & Assess |
| Clickstream analytics | Behavioral | Quantitative | Launch & Assess |
| A/B testing | Behavioral | Quantitative | Launch & Assess |
| Surveys | Attitudinal | Quantitative | Any |

---

## Output Format

When making a recommendation, structure the response as:

1. **Recommended method(s)** — with a brief rationale
2. **Why this fits** — reference the relevant dimension(s) and phase
3. **What you'll learn** — what question it answers
4. **Watch out for** — key limitation or pitfall of this method
5. **Also consider** — 1–2 complementary methods if relevant

Keep recommendations concrete and actionable. If multiple methods fit, help the user prioritize by constraints (time, budget, access to users).

---

## Common Traps to Avoid

- **Only using one method**: Most projects benefit from combining methods (e.g., interviews to generate hypotheses, then surveys to validate at scale).
- **Confusing attitudinal and behavioral**: What users say they do and what they actually do often diverge. When behavior matters, prioritize behavioral methods.
- **Using qualitative methods to get quantitative answers**: A usability test with 5 participants can't tell you what % of users have a problem — it tells you *why* they do.
- **Using surveys to diagnose why**: Surveys tell you *what* and *how many*, not *why*.
- **Running benchmarking too early**: Summative methods require a stable product to produce meaningful metrics.
