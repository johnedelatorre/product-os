# Product OS — Claude Instructions

> **Product OS** is a portable product management and design operating system for AI-assisted product development. It embeds PM rigor—strategy alignment, business outcomes, prioritization, metrics, stakeholder management, roadmaps, decision-making, and delivery accountability—into every artifact and workflow.

## Philosophy

**PM rigor leads; design serves product strategy.**

Every initiative starts with a clear problem statement backed by evidence. Every solution ties to measurable business outcomes. Design decisions are evaluated against product goals, not aesthetic preference. Delivery is accountable to committed metrics, not feature completion.

## Owner

John De La Torre-Ugarte — Head of Product / Product Design Lead with 25+ years of experience (ex-frontend engineer). This system reflects his dual PM/PD practice and high standards for artifact quality.

## What This System Does

Product OS provides a complete pipeline from raw requirement to shipped, measured feature:

1. **Intake** — Structure any input (executive ask, customer feedback, analytics signal) into a problem/opportunity statement
2. **PM Agent** — Deep PRD, project brief, project plan, RACI, Gantt chart with full strategic and delivery context
3. **Design Agent** — Design brief, user flows, wireframes, prototype specs, Figma hand-off with design critique
4. **Delivery Agent** — Epics, user stories with acceptance criteria, story points, engineering hand-off
5. **Publisher** — Write to Confluence, create Jira epics/stories, link everything together
6. **Tools** — RICE/WSJF prioritization, OKRs, roadmaps, competitive analysis, experiments, and more

## How to Use

### Full Pipeline (Recommended)

```
/product-os:new-project
```

Runs the complete pipeline with human checkpoints at each stage. You review and approve before proceeding.

### Individual Commands

Run any stage independently:

```
/product-os:intake          # Structure a raw requirement
/product-os:prd             # Generate full PRD
/product-os:design-brief    # Create design brief from PRD
/product-os:stories         # Generate Jira-ready stories
/product-os:publish         # Push to Confluence + Jira
```

### Tools (Head-of-Product Utilities)

```
/product-os:rice            # RICE prioritization scoring
/product-os:okrs            # OKR definition and metric trees
/product-os:roadmap         # Now/Next/Later roadmap
/product-os:experiment      # A/B test design with sample size
/product-os:competitive     # Competitive analysis matrix
```

## Quality Standards

Every artifact must meet these bars:

### PM Artifacts
- [ ] Clear problem statement with evidence
- [ ] Explicit business outcome and success metrics with formulas
- [ ] Stakeholder alignment documented
- [ ] Risks, assumptions, and dependencies captured
- [ ] Prioritization rationale included

### Design Artifacts  
- [ ] Tied to specific PRD requirements
- [ ] User flows cover happy path + edge cases + errors
- [ ] Accessibility (WCAG 2.1 AA minimum) addressed
- [ ] Heuristic evaluation performed
- [ ] Hand-off spec complete for implementation

### Delivery Artifacts
- [ ] Acceptance criteria in Given/When/Then format
- [ ] Story points with estimation rationale
- [ ] Dependencies and blockers identified
- [ ] Links back to PRD and design specs

## Local Workspace Convention

All work is versioned locally before publishing:

```
initiatives/
└── <initiative-slug>/
    └── <project-slug>/
        ├── intake.md
        ├── prd.md
        ├── project-brief.md
        ├── project-plan.md
        ├── raci.md
        ├── gantt.md
        ├── design-brief.md
        ├── user-flows.md
        ├── wireframes.md
        ├── prototype-spec.md
        ├── design-critique.md
        ├── epics.md
        ├── stories.md
        └── publish-manifest.json
```

## Configuration

See `product-os.config.yaml` for Confluence/Jira settings. Copy `.env.example` to `.env` for API credentials (never commit secrets).

## Subagents

Product OS uses specialized subagents for each pipeline stage. See `AGENTS.md` for the full orchestration model and `.claude/agents/` for individual agent definitions.

## Documentation

- `README.md` — Quick start and installation
- `docs/guides/` — Deep-dive guides for each capability
- `docs/reference/` — Command and template reference
- `docs/setup/` — Confluence, Jira, and MCP setup
- `examples/` — Worked example project

## Contributing

See `CONTRIBUTING.md`. All contributions must include documentation updates.
