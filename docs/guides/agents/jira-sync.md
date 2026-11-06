# Jira Sync Agent

Creates and updates Jira epics and stories.

## What It Does

Syncs project backlog to Jira with story points, discipline labels, dates, and dependencies for Jira Plans.

## When to Use

- After Confluence publishing
- Before sprint planning
- Keeping Jira in sync

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Path to project directory |

## Outputs

- Jira epics and stories
- `jira-sync-manifest.json` — Issue keys and URLs

## Example

```bash
/product-os:jira-sync --project initiatives/onboarding/signup/
```

## What Gets Created

| Artifact | Jira Issue |
|----------|------------|
| Epic | Epic with dates, labels |
| Story | Story with points, discipline, dates |
| Dependencies | Issue links (blocks/blocked by) |

## Jira Plans Integration

Stories include start/end dates from the Gantt chart, enabling:
- Timeline view in Jira Plans
- Dependency arrows
- Critical path visibility

## Tips

1. **Publish to Confluence first** — for linking
2. **Sync is idempotent** — safe to re-run
3. **Check Plans view** — verify dates and dependencies

## Related

- [Jira Sync Skill](../../.claude/skills/jira-sync.md)
- [Confluence Publisher](confluence-publisher.md) — run first
