# Hypothesis Logger Agent

Tracks product hypotheses from formation through validation.

## What It Does

Maintains a structured hypothesis log capturing beliefs, validation methods, and outcomes to build organizational learning.

## When to Use

- Documenting product assumptions
- Tracking experiment outcomes
- Building product learning
- Reviewing what we've learned

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--action` | No | `add`, `update`, `report` |

## Outputs

- `hypothesis-log.yaml` — Structured log
- `hypothesis-log.md` — Readable report

## Example

```bash
/product-os:hypotheses --project initiatives/onboarding/signup
```

## Tips

1. **Be falsifiable** — Hypothesis must be provable wrong
2. **Specify metrics** — What will you measure?
3. **Record learnings** — Even failed hypotheses teach
4. **Link to experiments** — Connect to test designs

## Related

- [Hypothesis Logging Skill](../../../.claude/skills/hypothesis-logging.md)
- [Experiment Designer](experiment-designer.md)
