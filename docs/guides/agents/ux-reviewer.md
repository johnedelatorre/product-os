# UX Reviewer Agent

Evaluates designs against UX best practices and heuristics.

## What It Does

Reviews designs using Nielsen's 10 heuristics and Laws of UX, producing severity-rated findings with recommendations.

## When to Use

- Design ready for UX evaluation
- Before user testing
- Quality gate before handoff

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--designs` | Yes | Designs to review |
| `--flows` | No | User flows for context |

## Outputs

- `ux-review.md` — Heuristic evaluation report

## Example

```bash
/product-os:ux-review --designs wireframes.md --flows flows.md
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
2. **Be specific** — cite which heuristic and why
3. **Prioritize findings** — severity matters

## Related

- [UX Heuristics Skill](../../.claude/skills/ux-heuristics.md)
- [Design Critic](design-critic.md) — visual critique
