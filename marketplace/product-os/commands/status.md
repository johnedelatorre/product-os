---
description: "Show current progress through guided mode."
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

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
/product-os:status --workstream "Design office"
```

In a chat, "status of the design office" is the same request.

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | No | Initiative slug (defaults to current) |
| `--project` | No | Project slug (defaults to current) |
| `--verbose` | No | Show full document details |
| `--compact` | No | The short board for a phone: one task per line, under 40 characters |
| `--connectors` | No | Each connector, its status, and what happens without it |
| `--settings` | No | Readers, role, design system, Confluence space, Jira project, ticket size, accessibility level |
| `--workstream` | No | One workstream, by the PM's name for it: its board line, checked against the real output |

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

### One workstream

For a project that runs in more than one chat. The agent reads that workstream on the board and, where it has the tool, checks the real output itself: the screens per theme in the design file, the pages in Confluence, the tickets in Jira. The answer has this shape and is no longer. Rules: `.claude/skills/multi-chat.md` → "Status Across Chats".

```
The design office finished round 2 of 8: 96 of 402 screens exist in both themes.

Screens: 96 of 402 · Dark 48 · Light 48
Board line: changed 12 minutes ago

What I checked
1. The board document for the design office
2. The design file: frames per page, counted by theme

Stage: round 3 of 8, tablet sizes. Next check: at the end of that round, about 40 minutes.
```

The agent cannot watch another chat live. Where a scheduling tool exists it offers one check-in at the expected end of the round; where none exists it says so.

## What It Does

1. Reads `initiatives/<initiative>/<project>/progress.yaml`
2. Lists open items first: id, phase, what's missing, owner, revisit by, and which are due now
3. Calculates phase and document completion
4. Lists gates passed
5. Recommends next action
6. Lists each workstream with its step, status and last update, when the project has more than one

## Agent

Uses `.claude/agents/guide.md`
