# Product OS — Claude Instructions

> **Product OS** is a portable product management and design operating system for AI-assisted product development. It embeds PM rigor—strategy alignment, business outcomes, prioritization, metrics, stakeholder management, roadmaps, decision-making, and delivery accountability—into every artifact and workflow.

## Philosophy

**PM rigor leads; design serves product strategy.**

Every initiative starts with a clear problem statement backed by evidence. Every solution ties to measurable business outcomes. Design decisions are evaluated against product goals, not aesthetic preference. Delivery is accountable to committed metrics, not feature completion.

## Output Style (Always On)

**All agents follow the Clear Output Style.** See `.claude/skills/clear-output.md` for the full specification.

The 10 rules:
1. Lead with the next action
2. Number multi-step tasks
3. End with one concrete next step
4. Suppress tangents
5. Restate state every turn
6. Give specific time estimates
7. Make wins visible
8. State errors matter-of-factly
9. Cap lists to 5 items
10. No preamble, no recap, no closers

Documents include a TL;DR block at top, use scannable headings, numbered steps, and short lists. Full depth is maintained—the style governs structure and wording, not content removal.

Attribution: Adapted from [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT License). See NOTICE.md.

## Owner

John De La Torre-Ugarte — Head of Product / Product Design Lead with 25+ years of experience (ex-frontend engineer). This system reflects his dual PM/PD practice and high standards for artifact quality.

## Platform Compatibility

Product OS works in both **Claude Code** and **Cursor**:

| Platform | Commands | Agents |
|----------|----------|--------|
| Claude Code | Slash commands (`/product-os:*`) | Native Task delegation |
| Cursor | Role-based invocation | `.cursor/agents/` + role-based |

Canonical content lives in `.claude/` (read by both platforms). See `docs/guides/platform-compatibility.md`.

## What This System Does

Product OS provides a complete pipeline from raw requirement to shipped, measured feature:

1. **Intake** — Structure any input (executive ask, customer feedback, analytics signal) into a problem/opportunity statement
2. **Proposal** — For new ideas: research, propose solution, interface first (see `.claude/skills/proposal.md`)
3. **PM Agent** — Deep PRD, project brief, project plan, RACI, Gantt chart with full strategic and delivery context
4. **Design Agent** — Design brief, user flows, wireframes, prototype specs, Figma hand-off with design critique
5. **Delivery Agent** — Epics, user stories with acceptance criteria, story points, engineering hand-off
6. **Publisher** — Write to Confluence, create Jira epics/stories, link everything together
7. **Tools** — RICE/WSJF prioritization, OKRs, roadmaps, competitive analysis, experiments, and more

## How to Use

### Guided Mode (Recommended for New PMs)

```
/product-os:guide --initiative <slug> --project <slug>
```

Walks you step-by-step through all 9 phases:
1. Intake → 2. Discovery → 3. Prioritize → 4. Define → 5. Design → 6. Review → 7. Deliver → 8. Launch → 9. Measure

Progress is tracked in `progress.yaml`. Check status with `/product-os:status`. Do the next step with `/product-os:next`.

See `docs/guides/guided-workflow.md` for the full playbook.

### Full Pipeline (Automated)

```
/product-os:new-project
```

Runs the complete pipeline with human checkpoints at each stage. You review and approve before proceeding.

### Individual Commands

Run any stage independently:

```
/product-os:intake          # Structure a raw requirement
/product-os:propose         # Research idea, propose solution (new ideas only)
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

### Code Shipping Commands

```
/product-os:release-gate    # Full release gate process
/product-os:audit-intent    # Audit code vs documented intent
/product-os:handover        # Create session handover
```

## Code Shipping Requirements

When shipping code (not PM-only artifacts), these are **mandatory**:

| Requirement | Skill |
|-------------|-------|
| Intent vs. implementation audit | `.claude/skills/intended-vs-implemented.md` |
| Independent review | `.claude/skills/independent-review.md` |
| Test evidence | Project-specific |
| Owner explicit GO | Silence is never go |
| Build verification | `.claude/skills/release-gate.md` |

**If tools/reviewer unavailable:** Mark Not Verified and **block release**. Never claim independence that doesn't exist.

**Waivers remain waivers** (not Pass). See `.claude/agents/gate-keeper.md` for blocking rules.

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
