---
description: "Create and sync the epic (with its handoff links), stories and sub-tasks to Jira."
argument-hint: "--project <path> [--config <config.yaml>]"
---
# /product-os:jira-sync

Create and sync the epic (with its handoff links), stories and sub-tasks to Jira.

## Usage

```
/product-os:jira-sync --project <path> [--config <config.yaml>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Path to project folder |
| `--config` | No | Config file (default: `product-os.config.yaml`) |
| `--dry-run` | No | Preview without creating issues |

## What Gets Created

### Epics
- Summary: `[Project] — [Outcome in plain words]`
- Description in the standard epic format (`docs/reference/document-format.md` §3): Subtitle, What and why, Who it is for, the Handoff table (PRD, project brief, user flows, final design, end-to-end prototype, extras, links page), the ticket list
- Each handoff output also added as a web link on the epic, so it shows in the epic's links panel
- Labels: `product-os`, initiative slug, project slug
- Start/Due dates from Gantt

### Stories
- Summary: `[Verb] [thing] [for whom]`
- Description in the standard story format (§4), each part once: user story, Problem, Requirements, UX and design requirements, Design (this ticket's own Figma page or frame and prototype step), Done when, Estimate
- Backend tickets also carry an empty **Engineering to complete** section; a re-sync never overwrites what the engineers wrote there
- Epic link to parent
- **Story points** (custom field)
- **Discipline labels**: `frontend`, `backend`, or both for fullstack
- Start/Due dates from Gantt
- Dependencies as issue links (blocks/is blocked by)

### Sub-tasks
- One Jira sub-task per line under a story's `## Sub-tasks`, created under that story, with no points

Nothing is synced before you have accepted the ticket tree. The PM notes in `stories.md` are never sent.

## Jira Plans/Timeline

The sync populates fields for Jira Plans (Advanced Roadmaps):
- Start Date and Due Date enable timeline bars
- Dependencies show as connecting lines
- Epic hierarchy groups related work

## Idempotent Sync

Re-running updates existing issues:
- Matches by `product-os-id` custom field or label + summary
- Updates changed fields
- Never creates duplicates

## Discipline to Component Mapping

Configure in `product-os.config.yaml`:
```yaml
jira:
  discipline_mapping: "labels"  # or "components"
  components:
    frontend: "Frontend"
    backend: "Backend"
```

## Output

- Jira issues created/updated
- `jira-sync-manifest.json` — Record of all issue keys and URLs
- Confluence links page and Epics & Stories page updated with Jira links
- One link to share with the team: the epic

## Example

```
/product-os:jira-sync --project initiatives/onboarding/signup/
```

## Agent

Uses: `jira-sync.md`

## Prerequisites

- Atlassian MCP connected (preferred; no credentials needed), OR
- `product-os.config.yaml` with project key (field IDs are read from your instance; config values are hints)

## Approval

The agent first shows the proposed creates, updates, and links. Nothing is written to Jira until you explicitly approve. Team-managed projects link stories to epics via the `parent` field.
