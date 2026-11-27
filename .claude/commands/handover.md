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
/product-os:handover --workstream design-office
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--initiative` | No | Initiative slug (for project context) |
| `--project` | No | Project slug |
| `--what-next` | No | Hint about what next session will do |
| `--workstream` | No | The workstream to hand over, by its name or id |

## When to Use

- Session ending or context running out
- Work continues tomorrow
- Handing off to another agent
- Long-running work spanning sessions

## With a Board

When the project has a Product OS board, the handover lives on the board, not in a file. Rules: `.claude/skills/multi-chat.md`.

1. Write `handover/<workstream id>`: the goal, the scope in the PM's words, ids and links, content rules, working rules, the steps left with done marks, the counts, the decisions already made, and how to report.
2. Write `workstreams/<id>`, so the board shows the row.
3. Give the PM the board link and the one prompt that starts the workstream, once, in one code block. The board shows the same prompt with a Copy button.
4. Make a file only when the next chat cannot read the board. The board offers it as one Markdown file.

The process below applies where there is no board.

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
| Open items | Each open item from `progress.yaml`: what's missing, owner, revisit by |
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

Handover references progress.yaml, doesn't duplicate. It does list the open items so the next session sees what is still missing.

## Quality Checklist

- [ ] Reconciled with disk first
- [ ] Uncommitted work labeled as uncommitted
- [ ] Evidence verified or marked unverified
- [ ] Next action is concrete
- [ ] No secrets in handover
- [ ] Owner decisions have recommendations

## Skill Reference

See `.claude/skills/session-handover.md` for full methodology.
