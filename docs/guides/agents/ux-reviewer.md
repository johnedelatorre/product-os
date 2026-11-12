# UX Reviewer Agent

Evaluates the actual designs against UX best practices and heuristics.

## What It Does

Reviews real designs using Nielsen's 10 heuristics, Laws of UX and pattern best practices, producing severity-rated findings with recommendations. Each finding cites the exact screen, frame and element it is about.

## When to Use

- Design ready for UX evaluation
- Before user testing
- Quality gate before handoff

## What It Needs: the Real Design

At least one of `wireframes.md`, `prototype.html` or a prototype URL, a Figma link (read through the Figma MCP), or screenshots. `flows.md` and the PRD give context; they are not the design. No design available: the agent stops and asks you for one.

Interaction heuristics (system feedback, loading, undo) need the clickable prototype. On static wireframes they are marked Not Verified.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--designs` | Yes | The real design: `wireframes.md`, `prototype.html`, a prototype URL, a Figma link or screenshots |
| `--flows` | Yes | `flows.md` for context |

## Outputs

- `ux-review.md` — standard header, then a **What was reviewed** table (sources, screen/frame IDs, version, review date) and the heuristic evaluation. Template: `templates/design/ux-review.md`.

## Example

```bash
/product-os:ux-review --designs initiatives/onboarding/signup/prototype.html --flows initiatives/onboarding/signup/flows.md
```

## Heuristics Evaluated

1. Visibility of system status
2. Match between system and real world
3. User control and freedom
4. Consistency and standards
5. Error prevention
6. Recognition rather than recall
7. Flexibility and efficiency of use
8. Aesthetic and minimalist design
9. Help users recognize, diagnose, recover from errors
10. Help and documentation

## Laws of UX Applied

- Fitts's Law (target size)
- Hick's Law (choice complexity)
- Miller's Law (cognitive load)
- Jakob's Law (familiar patterns)

## Tips

1. **Review in context** — consider the user journey
2. **Be specific** — cite which heuristic, which screen, and why
3. **Prioritize findings** — severity matters

## Related

- [Design Workflow](../design-workflow.md) — from PRD to reviewed designs
- [UX Heuristics Skill](../../../.claude/skills/ux-heuristics.md)
- [Design Critic](design-critic.md) — visual critique
