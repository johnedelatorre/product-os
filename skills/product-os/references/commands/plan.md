---
description: "Create project plan, RACI, and Gantt chart."
argument-hint: "--from <prd.md> [--stories <stories.md>]"
---
# /product-os:plan

Create project plan, RACI, and Gantt chart.

## Usage
```
/product-os:plan --from <prd.md> [--stories <stories.md>]
```

## Output
- `project-plan.md` — Phases, milestones, timeline
- `raci.md` — Responsibility assignment matrix
- `gantt.md` — Mermaid Gantt + CSV export

## Gantt Integration
Dates and dependencies used by jira-sync to populate:
- Start/Due Date fields
- Issue links (blocks/is blocked by)
- Jira Plans/Timeline visualization

## Agent
Uses: `project-planner.md`
