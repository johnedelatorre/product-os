# Confluence Publisher Agent

Publishes the project to Confluence: a short links page for the team, and one PM workspace page for you.

## What It Does

Creates the Confluence hierarchy (Initiatives > Initiative > the project's links page), puts the pages the team needs directly under it, and puts every other document you asked for under one **PM workspace** page. Every page opens with the standard header from [`docs/reference/document-format.md`](../../reference/document-format.md). Nothing is written until you approve the publish plan. The rules for what goes where are in [`.claude/skills/engineering-handoff.md`](../../../.claude/skills/engineering-handoff.md).

## When to Use

- Project artifacts ready for documentation
- Sharing with stakeholders
- Creating official record

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Path to project directory |

## Outputs

- The project's links page, with a "Handoff" table that has the same links as the Jira epic
- The team's pages: PRD, Project Brief, User Flows, any extras you attached, and Epics & Stories
- A PM workspace page with four group pages (1. Strategy & Definition, 2. Design, 3. Delivery, 4. Decisions & Launch) for everything else
- `publish-manifest.json` — Page IDs and URLs

## Example

```bash
/product-os:publish --project initiatives/onboarding/signup/
```

## What Gets Published

| Artifact | Confluence Page | Where |
|----------|-----------------|-------|
| Project overview and the Handoff table | [Project] (links page) | — |
| PRD, Project Brief, User Flows | [Project] — PRD, etc. | Under the project page, for the team |
| Extras you attached to the epic (wireframes, schema, Gantt chart…) | [Project] — Wireframes, etc. | Under the project page, for the team |
| Epics & Stories | [Project] — Epics & Stories | Under the project page, for the team |
| Intake, Proposal, Metrics | [Project] — Intake, etc. | PM workspace · 1. Strategy & Definition |
| Design Brief, Wireframes & Prototype, Critique, UX Review, Accessibility | [Project] — Design Brief, etc. | PM workspace · 2. Design |
| Plan, RACI, Gantt, Risks, Dependencies, Traceability | [Project] — Project Plan, etc. | PM workspace · 3. Delivery |
| Decision Log, Event Tracking Plan, Release Notes, Post-Launch Review | [Project] — Decision Log, etc. | PM workspace · 4. Decisions & Launch |

Only the documents you asked for are created and published. A document too long for one page splits at its own sections, each named for its content ("PRD — Functional Requirements"), never "Part 1". The PRD review and the PM notes in `stories.md` are never published.

## Epics & Stories Page

One short page:
- What each epic delivers, in 2–4 sentences
- The handoff links
- The ticket tree: stories with their sub-tasks, discipline, points and Jira links (after sync)

## Tips

1. **Publish early, update often** — idempotent updates
2. **Check hierarchy first** — parent pages must exist
3. **Check the header** — the links page and the PRD need Problem Statement, Solution and Success Metrics; gaps show as named TBDs in the publish plan
4. **Send the team the epic, not a Confluence page** — the epic has every link they need
5. **Review in Confluence** — formatting may need tweaks

## Related

- [Confluence Skill](../../../.claude/skills/confluence-publishing.md)
- [Jira Sync](jira-sync.md) — creates linked issues
