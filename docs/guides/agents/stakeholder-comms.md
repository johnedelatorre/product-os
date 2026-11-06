# Stakeholder Comms Agent

Creates stakeholder updates and release notes.

## What It Does

Generates status updates, executive summaries, and release notes for different audiences.

## When to Use

- Weekly status updates
- Milestone announcements
- Release communications

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project to report on |
| `--type` | No | `status`, `milestone`, `release` |
| `--audience` | No | `executive`, `team`, `customer` |

## Outputs

- `status-update.md` — Progress update
- `release-notes.md` — What shipped

## Example

```bash
/product-os:comms --project initiatives/onboarding/signup/ --type status
```

## Communication Types

| Type | Purpose |
|------|---------|
| Status | Weekly progress update |
| Milestone | Key achievement announcement |
| Release | What shipped and impact |

## Tips

1. **Match audience** — executives want outcomes, teams want details
2. **Lead with impact** — results before activity
3. **Be honest about blockers** — builds trust

## Related

- [PRD Author](prd-author.md) — source of metrics
- [Delivery Agent](delivery-agent.md) — source of progress
