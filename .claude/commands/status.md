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
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | No | Initiative slug (defaults to current) |
| `--project` | No | Project slug (defaults to current) |
| `--verbose` | No | Show full document details |

## Output

### Standard

```
Initiative: customer-onboarding
Project: self-serve-signup
Phase: Define (4 of 9)

Open items: 2
  OI-1 prioritize · Sales sign-off on Q1 placement · owner TBD · revisit by Define (due now)
  OI-2 define · Activation-rate baseline · owner Data team · revisit by Design

Progress:
  ✓ Intake — complete
  ○ Discovery — skipped (time-sensitive)
  ◐ Prioritize — complete with open items (1)
  ▶ Define — in progress (PRD: in progress)
  · Design — not started
  · Review — not started
  · Deliver — not started
  · Launch — not started
  · Measure — not started

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

## What It Does

1. Reads `initiatives/<initiative>/<project>/progress.yaml`
2. Lists open items first: id, phase, what's missing, owner, revisit by, and which are due now
3. Calculates phase and document completion
4. Lists gates passed
5. Recommends next action

## Agent

Uses `.claude/agents/guide.md`
