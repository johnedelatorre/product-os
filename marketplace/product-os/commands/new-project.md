---
description: "Run the full Product OS pipeline from intake to publication."
argument-hint: "--initiative <slug> --project <slug> --input \"<requirement>\""
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

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
4. **Prototype** → `prototype.html`, `prototype-react.tsx`, `prototype-handoff.html`
5. **Review** → `design-critique.md` paired with the UX writing pass (`ux-writing.md` and the final designs), `ux-review.md`, `accessibility-audit.md`
6. **Delivery** → the outputs question, then `epics.md`, `stories.md` and the proposed ticket tree
7. **Publish** → Confluence pages, Jira issues, and the final output list

Before stage 1, the pipeline asks the seven start questions in `.claude/skills/engineering-handoff.md`, one at a time: what you are building and who will use it, who will read what it writes, your role, the design system to follow and the existing designs to match (each in Figma, in Claude Design, or both), where the initiative came from, and everything you have (the request, proposals, emails, existing PRDs, the tech stack, backend schemas, existing designs) in one step. It then plays back what it understood and what it will make, and waits for your yes. In stage 2, `project-plan.md`, `raci.md` and `gantt.md` are written only if they are in that list; the same goes for `design-brief.md`, `wireframes.md` and the reviews in stages 3 and 5. After the handoff it asks what the team said, and saves it for your next project.

## Human Checkpoints

The pipeline pauses at each checkpoint for approval:
- After Intake: Approve problem framing
- After PM: Approve PRD and plan
- After Design: Approve design direction
- After Review: Address critical findings
- After Delivery: Accept the ticket tree, then approve stories
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

- Resume an interrupted pipeline: re-run `/product-os:new-project` with the same `--initiative`/`--project`; the orchestrator reads `pipeline-state.json` and continues from the first incomplete stage
- `/product-os:guide` — Guided, one-phase-at-a-time mode (resumes from `progress.yaml`)
- Individual stage commands for standalone use
