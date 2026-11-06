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

Progress:
  ✓ Intake — complete
  ○ Discovery — skipped (time-sensitive)
  ✓ Prioritize — complete
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
    Sections complete: 14/18
    Missing: Success Metrics, Experiments, Milestones, Appendices
  · project-brief.md — not started
  · metrics-framework.md — not started
  · project-plan.md — not started
```

## What It Does

1. Reads `initiatives/<slug>/progress.yaml`
2. Calculates phase and document completion
3. Lists gates passed
4. Recommends next action

## Agent

Uses `.claude/agents/guide.md`
