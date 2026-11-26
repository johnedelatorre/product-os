# Dashboard Performance — Confluence Page Map

**Where each example document lives in Confluence; for PMs setting up a project space.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
`/product-os:publish` turns the project's local files into one links page for the team, the few pages the team needs, and one PM workspace page for everything else (`docs/reference/document-format.md` §2), filed under the Initiative page inside the space's Initiatives page, as `confluence-publisher` creates them. This note shows which page each example file becomes. [00-hub-page.md](00-hub-page.md) is the hub page exactly as it renders.

## Problem Statement
Readers get lost when a project's pages are scattered or split into "Part 1 / Part 2". The Dashboard Performance pages must be findable from one place.

## Solution
One links page with the Handoff table, the team's pages directly under it, and the PM's own documents under one PM workspace page. The Jira epic carries the same links, and the team starts there.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Handoff outputs reachable from the epic and the links page in one click | — | 100% | The Handoff table |

## Next Action
Priya Shah approves the publish preview, then runs `/product-os:publish`.

---

## Page tree

```
[Product Space]
└── Initiatives                                        ← parent for all initiatives (initiatives_parent_page_id)
    └── Platform Performance                           ← Initiative page
        └── Dashboard Performance                      ← Links page: 00-hub-page.md (the Handoff table, pointing to epic DASH-100)
            ├── Dashboard Performance — PRD                        ← pm/prd.md
            ├── Dashboard Performance — Project Brief              ← pm/project-brief.md
            ├── Dashboard Performance — User Flows                 ← design/flows.md (Mermaid renders as diagrams)
            ├── Dashboard Performance — Wireframes                 ← design/wireframes.md (attached to the epic by the PM)
            ├── Dashboard Performance — Epics & Stories            ← jira/epic.md + jira/stories.md (the ticket tree, links to Jira DASH-100)
            └── PM workspace                                       ← the documents Priya asked for herself
                ├── 1. Strategy & Definition
                │   ├── Dashboard Performance — Intake             ← intake/intake.md
                │   └── Dashboard Performance — Metrics Framework  ← pm/metrics-framework.md
                ├── 2. Design
                │   ├── Dashboard Performance — Prototype          ← design/prototype.html, the full version with every state
                │   ├── Dashboard Performance — Design Critique    ← design/design-critique.md
                │   ├── Dashboard Performance — UX Review          ← design/ux-review.md
                │   └── Dashboard Performance — Accessibility Audit ← design/accessibility-audit.md
                ├── 3. Delivery                                    ← empty: Priya did not ask for a project plan, RACI or Gantt chart
                └── 4. Decisions & Launch                          ← empty until the decision log and launch pages exist
```

The team's pages are the six directly under the project page. They link to each other, to the handoff prototype (`design/prototype-handoff.html`) and to Jira. They do not link into the PM workspace.

## Not published to Confluence

| File | Where it goes |
|------|---------------|
| `design/flows.yaml` | Stays in the repo; source the flows page is rendered from |
| `jira/epic.md`, `jira/stories.md` Description blocks | Jira issues via `/product-os:jira-sync` (the Confluence page summarizes and links them) |
| `jira/stories.md` PM notes | Stay in the repo; never sent to Jira or shown on the team's pages |
