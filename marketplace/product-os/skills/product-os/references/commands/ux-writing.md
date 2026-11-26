---
description: "Run the UX writing pass on the real designs and write the UX writing guide."
argument-hint: "--designs <path> --prd <prd.md> [--prior <paths>] [--critique <design-critique.md>]"
---
# /product-os:ux-writing

Run the UX writing pass on the real designs and write the UX writing guide: the voice, the words, and the final copy for every screen.

## Usage
```
/product-os:ux-writing --designs <path> --prd <prd.md> [--prior <paths>] [--critique <design-critique.md>]
```

## Arguments
| Argument | Required | Description |
|----------|----------|-------------|
| `--designs` | Yes | The real design: `wireframes.md`, `prototype.html`, a prototype URL, a Figma link or screenshot files |
| `--prd` | Yes | `prd.md`, for the facts the copy relies on |
| `--prior` | No | What shows how the product already writes: prior designs, screenshots, a voice or style guide, earlier documents. Comma-separated |
| `--critique` | No | `design-critique.md`, so its findings on wording are covered |

## It Asks First

One question at a time (`.claude/skills/guided-questions.md`):

1. Do you have anything that shows how the product writes today? Prior designs, screenshots, a style guide.
2. Which words does the product already use for its main things?
3. Who reads this copy?
4. Which languages?
5. How formal?

With no prior material, the pass works from the designs alone and confirms the voice with you before writing.

## Paired With the Design Critique

`/product-os:critique` and `/product-os:ux-writing` run as a pair. The critique runs first, you decide its findings, then the pass runs on the design with those fixes in it. Together they give you two outputs: the final designs and the UX writing guide.

## Works on the Real Design Only

1. **Needs the actual design.** Without one, the agent stops and asks you for it.
2. Every line of copy cites its screen (`SCR-###`) and element.
3. No product fact is invented. A gap is a named TBD.
4. A screen is marked applied only after its copy is in the design.

## Output
- `ux-writing.md` — The UX writing guide: voice and tone, words we use, patterns, and the final copy for every screen
- `wireframes.md`, `prototype.html`, `prototype-handoff.html` — updated with the approved copy
- For Figma: a list of copy changes by screen and element

## What the Team Gets
- The epic's Handoff table links to the UX writing guide
- Every ticket with a screen says: use the copy in the design as is

## Agent
Uses: `ux-writer.md`

## Skill
Follows: `.claude/skills/ux-writing.md`
