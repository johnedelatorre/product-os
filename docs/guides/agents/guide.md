# Guide Agent

Walks you through the product lifecycle one phase at a time, tracking progress in `progress.yaml`.

## What It Does

Coaches a PM through all 9 phases (Intake → Discovery → Prioritize → Define → Design → Review → Deliver → Launch → Measure). For each phase it explains the purpose, asks focused questions, delegates document creation to specialist agents, checks exit criteria, and records state. It does not write documents itself or make product decisions.

## When to Use

- You're new to Product OS and want step-by-step guidance
- An initiative spans several phases and sessions
- You already have some artifacts (e.g. a PRD) and want to continue from there

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--initiative` | For new | Initiative slug |
| `--project` | For new | Project slug |
| `<phase>` | No | Jump to a phase (`intake`, `discovery`, `prioritize`, `define`, `design`, `review`, `deliver`, `launch`, `measure`) |
| `--skip` | No | Skip the current (or named) document or optional phase, recording the risks |

## Outputs

- `initiatives/<initiative>/<project>/progress.yaml` — Guided-mode state (schema v1.1)
- Documents for each phase, created by the specialist agents it delegates to

## Example

```bash
# Start or resume
/product-os:guide --initiative customer-onboarding --project signup

# Check progress / do the next step
/product-os:status
/product-os:next

# Jump to a phase, or skip a document
/product-os:guide design
/product-os:guide --skip brief
```

## Existing Work

On start, the guide scans the project directory for known artifacts and marks them `complete` or `in_progress` in `progress.yaml` instead of recreating them. Older `progress.yaml` files without `schema_version` are migrated to v1.1 non-destructively.

## Tips

1. **Confirm detected files** — review what the guide marked complete before moving on
2. **Skip with reasons** — skipped phases carry recorded risks downstream
3. **Hand over between sessions** — run `/product-os:handover` before stopping

## Related

- [Guided Workflow Playbook](../guided-workflow.md) — Full phase-by-phase guide
- [Orchestrator](orchestrator.md) — Automated full-pipeline alternative
- `.claude/skills/guided-workflow.md` — `progress.yaml` schema
