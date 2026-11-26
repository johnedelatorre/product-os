# Skill: RACI Matrix

Create responsibility assignment matrices for clear accountability.

## When to Use

- Starting a new project
- Clarifying roles across teams
- Resolving "who owns this?" questions
- Onboarding new team members

## Quick Start

```
/product-os:plan --from prd.md
```

## RACI Definitions

| Letter | Role | Definition | Rules |
|--------|------|------------|-------|
| **R** | Responsible | Does the work | Can be multiple people |
| **A** | Accountable | Owns the outcome, approves | **Exactly ONE per row** |
| **C** | Consulted | Provides input before | Two-way communication |
| **I** | Informed | Notified after | One-way communication |

## Matrix Structure

```markdown
| Activity | Product | Engineering | Design | QA |
|----------|---------|-------------|--------|-----|
| Write PRD | R/A | C | C | I |
| Technical design | C | R/A | I | I |
| Visual design | A | C | R | I |
| Development | I | R/A | C | C |
| QA testing | C | C | I | R/A |
| Launch decision | A | C | C | C |
```

## Rules

### Rule 1: One A per Row
Every activity must have exactly one Accountable person. If you can't identify one, the activity isn't well-defined.

❌ **Wrong:** Two people accountable
✅ **Right:** One person accountable, others responsible

### Rule 2: A can also be R
The Accountable person can also be Responsible (R/A), meaning they both do and own the work.

### Rule 3: Minimize C
Too many Consulted people = decision paralysis. Ask: "Does this person's input actually change the outcome?"

### Rule 4: I is Not Optional
People who need to know but don't need to approve should be Informed, not Consulted.

## Common Activities by Phase

### Discovery
| Activity | Typical RACI |
|----------|--------------|
| Define problem | Product: R/A, Eng: C, Design: C |
| User research | Design: R/A, Product: C |
| Technical feasibility | Eng: R/A, Product: C |
| Prioritization | Product: A, Eng: C, Design: C |

### Design
| Activity | Typical RACI |
|----------|--------------|
| User flows | Design: R/A, Product: C, Eng: I |
| Wireframes | Design: R, Product: A |
| Visual design | Design: R/A, Product: C |
| Prototype | Design: R/A, Eng: C |

### Development
| Activity | Typical RACI |
|----------|--------------|
| Architecture | Eng: R/A, Product: I |
| Implementation | Eng: R, Eng Lead: A |
| Code review | Eng: R/A |
| Unit testing | Eng: R/A |

### Launch
| Activity | Typical RACI |
|----------|--------------|
| Launch checklist | Product: R/A, All: C |
| Go/no-go decision | Product: A, Eng: C, QA: C |
| Rollout execution | Eng: R, Product: A |
| Monitoring | Eng: R, Product: I |

## Quality Checklist

- [ ] Every activity has exactly one A
- [ ] R/A assigned to someone who can do it
- [ ] C is limited (avoid decision paralysis)
- [ ] I includes everyone who needs to know
- [ ] No empty rows or columns
- [ ] Reviewed with all stakeholders

## Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Multiple A's | No clear owner | Pick one decision-maker |
| No A | Orphaned activity | Assign accountability |
| Everyone is C | Nothing gets done | Limit to essential input |
| Missing I | Surprises later | Include downstream teams |
| Too granular | Matrix too complex | Group related activities |

## Tips

1. **Start with activities, not roles** — list what needs to happen, then assign
2. **Review with stakeholders** — they must agree to their assignments
3. **Post it visibly** — RACI only works if people reference it
4. **Update when roles change** — keep it current
5. **Use for escalation** — "Per our RACI, you're accountable for this decision"

## Related

- `/product-os:plan` — Generate RACI with project plan
- `.claude/agents/project-planner.md` — Full agent specification
