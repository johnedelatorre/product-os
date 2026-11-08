---
description: "Generate a comprehensive Product Requirements Document."
argument-hint: "--from <intake.md> [--context <files>]"
---
# /product-os:prd

Generate a comprehensive Product Requirements Document.

## Usage

```
/product-os:prd --from <intake.md> [--context <files>]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to approved intake document |
| `--context` | No | Additional context files (strategy, research) |
| `--output` | No | Output path (default: `prd.md`) |

## Output

Generates `prd.md` following `templates/pm/prd.md` (header plus 19 numbered sections):
1. Problem statement
2. Hypotheses
3. Background and evidence
4. Goals and non-goals
5. User types and personas
6. Jobs-to-be-done
7. Use cases
8. Functional requirements (numbered, MoSCoW)
9. Non-functional requirements
10. Success metrics with formulas
11. Analytics and instrumentation
12. Technical needs
13. Dependencies
14. Risks and mitigations
15. Alternatives considered
16. Rollout plan
17. Open questions
18. AI feature specification (if applicable)
19. Appendix

## Example

```
/product-os:prd --from initiatives/onboarding/signup/intake.md
```

## Agent

Uses: `prd-author.md`

## Quality Checklist

- [ ] Every claim has evidence
- [ ] Goals are SMART
- [ ] Requirements are numbered (REQ-XXX)
- [ ] Metrics have formulas and targets
- [ ] Risks have mitigations
