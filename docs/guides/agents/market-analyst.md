# Market Analyst Agent

Creates market analysis briefs with sizing, trends, and positioning.

## What It Does

Analyzes markets with TAM/SAM/SOM sizing, trend identification, segment analysis, and strategic positioning recommendations.

## When to Use

- Strategic planning
- New market entry
- Positioning decisions
- Investor/stakeholder materials

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--market` | Yes | Market to analyze |
| `--depth` | No | `brief`, `standard`, `deep` |

## Outputs

- `market-analysis.md` — Full analysis brief
- `market-data.yaml` — Structured data

## Example

```bash
/product-os:market --market "B2B SaaS Customer Onboarding" --depth standard
```

## Tips

1. **Define boundaries** — What's in/out of market
2. **Cite sources** — TAM claims need methodology
3. **Segment clearly** — Who are the buyers?
4. **Actionable recommendations** — What should we do?

## Related

- [Competitive Analyst](competitive-analyst.md) — Specific competitors
- [Strategist](strategist.md) — Prioritization
