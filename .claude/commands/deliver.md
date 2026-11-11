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

## Epic Format

`epics.md` opens with the standard header (`docs/reference/document-format.md` §1). Each epic follows §3: summary `[Project] — [Outcome in plain words]`, then one complete body: Subtitle, Description, Problem Statement, Solution (in / out of scope), Success Metrics, Stories (summary, story list, estimation), Dependencies and Links. Priority, owner and status are Jira fields. Template: `templates/delivery/epic.md`.

## Story Format

`stories.md` opens with the standard header. Each story follows §4 (summary `[Verb] [thing] [for whom]`): one complete body, each field once. Template: `templates/delivery/user-story.md`.

Each story includes, in this order:
- User story line (As a... I want... so that...)
- Description, Problem Statement and Solution
- Acceptance criteria (Given/When/Then)
- Design: use cases, flow and screens (FLOW-###, SCR-###), states, UX requirements
- Validation: tests, observability, rollout / rollback, the success metric it moves
- Details: **discipline label** (`frontend`, `backend`, or `fullstack`), story points, confidence, dependencies, estimate rationale, out of scope
- Links: epic, PRD requirement, Confluence

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
- [ ] Every epic and story has Description, Problem Statement, Solution and Success Metrics / Validation
- [ ] Acceptance criteria are testable
- [ ] Story points have rationale
- [ ] Discipline labels assigned
- [ ] Dependencies identified
