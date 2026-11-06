# /product-os:jira-sync

Create and sync epics/stories to Jira.

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
- Summary: `[Project] Epic: [Title]`
- Description with Confluence links
- Labels: `product-os`, initiative slug, project slug
- Start/Due dates from Gantt

### Stories
- Summary: Story title
- Description with acceptance criteria
- Epic link to parent
- **Story points** (custom field)
- **Discipline labels**: `frontend`, `backend`, or both for fullstack
- Start/Due dates from Gantt
- Dependencies as issue links (blocks/is blocked by)

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
- Confluence backlog page updated with Jira links

## Example

```
/product-os:jira-sync --project initiatives/onboarding/signup/
```

## Agent

Uses: `jira-sync.md`

## Prerequisites

- Atlassian MCP connected, OR
- `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `.env`
- `product-os.config.yaml` with project key and custom field IDs
