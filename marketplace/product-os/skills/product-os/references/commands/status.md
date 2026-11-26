---
description: "Show current progress through guided mode."
---
# /product-os:status

Show current progress through guided mode.

## Usage

```
/product-os:status
/product-os:status --initiative <slug> --project <slug>
/product-os:status --verbose
/product-os:status --compact
/product-os:status --connectors
/product-os:status --settings
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | No | Initiative slug (defaults to current) |
| `--project` | No | Project slug (defaults to current) |
| `--verbose` | No | Show full document details |
| `--compact` | No | The short board for a phone: one task per line, under 40 characters |
| `--connectors` | No | Each connector, its status, and what happens without it |
| `--settings` | No | Readers, role, design system, Confluence space, Jira project, ticket size, accessibility level |

## Output

### Standard

The status board (`.claude/skills/guided-workflow.md` → "The Status Board"): where you are, the task counts, then every task with its status and numbers.

```
Self-serve signup · Phase 4 of 9 · Define · PRD in progress
Tasks: 3 done · 1 in progress · 6 not started · Open items: 2

Open items:
  OI-1 prioritize · Sales sign-off on Q1 placement · owner TBD · revisit by Define (due now)
  OI-2 define · Activation-rate baseline · owner Data team · revisit by Design

✓ Start          7 of 7 steps
✓ 1 Intake       1 of 1 document
– 2 Discovery    skipped: time-sensitive
✓ 3 Prioritize   1 of 1 document · 1 open item
● 4 Define       1 of 5 documents · PRD in progress
○ 5 Design       0 of 4 documents
○ 6 Review       0 of 2 documents
○ 7 Deliver      0 of 1 document
○ 8 Launch       0 of 2 documents
○ 9 Measure      0 of 1 document

Documents: 3 complete | 1 in progress | 12 remaining
Gates passed: intake_approved, priority_confirmed

Next: Complete PRD success metrics section.
```

### Verbose

Adds per-phase document breakdown:

```
Phase: Define
  ▶ prd.md — in progress
    Sections complete: 15/19
    Missing: Success Metrics, Experiments, Milestones, Appendices
  · project-brief.md — not started
  · metrics-framework.md — not started
  · project-plan.md — not started
```

### Compact, connectors and settings

The short views for a narrow screen, and the setup. Formats and rules: `.claude/skills/guided-workflow.md` → "On a Phone" and "Connectors and Settings".

```
Self-serve signup
Phase 4 of 9 · Define
3 done · 1 in progress · 6 to go

✓ Start · 7 of 7
✓ 1 Intake · 1 of 1
– 2 Discovery · skipped
✓ 3 Prioritize · 1 of 1
● 4 Define · 1 of 5
○ 5 Design · 0 of 4
```

```
✓ Confluence · connected
✓ Jira · connected
○ Figma · not connected
– Claude Design · not used
```

## What It Does

1. Reads `initiatives/<initiative>/<project>/progress.yaml`
2. Lists open items first: id, phase, what's missing, owner, revisit by, and which are due now
3. Calculates phase and document completion
4. Lists gates passed
5. Recommends next action

## Agent

Uses `.claude/agents/guide.md`
