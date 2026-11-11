# Product Designer Agent

Creates the design brief and sets design direction.

## What It Does

Translates PRD requirements into a design brief that guides flows, wireframes, the prototype, visual design and brand alignment.

## When to Use

- PRD approved, ready for design
- Need design direction before wireframes
- Aligning design with brand guidelines

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to `prd.md` |

Design system, brand guidelines and competitive research are used when you provide them.

## Outputs and How to View Them

| File | How to view | Confluence |
|------|-------------|------------|
| `initiatives/<initiative>/<project>/design-brief.md` | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Design Brief** page under **2. Design** via `/product-os:publish` |

The brief opens with the standard header (`docs/reference/document-format.md`). Template: `templates/design/design-brief.md`.

## Example

```bash
/product-os:design-brief --from initiatives/onboarding/signup/prd.md
```

## Brief Contents

- Design goals
- Target audience context
- Key screens/flows
- Visual direction
- Interaction patterns
- Constraints
- References

## What Comes Next

1. `/product-os:flows` — user flow diagrams (`flows.md`)
2. `/product-os:wireframes` — `wireframes.md`
3. `/product-os:prototype` — clickable `prototype.html`

## Tips

1. **Reference the PRD** — design serves requirements
2. **Include constraints** — technical, brand, accessibility
3. **List open questions** — what needs exploration?

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [Flow Designer](flow-designer.md) — creates user flows
- [Wireframer](wireframer.md) — creates wireframes
