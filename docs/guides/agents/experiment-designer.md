# Experiment Designer Agent

Designs A/B tests with statistical rigor.

## What It Does

Creates experiment designs with hypotheses, sample size calculations, and success criteria.

## When to Use

- Before launching A/B tests
- Validating product changes
- Data-driven decision making

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--hypothesis` | Yes | What you're testing |
| `--metric` | Yes | Primary success metric |
| `--baseline` | No | Current conversion rate |

## Outputs

- `experiment-design.md` — Test design document

## Example

```bash
/product-os:experiment \
  --hypothesis "Simplified checkout increases conversion" \
  --metric "checkout_completion_rate" \
  --baseline 0.34
```

## Design Includes

- Hypothesis (null and alternative)
- Sample size calculation
- Test duration estimate
- Success criteria
- Guardrail metrics

## Tips

1. **One variable at a time** — isolate the change
2. **Sufficient sample** — don't peek early
3. **Define guardrails** — what not to hurt

## Related

- [PRD Author](prd-author.md) — defines metrics
- [Strategist](strategist.md) — prioritizes experiments
