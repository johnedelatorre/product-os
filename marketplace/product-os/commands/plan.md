---
description: "Create project plan, RACI, and Gantt chart."
argument-hint: "--from <prd.md> [--stories <stories.md>]"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

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
