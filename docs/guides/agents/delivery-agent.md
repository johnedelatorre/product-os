# Delivery Agent Agent

Creates epics, stories, and story point estimates.

## What It Does

Transforms design and planning artifacts into a backlog with properly pointed stories and discipline labels.

## When to Use

- Design approved, ready for delivery planning
- Creating sprint backlog
- Estimating work

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | PRD, flows, and design artifacts |
| `--velocity` | No | Team velocity for sprint planning |

## Outputs

- `epics.md` — Epic definitions
- `stories.md` — User stories with points and disciplines

## Example

```bash
/product-os:deliver --from prd.md
```

## Story Structure

Each story includes:
- User story format ("As a... I want... So that...")
- Acceptance criteria
- Story points (Fibonacci)
- Discipline label (frontend/backend/fullstack)
- Dependencies

## Discipline Labels

| Label | Meaning |
|-------|---------|
| `frontend` | UI/UX implementation |
| `backend` | API, data, business logic |
| `fullstack` | Both frontend and backend |

## Tips

1. **Keep stories small** — Under 8 points ideally
2. **Include rationale** — Why this point estimate?
3. **Track dependencies** — Note blockers

## Related

- [Story Pointing Skill](../../.claude/skills/story-pointing.md)
- [Discipline Labeling Skill](../../.claude/skills/discipline-labeling.md)
- [Confluence Publisher](confluence-publisher.md) — next step
