---
description: "Create design brief from PRD."
argument-hint: "--from <prd.md>"
---

> This file names Product OS files by their path in the Product OS repo (`.claude/...`, `templates/...`, `docs/reference/...`). In this plugin those files are in the `product-os` skill: load that skill first, and use its "Where the files are" table to find each one.

# /jdlt-product-os:design-brief

Create design brief from PRD.

## Usage
```
/jdlt-product-os:design-brief --from <prd.md>
```

## Output
- `design-brief.md` — Design goals, principles, constraints

## Where It Goes and How to View It

| File | How to view | Confluence |
|------|-------------|------------|
| `initiatives/<initiative>/<project>/design-brief.md` | Any Markdown viewer (GitHub, VS Code, claude.ai) | **Design Brief** page under **2. Design**, via `/jdlt-product-os:publish` |

Opens with the standard header (`docs/reference/document-format.md`); template: `templates/design/design-brief.md`.

## What Comes Next

1. `/jdlt-product-os:flows --from prd.md`: user flow diagrams (`flows.md`)
2. `/jdlt-product-os:wireframes --from flows.yaml --brief design-brief.md`: `wireframes.md`
3. `/jdlt-product-os:prototype --from wireframes.md --flows flows.yaml`: clickable `prototype.html`

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
