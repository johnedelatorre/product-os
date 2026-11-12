# Document Format Standard

> **TL;DR:** The project hub and the PRD open with the full header: Title, Subtitle, Description, Problem Statement, Solution, Success Metrics, Next Action. Every other document opens with Title, Subtitle, header table and Description (plus a one-line link to the PRD), then its own content. Jira epics and stories use the same opening sections in one complete body each (§3, §4). A reader gets the point in 30 seconds; the detail follows below.

This is the format PMs and Heads of Product expect. Agents apply it to every artifact they write or publish. Templates in `templates/` already follow it.

## 1. The Standard Header (documents and Confluence pages)

```markdown
# [Title]

**[Subtitle: one line saying what this page is and who it is for]**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| [initiative] | [project] | [name] | Draft / In review / Approved | [YYYY-MM-DD] |

## Description
[2–4 sentences: what this document covers and how to use it.]

## Problem Statement
[Who has the problem, what it is, the evidence, and what it costs if we do nothing.]

## Solution
[What we will do (or what this document proposes). Key scope in and out.]

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| [metric] | [value or TBD: who provides it] | [value] | [source / event] |

## Next Action
[One action, one owner.]

---

[Document-specific sections follow.]
```

Rules:
1. **Title** names the thing, not the process ("Self-Serve Signup — PRD", not "PRD v2 draft"). <!-- hygiene-ok -->
2. **Subtitle** is one sentence, under 20 words.
3. **Problem Statement, Solution and Success Metrics appear only on the project hub and the PRD**, and are never empty there. They are specific: who has the problem, what Virtus already has, what breaks today, the evidence, and what it costs; what we build and how it solves each part. Every other document (brief, metrics, design brief, flows, wireframes, plan, epics, handoff, tracking plan, decision log, group pages, RACI, Gantt, risk register) leaves them out and ends its Description with one line linking to the PRD for the problem, solution and success metrics. It keeps Next Action only when it has its own. This keeps pages from repeating the same paragraphs.
4. **Success Metrics** links to the project's metrics framework. A missing baseline or target is written as a named TBD (what is missing, who provides it) and tracked as an open item; it never blocks the document.
5. **Current state only:** no version banners or change history in the body (see `.claude/skills/doc-hygiene.md`).
6. **The header is the problem, solution and success section.** The body never repeats it: no second Problem, Goals or Success Metrics section, no TL;DR or Executive Summary, and no Metadata table repeating Owner, Status or Last updated. Body sections add detail the header does not hold.

## 2. Confluence Page Structure

Fewer, clearer pages. One hub page per project, then four groups.

```
[Project Name]                          ← Hub page: standard header + "Documents in this project" table
├── 1. Strategy & Definition            ← Intake, Proposal, PRD, Project Brief, Metrics Framework
├── 2. Design                           ← Design Brief, User Flows, Wireframes & Prototype, Design Critique, UX Review, Accessibility Audit
├── 3. Delivery                         ← Project Plan, Epics & Stories
└── 4. Decisions & Launch               ← Event Tracking Plan, Decision Log, Release Notes, Post-Launch Review
```

The hub page's documents table:

| Document | What it is | Status | Owner |
|----------|-----------|--------|-------|
| PRD (linked to its page) | Requirements: what we build and why | Approved | [name] |
| User Flows (linked to its page) | Step-by-step journeys as diagrams | In review | [name] |

