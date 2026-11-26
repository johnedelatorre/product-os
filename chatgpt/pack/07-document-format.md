# Product OS pack: The standard document, epic and ticket formats

Bundled from the Product OS repo for ChatGPT. Each section below is one Product OS file.
Its path is on the line that starts with `FILE:`. Instructions that name a path mean that section.

Contents:
- `docs/reference/document-format.md`

---

FILE: `docs/reference/document-format.md`

# Document Format Standard

> **TL;DR:** The project's links page and the PRD open with the full header: Title, Subtitle, Description, Problem Statement, Solution, Success Metrics, Next Action. Every other document opens with Title, Subtitle, header table and Description (plus a one-line link to the PRD), then its own content. The Jira epic is the team's hub: a short summary and a table of links (§3). Each ticket is short: user story, requirements, design link, a Done when checklist and an estimate (§4). A reader gets the point in 30 seconds; the detail follows below.

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
3. **Problem Statement, Solution and Success Metrics appear only on the project's links page and the PRD**, and are never empty there. They are specific: who has the problem, what the product already has, what breaks today, the evidence, and what it costs; what we build and how it solves each part. Every other document (brief, metrics, design brief, flows, wireframes, plan, epics, handoff, tracking plan, decision log, group pages, RACI, Gantt, risk register) leaves them out and ends its Description with one line linking to the PRD for the problem, solution and success metrics. It keeps Next Action only when it has its own. This keeps pages from repeating the same paragraphs.
4. **Success Metrics** links to the project's metrics framework. A missing baseline or target is written as a named TBD (what is missing, who provides it) and tracked as an open item; it never blocks the document.
5. **Current state only:** no version banners or change history in the body (see `.claude/skills/doc-hygiene.md`).
6. **The header is the problem, solution and success section.** The body never repeats it: no second Problem, Goals or Success Metrics section, no TL;DR or Executive Summary, and no Metadata table repeating Owner, Status or Last updated. Body sections add detail the header does not hold.

## 2. Confluence Page Structure

Two audiences, one project page. The team sees the handoff: a short set of pages and one table of links. The PM keeps everything else under one **PM workspace** page. The rules for what goes where are in `.claude/skills/engineering-handoff.md`.

```
[Project Name]                          ← Links page: standard header + "Handoff" table
├── PRD
├── Project Brief
├── User Flows
├── [Extras the PM attached]            ← for example Wireframes, Schema
├── Epics & Stories                     ← backlog summary; Jira holds the tickets
└── PM workspace                        ← everything else, for the PM
    ├── 1. Strategy & Definition        ← Intake, Proposal, Metrics Framework
    ├── 2. Design                       ← Design Brief, Wireframes & Prototype, Design Critique, UX Review, Accessibility Audit
    ├── 3. Delivery                     ← Project Plan, Traceability
    └── 4. Decisions & Launch           ← Event Tracking Plan, Decision Log, Release Notes, Post-Launch Review
```

The links page's handoff table has the same rows as the epic (§3):

| What | Link | Status |
|------|------|--------|
| PRD (linked to its page) | Requirements: what we build and why | Approved |
| Project brief (linked to its page) | The project on one page | Approved |
| User flows (linked to its page) | Step-by-step journeys as diagrams | Approved |
| Final design | The main Figma file, or the Claude design | Approved |
| UX writing guide (linked to its page) | The copy for every screen. The designs already use it | Approved |
| End-to-end prototype | Clickable, one straight path per user | Approved |
| Epic in Jira | The tickets, with estimates | Ready |

