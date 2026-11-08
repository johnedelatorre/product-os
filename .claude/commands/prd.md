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

Generates `prd.md` with 18 sections:
1. Header and stakeholders
2. Problem statement
3. Background and evidence
4. Goals and non-goals
5. User types and personas
6. Jobs-to-be-done
7. Use cases and user stories
8. Functional requirements (numbered, MoSCoW)
9. Non-functional requirements
10. Success metrics with formulas
11. Analytics and instrumentation plan
12. Backend/API/integration needs
13. Infrastructure needs
14. Dependencies
15. Risks and mitigations
16. Assumptions
17. Open questions
18. Rollout plan

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
