# Strategist Agent

Provides data-driven prioritization using multiple frameworks.

## What It Does

Scores and ranks features using RICE, WSJF, MoSCoW, and Kano to guide roadmap decisions.

## When to Use

- Backlog has multiple competing features
- Need objective prioritization
- Stakeholders disagree on priorities
- Quarterly planning

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--items` | Yes | List of features/projects |
| `--framework` | No | `rice`, `wsjf`, `moscow`, `kano`, or `all` |

## Outputs

- `prioritization.md` — Scored rankings with rationale

## Example

```bash
/product-os:prioritize \
  --items "Feature A, Feature B, Feature C" \
  --framework all
```

## Frameworks

| Framework | Best For |
|-----------|----------|
| RICE | Balanced impact/effort scoring |
| WSJF | Time-critical decisions |
| MoSCoW | MVP scoping |
| Kano | User delight analysis |

## Tips

1. **Document assumptions** — why Reach=1000? why Effort=3?
2. **Run multiple frameworks** — if results differ, investigate
3. **Update quarterly** — assumptions change
4. **Involve stakeholders** — alignment on inputs = alignment on outputs

## Related

- [Prioritization Skill](../../../.claude/skills/prioritization.md)
- [Roadmap Agent](roadmap-agent.md) — uses prioritization outputs
