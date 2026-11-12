# Project Brief Agent

Creates one-page executive summaries for stakeholder alignment.

## What It Does

Distills a full PRD into a one-page brief that busy stakeholders can quickly understand and approve.

## When to Use

- Need executive sign-off
- Kicking off a project with stakeholders
- Sharing project scope with cross-functional teams

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |

## Outputs

- `project-brief.md` — One-page summary (~500-600 words)

## Example

```bash
/product-os:brief --from prd.md
```

## Brief Sections

- Problem (2-3 sentences)
- Why Now (2-3 sentences)
- Goals & Metrics (2-3 rows)
- Scope (in/out)
- Users
- Stakeholders
- Timeline
- Risks (top 3)
- Links

## Constraint

**Must fit on one printed page.** If it doesn't fit, you're including too much detail.

## Tips

1. **Lead with impact** — problem and why now are critical
2. **Test with non-experts** — can they understand in 60 seconds?
3. **Keep it updated** — brief should reflect current scope

## Related

- [Project Brief Skill](../../../.claude/skills/project-brief.md)
- [PRD Author](prd-author.md) — full PRD that brief summarizes
