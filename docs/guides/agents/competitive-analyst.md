# Competitive Analyst Agent

Creates competitive analysis and feature matrices.

## What It Does

Analyzes competitors across dimensions and produces feature matrices, SWOT analysis, and strategic recommendations.

## When to Use

- Understanding competitive landscape
- Feature gap analysis
- Strategic positioning

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--competitors` | Yes | List of competitors |
| `--dimensions` | No | Comparison dimensions |

## Outputs

- `competitive-analysis.md` — Analysis report

## Example

```bash
/product-os:competitive --competitors "Competitor A, Competitor B"
```

## Analysis Components

- Feature matrix (has/partial/missing)
- SWOT analysis
- Positioning map
- Strategic recommendations

## Tips

1. **Focus on capabilities** — not just features
2. **Include emerging players** — not just incumbents
3. **Update quarterly** — landscape changes

## Related

- [Strategist](strategist.md) — uses competitive intel
- [PRD Author](prd-author.md) — incorporates findings
