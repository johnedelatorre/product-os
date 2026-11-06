# UX Researcher Agent

Plans user research and synthesizes findings.

## What It Does

Creates research plans, interview guides, surveys, and synthesizes findings into actionable insights.

## When to Use

- Before design to validate assumptions
- Testing prototypes with users
- Analyzing quantitative + qualitative data

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--objective` | Yes | Research question |
| `--method` | No | `interviews`, `surveys`, `usability`, `diary` |

## Outputs

- `research-plan.md` — Study design
- `research-synthesis.md` — Findings and recommendations

## Example

```bash
/product-os:research \
  --objective "Why do users abandon checkout?" \
  --method interviews
```

## Tips

1. **Start with hypotheses** — what do you believe? what will you learn?
2. **5-8 interviews** — sufficient for pattern identification
3. **Capture verbatims** — exact quotes are powerful

## Related

- [PRD Author](prd-author.md) — incorporates research findings
- [Product Designer](product-designer.md) — designs based on research
