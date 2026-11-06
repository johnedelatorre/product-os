# Project Planner Agent

Creates RACI matrices, Gantt charts, and project timelines.

## What It Does

Converts project scope into structured plans with clear responsibilities, dependencies, and timelines.

## When to Use

- Project approved, ready for planning
- Need RACI for stakeholder clarity
- Building a Gantt for Jira Plans

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |
| `--team` | No | Team members and roles |

## Outputs

- `raci.md` — Responsibility matrix
- `gantt.md` — Mermaid Gantt chart
- `project-plan.md` — Combined plan document

## Example

```bash
/product-os:plan --from prd.md
```

## Tips

1. **One R per row** — only one Responsible person
2. **Include dependencies** — for Jira Plans integration
3. **Buffer time** — add 20% for unknowns

## Related

- [RACI Skill](../../.claude/skills/raci-matrix.md)
- [Gantt Skill](../../.claude/skills/gantt-generation.md)
- [Delivery Agent](delivery-agent.md) — creates stories from plan
