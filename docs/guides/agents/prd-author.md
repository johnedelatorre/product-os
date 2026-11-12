# PRD Author Agent

Writes comprehensive Product Requirements Documents.

## What It Does

Transforms an approved intake into a complete 19-section PRD with strategic context, requirements, metrics, and delivery planning.

## When to Use

- Intake is approved and ready for deep specification
- Need a complete PRD for stakeholder review
- Want to document requirements before design begins

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--from` | Yes | Path to approved `intake.md` |
| `--context` | No | Strategy docs, research |

## Outputs

- `prd.md` — Complete PRD with 19 sections

## Example

```bash
/product-os:prd --from intake.md
```

## PRD Sections

1. Header & stakeholders
2. Problem statement
3. Background & evidence
4. Goals & non-goals
5. User types & personas
6. Jobs-to-be-done
7. Use cases
8. Functional requirements (MoSCoW)
9. Non-functional requirements
10. Success metrics (with formulas)
11. Analytics plan
12. Technical needs
13. Infrastructure
14. Dependencies
15. Risks & mitigations
16. Assumptions
17. Open questions
18. Rollout plan

## Tips

1. **Every claim needs evidence** — no unsupported assertions
2. **Requirements need IDs** — REQ-001, REQ-002 for traceability
3. **Metrics need formulas** — not just "improve conversion"
4. **Non-goals prevent scope creep** — be explicit

## Related

- [PRD Writing Skill](../../../.claude/skills/prd-writing.md)
- [Project Brief](project-brief.md) — one-page summary
