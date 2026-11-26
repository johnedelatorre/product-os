---
description: "Publish to Confluence: a links page and the team's pages, with your own documents under one PM workspace page."
argument-hint: "--project <path> [--config <config.yaml>]"
---
# /product-os:publish

Publish to Confluence: a links page and the team's pages, with your own documents under one PM workspace page.

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

One links page per project for the team, and one PM workspace page for everything else (`docs/reference/document-format.md` §2, `.claude/skills/engineering-handoff.md`):

```
Product Space
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]                   ← Links page: standard header + "Handoff" table
            ├── PRD
            ├── Project Brief
            ├── User Flows
            ├── [Extras you attached]        ← for example Wireframes, Schema
            ├── Epics & Stories              ← the ticket tree, with Jira links
            └── PM workspace                 ← everything else, for you
                ├── 1. Strategy & Definition ← Intake, Proposal, Metrics Framework
                ├── 2. Design                ← Design Brief, Wireframes & Prototype, Design Critique, UX Review, Accessibility Audit
                ├── 3. Delivery              ← Project Plan, RACI, Gantt Chart, Risks, Dependencies, Traceability
                └── 4. Decisions & Launch    ← Decision Log, Event Tracking Plan, Release Notes, Post-Launch Review
```

The links page carries the same Handoff table as the Jira epic and links back to it. The team's pages never link into the PM workspace. Long documents split at their own sections, named for their content ("PRD — Functional Requirements"), never "Part 1".

A project published with the earlier layout keeps its pages: the publish plan lists each page that would move under PM workspace, and nothing moves until you approve.

## Epics & Stories Page

One short page, below its standard header:
- What the epic delivers, in 2–4 sentences
- The handoff links
- The ticket tree with discipline, points and Jira links (populated after jira-sync)
- One estimate line

Point totals by discipline and the sprint allocation are in the Project Plan, in the PM workspace.

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