Rules:
1. Each group page holds a one-line description of every page under it.
2. Page titles are `[Project] — [Document]` ("Self-Serve Signup — PRD"). No numbers, file names or version tags in titles ("05 Signup — Metrics", "prd-v2"). The group pages carry the only numbers (1–4).
3. Pages appear in the order the PM creates them (the guided workflow's phase order), in the page tree and in every documents table: the order in the tree above. The Project Brief follows the PRD because it is written from it. Documents the tree does not list (a concept note, a catalog, a handoff) go after the listed ones in their group.
4. A document too long for one page splits at its own sections. The parent page keeps the standard header, the first sections and, at the end, a numbered list of its child pages; each child page is named for its content ("PRD — Functional Requirements"), never "Part 1", ends with a link to the next one, and sits in section order.
5. Confluence holds final documents only. Working notes (the PRD review, reviewer findings, drafts) stay in the project folder and are never published; their outcome is already in the final document.
6. Supporting documents nest under the document they support, as named child pages, so each group shows a few documents: market analysis, hypothesis log, concept and catalog under the PRD; RACI, Gantt, risks and dependencies under the Project Plan; traceability under Epics & Stories. Nothing is dropped.
7. The hub and the PRD carry the full standard header; every other page carries Title, Subtitle, header table, Description and the PRD link line (rule 1.3).

## 3. Jira Epic

**Summary:** `[Project] — [Outcome in plain words]` (for example "Self-Serve Signup — Users finish signup without sales help")

**Description** (the complete epic body; nothing is added below it):

```markdown
**[Subtitle: one line on the outcome this epic delivers]**

## Description
[2–4 sentences: what this epic covers.]

## Problem Statement
[Who has the problem and the evidence.]

## Solution
**In scope:** [what this epic delivers]
**Out of scope:** [what it explicitly excludes]

## Success Metrics
| Metric | Baseline | Target |
|--------|----------|--------|
| [metric from the PRD] | [value or TBD: who provides it] | [value] |

## Stories
[1–3 lines: the story groups and the order they ship in. Jira lists the child issues.]

| Story | Summary | Discipline | Points | Status |
|-------|---------|------------|--------|--------|
| [KEY] | [Verb] [thing] [for whom] | frontend / backend / fullstack | [1–13] | [status] |

**Estimation:** [n] stories · [n] points ([n] frontend, [n] backend) · confidence High / Medium / Low · about [n] sprints at [velocity] points per sprint

## Dependencies
| Dependency | Type | Status |
|------------|------|--------|
| [team, system or issue] | Blocks / Blocked by / External | [status] |

## Links
PRD: [link, goal and REQ IDs] · Design: [flows, wireframes, prototype] · Confluence hub page: [link] · Backlog: [link]
```

Jira fields, not repeated in the Description: key, owner (assignee), status, priority, labels, target release.

## 4. Jira Story

**Summary:** `[Verb] [thing] [for whom]` (for example "Show password rules while the user types")

**Description** (the complete story body; nothing is added below it):

````markdown
**As a** [user], **I want** [capability], **so that** [outcome].

## Description
[What this story changes, in 2–3 sentences.]

## Problem Statement
[The user problem this story solves.]

## Solution
[What we build, with any technical notes engineering needs.]

## Acceptance Criteria
```gherkin
Feature: [feature name]

  Scenario: [KEY].AC1 [happy path]
    Given ...
    When ...
    Then ...

  Scenario: [KEY].AC2 [error case]
    Given ...
    When ...
    Then ...
```

## Design
**Use cases:** [UC-X / JTBD-X this story serves (PRD §Use Cases / §JTBD)]
**Flow and screens:** [FLOW-### steps and SCR-### screens this story implements, linked to the flow, wireframe and prototype; or "No UI design" for backend-only stories]
**States:** [empty, loading, error, success and edge states this story must show; name the AC that covers each]
**UX requirements:** [design-system, copy, accessibility (WCAG 2.2 AA) and interaction rules; or "None" with the reason]

## Validation
| Check | What proves it |
|-------|----------------|
| Tests | [unit, integration, E2E: what each covers; N/A if not applicable] |
| Observability | [logs, events and alerts that prove it works in production] |
| Rollout / rollback | [feature flag, rollback trigger and rollback step] |
| Success metric | [MET-### or event this story moves] |

## Details
| Discipline | Points | Confidence | Dependencies |
|------------|--------|------------|--------------|
| frontend / backend / fullstack | [1–13 or TBD: team calibration] | High / Medium / Low | [KEY (type, status) or None] |

**Estimate rationale:** [complexity, uncertainty, similar past work, and why this discipline]
**Out of scope:** [explicit exclusions, or "None"]

## Links
Epic: [KEY] · PRD requirement: [REQ-###] · Confluence: [Epics & Stories page]
````

Jira fields, not repeated in the Description: key, assignee, status, story points field (mirrors Details), labels.

## 5. Where to See It

Complete filled-in examples (hub page, PRD page, epic, story, flows, wireframe, design critique, UX review, accessibility audit, metrics): [`examples/acme-dashboard/`](../../examples/acme-dashboard/).
