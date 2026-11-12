# Confluence Publisher Agent

Publishes all project artifacts to Confluence.

## What It Does

Creates the Confluence hierarchy (Initiatives > Initiative > Project hub page > four group pages) and publishes every markdown artifact with the standard header from [`docs/reference/document-format.md`](../../reference/document-format.md). Nothing is written until you approve the publish plan.

## When to Use

- Project artifacts ready for documentation
- Sharing with stakeholders
- Creating official record

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Path to project directory |

## Outputs

- Project hub page with a "Documents in this project" table
- Four group pages: 1. Strategy & Definition, 2. Design, 3. Delivery, 4. Decisions & Launch
- One page per document, each opening with the standard header
- `publish-manifest.json` — Page IDs and URLs

## Example

```bash
/product-os:publish --project initiatives/onboarding/signup/
```

## What Gets Published

| Artifact | Confluence Page | Group |
|----------|-----------------|-------|
| Project overview | [Project] (hub page) | — |
| Intake, Proposal, PRD (supporting docs as child pages; the PRD review is not published), Project Brief, Metrics | [Project] — PRD, etc. | 1. Strategy & Definition |
| Design Brief, Flows, Wireframes & Prototype, Critique, UX Review, Accessibility | [Project] — User Flows, etc. | 2. Design |
| Epics & Stories, Plan, RACI, Gantt, Risks, Dependencies, Traceability | [Project] — Epics & Stories (Backlog), etc. | 3. Delivery |
| Decision Log, Event Tracking Plan, Release Notes, Post-Launch Review | [Project] — Decision Log, etc. | 4. Decisions & Launch |

A document too long for one page splits at its own sections, each named for its content ("PRD — Functional Requirements"), never "Part 1".

## Backlog Tables

The backlog page includes:
- Story point subtotals by discipline
- Epic groupings
- Status columns
- Jira links (after sync)

## Tips

1. **Publish early, update often** — idempotent updates
2. **Check hierarchy first** — parent pages must exist
3. **Check the header** — every page needs Problem Statement, Solution and Success Metrics; gaps show as named TBDs in the publish plan
4. **Review in Confluence** — formatting may need tweaks

## Related

- [Confluence Skill](../../../.claude/skills/confluence-publishing.md)
- [Jira Sync](jira-sync.md) — creates linked issues
