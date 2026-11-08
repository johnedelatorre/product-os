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

```
Product Space
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]
            ├── Project Brief
            ├── PRD
            ├── Project Plan
            ├── RACI
            ├── Gantt Chart
            ├── Design Brief
            ├── User Flows
            ├── Wireframes
            ├── Design Critique
            ├── UX Review
            ├── Accessibility Audit
            ├── Backlog ← Special page with tables
            └── Decision Log
```

## Backlog Page

The Backlog page includes:
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

- Atlassian MCP connected, OR
- `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `.env`
- `product-os.config.yaml` with space key and parent page

## See Also

- `/product-os:jira-sync` — Create Jira issues after publishing
