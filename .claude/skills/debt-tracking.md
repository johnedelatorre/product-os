# Skill: Tech Debt and Design Debt Tracking

Track and prioritize technical and design debt.

## When to Use

- Documenting known issues
- Sprint planning (paydown allocation)
- Quarterly planning
- Risk assessment

## Quick Start

```
/product-os:debt --action report
```

## Tech Debt Categories

| Category | Examples |
|----------|----------|
| `architecture` | Monolith, wrong patterns |
| `code-quality` | Duplication, complexity |
| `testing` | Low coverage, flaky tests |
| `infrastructure` | Outdated deps, scaling |
| `documentation` | Missing/stale docs |
| `security` | Vulnerabilities |

## Design Debt Categories

| Category | Examples |
|----------|----------|
| `consistency` | Multiple styles |
| `accessibility` | Missing labels |
| `ux-completeness` | Missing states |
| `design-system` | Component gaps |
| `content` | Inconsistent copy |

## Debt Item Format

```yaml
- id: TD-001
  title: "Legacy auth module"
  category: architecture
  
  description: "Uses deprecated patterns"
  
  impact:
    severity: high
    interest: "4 hrs/sprint maintaining workarounds"
    
  remediation:
    approach: "Rewrite with OAuth 2.0"
    effort: "2 sprints"
    owner: "@backend-lead"
    
  priority:
    score: 8
    rationale: "Blocks strategic feature"
```

## Priority Scoring

```
Priority = (Impact × 3) + (Interest × 2) + (Risk × 1)
                         ─────────────────────────────
                                     6
```

| Factor | Question |
|--------|----------|
| Impact | How bad is it? (1-10) |
| Interest | Ongoing cost? (1-10) |
| Risk | Will it worsen? (1-10) |

## Debt Interest

Track ongoing cost:

- Hours per sprint maintaining
- Features blocked
- Support tickets caused
- Performance degradation

## Status Values

| Status | Meaning |
|--------|---------|
| `identified` | Known, not planned |
| `planned` | Scheduled |
| `in-progress` | Being paid down |
| `resolved` | Fixed |

## Capacity Allocation

Recommend 10-20% capacity for debt paydown:

```
Sprint capacity: 40 points
Debt allocation: 8 points (20%)
Feature work: 32 points
```

## Quality Checklist

- [ ] All items have descriptions
- [ ] Impact documented
- [ ] Remediation defined
- [ ] Priority scores current
- [ ] Owners assigned
- [ ] Trend tracked

## Related

- `/product-os:debt` — Manage tracker
- `/product-os:risks` — Link to risks
- `.claude/agents/debt-tracker.md` — Full spec
