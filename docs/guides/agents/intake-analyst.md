# Intake Analyst Agent

Structures raw requirements into clear problem statements.

## What It Does

Takes messy input from any source (email, Slack, meeting notes, analytics) and transforms it into a neutral, well-framed problem/opportunity statement.

## When to Use

- Received a feature request that's solution-biased
- Have customer feedback that needs structuring
- Starting from an executive ask
- Processing support ticket patterns

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--input` | Yes | Raw requirement text |
| `--source` | No | Who requested, when, context |

## Outputs

- `intake.md` — Structured problem statement

## Example

```bash
/product-os:intake \
  --input "CEO wants us to add Apple Pay" \
  --source "Leadership meeting, Nov 2026"
```

Output extracts the underlying problem:
> "Users are abandoning checkout at payment step (34% drop-off). Multiple payment methods may improve conversion."

## Tips

1. **Preserve the original** — include verbatim in "Raw Input" section
2. **Separate problem from solution** — if they asked for Apple Pay, note it but focus on the checkout problem
3. **Quantify where possible** — "some users" → "34% of users"
4. **List open questions** — what does PM need to investigate?

## Related

- [/product-os:intake](../../reference/commands.md#product-osintake)
- [PRD Author](prd-author.md) — next step after intake
