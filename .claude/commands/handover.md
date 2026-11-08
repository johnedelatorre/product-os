---
description: "Write the handover for next session: state, evidence, next action, blockers, owner decisions."
---
# /product-os:handover

> Write the handover for next session: state, evidence, next action, blockers, owner decisions.

**Output Style:** Follow `.claude/skills/clear-output.md`

## Usage

```
/product-os:handover
/product-os:handover --initiative <slug> --project <slug>
/product-os:handover --what-next "finish billing stage"
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--initiative` | No | Initiative slug (for project context) |
| `--project` | No | Project slug |
| `--what-next` | No | Hint about what next session will do |

## When to Use

- Session ending or context running out
- Work continues tomorrow
- Handing off to another agent
- Long-running work spanning sessions

## Process

### 1. Reconcile with Reality

Before writing, verify:
- `git status` — what's actually committed/uncommitted
- Running processes — still running? Exit codes?
- Project state files — progress.yaml, existing handover

### 2. Write Handover

| Section | Contents |
|---------|----------|
| Objective | What the work is for, who asked |
| Where it stands | Built, committed, pushed, deployed |
| Evidence | What was run and observed (verified or not) |
| Left to do | In order, each actionable |
| Open decisions | Options, recommendation, owner |
| Where things are | Branches, files, logs, processes |
| Next action | One concrete step (never "continue") |

### 3. Resume Instruction

End with exactly what to tell next session:
> Read HANDOVER.md and start from its next action.

## Output

Creates or updates `HANDOVER.md` at project or repo root.

For long-running work, also maintains `STATUS.md` with:
- RUNNING NOW
- QUEUED
- BLOCKED
- AWAITING OWNER
- DONE
- EVIDENCE

## Integration with Progress

| File | Purpose |
|------|---------|
| `progress.yaml` | Guided workflow tracking |
| `HANDOVER.md` | Session handover |
| `STATUS.md` | Long-running status board |

Handover references progress.yaml, doesn't duplicate.

## Quality Checklist

- [ ] Reconciled with disk first
- [ ] Uncommitted work labeled as uncommitted
- [ ] Evidence verified or marked unverified
- [ ] Next action is concrete
- [ ] No secrets in handover
- [ ] Owner decisions have recommendations

## Skill Reference

See `.claude/skills/session-handover.md` for full methodology.
