# /product-os:new-project

Run the full Product OS pipeline from intake to publication.

## Usage

```
/product-os:new-project --initiative <slug> --project <slug> --input "<requirement>"
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | Yes | Initiative slug (kebab-case) |
| `--project` | Yes | Project slug (kebab-case) |
| `--input` | Yes | Raw requirement text or file path |
| `--skip-stages` | No | Comma-separated stages to skip |
| `--targets` | No | Flow render targets (default: mermaid) |

## Pipeline Stages

1. **Intake** → `intake.md`
2. **PM** → `prd.md`, `project-brief.md`, `project-plan.md`, `raci.md`, `gantt.md`
3. **Design** → `design-brief.md`, `flows.yaml`, `flows.md`, `wireframes.md`
4. **Prototype** → `prototype.html`, `prototype-react.tsx`
5. **Review** → `design-critique.md`, `ux-review.md`, `accessibility-audit.md`
6. **Delivery** → `epics.md`, `stories.md`
7. **Publish** → Confluence pages, Jira issues

## Human Checkpoints

The pipeline pauses at each checkpoint for approval:
- After Intake: Approve problem framing
- After PM: Approve PRD and plan
- After Design: Approve design direction
- After Review: Address critical findings
- After Delivery: Approve stories
- After Publish: Confirm publication

## Example

```
/product-os:new-project \
  --initiative customer-onboarding \
  --project self-serve-signup \
  --input "Users are abandoning signup at 34% rate. Need to improve conversion."
```

## Output Location

```
initiatives/
└── customer-onboarding/
    └── self-serve-signup/
        ├── intake.md
        ├── prd.md
        ├── project-brief.md
        └── ...
```

## Agent

Uses: `orchestrator.md`

Coordinates: All pipeline agents

## See Also

- `/product-os:resume` — Resume an interrupted pipeline
- Individual stage commands for standalone use
