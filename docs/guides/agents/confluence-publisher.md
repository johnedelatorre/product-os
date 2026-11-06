# Confluence Publisher Agent

Publishes all project artifacts to Confluence.

## What It Does

Creates the full Confluence hierarchy (Product > Initiatives > Projects) and publishes all markdown artifacts with proper formatting.

## When to Use

- Project artifacts ready for documentation
- Sharing with stakeholders
- Creating official record

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Path to project directory |

## Outputs

- Confluence pages with hierarchy
- `confluence-manifest.json` — Page IDs and URLs

## Example

```bash
/product-os:publish --project initiatives/onboarding/signup/
```

## What Gets Published

| Artifact | Confluence Page |
|----------|-----------------|
| PRD | [Project] PRD |
| Project Brief | [Project] Brief |
| Flows | [Project] User Flows |
| Design Critique | [Project] Design Review |
| Stories | [Project] Backlog |

## Backlog Tables

The backlog page includes:
- Story point subtotals by discipline
- Epic groupings
- Status columns
- Jira links (after sync)

## Tips

1. **Publish early, update often** — idempotent updates
2. **Check hierarchy first** — parent pages must exist
3. **Review in Confluence** — formatting may need tweaks

## Related

- [Confluence Skill](../../.claude/skills/confluence-publishing.md)
- [Jira Sync](jira-sync.md) — creates linked issues
