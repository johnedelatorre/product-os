# Dashboard Performance — Confluence Page Map

**Where each example document lives in Confluence; for PMs setting up a project space.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format.

## Description
`/product-os:publish` turns the project's local files into one hub page plus four group pages (`docs/reference/document-format.md` §2), filed under the Initiative page inside the space's Initiatives page, as `confluence-publisher` creates them. This note shows which page each example file becomes. [00-hub-page.md](00-hub-page.md) is the hub page exactly as it renders.

## Problem Statement
Readers get lost when a project's pages are scattered or split into "Part 1 / Part 2". The Dashboard Performance pages must be findable from one place.

## Solution
One hub page, four groups, one page per document; Jira issues link back to the hub.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| Pages reachable from the hub in one click | — | 100% | Hub "Documents in this project" table |

## Next Action
Priya Shah approves the publish preview, then runs `/product-os:publish`.

---

## Page tree

```
[Product Space]
└── Initiatives                                        ← parent for all initiatives (initiatives_parent_page_id)
    └── Platform Performance                           ← Initiative page
        └── Dashboard Performance                      ← Project hub page: 00-hub-page.md
            ├── 1. Strategy & Definition
            │   ├── Dashboard Performance — Intake                 ← intake/intake.md
            │   ├── Dashboard Performance — Project Brief          ← pm/project-brief.md
            │   ├── Dashboard Performance — PRD                    ← pm/prd.md
            │   └── Dashboard Performance — Metrics Framework      ← pm/metrics-framework.md
            ├── 2. Design
            │   ├── Dashboard Performance — User Flows             ← design/flows.md (Mermaid renders as diagrams)
            │   ├── Dashboard Performance — Wireframes & Prototype ← design/wireframes.md + prototype.html attached
            │   ├── Dashboard Performance — Design Critique        ← design/design-critique.md
            │   ├── Dashboard Performance — UX Review              ← design/ux-review.md
            │   └── Dashboard Performance — Accessibility Audit    ← design/accessibility-audit.md
            ├── 3. Delivery
            │   └── Dashboard Performance — Epics & Stories        ← jira/epic.md + jira/stories.md (links to Jira DASH-100)
            └── 4. Decisions & Launch                              ← empty until the decision log and launch pages exist
```

## Not published to Confluence

| File | Where it goes |
|------|---------------|
| `design/flows.yaml` | Stays in the repo; source the flows page is rendered from |
| `jira/epic.md`, `jira/stories.md` Description blocks | Jira issues via `/product-os:jira-sync` (the Confluence page summarizes and links them) |
