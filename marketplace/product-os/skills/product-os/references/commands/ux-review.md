---
description: "Evaluate designs against UX heuristics and patterns."
argument-hint: "--designs <path> --flows <flows.md>"
---
# /product-os:ux-review

Evaluate designs against UX heuristics and patterns.

## Usage
```
/product-os:ux-review --designs <path> --flows <flows.md>
```

## Arguments
| Argument | Required | Description |
|----------|----------|-------------|
| `--designs` | Yes | The real design: `wireframes.md`, `prototype.html`, a prototype URL, a Figma link or screenshot files |
| `--flows` | Yes | `flows.md` for context (not a substitute for the design) |

## Reviews the Real Design Only

1. **Needs the actual design:** `wireframes.md`, `prototype.html` or a prototype URL, a Figma link, or screenshots. Without one, the agent stops and asks you for it. It never reviews a described or imagined screen.
2. The report opens with the standard header (`docs/reference/document-format.md`) and §1 **What was reviewed**: files or links, screen IDs (`SCR-###`, prototype `#scr-###`, Figma node IDs), version, review date.
3. Every finding cites the exact screen, element and file line (for example SCR-003 → Retry button, `prototype.html` line 226), with a screenshot or frame link where possible.
4. Anything the agent could not inspect is marked **Not Verified**, not guessed. Interaction heuristics (feedback, loading, undo) need the clickable prototype; on static wireframes they are Not Verified.

## Evaluates Against
- Nielsen's 10 Usability Heuristics
- Laws of UX (Fitts, Hick, Jakob, Miller, etc.)
- Pattern best practices (forms, onboarding, empty states, errors, navigation, tables, search, dashboards)
- Mobile/responsive guidance
- Trust and conversion patterns

## Output
- `ux-review.md` — Findings with severity and recommendations

## Agent
Uses: `ux-reviewer.md`
