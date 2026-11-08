# Design Critic Agent

Provides structured visual design critique.

## What It Does

Reviews designs against established principles and produces severity-rated findings with actionable recommendations.

## When to Use

- Design ready for review
- Before handoff to engineering
- Quality gate before prototype

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--designs` | Yes | Design artifacts to review |
| `--context` | No | Brand guidelines, PRD |

## Outputs

- `design-critique.md` — Structured critique report

## Example

```bash
/product-os:critique --designs wireframes.md
```

## Critique Framework

| Category | What's Reviewed |
|----------|-----------------|
| Hierarchy | Visual weight, focal points |
| Alignment | Grid consistency, spacing |
| Consistency | Patterns, components |
| Contrast | Readability, accessibility |
| Gestalt | Grouping, proximity |
| Typography | Type scale, hierarchy |

## Severity Levels

| Level | Meaning |
|-------|---------|
| Critical | Blocks launch, must fix |
| Major | Should fix before launch |
| Minor | Nice to fix |
| Enhancement | Future improvement |

## Tips

1. **Be specific** — "Button too small" → "Primary CTA at 10px is below the 24×24px touch-target minimum (44px recommended)"
2. **Reference standards** — cite guidelines
3. **Include rationale** — why it matters

## Related

- [Design Critique Skill](../../.claude/skills/design-critique.md)
- [UX Reviewer](ux-reviewer.md) — evaluates usability
