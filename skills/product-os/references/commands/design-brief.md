---
description: "Create design brief from PRD."
argument-hint: "--from <prd.md>"
---
# /product-os:design-brief

Create design brief from PRD.

## Usage
```
/product-os:design-brief --from <prd.md>
```

## Output
- `design-brief.md` — Design goals, principles, constraints

## Where It Goes and How to View It

| File | How to view | Confluence |
|------|-------------|------------|
| `initiatives/<initiative>/<project>/design-brief.md` | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Design Brief** page under **2. Design**, via `/product-os:publish` |

Opens with the standard header (`docs/reference/document-format.md`); template: `templates/design/design-brief.md`.

## What Comes Next

1. `/product-os:flows --from prd.md`: user flow diagrams (`flows.md`)
2. `/product-os:wireframes --from flows.yaml --brief design-brief.md`: `wireframes.md`
3. `/product-os:prototype --from wireframes.md --flows flows.yaml`: clickable `prototype.html`

Full walkthrough: `docs/guides/design-workflow.md`.

## Sections
- Design context and key requirements
- Design goals (primary, secondary, non-goals)
- Design principles with trade-off guidance
- Constraints (technical, business, accessibility, platform)
- Design system patterns to use/avoid
- Success criteria

## Agent
Uses: `product-designer.md`
