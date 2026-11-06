# Wireframer Agent

Creates low-fidelity wireframes for rapid iteration.

## What It Does

Produces ASCII or HTML wireframes focused on layout and structure, not visual polish.

## When to Use

- Flows approved, ready for screen design
- Need quick layout exploration
- Before high-fidelity design

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--screens` | Yes | Screen names from flows |
| `--format` | No | `ascii` or `html` |

## Outputs

- `wireframes.md` — ASCII wireframes
- `wireframes.html` — HTML wireframes (if requested)

## Example

```bash
/product-os:wireframes \
  --screens "login, signup, dashboard" \
  --format ascii
```

## Tips

1. **Keep it ugly** — lo-fi prevents bikeshedding
2. **Focus on layout** — not colors or fonts
3. **Label everything** — component names for discussion
4. **Include states** — empty, loading, error

## Related

- [Wireframing Skill](../../.claude/skills/wireframing.md)
- [Prototyper](prototyper.md) — clickable from wireframes
