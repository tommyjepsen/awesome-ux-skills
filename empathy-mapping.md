---
name: empathy-mapping
description: Create, facilitate, and critique empathy maps for UX research and design thinking. Use this skill
  whenever a user wants to build an empathy map, understand their users more deeply, synthesize
  qualitative research into a shared team artifact, or translate user interviews into structured
  insights. Trigger on phrases like "create an empathy map", "map out what users think and feel",
  "help me understand my users", "synthesize these interviews", "what do my users say vs think",
  "build user empathy", or any request to structure user research into Says/Thinks/Does/Feels
  quadrants. Also trigger when users share raw interview transcripts, survey responses, or user
  research notes and want to make sense of them. Always use this skill before attempting to create
  any empathy map content from scratch.
---

# Empathy Mapping Skill

Empathy maps are collaborative visualizations that externalize what a team knows about a specific type of user. They create shared understanding and surface gaps in research before design decisions are made.

---

## When to use which format

| Situation | Format |
|---|---|
| Single user interview or diary entry | **Individual empathy map** (1:1) |
| Multiple interviews, same user segment | **Aggregated empathy map** |
| Early design thinking / no research yet | Sketch a sparse map to reveal gaps |
| Communicating a persona to stakeholders | Empathy map as visual persona summary |

Always start with 1:1 mapping. Aggregate only after individual maps exist.

---

## The Four Quadrants

### Says
Direct, verbatim quotes from research — what the user said out loud.
- Pull exact language where possible
- Note hesitations, qualifiers, contradictions

### Thinks
What occupies the user's mind — including things they wouldn't say out loud.
- What worries them?
- What do they assume or believe (rightly or wrongly)?
- Where do they feel self-conscious, uncertain, or polite?

### Does
Observable behaviors and actions.
- What do they physically do during the experience?
- What workarounds or habits have they developed?
- What do they do before, during, and after?

### Feels
Emotional state — adjective + short context sentence.
- What frustrates, excites, or worries them?
- Use format: `[Emotion]: [reason]` — e.g., "Confused: too many options with no clear difference"

### Optional: Goals (fifth quadrant)
What the user ultimately wants to achieve. Useful when the team needs to stay anchored to user intent throughout design decisions.

---

## Juxtaposition is valuable

Users are complex. You will often find:
- Positive **Says** but negative **Feels** → surface-level satisfaction hiding frustration
- Active **Does** but doubtful **Thinks** → workaround behaviors masking unmet needs

These contradictions are the most valuable insights. Flag them explicitly when building the map.

---

## Process

### Step 1 — Define scope
- Who are you mapping? (specific user or persona)
- What experience or journey does this map cover?
- What is the team trying to align on?

### Step 2 — Gather inputs
Empathy mapping requires qualitative inputs:
- User interview transcripts
- Field study notes
- Diary study logs
- Open-ended survey responses
- Listening session recordings

**If no research exists:** create a sparse map and treat empty quadrants as a research backlog — each blank is a question the team needs to answer before proceeding.

### Step 3 — Generate quadrant entries
Go through the research and extract entries for each quadrant. Each entry should be:
- Specific (not generic)
- Grounded in actual user data (not team assumptions)
- Tagged to source where possible

### Step 4 — Cluster and synthesize
Group similar entries into themes. Name each cluster. Look across quadrants for:
- Repeated themes (high confidence)
- Contradictions (worth investigating)
- Empty quadrants (gaps requiring more research)

### Step 5 — Capture and share
Document the finished map with:
- User name or segment label
- Date and version
- Open questions / next research steps

---

## Output format

When generating an empathy map, always present it in this structure:

```
EMPATHY MAP — [User / Segment Name]
Date: [date]  |  Based on: [research source]

SAYS
• [verbatim or paraphrased quote]
• [verbatim or paraphrased quote]

THINKS
• [internal belief or concern]
• [unspoken assumption]

DOES
• [observable action]
• [behavioral pattern]

FEELS
• [Emotion]: [context]
• [Emotion]: [context]

GOALS (optional)
• [what they ultimately want]

⚡ TENSIONS & CONTRADICTIONS
• [e.g., Says they're satisfied → Feels frustrated by slow load times]

🔍 RESEARCH GAPS
• [quadrant or topic where more data is needed]
```

---

## Facilitating a team session

If the user wants to run an empathy mapping workshop:

1. **Before**: Share research in advance. Give everyone time to read.
2. **During**: Individual silent sticky-note generation first, then group clustering. Avoid groupthink.
3. **Debrief**: Discuss outliers, contradictions, and surprising findings as a group.
4. **Output**: Photograph or digitize the map. Assign owners for research gaps.
5. **Living document**: Revisit the map as new research comes in. Update or invalidate entries explicitly.

---

## Quality checks

Before finalizing any empathy map, verify:
- [ ] Every quadrant has at least 2–3 entries (if blank, flag as research gap)
- [ ] Says entries use actual user language, not team paraphrasing
- [ ] Thinks entries capture what users wouldn't say out loud
- [ ] Feels entries follow `[Emotion]: [reason]` format
- [ ] Contradictions across quadrants have been explicitly surfaced
- [ ] Map is scoped to one user / segment (not a mix)
- [ ] Open questions are documented for follow-up research

---

## Empathy maps vs. personas

| | Empathy Map | Persona |
|---|---|---|
| Format | 4-quadrant visual | Narrative profile |
| Focus | Specific experience or moment | Full user archetype |
| Best for | Synthesizing research, team alignment | Long-term design reference |
| Relationship | Can inform and summarize a persona | Broader than an empathy map |

They complement each other. An empathy map is often a first step toward building or communicating a persona.
