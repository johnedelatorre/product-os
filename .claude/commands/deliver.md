---
description: "Generate epics and user stories with acceptance criteria."
argument-hint: "--from <prd.md> --designs <design-brief.md,wireframes.md>"
---
# /product-os:deliver

Generate epics and user stories with acceptance criteria.

## Usage

```
/product-os:deliver --from <prd.md> --designs <design-brief.md,wireframes.md>
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to PRD |
| `--designs` | Yes | Design artifacts (comma-separated) |
| `--velocity` | No | Team velocity for sprint estimate |
| `--output` | No | Output directory |

## Output

Generates:
- `epics.md` — Epics mapped to PRD goals
- `stories.md` — Stories with acceptance criteria
- `backlog.csv` — Export for Jira import

## Story Format

Each story includes:
- User story format (As a... I want... So that...)
- Acceptance criteria (Given/When/Then)
- Story points with rationale
- **Discipline label** (`frontend`, `backend`, or `fullstack`)
- Dependencies
- PRD and design references

## Discipline Labels

| Label | When to Use |
|-------|-------------|
| `frontend` | UI only, no API changes |
| `backend` | API/database only, no UI |
| `fullstack` | Both frontend and backend |

## Story Point Rubric

| Points | Complexity | Uncertainty |
|--------|------------|-------------|
| 1 | Trivial | None |
| 2 | Simple | Low |
| 3 | Moderate | Low |
| 5 | Complex | Medium |
| 8 | Very Complex | High |
| 13 | Extremely Complex | Very High |

## Example

```
/product-os:deliver \
  --from prd.md \
  --designs design-brief.md,wireframes.md \
  --velocity 40
```

## Agent

Uses: `delivery-agent.md`

## Quality Checklist

- [ ] Every PRD requirement has stories
- [ ] Acceptance criteria are testable
- [ ] Story points have rationale
- [ ] Discipline labels assigned
- [ ] Dependencies identified
