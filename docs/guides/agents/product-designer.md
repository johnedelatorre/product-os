# Product Designer Agent

Creates design briefs and establishes design direction.

## What It Does

Translates PRD requirements into design briefs that guide visual design, interaction patterns, and brand alignment.

## When to Use

- PRD approved, ready for design
- Need design direction before wireframes
- Aligning design with brand guidelines

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |
| `--brand` | No | Brand guidelines reference |

## Outputs

- `design-brief.md` — Design direction document

## Example

```bash
/product-os:design-brief --from prd.md
```

## Brief Contents

- Design goals
- Target audience context
- Key screens/flows
- Visual direction
- Interaction patterns
- Constraints
- References

## Tips

1. **Reference the PRD** — design serves requirements
2. **Include constraints** — technical, brand, accessibility
3. **List open questions** — what needs exploration?

## Related

- [Flow Designer](flow-designer.md) — creates user flows
- [Wireframer](wireframer.md) — creates wireframes
