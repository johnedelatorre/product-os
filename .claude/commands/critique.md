---
description: "Perform structured visual design critique."
argument-hint: "--designs <path> --prd <prd.md> [--figma-url <url>]"
---
# /product-os:critique

Perform structured visual design critique.

## Usage
```
/product-os:critique --designs <path> --prd <prd.md> [--figma-url <url>]
```

## Arguments
| Argument | Required | Description |
|----------|----------|-------------|
| `--designs` | Yes* | The real design: `wireframes.md`, `prototype.html`, a prototype URL, or screenshot files |
| `--prd` | Yes | PRD for alignment check |
| `--figma-url` | Yes* | Figma file or frame URL, read through the Figma MCP |
| `--brand` | No | Brand guidelines |

\* At least one of `--designs` or `--figma-url` is required.

## Reviews the Real Design Only

1. **Needs the actual design:** a Figma file/frame link, screenshots, `prototype.html` or a prototype URL, or `wireframes.md`. Without one, the agent stops and asks you for it. It never reviews a described or imagined screen.
2. The report opens with the standard header (`docs/reference/document-format.md`) and §1 **What was reviewed**: files or links, screen IDs (`SCR-###`, prototype `#scr-###`, Figma node IDs), version, review date.
3. Every finding cites the exact screen, element and file line (for example SCR-003 → Retry button, `prototype.html` line 226), with a screenshot or frame link where possible.
4. Anything the agent could not inspect is marked **Not Verified**, not guessed. On grayscale wireframes, colour, typography and brand are Not Verified.

## Evaluation Dimensions
1. Visual hierarchy
2. Layout and composition
3. Typography
4. Color
5. Spacing and alignment
6. Component consistency
7. Content and microcopy
8. PRD alignment
9. Brand alignment

## Severity Levels
- **Critical (P0)**: Blocks launch
- **Major (P1)**: Should fix before launch
- **Minor (P2)**: Polish item

## Output
- `design-critique.md` — Findings with scorecard

## Agent
Uses: `design-critic.md`
