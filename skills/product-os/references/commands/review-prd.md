---
description: "Conduct a multi-perspective PRD review synthesizing feasibility, UX, strategy, research, privacy, and customer perspectives."
argument-hint: "--from prd.md"
---
# /product-os:review-prd

Conduct a multi-perspective PRD review synthesizing feasibility, UX, strategy, research, privacy, and customer perspectives.

## Usage

```
/product-os:review-prd --from prd.md
/product-os:review-prd --from prd.md --perspectives feasibility,ux,strategy
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--from` | Yes | Path to PRD file |
| `--perspectives` | No | Comma-separated list (default: all) |
| `--output` | No | Output path (default: prd-review.md) |

## Available Perspectives

| Perspective | What It Checks | Simulates |
|-------------|----------------|-----------|
| `feasibility` | Technical risks, estimation readiness, dependencies | Engineering Lead |
| `ux` | UX concerns, accessibility, consistency | Design Lead |
| `strategy` | Alignment with goals, roadmap fit, priority | Product Lead |
| `research` | Evidence quality, unsupported assumptions, contradictions | UX Researcher |
| `privacy` | Data handling, security requirements, compliance | Security Lead |
| `customer` | User concerns, edge cases, adversarial scenarios | Customer Advocate |

## Output

Generates `prd-review.md` with:
- Summary of each perspective's findings
- Blockers (must fix before approval)
- Gaps (should address)
- Suggestions (nice to have)
- Conflicts between perspectives
- Resolution tracking
- Approval recommendation

## Examples

```bash
# Full review with all perspectives
/product-os:review-prd --from initiatives/onboarding/signup/prd.md

# Quick feasibility check only
/product-os:review-prd --from prd.md --perspectives feasibility

# UX and accessibility focus
/product-os:review-prd --from prd.md --perspectives ux,customer
```

## What It Does

1. Reads the PRD
2. Evaluates from each requested perspective
3. Identifies blockers, gaps, and suggestions
4. Flags conflicts between perspectives
5. Synthesizes into approval recommendation
6. Creates resolution tracking for follow-up

## Not a Replacement For

- **Legal review** — Consult Legal for compliance
- **User research** — Conduct actual studies
- **Security audit** — Perform formal audit for sensitive features
- **Accessibility certification** — Conduct full audit before launch

This review identifies issues for discussion; it doesn't provide authoritative signoff.

## Template

Uses `templates/pm/prd-review.md`
