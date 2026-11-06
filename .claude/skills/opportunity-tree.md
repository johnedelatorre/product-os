# Skill: Opportunity Solution Tree

Create opportunity solution trees for structured discovery.

## When to Use

- Before writing a PRD
- Exploring a problem space
- Connecting outcomes to solutions
- Preventing solution-first thinking

## Quick Start

```
/product-os:opportunity-tree --outcome "Increase signup conversion from 66% to 80%"
```

## Tree Structure

```
🎯 Outcome (measurable goal)
├── 💡 Opportunity 1 (problem/need)
│   ├── 🔧 Solution A
│   └── 🔧 Solution B
└── 💡 Opportunity 2 (problem/need)
    ├── 🔧 Solution C
    └── 🔧 Solution D
```

## Key Principles

1. **Outcome first** — Start with what you want to achieve
2. **Opportunities are problems** — Not solutions
3. **Evidence-backed** — Each opportunity needs data
4. **Solutions are hypotheses** — To be validated
5. **One outcome per tree** — Keep focused

## Confidence Levels

| Level | Evidence Required |
|-------|-------------------|
| `high` | Quantitative data, multiple sources |
| `medium` | Qualitative research, limited data |
| `low` | Assumption, needs validation |

## Solution Status

| Status | Meaning |
|--------|---------|
| `idea` | Not validated |
| `exploring` | Gathering evidence |
| `testing` | Running experiment |
| `validated` | Experiment successful |
| `invalidated` | Experiment failed |
| `building` | In development |
| `shipped` | In production |

## Example Tree

```yaml
outcome: "Increase signup conversion from 66% to 80%"

opportunities:
  - name: "Reduce form friction"
    evidence: "34% drop-off at form step"
    confidence: high
    solutions:
      - name: "Simplify to 3 fields"
        status: testing
      - name: "Add social login"
        status: idea
```

## Quality Checklist

- [ ] Outcome is measurable
- [ ] Opportunities have evidence
- [ ] Solutions map to opportunities (not outcome)
- [ ] No solution-first branches
- [ ] Assumptions are explicit

## Related

- `/product-os:opportunity-tree` — Create tree
- `/product-os:hypotheses` — Track hypotheses
- `.claude/agents/opportunity-tree.md` — Full spec
