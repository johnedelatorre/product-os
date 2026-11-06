# Prototyper Agent

Creates clickable HTML/React prototypes.

## What It Does

Generates single-file prototypes that demonstrate interactions and flows for user testing.

## When to Use

- Wireframes approved, need interaction testing
- User research with clickable prototype
- Stakeholder demo

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to wireframes or flows |
| `--type` | No | `html` or `react` |

## Outputs

- `prototype.html` — Single-file HTML prototype
- or `prototype.tsx` — React component

## Example

```bash
/product-os:prototype --from wireframes.md --type html
```

## Features

- Click navigation between screens
- Basic interactions (buttons, forms)
- State changes (loading, error, success)
- Mobile-responsive layout
- No external dependencies

## Tips

1. **Single file** — Claude artifacts require self-contained code
2. **Inline styles** — no CSS imports
3. **Mock data** — realistic placeholder content
4. **Touch-friendly** — test on mobile devices

## Related

- [Prototype Skill](../../.claude/skills/prototype-generation.md)
- [UX Reviewer](ux-reviewer.md) — review prototype
