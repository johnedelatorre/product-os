# Post-Launch Reviewer Agent

Conducts reviews comparing results to PRD goals.

## What It Does

Evaluates shipped features against success criteria, documents learnings, and creates follow-up intake items to close the learning loop.

## When to Use

- 14+ days after launch
- Quarterly reviews
- Before starting next iteration
- Building organizational learning

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project path |
| `--prd` | Yes | Original PRD |
| `--days` | No | Days since launch |

## Outputs

- `post-launch-review.md` — Full review
- `followup-intake.md` — New intake items

## Example

```bash
/product-os:review-launch --project initiatives/onboarding/signup --prd prd.md
```

## Tips

1. **Wait for data** — 14 days minimum for significance
2. **Compare to targets** — What did PRD promise?
3. **Document surprises** — What was unexpected?
4. **Create follow-ups** — Feed the next cycle

## Related

- [Post-Launch Review Skill](../../../.claude/skills/post-launch-review.md)
- [Hypothesis Logger](hypothesis-logger.md)
