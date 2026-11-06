# Orchestrator Agent

Coordinates the full Product OS pipeline with human checkpoints.

## What It Does

The Orchestrator runs the complete pipeline from intake to publication, delegating work to specialist agents and managing approval gates at each stage.

## When to Use

- Starting a new project from scratch
- Running the full end-to-end pipeline
- Need human checkpoints at each stage

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--initiative` | Yes | Initiative slug (kebab-case) |
| `--project` | Yes | Project slug (kebab-case) |
| `--input` | Yes | Raw requirement text or file |

## Outputs

All artifacts in `initiatives/<initiative>/<project>/`:
- `intake.md`, `prd.md`, `project-brief.md`
- `raci.md`, `gantt.md`, `project-plan.md`
- `design-brief.md`, `flows.yaml`, `wireframes.md`
- `prototype.html`, `design-critique.md`
- `epics.md`, `stories.md`
- Confluence pages, Jira issues

## Example

```bash
/product-os:new-project \
  --initiative customer-onboarding \
  --project self-serve-signup \
  --input "Users abandoning signup at 34% rate"
```

## Checkpoints

At each stage, the orchestrator:
1. Presents summary of outputs
2. Reports quality checklist status
3. Waits for approval (`approved`, `yes`, `continue`)
4. Accepts feedback for revisions

## Tips

1. **Don't skip checkpoints** — they catch issues early
2. **Use `--skip-stages` sparingly** — breaks downstream
3. **Save state** — if interrupted, use `/product-os:resume`

## Related

- [Pipeline Overview](../pipeline-overview.md)
- [AGENTS.md](/AGENTS.md) — Full orchestration spec
