# Skill: Project Brief

Create one-page executive summaries for stakeholder alignment.

## When to Use

- Need executive approval for a project
- Communicating with stakeholders who won't read full PRD
- Starting a project kickoff meeting
- Aligning cross-functional teams

## Quick Start

```
/product-os:brief --from prd.md
```

## One-Page Constraint

The brief must fit on **one printed page** (~500-600 words). This forces clarity.

## Required Sections

| Section | Max Length | Content |
|---------|------------|---------|
| Problem | 2-3 sentences | What's broken, who's affected, evidence |
| Why Now | 2-3 sentences | Urgency, cost of delay, opportunity |
| Goals & Metrics | 2-3 rows | Primary outcomes with targets |
| Scope | 3-5 bullets each | In scope / Out of scope |
| Users | 2-3 rows | Who we're building for |
| Stakeholders | Key roles | Approval responsibilities |
| Timeline | 5-6 milestones | Major dates |
| Risks | Top 3 | Probability, impact, mitigation |
| Links | All docs | PRD, design, Jira |

## Template

```markdown
# Project Brief: [Name]

## Problem
[2-3 sentences: What's broken? Who's affected? Evidence?]

## Why Now
[2-3 sentences: Urgency, cost of delay, opportunity window]

## Goals & Success Metrics
| Goal | Metric | Target | Timeline |
|------|--------|--------|----------|
| [Goal] | [Measure] | [Number] | [When] |

## Scope
### In Scope
- [Deliverable 1]
- [Deliverable 2]

### Out of Scope
- [Exclusion 1]

## Users
| Type | Description | Size |
|------|-------------|------|
| Primary | [Who] | [Count] |

## Timeline
| Milestone | Date |
|-----------|------|
| PRD Approved | [Date] |
| Launch | [Date] |

## Risks
| Risk | P | I | Mitigation |
|------|---|---|------------|
| [Risk] | H/M/L | H/M/L | [Action] |

## Links
- PRD: [link]
- Design: [link]
```

## Writing Guidelines

### Do
- Lead with impact
- Use plain language
- Be specific with numbers
- State constraints directly
- Make risks visible

### Don't
- Use technical jargon
- Hedge with weasel words
- Hide bad news
- Include implementation details
- Exceed one page

## Quality Checklist

- [ ] Fits on one page
- [ ] Problem clear in 10 seconds
- [ ] Why now is compelling
- [ ] Goals are SMART
- [ ] Scope has clear boundaries
- [ ] Stakeholders listed with responsibilities
- [ ] Timeline has specific dates
- [ ] Top risks visible
- [ ] No jargon

## Tips

1. **Write the problem first** — if you can't explain it simply, you don't understand it
2. **Test with a non-expert** — can they understand it in 60 seconds?
3. **Use the brief in meetings** — project to screen, walk through section by section
4. **Update when scope changes** — keep it current

## Related

- `/product-os:prd` — Full PRD that the brief summarizes
- `.claude/agents/project-brief.md` — Full agent specification
