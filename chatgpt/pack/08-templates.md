# Product OS pack: Templates

Bundled from the Product OS repo for ChatGPT. Each section below is one Product OS file.
Its path is on the line that starts with `FILE:`. Instructions that name a path mean that section.

Contents:
- `templates/pm/prd.md`
- `templates/pm/project-brief.md`
- `templates/pm/metrics-framework.md`
- `templates/design/design-brief.md`
- `templates/design/design-critique.md`
- `templates/design/ux-writing-guide.md`
- `templates/delivery/epic.md`
- `templates/delivery/user-story.md`

---

FILE: `templates/pm/prd.md`

# [Feature/Project Name] — PRD

**[Subtitle: one line on the problem, the solution and the expected outcome, for product, design and engineering]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [author] | Draft / In review / Approved / Implementing / Shipped | [YYYY-MM-DD] |

## Description
[2–4 sentences: what this PRD covers, what it is based on (intake / proposal), and how to read it: summary here, detail in the numbered sections below.]

## Problem Statement
[Who has the problem, what it is, the evidence, and what it costs if we do nothing. Full evidence: §1 Problem Statement.]

## Solution
[What we will build. Key scope in and out (full list: §4 Goals & Non-Goals, §8 Functional Requirements).]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| [Primary metric] | [value or TBD: who provides it] | [value] | [source / event] |
| [Guardrail metric] | [value or TBD: who provides it] | [Do not exceed X] | [source / event] |

Full metric definitions (formulas, guardrails, instrumentation): §10 Success Metrics and the project's metrics framework.

### Validation: how we know we are right

| Hypothesis | How we validate it | Status | Metric it moves |
|------------|--------------------|--------|-----------------|
| [H-1: We believe X because Y] | [Experiment / usability test / analytics / interview] | Unvalidated / Partial / Validated | [metric above] |

Full hypotheses and assumptions: §2 Hypotheses & Validation. Stop criteria: §16 Rollout Plan.

## Next Action
[One action, one owner.]

---

## Document Details

| Field | Value |
|-------|-------|
| **Stage** | Early (hypotheses) / Defined (requirements) / Delivery-ready (evidence-backed) |
| **Created** | [Date] |
| **Intake Reference** | [Link to intake.md] |

### Stakeholders

| Role | Name | Responsibility |
|------|------|----------------|
| Product Owner | | Final approver |
| Engineering Lead | | Feasibility review |
| Design Lead | | UX review |
| QA Lead | | Test strategy |

---

## 1. Problem Statement

### What's Broken

[Describe the problem in user/business terms. No solution language.]

### Evidence

| Source | Finding | Confidence |
|--------|---------|------------|
| [Analytics/Research/Support/etc.] | [What the data shows] | High/Medium/Low |

### Impact

- **Who:** [Affected users/segments]
- **How many:** [Quantify reach]
- **Severity:** [How bad is the problem for them]
- **Business cost:** [Revenue, retention, efficiency impact]

---

## 2. Hypotheses & Validation

> **Note:** Hypotheses are beliefs requiring validation. Early-stage PRDs may have mostly hypotheses; delivery-ready PRDs need evidence.

