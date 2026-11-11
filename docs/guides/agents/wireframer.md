# Wireframer Agent

Creates low-fidelity wireframes for every screen in the user flows.

## What It Does

Produces annotated lo-fi wireframes (ASCII by default, HTML when higher fidelity is needed) focused on layout, hierarchy and content, not visual polish.

## When to Use

- Flows approved, ready for screen design
- Need quick layout exploration
- Before high-fidelity design

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | `flows.yaml` (screens come from the flows) |
| `--brief` | Yes | `design-brief.md` |

Ask for HTML wireframes in your request when you need them; ASCII is the default.

## Outputs and How to View Them

All files land in `initiatives/<initiative>/<project>/`.

| File | What it is | How to view | Confluence |
|------|-----------|-------------|------------|
| `wireframes.md` | Screen inventory, then one ASCII wireframe per screen (`SCR-###`) with interaction, responsive, accessibility and state annotations | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Wireframes** page under **2. Design** via `/product-os:publish` |
| `wireframes/<screen>.html` (optional) | HTML wireframe per screen | Open in a browser | Linked from the Wireframes page |

`wireframes.md` opens with the standard header (`docs/reference/document-format.md`). Wireframes are static; the clickable version is the [prototype](prototyper.md).

## Example

```bash
/product-os:wireframes --from initiatives/onboarding/signup/flows.yaml --brief initiatives/onboarding/signup/design-brief.md
```

## Tips

1. **Keep it ugly** — lo-fi prevents bikeshedding
2. **Focus on layout** — not colors or fonts
3. **Label everything** — component names for discussion
4. **Include states** — empty, loading, error

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Wireframing Skill](../../../.claude/skills/wireframing.md)
- [Prototyper](prototyper.md) — clickable from wireframes
