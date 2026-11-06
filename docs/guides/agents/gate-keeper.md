# Gate Keeper Agent

Enforces Definition of Ready and Definition of Done gates.

## What It Does

Validates stories against DoR (before sprint) and DoD (before completion) checklists, reporting compliance and gaps.

## When to Use

- Sprint planning (DoR check)
- Story completion (DoD check)
- Process improvement
- Quality assurance

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--stories` | Yes | Stories to check |
| `--gate` | Yes | `dor` or `dod` |
| `--strict` | No | Fail on any gap |

## Outputs

- `gate-report.md` — Validation report
- `gate-report.yaml` — Machine-readable

## Example

```bash
/product-os:gate --stories stories.md --gate dor
```

## Tips

1. **Be consistent** — Same criteria every sprint
2. **No exceptions** — Gate is gate
3. **Fix before sprint** — Not during
4. **Track trends** — Are we improving?

## Related

- [DoR/DoD Gates Skill](../../.claude/skills/dor-dod-gates.md)
- [Delivery Agent](delivery-agent.md)
