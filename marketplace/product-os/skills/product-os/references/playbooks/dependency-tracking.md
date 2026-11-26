# Skill: Dependency and Risk Tracking

Maintain dependencies and risks integrated with RACI.

## When to Use

- Project planning
- Identifying blockers
- Risk management
- Status reporting

## Quick Start

```
/product-os:dependencies --project initiatives/onboarding/signup
```

## Dependency Format

```yaml
- id: DEP-001
  name: "Authentication API upgrade"
  type: internal
  
  source:
    team: "Platform"
    contact: "@platform-lead"
    
  target:
    deliverable: "Auth API v2 deployed"
    date: 2026-11-15
    
  status: on-track
  
  impact_if_missed:
    severity: high
    mitigation: "Launch without SSO"
    
  raci:
    responsible: "@platform-lead"
    accountable: "@eng-director"
```

## Dependency Types

| Type | Example |
|------|---------|
| `internal` | Platform team API |
| `external` | Vendor delivery |
| `regulatory` | Legal/compliance |
| `technical` | Infrastructure |

## Status Values

| Status | Action |
|--------|--------|
| `on-track` | Monitor |
| `at-risk` | Escalate |
| `blocked` | Immediate action |
| `complete` | Remove |

## Risk Matrix

| | Low Impact | Med | High |
|---|---|---|---|
| High Prob | 3 | 6 | 9 |
| Med Prob | 2 | 4 | 6 |
| Low Prob | 1 | 2 | 3 |

## RACI Integration

Link dependencies to RACI:

```yaml
raci:
  responsible: "@platform-lead"   # Does the work
  accountable: "@eng-director"    # Has authority
  consulted: ["@security"]        # Provides input
  informed: ["@pm"]               # Kept updated
```

## Weekly Check

1. Update status for all dependencies
2. Flag new blockers
3. Update risk scores
4. Report to stakeholders

## Quality Checklist

- [ ] All dependencies have owners
- [ ] All have target dates
- [ ] At-risk items have mitigations
- [ ] RACI links accurate
- [ ] Updates within 7 days

## Related

- `/product-os:dependencies` — Manage register
- `/product-os:risks` — Risk register
- `/product-os:plan` — Project planning
- `.claude/agents/dependency-tracker.md` — Full spec