| ID | Hypothesis | Evidence Status | Validation Method |
|----|------------|-----------------|-------------------|
| H-1 | [We believe X because Y] | Unvalidated / Partial / Validated | [How we'll test it] |
| H-2 | | | |

### Assumptions & Provenance

| ID | Assumption | Source | Confidence | Validation Plan |
|----|------------|--------|------------|-----------------|
| A-1 | [What we're assuming] | [Who said it / where it came from] | High/Med/Low | [How to validate] |

---

## 3. Background & Evidence

### Market Context

[Competitive landscape, market trends, TAM/SAM/SOM if relevant]

### Research Findings

| Study | Method | Key Finding | Limitations |
|-------|--------|-------------|-------------|
| | | | |

### Strategic Alignment

- **Company goal:** [Which company goal this supports]
- **Product strategy:** [How this fits the roadmap]
- **Why now:** [Timing rationale]

---

## 4. Goals & Non-Goals

### Goals

| ID | Goal | Success Metric | Target | Timeline | Evidence Required |
|----|------|----------------|--------|----------|-------------------|
| G-1 | | | | | [What proves success] |
| G-2 | | | | | |

### Non-Goals

| Exclusion | Rationale |
|-----------|-----------|
| [What we're explicitly NOT doing] | [Why it's out of scope] |

---

## 5. User Types & Personas

| Persona | Description | Primary JTBD | Evidence Source |
|---------|-------------|--------------|-----------------|
| | | | [Research/data backing this persona] |

---

## 6. Jobs-to-be-Done

| ID | When I... | I want to... | So that I... | Priority | Evidence |
|----|-----------|--------------|--------------|----------|----------|
| JTBD-1 | | | | Must | [Source] |
| JTBD-2 | | | | Should | |

---

## 7. Use Cases

### UC-1: [Use Case Name]

**Actor:** [Persona]
**Preconditions:** [State before]
**Trigger:** [What initiates]

**Main Flow:**
1. [Step]
2. [Step]

**Postconditions:** [State after]

**Alternative Flows:**
- [Variation and how it's handled]

**Exception Flows:**
- [Error condition and recovery]

---

## 8. Functional Requirements

| ID | Requirement | Priority | JTBD | Stage | Notes |
|----|-------------|----------|------|-------|-------|
| REQ-001 | | Must | JTBD-1 | Defined | |
| REQ-002 | | Should | JTBD-1 | TBD | [What's needed to define] |

> **Stage key:** Defined = ready for implementation; TBD = needs spike or research; Deferred = pushed to later phase

---

## 9. Non-Functional Requirements

| Category | Requirement | Target | Current | Priority |
|----------|-------------|--------|---------|----------|
| Performance | Page load time | <2s p95 | [Baseline] | Must |
| Scalability | Concurrent users | [Target] | [Current] | Should |
| Security | [Requirement] | | | Must |
| Accessibility | WCAG level | 2.2 AA | | Must |
| Reliability | Uptime | 99.9% | | Must |

---

## 10. Success Metrics

### Primary Metrics

| Metric | Formula | Baseline | Target | Measurement Window |
|--------|---------|----------|--------|--------------------|
| | | | | |

### Guardrail Metrics

| Metric | Threshold | Stop Criteria | Action if Breached |
|--------|-----------|---------------|-------------------|
| | Do not exceed X | If Y happens | [Specific action] |

### Instrumentation vs Outcomes

| Metric Type | Example | What It Proves |
|-------------|---------|----------------|
| Instrumentation | Event fires on button click | Code works |
| Adoption | 50% of users click button | Feature is used |
| Outcome | 20% lift in conversion | Business value delivered |

> **Note:** Instrumentation proves tracking works. Adoption proves usage. Outcomes prove value. Don't conflate them.

---

## 11. Analytics & Instrumentation

### Events

| Event Name | Trigger | Properties | Purpose |
|------------|---------|------------|---------|
| | | | |

### Dashboards

| Dashboard | Metrics | Audience | Update Frequency |
|-----------|---------|----------|------------------|
| | | | |

---

## 12. Technical Needs

### Data Models

[Data structures this feature adds or changes]

### APIs

| Endpoint | Method | Purpose | Owner |
|----------|--------|---------|-------|
| | | | |

### Integrations

| System | Integration Type | Status |
|--------|------------------|--------|
| | | |

---

## 13. Dependencies

| ID | Dependency | Team/System | Status | Risk Level | Mitigation |
|----|------------|-------------|--------|------------|------------|
| DEP-1 | | | | | |

---

## 14. Risks & Mitigations

| ID | Risk | Probability | Impact | Score | Mitigation | Owner |
|----|------|-------------|--------|-------|------------|-------|
| R-1 | | H/M/L | H/M/L | [P×I] | | |

---

## 15. Alternatives Considered

| Option | Description | Pros | Cons | Why Not Selected |
|--------|-------------|------|------|------------------|
| [Current choice] | | | | **Selected** |
| [Alternative 1] | | | | |
| [Alternative 2] | | | | |

---

## 16. Rollout Plan

### Phases

| Phase | Scope | Success Criteria | Rollback Trigger |
|-------|-------|------------------|------------------|
| 1 | [% of users / segment] | [Metrics to hit] | [When to pull back] |
| 2 | | | |
| GA | 100% | | |

### Feature Flags

| Flag | Description | Default | Rollback Owner |
|------|-------------|---------|----------------|
| | | Off | |

### Rollback Criteria

| Condition | Action | Owner | SLA |
|-----------|--------|-------|-----|
| [Metric breaches threshold] | [Specific action] | [Name] | [Time to act] |

### Stop Criteria

| Condition | Decision | Owner |
|-----------|----------|-------|
| [When we'd kill the feature entirely] | [Who decides] | |

---

## 17. Open Questions

| ID | Question | Owner | Due Date | Resolution | Status |
|----|----------|-------|----------|------------|--------|
| Q-1 | | | | | Open / Resolved |

---

## 18. AI Feature Specification (If Applicable)

> **Include only if the feature involves AI/ML components.**

### Model Behavior

| Aspect | Specification |
|--------|---------------|
| Input | [What the model receives] |
| Output | [What the model produces] |
| Confidence threshold | [Minimum confidence to surface] |
| Fallback behavior | [What happens when uncertain] |

### Evaluation Criteria

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| Accuracy | | |
| Latency | | |
| Fairness | | [How bias is measured] |

### Failure Modes

| Failure | User Impact | Mitigation |
|---------|-------------|------------|
| Model unavailable | | |
| Low confidence | | |
| Incorrect output | | |

### Human Override

[How users can correct or override AI decisions]

---

## 19. Appendix

### Research Data

[Links to full research reports]

### Technical Diagrams

[Architecture, sequence diagrams]

---

## Stage Completeness Guide

| Stage | Required Sections | Evidence Bar |
|-------|-------------------|--------------|
| **Early** | Problem, Hypotheses, Goals, JTBD | Hypotheses can be unvalidated |
| **Defined** | All sections | At least partial evidence for key hypotheses |
| **Delivery-Ready** | All sections complete | Evidence for all critical hypotheses; metrics baselined |

For early-stage PRDs, mark incomplete sections with `[TBD: what's needed]` rather than fabricating content.

---

FILE: `templates/pm/project-brief.md`

# [Project Name] — Project Brief

**[Subtitle: one-page summary of the problem, solution and success measures, for sponsors and the delivery team]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [parent initiative] | [project] | [author] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: what this brief summarizes (link to the full PRD), who must sign off, and what approval unlocks (design).]

## Problem Statement
[2-3 sentences max. What's broken? Who's affected? What's the evidence?]

## Solution
[One or two sentences on what we will build. Key scope in and out is listed under Scope below.]

## Success Metrics
| Goal | Metric | Baseline | Target (by when) | How we measure |
|------|--------|----------|------------------|----------------|
| [Primary goal] | [Primary metric] | [value or TBD: who provides it] | [Specific target, timeline] | [source / event] |
| [Secondary goal] | [Secondary metric] | [value or TBD: who provides it] | [Specific target, timeline] | [source / event] |

## Next Action
Review and approve this brief to proceed to design ([owner]).

---

## Why Now

[2-3 sentences. Why is this urgent? What's the cost of delay? What opportunity window exists?]

---

## Scope

### In Scope
- [Key deliverable 1]
- [Key deliverable 2]
- [Key deliverable 3]

### Out of Scope
- [Explicit exclusion 1]
- [Explicit exclusion 2]

---

## Users

| User Type | Description | Size | Priority |
|-----------|-------------|------|----------|
| [Primary] | [Who they are] | [Est. count] | Primary |
| [Secondary] | [Who they are] | [Est. count] | Secondary |

---

## Stakeholders

| Role | Name | Responsibility | Sign-off Required |
|------|------|----------------|-------------------|
| Sponsor | [Name] | Executive oversight | Yes |
| Product | [Name] | Requirements & prioritization | Yes |
| Engineering | [Name] | Feasibility & delivery | Yes |
| Design | [Name] | User experience | Yes |
| QA | [Name] | Quality assurance | No |

---

## Timeline

| Milestone | Target Date | Dependencies |
|-----------|-------------|--------------|
| PRD Approved | [Date] | — |
| Design Complete | [Date] | PRD |
| Development Complete | [Date] | Design |
| Launch | [Date] | QA |

---

## Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Top risk 1] | H/M/L | H/M/L | [One-line mitigation] |
| [Top risk 2] | H/M/L | H/M/L | [One-line mitigation] |

---

## Links

| Document | Link |
|----------|------|
| Full PRD | [Link] |
| Intake | [Link] |
| Design | [TBD] |
| Jira Epic | [TBD] |

---

## Approvals

| Role | Name | Date | Status |
|------|------|------|--------|
| Sponsor | | | Pending |
| Product | | | Pending |
| Engineering | | | Pending |

---

*This is a one-page summary. See the full PRD for complete details.*

---

FILE: `templates/pm/metrics-framework.md`

# [Project Name] — Metrics Framework

**[Subtitle: one line on the north star metric, the key target and how we measure it]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: the metrics that define success for this project, how each is measured, and when we stop. Every other document's Success Metrics links here.]

## Problem Statement
[The project's problem in 1–2 lines (who, evidence, cost of doing nothing), and how this document serves it.]

## Solution
[The project's solution in 1–2 lines, and what this document adds to it.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| [North star metric] | [value or TBD: who provides it] | [value] | [data source / event] |
| [Top input metric] | [value or TBD: who provides it] | [value] | [data source / event] |

## Next Action
[One action, one owner.]

---

## North Star Metric

| Field | Value |
|-------|-------|
| Name | |
| Formula | |
| Current Baseline | |
| Target | |
| Measurement Frequency | |

**Rationale:** [Why this metric captures value]

## Input Metrics (Leading)

| Metric | Formula | Baseline | Target | Owner |
|--------|---------|----------|--------|-------|
| | | | | |

## Guardrail Metrics

| Metric | Threshold | Action if Breached | Owner |
|--------|-----------|-------------------|-------|
| | Do not exceed X | | |

## Stop Criteria

| Condition | Action | Owner | SLA |
|-----------|--------|-------|-----|
| [When to halt/kill feature] | | | |

## Success Criteria

### Must Have
- [ ] [Metric] [condition]

### Should Have
- [ ] [Metric] [condition]

## Measurement Plan

| Metric | Data Source | Dashboard | Owner |
|--------|-------------|-----------|-------|
| | | | |

## Baseline Notes

| Metric | Baseline Date | Data Quality | Notes |
|--------|---------------|--------------|-------|
| | | High/Med/Low | |

---

FILE: `templates/design/design-brief.md`

# [Project Name] — Design Brief

**[Subtitle: one line on the design goal, key constraint and target outcome, for design and product]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: what this brief asks design to solve, what it is based on (PRD link), and what deliverables come out of it.]

## Problem Statement
[What user/business problem the design solves: who, evidence, cost of doing nothing. Restate from the PRD.]

## Solution
[The design direction this brief sets. Scope in (flows, screens, states) and out.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| [Measurable design outcome, e.g. task success rate] | [value or TBD: who provides it] | [value] | [usability test / analytics event] |

## Next Action
[One action, one owner.]

---

## Context

**PRD Reference:** [Link]

## Design Goals

1. [Primary goal]
2. [Secondary goal]

## Constraints

| Constraint | Impact |
|------------|--------|
| [Technical/brand/time] | [How it affects design] |

## Target Users

| Persona | Primary Need |
|---------|--------------|
| | |

## Requirements to Address

| REQ ID | Requirement | Design Approach |
|--------|-------------|-----------------|
| REQ-XXX | | |

## Design Principles

1. [Principle guiding this design]

## Deliverables

| Deliverable | Command | File (in this project folder) | How to view |
|-------------|---------|-------------------------------|-------------|
| User flows | `/product-os:flows --from prd.md` | `flows.md` (Mermaid diagrams), `flows.yaml` | GitHub, claude.ai or a Mermaid preview |
| Wireframes | `/product-os:wireframes --from flows.yaml --brief design-brief.md` | `wireframes.md` | Any Markdown viewer |
| Clickable prototype | `/product-os:prototype --from wireframes.md --flows flows.yaml` | `prototype.html` | Open in a browser |

- [ ] User flows
- [ ] Wireframes
- [ ] Prototype

## Success Criteria

- [ ] [Design outcome checklist; measurable targets live in Success Metrics above]

## Open Questions

| Question | Owner | Due |
|----------|-------|-----|
| | | |

---

FILE: `templates/design/design-critique.md`

# [Project Name] — Design Critique

**Severity-rated critique of the actual [project] designs, for the PM, designer and engineering lead.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: which designs were critiqued (see §1 What was reviewed), against what (PRD, design brief, brand), and how to use the findings. Score and counts: §2 Summary.]

## Problem Statement
[One or two lines restating the project's problem from the PRD, and how this critique serves it: catching design issues before build.]

## Solution
[One or two lines restating the project's solution, and the critique's recommendation: Approve / Approve with fixes / Revise.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Critical findings open | [count] | 0 before delivery | This critique |
| [Project metric from metrics framework] | [value or TBD: who provides it] | [value] | [source / event] |

## Next Action
[One action, one owner, e.g. "Designer fixes C-001 and C-002 in SCR-002, then re-run /product-os:critique".]

---

## 1. What was reviewed

Reviews cover the actual design only. No design available: stop and ask the PM for one.

| Artifact | Path or URL | Screens / elements | How it was reviewed | Version reviewed |
|----------|-------------|--------------------|---------------------|------------------|
| [Clickable prototype / Wireframes / Figma / Screenshot] | [e.g. `initiatives/<initiative>/<project>/prototype.html` or Figma link] | [SCR-### IDs, prototype `scr-###` section IDs, Figma node IDs] | [e.g. opened at 1280 px and 390 px; clicked every link; read the source] | [date or commit] |
| PRD | [link] | [REQ IDs traced] | [Traced each requirement to a screen element] | [status, date] |
| Design brief | [link] | [design goals, principles] | [Checked the design against it] | [status, date] |

**Not reviewed:** [screens or frames that exist but were not covered, or "None"]
**Not Verified:** [checks that could not be made and what is missing, e.g. "Contrast: wireframes are grayscale, needs Figma colours", or "None"]

## 2. Summary

**Overall score:** X.X / 5 ([n] dimensions scored; [dimensions] Not Verified)

| Severity | Count |
|----------|-------|
| Critical | X |
| Major | X |
| Minor | X |

**Key findings**
1. [Most important finding]
2. [Second most important finding]
3. [Third most important finding]

## 3. Scorecard

| Dimension | Score (1-5) | Critical | Major | Minor | Notes |
|-----------|-------------|----------|-------|-------|-------|
| Visual Hierarchy | | | | | |
| Layout & Composition | | | | | |
| Typography | | | | | |
| Color | | | | | |
| Spacing & Alignment | | | | | |
| Component Consistency | | | | | |
| Content & Microcopy | | | | | |
| PRD Alignment | | | | | |
| Brand Alignment | | | | | |
| **Overall** | **X.X** | **X** | **X** | **X** | |

A dimension that could not be inspected shows **Not Verified** instead of a score (for example Color on grayscale wireframes).

Score key: 5 Excellent (no issues) · 4 Good (minor issues only) · 3 Acceptable (some major issues, still functional) · 2 Needs work (multiple major issues) · 1 Critical (cannot ship).

## 4. Findings

Severity is written as text: **Critical** (blocks delivery), **Major** (fix before launch), **Minor** (track). IDs: `C-###`, `M-###`, `m-###`.

### [CRITICAL] C-001 [Finding title]

**Location (required):** [Screen → element, with the file line, e.g. SCR-003, Retry button, `prototype.html` line 226 (`#retry-active`); or Figma frame 12:345 → Header]
**Dimension:** [Category from the scorecard]

**Issue:** [What was observed in the design]
**Impact:** [How this affects users and business outcomes]
**Evidence (required):** [Quoted markup or text, screenshot, frame link or measurement from the reviewed design]
**Recommendation:** [Concrete fix with specifics]
**PRD reference:** [REQ-### / flow step]
**Fixed in:** [Story and AC whose acceptance criteria require the fix, e.g. STORY-003.AC2; or "Design file only"]

### [MAJOR] M-001 [Finding title]

**Location (required):** [Screen → element, file line]
**Dimension:** [Category]

**Issue:** [Description]
**Impact:** [Effect on users]
**Evidence (required):** [Quoted markup, text or screenshot]
**Recommendation:** [Specific fix]
**PRD reference:** [REQ-###]
**Fixed in:** [Story and AC, or "Design file only"]

### [MINOR] m-001 [Finding title]

**Location (required):** [Screen → element, file line]
**Dimension:** [Category]
**Issue / impact:** [Brief description]
**Recommendation:** [Quick fix]
**PRD reference:** [REQ-###]

## 5. What works (keep these)

| ID | Positive | Where |
|----|----------|-------|
| P-1 | [Positive observation] | [Screen, element, file line] |

## 6. PRD alignment

| Requirement | Addressed | Notes |
|-------------|-----------|-------|
| REQ-001 | Yes / Partial / No | [Finding IDs or notes] |
| REQ-002 | Yes / Partial / No | [Finding IDs or notes] |

## 7. Fix tracker

| Finding | Severity | Owner | Due | Fixed in | Status |
|---------|----------|-------|-----|----------|--------|
| C-001 | Critical | [name] | [date] | [STORY-XXX.ACn] | Open / Fixed |
| M-001 | Major | [name] | [date] | [STORY-XXX.ACn] | Open / Fixed |
| m-001 | Minor | [name] | [date or "Visual design"] | — | Open / Fixed |

Critical findings are fixed before delivery, Major before launch, Minor are tracked. After the fixes, re-run `/product-os:critique` on the revised files; the page then shows the new findings only.

---

FILE: `templates/design/ux-writing-guide.md`

# [Project Name] — UX Writing Guide

**The voice, the words and the final copy for every screen of [project], for the PM, designer and engineers.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: which designs the UX writing pass covered (see §1 What was reviewed), which voice or style guide it follows, and how to use this guide. The final design already carries this copy: build the copy as it appears in the design.]

## Problem Statement
[One or two lines restating the project's problem from the PRD, and how the copy serves it: users understand each screen and know what to do next.]

## Solution
[One or two lines restating the project's solution, and what this guide fixes: one word per thing, buttons that say what happens, errors that say how to recover.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Screens with approved copy applied in the design | [count] of [total] | All before delivery | §5 Copy by screen |
| [Project metric from the metrics framework that copy affects] | [value or TBD: who provides it] | [value] | [source / event] |

## Next Action
[One action, one owner, e.g. "Designer applies the SCR-004 copy in Figma, then the Delivery Agent adds the Copy line to STORY-003".]

---

## 1. What was reviewed

The pass covers the actual design only. No design available: stop and ask the PM for one.

| Artifact | Path or URL | Screens | Version reviewed |
|----------|-------------|---------|------------------|
| [Clickable prototype / Wireframes / Figma / Screenshot] | [path or link] | [SCR-### IDs] | [date or commit] |
| PRD | [link] | [REQ IDs the copy relies on] | [status, date] |
| Prior designs, screenshots or a style guide | [links to what shows how the product already writes, or "None: voice taken from these designs and confirmed with the PM"] | — | [date] |
| Design critique | [link, or "Not run"] | [findings on wording taken into this pass] | [date] |

**Not reviewed:** [screens that exist but were not covered, or "None"]

## 2. Voice and tone

| Rule | Example |
|------|---------|
| [e.g. Plain words the user already uses] | [a line from this product] |
| [e.g. Calm when something fails] | [a line from this product] |
| [3–5 rules in total] | |

**Readers:** [who reads this copy, how often, and their reading level]
**Languages:** [source language, and whether the copy is translated]

## 3. Words we use

| Thing | Use | Do not use | Why |
|-------|-----|------------|-----|
| [the main object in the product] | [word] | [words to avoid] | [e.g. matches the navigation and the help center] |

## 4. Patterns

| Element | Rule for this product | Example |
|---------|-----------------------|---------|
| Button | [Verb plus object] | [example] |
| Confirmation | [The button's verb, past tense] | [example] |
| Error | [What happened, then how to fix it] | [example] |
| Empty state | [What this is for, then the first action] | [example] |
| Loading | [Say what is loading] | [example] |

## 5. Copy by screen

One table per screen. The copy here is final: build it as written.

### SCR-001 [Screen name]

**Applied in the design:** [Yes, YYYY-MM-DD / No: who applies it, by when]

| Element | Final copy |
|---------|------------|
| Title | [copy] |
| [Label / help text / button / message / state] | [copy] |

### SCR-002 [Screen name]

**Applied in the design:** [Yes, YYYY-MM-DD / No: who applies it, by when]

| Element | Final copy |
|---------|------------|
| Title | [copy] |
| [Element] | [copy] |

## 6. Open items

| Screen | Element | TBD | Who provides it |
|--------|---------|-----|-----------------|
| [SCR-###] | [element] | [what is undecided] | [name] |

[Or "None."]

---

FILE: `templates/delivery/epic.md`

# Epic: [EPIC-XXX] [Project] — [Outcome in plain words]

<!-- Jira Summary: "[Project] — [Outcome in plain words]", e.g. "Self-Serve Signup — Users finish signup without sales help".
     Jira Description: everything below this comment, exactly as laid out in docs/reference/document-format.md §3.
     The epic is the hub for the team: it links to every handoff output (.claude/skills/engineering-handoff.md).
     Start here has one line per reader group. With one group, write it as a single line: "**Start here:** open the …".
     Jira fields, not repeated in the Description: key, owner (assignee), status (Draft / Ready / In Progress / Done), priority, labels, target release. -->

**[Subtitle: one line on the outcome this epic delivers]**

**Start here**
- **Engineers:** open the [end-to-end prototype](link) for the whole journey, then pick up [first ticket].
- **[Another reader group, such as the head of product]:** [where they start: read the [project brief](link), then the [Gantt chart](link)].

Everything else you need is in the Handoff table.

## What and why
[2–4 sentences: what this epic delivers, for whom, and the problem it solves. The PRD holds the detail.]

## Who it is for
- **[User type]:** [what they need from this, in one line]
- **[User type]:** [what they need from this, in one line]

## Handoff
| What | Link |
|------|------|
| PRD | [link] |
| Project brief | [link] |
| User flows | [link] |
| Final design ([Figma / Claude design]) | [link to the main design file] |
| UX writing guide | [link: the copy for every screen. The designs already use it.] |
| End-to-end prototype | [link: one straight path per user] |
| [Extra: low-fidelity wireframes, schema, the Gantt chart for the head of product, …] | [link] |
| Links page | [link to the project page in Confluence] |

## Tickets
| Ticket | Summary | Discipline | Points |
|--------|---------|------------|--------|
| STORY-XXX | [Verb] [thing] [for whom] | frontend / backend / fullstack | [1–5] |

**Estimate:** [n] tickets · [n] points · about [n] sprints at [velocity] points per sprint

## Dependencies
[Only when there are any: team, system or issue, and whether it blocks this epic. Otherwise leave this section out.]

**Feedback:** what was missing, and what was too much? Comment on this epic.

---

FILE: `templates/delivery/user-story.md`

# Story: [STORY-XXX] [Verb] [thing] [for whom]

<!-- Jira Summary: "[Verb] [thing] [for whom]", e.g. "Show password rules while the user types".
     Jira Description: everything below this comment, exactly as laid out in docs/reference/document-format.md §4.
     Keep it short: an engineer should read the whole ticket in under a minute (.claude/skills/engineering-handoff.md).
     Jira fields, not repeated in the Description: key, assignee, status, story points field (mirrors Estimate), labels. -->

**As a** [user type], **I want** [capability], **so that** [outcome].

**Problem:** [One or two sentences: what is broken or missing for this user today.]

## Requirements
- [What to build, in 3–5 short lines.]
- [Name the labels, components, rules and data an engineer needs.]

## UX and design requirements
- [Design-system components, copy, the states to show, accessibility. Or "None: no UI" for backend-only work.]

## Design
[Figma: link to this ticket's own page or frame in the main design file] · Prototype: [link to its step, `#scr-###`] · Flow: [FLOW-### step]
**Copy:** use the copy in the design as is. It has been through the UX writing pass. [UX writing guide](link)
<!-- Copy line: only on tickets with a screen, and only when the screen is marked applied in ux-writing.md. Leave it out of backend-only tickets. -->

## Done when
- [ ] [A plain sentence a tester can check]
- [ ] [3–5 lines in total, covering the main path and the one or two cases that matter]

## Estimate
[n] points · frontend / backend / fullstack · PRD: REQ-XXX · Depends on: [STORY-XXX or None]
<!-- Backend tickets: write "[n] points (proposed; engineering confirms)". -->

## Sub-tasks
<!-- Optional. Use when the work divides by discipline or by step. One line each, no points. Leave the section out when there are none. -->
- [frontend] [step]
- [backend] [step]

## Engineering to complete
<!-- Backend tickets only. Product OS writes the user story, the problem, the high-level requirements and Done when, and leaves this section empty. The engineers fill it in. Leave the section out of frontend tickets. -->
- **Approach:**
- **API and data changes:**
- **Risks and unknowns:**
