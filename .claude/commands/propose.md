---
description: "Research an idea and propose what to build, interface first. For new ideas \u2014 not agreed changes or bugs."
argument-hint: "--idea \"I have an idea for...\" --initiative <slug> --project <slug>"
---
# /product-os:propose

> Research an idea and propose what to build, interface first. For new ideas — not agreed changes or bugs.

**Output Style:** Follow `.claude/skills/clear-output.md`

## Usage

```
/product-os:propose --idea "I have an idea for..." --initiative <slug> --project <slug>
/product-os:propose --next --initiative <slug> --project <slug>  # Product in use, new evidence
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--idea` | Yes* | The idea or question to research |
| `--next` | Yes* | Flag to iterate on existing product with new evidence |
| `--initiative` | Yes | Initiative slug |
| `--project` | Yes | Project slug |

*One of `--idea` or `--next` required

## When to Use

- **New ideas** — "I have an idea for..."
- **Worth building?** — "Should we build X?"
- **Next iteration** — Evidence-based product evolution

## When NOT to Use

- **Agreed changes** → Go to `/product-os:prd` or `/product-os:plan`
- **Bugs** → Go straight to fix
- **Small UI changes** → No proposal overhead
- **Existing WIP** → Continue with current artifacts

## Process

1. Read existing materials and product context
2. Research alternatives (including substitutes, do nothing)
3. Check feasibility before drawing screens
4. Mark every claim by type (fact, decision, inference, assumption)
5. Create jobs map before screens
6. Propose direction with recommendation
7. Define experiment to test weakest assumption
8. Ask only questions evidence can't decide

## Output

Creates `initiatives/<initiative>/<project>/proposal.md`

## Related Commands

- `/product-os:prd` — After proposal accepted, create full PRD
- `/product-os:intake` — For raw requirements (not ideas)
- `/product-os:market` — Market analysis, including beachhead segment selection (see `.claude/skills/beachhead-segment.md`)

## Skill Reference

See `.claude/skills/proposal.md` for full methodology.
