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

**Current state only:** docs, Confluence pages, epics and tickets show the final state, with no version banners, history blocks, change narratives or retired items. See `.claude/skills/doc-hygiene.md`; `/product-os:cleanup` cleans docs that already carry history.

Attribution: Adapted from [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT License). See NOTICE.md.

## Guided Questions (Always On)

**Every agent asks before it writes, and keeps asking until its document is finished.** See `.claude/skills/guided-questions.md`.

1. One question at a time, each with its place ("Question 2 of 4")
2. Short numbered options, the recommended one marked
3. At most 5 questions before a document, and a second round after the first draft
4. Never ask for what a source or `progress.yaml` already answers
5. No decision in a document is made by the agent alone; an undecided item is a named TBD

The PM never has to say "ask me guided questions". This covers every document, the design critique and the UX writing guide included.

## Owner

John De La Torre-Ugarte — Head of Product / Product Design Lead with 25+ years of experience (ex-frontend engineer). This system reflects his dual PM/PD practice and high standards for artifact quality.

## Platform Compatibility

Product OS works in **Claude Code**, **Cursor**, **claude.ai** and **ChatGPT**:

| Platform | Commands | Agents |
|----------|----------|--------|
| Claude Code | Plugin slash commands (`/product-os:*`, from `.claude-plugin/`) | Native Task delegation (agents in `.claude/agents/` register as subagents via frontmatter) |
| Cursor | Role-based invocation | `.cursor/agents/` + role-based |
| claude.ai | Plain language | One role at a time, from the files in `claude-ai/` |
| ChatGPT | Plain language | One role at a time, from the 8-file pack in `chatgpt/` |

Canonical content lives in `.claude/` (read by both platforms). Skills in `.claude/skills/` are reference documents read by path. See `docs/guides/platform-compatibility.md`.

## What This System Does

Product OS provides a complete pipeline from raw requirement to shipped, measured feature:

1. **Intake** — Structure any input (executive ask, customer feedback, analytics signal) into a problem/opportunity statement
2. **Proposal** — For new ideas: research, propose solution, interface first (see `.claude/skills/proposal.md`)
3. **PM Agent** — Deep PRD, project brief, project plan, RACI, Gantt chart with full strategic and delivery context
4. **Design Agents** — Design brief, user flows, wireframes, clickable prototypes, Figma sync, then the design critique paired with the UX writing pass (final designs and the UX writing guide), UX review, and accessibility audit
5. **Delivery Agent** — The engineering handoff: one epic that links to everything the team needs, lean tickets with estimates, and a ticket tree the PM approves (see `.claude/skills/engineering-handoff.md`)
6. **Publisher** — After human approval, write to Confluence, create or update Jira epics/stories, link everything together
7. **Tools** — RICE/WSJF prioritization, OKRs, roadmaps, competitive analysis, experiments, and more

## How to Use

### Guided Mode (Recommended for New PMs)

```
/product-os:guide --initiative <slug> --project <slug>
```

Walks you step-by-step through all 9 phases:
1. Intake → 2. Discovery → 3. Prioritize → 4. Define → 5. Design → 6. Review → 7. Deliver → 8. Launch → 9. Measure

Progress is tracked in `initiatives/<initiative>/<project>/progress.yaml`. Check status with `/product-os:status`. Do the next step with `/product-os:next`.

Missing information never blocks a phase: the PM can defer any document or exit criterion, it is tracked in `open_items` and resurfaced later, and open items are decided (resolve or accept risk) before Launch. Publishing approval and code-shipping release gates remain hard stops.

See `docs/guides/guided-workflow.md` for the full playbook.

### Full Pipeline (Automated)

```
/product-os:new-project
```

Runs the complete pipeline with human checkpoints at each stage. You review and approve before proceeding.

### It Asks Before It Writes

Product OS asks guided questions, one at a time, instead of producing everything:

1. **Seven questions at the start.** What you are building and who will use it; who will read what it writes; your role; the design system to follow (a Figma library, a Claude design system, both, or none yet); where it came from; everything you have, in one step, sorted into Found and Missing; and the playback, which you accept before anything is written. "That is all" is always a valid answer.
2. **Questions before every document.** The decisions that document needs, until it is finished (above).
3. **Two confirmations at the handoff.** What each reader group gets, and the ticket tree. You accept it or move items before anything reaches Jira.
4. **One question after the handoff.** What the team said was missing or too much. It becomes your team's default.

Every run ends with one list: for the team (share the epic), for you, and what was not created. Rules: `.claude/skills/engineering-handoff.md`.

### Individual Commands

Run any stage independently:

```
/product-os:intake          # Structure a raw requirement
/product-os:propose         # Research idea, propose solution (new ideas only)
/product-os:prd             # Generate full PRD
/product-os:design-brief    # Create design brief from PRD
/product-os:critique        # Design critique, paired with the UX writing pass
/product-os:ux-writing      # UX writing pass and the UX writing guide
/product-os:deliver         # Generate Jira-ready epics + stories
/product-os:publish         # Publish to Confluence + Jira (after approval)
```

### Tools (Head-of-Product Utilities)

```
/product-os:prioritize      # RICE/WSJF/MoSCoW/Kano scoring (--framework)
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
- [ ] Accessibility (WCAG 2.2 AA minimum) addressed
- [ ] Heuristic evaluation performed
- [ ] UX writing pass done with the design critique; the final design carries the copy from the UX writing guide
- [ ] Hand-off spec complete for implementation

### Delivery Artifacts
- [ ] The epic links to every handoff output: PRD, project brief, user flows, final design, UX writing guide, end-to-end prototype
- [ ] Tickets are short: user story, problem, requirements, design link, the "use the copy as is" line, a testable "Done when" checklist, estimate
- [ ] Tickets are 1–5 points; steps inside a ticket are sub-tasks; the PM accepted the ticket tree
- [ ] Backend tickets are high level and left for the engineers to complete
- [ ] Dependencies and blockers identified

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
        ├── flows.yaml
        ├── flows.md
        ├── wireframes.md
        ├── prototype.html
        ├── design-critique.md
        ├── ux-writing.md
        ├── epics.md
        ├── stories.md
        ├── progress.yaml          # Guided-mode state
        └── publish-manifest.json
```

`HANDOVER.md` (session handover) lives at the repo root unless the project already has a status or handoff file (see `.claude/skills/session-handover.md`).

## Configuration

See `product-os.config.yaml` for Confluence/Jira settings. Prefer the connected Atlassian MCP tools (no credentials needed). Copy `.env.example` to `.env` only if you use the REST fallback (`scripts/atlassian-fallback.py`); never commit secrets. Nothing is written to Confluence or Jira without explicit human approval.

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
