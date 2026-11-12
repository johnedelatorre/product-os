---
description: "Publish all project artifacts to Confluence."
argument-hint: "--project <path> [--config <config.yaml>]"
---
# /product-os:publish

Publish all project artifacts to Confluence.

## Usage

```
/product-os:publish --project <path> [--config <config.yaml>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Path to project folder |
| `--config` | No | Config file (default: `product-os.config.yaml`) |
| `--dry-run` | No | Preview without publishing |

## Confluence Hierarchy

One hub page per project, then four groups (`docs/reference/document-format.md` §2):

```
Product Space
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]                   ← Hub page: standard header + "Documents in this project" table
            ├── 1. Strategy & Definition     ← Intake, Proposal / Project Brief, PRD, PRD Review, Metrics Framework
            ├── 2. Design                    ← Design Brief, User Flows, Wireframes & Prototype, Design Critique, UX Review, Accessibility Audit
            ├── 3. Delivery                  ← Epics & Stories (Backlog), Project Plan, RACI, Gantt Chart, Risks, Dependencies, Traceability
            └── 4. Decisions & Launch        ← Decision Log, Event Tracking Plan, Release Notes, Post-Launch Review
```

Every page opens with the standard header (Title, Subtitle, Description, Problem Statement, Solution, Success Metrics, Next Action). Long documents split at their own sections, named for their content ("PRD — Functional Requirements"), never "Part 1".

## Backlog Page

The Backlog page (Epics & Stories, under 3. Delivery) includes, below its standard header:
- Epic table with story point totals
- Story table with discipline column
- **Story point subtotals by discipline** (Frontend, Backend, Fullstack)
- Sprint allocation estimate
- Links to Jira (populated after jira-sync)

## Output

- Confluence pages created/updated
- `publish-manifest.json` — Record of all page IDs and URLs

## Example

```
/product-os:publish --project initiatives/onboarding/signup/
```

## Agent

Uses: `confluence-publisher.md`

## Prerequisites

- Atlassian MCP connected (preferred; no credentials needed), OR
- `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `.env` (REST fallback only)
- `product-os.config.yaml` with space key and parent page

## Approval

The agent first shows the publish plan (pages to create or update, and where). Nothing is written to Confluence until you explicitly approve.

## See Also

- `/product-os:jira-sync` — Create Jira issues after publishing