Rules:
1. **The team's pages link only to each other, to the final design, to the prototype and to Jira.** They never link into the PM workspace. When the PM chose "Everything" in the outputs question, the links page adds a second table, "All documents", listing the PM workspace pages.
2. Page titles are `[Project] — [Document]` ("Self-Serve Signup — PRD"). No numbers, file names or version tags in titles ("05 Signup — Metrics", "prd-v2"). The PM workspace group pages carry the only numbers (1–4), and each holds a one-line description of every page under it.
3. Pages appear in the order the PM creates them (the guided workflow's phase order), in the page tree and in every table: the order in the tree above. The Project Brief follows the PRD because it is written from it.
4. A document too long for one page splits at its own sections. The parent page keeps the standard header, the first sections and, at the end, a numbered list of its child pages; each child page is named for its content ("PRD — Functional Requirements"), never "Part 1", ends with a link to the next one, and sits in section order.
5. Confluence holds final documents only. Working notes (the PRD review, reviewer findings, drafts) stay in the project folder and are never published; their outcome is already in the final document.
6. In the PM workspace, supporting documents nest under the document they support, as named child pages: market analysis, hypothesis log, concept and catalog under the Metrics Framework group; RACI, Gantt, risks and dependencies under the Project Plan. Nothing is dropped.
7. The links page and the PRD carry the full standard header; every other page carries Title, Subtitle, header table, Description and the PRD link line (rule 1.3).
8. A project published before this layout keeps its pages. On the next publish, the plan lists each page that would move under PM workspace, and nothing moves until the PM approves.

## 3. Jira Epic

The epic is the hub for the team. An engineer opens it and finds a link to everything they need.

**Summary:** `[Project] — [Outcome in plain words]` (for example "Self-Serve Signup — Users finish signup without sales help")

**Description** (the complete epic body; nothing is added below it):

```markdown
**[Subtitle: one line on the outcome this epic delivers]**

**Start here**
- **Engineers:** open the [end-to-end prototype](link) for the whole journey, then pick up [first ticket].
- **[Another reader group, such as the head of product]:** [where they start: read the [project brief](link), then the [Gantt chart](link)].

Everything else you need is in the Handoff table.

## What and why
[2–4 sentences: what this epic delivers, for whom, and the problem it solves. The PRD holds the detail.]

## Who it is for
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
| [KEY] | [Verb] [thing] [for whom] | frontend / backend / fullstack | [1–5] |

**Estimate:** [n] tickets · [n] points · about [n] sprints at [velocity] points per sprint

## Dependencies
[Only when there are any. Otherwise leave this section out.]

**Feedback:** what was missing, and what was too much? Comment on this epic.
```

Rules:
1. The epic does not repeat the PRD: no problem statement, scope lists or metrics tables.
2. The team gets one final design. When a Figma file and a Claude design both exist, the PM picks one; the other stays in the PM workspace.
2a. The epic opens with **Start here**, one line per reader group (a single line when there is one group), lists tickets in build order, ends with the **Feedback** line, and gets the Clear Output pass before it is shown (`.claude/skills/engineering-handoff.md` → "The Last Pass").
3. Every link in the Handoff table opens. A missing output is a named TBD (what is missing, who provides it), never an empty row.
4. Each handoff output is also added as a web link on the epic, so it shows in the epic's links panel. The links page in Confluence carries the same table and links back to the epic.
5. The team is given one link: the epic.

Jira fields, not repeated in the Description: key, owner (assignee), status, priority, labels, target release.

## 4. Jira Story

A ticket is short enough to read in under a minute.

**Summary:** `[Verb] [thing] [for whom]` (for example "Show password rules while the user types")

**Description** (the complete story body; nothing is added below it):

```markdown
**As a** [user], **I want** [capability], **so that** [outcome].

**Problem:** [One or two sentences: what is broken or missing for this user today.]

## Requirements
- [What to build, in 3–5 short lines.]
- [Name the labels, components, rules and data an engineer needs.]

## UX and design requirements
- [Design-system components, copy, the states to show, accessibility. Or "None: no UI" for backend-only work.]

## Design
[Figma: link to this ticket's own page or frame in the main design file] · Prototype: [link to its step] · Flow: [FLOW-### step]
**Copy:** use the copy in the design as is. It has been through the UX writing pass. [UX writing guide](link)

## Done when
- [ ] [A plain sentence a tester can check]
- [ ] [3–5 lines in total]

## Estimate
[n] points · frontend / backend / fullstack · PRD: REQ-### · Depends on: [KEY or None]

## Sub-tasks
- [frontend] [step]
- [backend] [step]

## Engineering to complete
- **Approach:**
- **API and data changes:**
- **Risks and unknowns:**
```

Rules:
1. **Done when** is a checklist of plain sentences, each numbered `[KEY].AC1`, `[KEY].AC2` in order, so tests and pull requests can cite them.
2. **Sub-tasks** is optional. Use it when the work divides by discipline or by step. Each line starts with its kind: `[frontend]`, `[backend]`, `[design]`, `[testing]` or `[tracking]`. Sub-tasks become Jira sub-tasks under the ticket, carry no points, and are left out when there are none. The PM accepts the proposed ticket tree before anything is sent to Jira.
2a. **Specific, not generic.** Every line names a real screen, component, field, rule or value in this project. No filler ("handle errors gracefully"), no analysis. Lists have at most 5 lines. Each ticket gets the Clear Output pass and the ready-to-run check before it is shown.
3. **One ticket is one thing a user can see or do**, at 1–5 points. Slicing rules: `.claude/skills/engineering-handoff.md`.
4. **Backend tickets are completed by the engineers.** Product OS writes the user story, the problem, high-level requirements and Done when, marks the estimate "(proposed; engineering confirms)", and leaves **Engineering to complete** empty. It never invents endpoints, tables or architecture. Frontend tickets leave that section out.
5. Not in the ticket: a long description, a solution paragraph, test and rollout tables, and the reasoning behind the estimate. The PRD holds the first three. The reasoning goes in **PM notes** at the end of `stories.md`, which is never sent to Jira.

Jira fields, not repeated in the Description: key, assignee, status, story points field (mirrors Estimate), labels.

## 5. Where to See It

Complete filled-in examples (links page, PRD page, epic, story, flows, wireframe, design critique, UX review, accessibility audit, metrics): [`examples/acme-dashboard/`](../../examples/acme-dashboard/).
