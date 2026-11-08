# Product OS — Agent Orchestration

> This document defines how Product OS agents work together. **PM rigor leads; design serves product strategy.**

## Platform Compatibility

Product OS works in both **Claude Code** and **Cursor**:

| Platform | Agents | Commands | Skills | Subagents |
|----------|--------|----------|--------|-----------|
| Claude Code | 39 | 46 (slash commands) | 40 | Full (Task tool) |
| Cursor | 39 | Role-based invocation | 40 | Partial (some subagent_types) |

In Cursor, invoke agents by reading their file:
```
Read .claude/agents/prd-author.md and create a PRD for [feature]
```

See `docs/guides/platform-compatibility.md` for full setup.

## Global Output Style

**All agents follow the Clear Output Style** defined in `.claude/skills/clear-output.md`. This is always on—no command needed.

Key rules: Lead with the next action. Number multi-step tasks. End with one concrete next step. No preamble, no recap, no closers. Cap lists to 5 items. Give specific time estimates.

Documents include TL;DR blocks, scannable headings, and numbered steps while maintaining full depth.

---

## Agent Roster (39 Agents)

### Pipeline Agents (7)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Orchestrator | `orchestrator.md` | Coordinate pipeline, manage checkpoints | `/product-os:new-project` |
| Intake Analyst | `intake-analyst.md` | Structure raw requirements | `/product-os:intake` |
| Strategist | `strategist.md` | RICE/WSJF/MoSCoW/Kano prioritization | `/product-os:prioritize` |
| Roadmap Agent | `roadmap-agent.md` | Now/Next/Later roadmaps | `/product-os:roadmap` |
| PRD Author | `prd-author.md` | Write comprehensive PRD | `/product-os:prd` |
| Project Brief | `project-brief.md` | One-page executive summary | `/product-os:brief` |
| Project Planner | `project-planner.md` | RACI, Gantt, timeline | `/product-os:plan` |

### Discovery Agents (6)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Opportunity Tree | `opportunity-tree.md` | Outcome-opportunity-solution trees | `/product-os:opportunity-tree` |
| Hypothesis Logger | `hypothesis-logger.md` | Track and validate hypotheses | `/product-os:hypotheses` |
| Market Analyst | `market-analyst.md` | TAM/SAM/SOM, trends, segments | `/product-os:market` |
| Competitive Analyst | `competitive-analyst.md` | Competitive analysis | `/product-os:competitive` |
| Experiment Designer | `experiment-designer.md` | A/B test design | `/product-os:experiment` |
| UX Researcher | `ux-researcher.md` | Research plans, synthesis | `/product-os:research` |

### Design Agents (5)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Product Designer | `product-designer.md` | Design brief, direction | `/product-os:design-brief` |
| Flow Designer | `flow-designer.md` | User flows, journey maps, sitemap | `/product-os:flows` |
| Wireframer | `wireframer.md` | Lo-fi wireframes | `/product-os:wireframes` |
| Prototyper | `prototyper.md` | Clickable HTML/React prototypes | `/product-os:prototype` |
| Figma Agent | `figma-agent.md` | Figma MCP integration | `/product-os:figma` |

### Review & Gate Agents (4)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Design Critic | `design-critic.md` | Visual design critique | `/product-os:critique` |
| UX Reviewer | `ux-reviewer.md` | Nielsen heuristics, Laws of UX | `/product-os:ux-review` |
| Accessibility Auditor | `accessibility-auditor.md` | WCAG 2.2 AA audit | `/product-os:a11y` |
| Gate Keeper | `gate-keeper.md` | DoR/DoD validation | `/product-os:gate` |

### Delivery Agents (3)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Delivery Agent | `delivery-agent.md` | Epics, stories, story points | `/product-os:deliver` |
| Confluence Publisher | `confluence-publisher.md` | Publish to Confluence | `/product-os:publish` |
| Jira Sync | `jira-sync.md` | Create/update Jira issues | `/product-os:jira-sync` |

### Metrics & Measurement Agents (3)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Metrics Designer | `metrics-designer.md` | North star, guardrails, success criteria | `/product-os:metrics` |
| Event Tracker | `event-tracker.md` | Analytics tracking plans | `/product-os:tracking` |
| Post-Launch Reviewer | `post-launch-reviewer.md` | Results vs PRD goals | `/product-os:review-launch` |

### Launch & GTM Agents (2)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Launch Manager | `launch-manager.md` | Release notes, enablement, changelog | `/product-os:launch` |
| Stakeholder Comms | `stakeholder-comms.md` | Updates, summaries | `/product-os:comms` |

### Governance Agents (5)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Artifact Registry | `artifact-registry.md` | Track design artifacts | `/product-os:artifacts` |
| Dependency Tracker | `dependency-tracker.md` | Dependencies + risks + RACI | `/product-os:dependencies` |
| Risk Manager | `risk-manager.md` | Risk register | `/product-os:risks` |
| Debt Tracker | `debt-tracker.md` | Tech and design debt | `/product-os:debt` |
| Decision Logger | `decision-logger.md` | ADR-style decisions | `/product-os:decision` |

### Tool Agents (3)

| Agent | File | Role | Command |
|-------|------|------|---------|
| OKR Agent | `okr-agent.md` | OKRs and metric trees | `/product-os:okrs` |
| Retro Facilitator | `retro-facilitator.md` | Retrospectives | `/product-os:retro` |
| PR/FAQ Author | `prfaq-author.md` | Amazon-style PR/FAQ | `/product-os:prfaq` |

### Guided Mode Agent (1)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Guide | `guide.md` | Step-by-step phase guidance with progress tracking | `/product-os:guide` |

---

## Agent Hierarchy

```
┌─────────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATOR                                  │
│              /product-os:new-project                                │
│         Coordinates pipeline, enforces checkpoints                  │
└─────────────────────────────────────────────────────────────────────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        ▼                       ▼                       ▼
┌───────────────┐      ┌───────────────┐      ┌───────────────┐
│    INTAKE     │ ───▶ │      PM       │ ───▶ │   DESIGNER    │
│   Agent       │      │    Agent      │      │    Agent      │
└───────────────┘      └───────────────┘      └───────────────┘
                                                      │
                                               ┌──────┴──────┐
                                               ▼             ▼
                                        ┌───────────┐ ┌───────────┐
                                        │  DESIGN   │ │ DELIVERY  │
                                        │  CRITIQUE │ │   Agent   │
                                        └───────────┘ └───────────┘
                                                            │
                                                            ▼
                                                    ┌───────────────┐
                                                    │   PUBLISHER   │
                                                    │     Agent     │
                                                    └───────────────┘
```

## Pipeline Flow

### Stage 1: Intake
**Agent:** `.claude/agents/intake-analyst.md`  
**Command:** `/product-os:intake`  
**Input:** Raw requirement from any source  
**Output:** Structured problem/opportunity statement  
**Checkpoint:** Human approves problem framing before PM work begins

### Stage 2: Product Management
**Agent:** `.claude/agents/pm.md`  
**Commands:** `/product-os:prd`, `/product-os:project-brief`, `/product-os:project-plan`, `/product-os:raci`, `/product-os:gantt`  
**Input:** Approved intake document  
**Output:** Complete PM artifact set (PRD, brief, plan, RACI, Gantt)  
**Checkpoint:** Human approves PRD and plan before design begins

### Stage 3: Product Design
**Agent:** `.claude/agents/designer.md`  
**Commands:** `/product-os:design-brief`, `/product-os:user-flows`, `/product-os:wireframes`, `/product-os:prototype-spec`, `/product-os:figma-handoff`  
**Input:** Approved PRD  
**Output:** Design brief, flows, wireframes, prototype spec, Figma hand-off  
**Checkpoint:** Human approves design direction before critique

### Stage 4: Design Critique
**Agent:** `.claude/agents/design-critique.md`  
**Command:** `/product-os:design-critique`  
**Input:** Design artifacts + PRD  
**Output:** Severity-rated findings for heuristics, accessibility, consistency, PRD alignment  
**Checkpoint:** Human addresses critical findings before delivery

### Stage 5: Delivery
**Agent:** `.claude/agents/delivery.md`  
**Commands:** `/product-os:epics`, `/product-os:stories`  
**Input:** Approved design + PRD  
**Output:** Epics, user stories with acceptance criteria, story points  
**Checkpoint:** Human approves stories before publishing

### Stage 6: Publishing
**Agent:** `.claude/agents/publisher.md`  
**Command:** `/product-os:publish`  
**Input:** All approved artifacts  
**Output:** Confluence pages, Jira epics/stories with links  
**Checkpoint:** Human confirms successful publication

---

## Agent Definitions

### Intake Agent

**Role:** Transform raw, unstructured requirements into clear problem/opportunity statements.

**Inputs:**
- Raw text from any source (Slack message, email, meeting notes, analytics export, support ticket)
- Source attribution (who requested, when, context)

**Outputs:**
- `intake.md` — Structured problem/opportunity statement

**Quality Checklist:**
- [ ] Problem is stated neutrally (not solution-biased)
- [ ] Source and context documented
- [ ] Initial evidence or signal captured
- [ ] Affected users/segments identified
- [ ] Business impact hypothesis stated
- [ ] Open questions listed for PM to investigate

---

### PM Agent

**Role:** Produce comprehensive product management artifacts with full strategic context, business rationale, and delivery planning.

**Inputs:**
- Approved intake document
- Existing product context (roadmap, OKRs, prior decisions)
- Stakeholder input (optional)

**Outputs:**
- `prd.md` — Deep product requirements document
- `project-brief.md` — Executive summary for stakeholders
- `project-plan.md` — Milestones, phases, timeline
- `raci.md` — Responsibility assignment matrix
- `gantt.md` — Visual timeline (Mermaid + CSV export)

**Quality Checklist:**
- [ ] Problem statement traces to intake with added depth
- [ ] Background includes market/competitive context
- [ ] Goals are SMART with explicit non-goals
- [ ] User personas based on data, not assumptions
- [ ] Jobs-to-be-done framework applied
- [ ] Use cases cover primary, secondary, edge cases
- [ ] Requirements are numbered and prioritized (MoSCoW)
- [ ] Success metrics have formulas and targets
- [ ] Analytics plan specifies events and properties
- [ ] Technical needs reviewed with engineering
- [ ] Dependencies mapped across teams
- [ ] Risks rated by probability × impact
- [ ] Rollout plan includes feature flags, % rollout, rollback
- [ ] Open questions have owners and due dates

---

### Designer Agent

**Role:** Translate PRD requirements into design artifacts that solve user problems within product constraints.

**Inputs:**
- Approved PRD
- Design system/brand guidelines (if available)
- Existing UI patterns in the product

**Outputs:**
- `design-brief.md` — Design goals, constraints, principles for this project
- `user-flows.md` — Mermaid diagrams for all flows
- `wireframes.md` — ASCII or HTML/SVG low-fidelity wireframes
- `prototype-spec.md` — Prompt/spec to generate clickable prototype
- `figma-handoff.md` — Specifications for Figma file John builds

**Quality Checklist:**
- [ ] Design brief ties every decision to PRD requirements
- [ ] User flows cover: happy path, errors, edge cases, empty states
- [ ] Wireframes annotated with interaction notes
- [ ] Accessibility considerations embedded (not an afterthought)
- [ ] Responsive behavior specified
- [ ] Prototype spec includes all states and transitions
- [ ] Figma hand-off has component specs, spacing, typography

---

### Design Critique Agent

**Role:** Evaluate design artifacts against established heuristics, accessibility standards, consistency rules, and PRD alignment.

**Inputs:**
- Design artifacts (brief, flows, wireframes)
- PRD for alignment check
- Design system (if available)

**Outputs:**
- `design-critique.md` — Severity-rated findings

**Evaluation Dimensions:**
1. **Nielsen's Heuristics** — Visibility, match to real world, user control, consistency, error prevention, recognition over recall, flexibility, aesthetic minimalism, error recovery, help/docs
2. **Accessibility (WCAG 2.1 AA)** — Perceivable, operable, understandable, robust
3. **Consistency** — Internal consistency, design system adherence, platform conventions
4. **PRD Alignment** — Every requirement addressed, no scope creep, success metrics achievable

**Severity Levels:**
- **Critical (P0):** Blocks launch, must fix
- **Major (P1):** Significant usability/accessibility issue, should fix before launch
- **Minor (P2):** Polish issue, fix if time permits
- **Enhancement (P3):** Nice-to-have improvement

**Quality Checklist:**
- [ ] Every finding has severity, location, description, recommendation
- [ ] Critical findings include remediation steps
- [ ] Positive observations noted (not just problems)
- [ ] PRD trace shows which requirements each design element addresses

---

### Delivery Agent

**Role:** Transform approved designs and PRD into implementation-ready epics and user stories.

**Inputs:**
- Approved PRD
- Approved design artifacts
- Team conventions (sprint length, story point scale)

**Outputs:**
- `epics.md` — High-level epics mapping to PRD goals
- `stories.md` — User stories with acceptance criteria and story points

**Story Format:**
```
**[STORY-ID] Story Title**

As a [user type],
I want to [action],
So that [benefit].

**Acceptance Criteria:**
- Given [context], When [action], Then [outcome]
- Given [context], When [action], Then [outcome]

**Story Points:** X (Rationale: ...)

**Dependencies:** [list]

**Design Reference:** [link to wireframe/flow]

**PRD Reference:** [requirement ID]
```

**Story Point Rubric (Fibonacci):**
| Points | Complexity | Uncertainty | Examples |
|--------|------------|-------------|----------|
| 1 | Trivial | None | Copy change, config update |
| 2 | Simple | Low | Single component, clear spec |
| 3 | Moderate | Low | Multiple components, some logic |
| 5 | Complex | Medium | New feature area, integrations |
| 8 | Very Complex | High | Cross-system, significant unknowns |
| 13 | Extremely Complex | Very High | Architecture change, spike needed |

**Quality Checklist:**
- [ ] Every PRD requirement has ≥1 story
- [ ] Acceptance criteria are testable (Given/When/Then)
- [ ] Stories are independent and vertically sliced
- [ ] Dependencies explicit with linked stories
- [ ] Story points consistent with rubric
- [ ] Design and PRD references linked

---

### Publisher Agent

**Role:** Publish all artifacts to Confluence and create corresponding Jira issues.

**Inputs:**
- All approved artifacts
- `product-os.config.yaml` — Confluence/Jira configuration
- Environment variables for authentication

**Outputs:**
- Confluence pages created in hierarchy
- Jira epics and stories created with links
- `publish-manifest.json` — Record of all created items with IDs/URLs

**Confluence Hierarchy:**
```
Product Space
└── Initiatives Section
    └── [Initiative Name]
        └── [Project Name]
            ├── 1. Intake
            ├── 2. PRD
            ├── 3. Project Brief
            ├── 4. Project Plan
            ├── 5. RACI
            ├── 6. Gantt
            ├── 7. Design Brief
            ├── 8. User Flows
            ├── 9. Wireframes
            ├── 10. Prototype Spec
            ├── 11. Design Critique
            ├── 12. Epics & Stories
            └── 13. Decision Log
```

**Jira Structure:**
- Epic per PRD goal
- Stories linked to parent epic
- Story points populated
- Labels: `product-os`, initiative slug, project slug
- Links to Confluence pages in description

**Quality Checklist:**
- [ ] All artifacts published to correct Confluence location
- [ ] Page hierarchy matches specification
- [ ] Jira epics/stories created with correct fields
- [ ] Bidirectional links (Confluence ↔ Jira)
- [ ] Publish manifest saved locally for reference

---

## Tool Agents

Beyond the pipeline, Product OS includes specialized tools. Each is available via command and uses appropriate templates.

| Tool | Command | Purpose |
|------|---------|---------|
| RICE Scoring | `/product-os:rice` | Prioritize features by Reach × Impact × Confidence ÷ Effort |
| WSJF Scoring | `/product-os:wsjf` | Weighted Shortest Job First prioritization |
| MoSCoW | `/product-os:moscow` | Must/Should/Could/Won't categorization |
| Kano Analysis | `/product-os:kano` | Basic/Performance/Delighter classification |
| OKRs | `/product-os:okrs` | Objectives and Key Results definition |
| Metric Tree | `/product-os:metric-tree` | Hierarchical metric decomposition |
| Roadmap | `/product-os:roadmap` | Now/Next/Later roadmap |
| Opportunity Solution Tree | `/product-os:ost` | Map opportunities to solutions |
| Competitive Analysis | `/product-os:competitive` | Feature/positioning matrix |
| User Research Plan | `/product-os:research-plan` | Study design and recruitment |
| Interview Synthesis | `/product-os:interview-synthesis` | Qualitative data analysis |
| Experiment Design | `/product-os:experiment` | A/B test with sample size formula |
| Stakeholder Update | `/product-os:stakeholder-update` | Exec summary and status |
| Launch Checklist | `/product-os:launch` | GTM and launch readiness |
| Release Notes | `/product-os:release-notes` | User-facing changelog |
| Retrospective | `/product-os:retro` | Post-launch reflection |
| Decision Log | `/product-os:decision-log` | ADR-style product decisions |
| Risk Register | `/product-os:risk-register` | Track and mitigate risks |
| PR/FAQ | `/product-os:prfaq` | Amazon-style press release + FAQ |

---

## Orchestration Protocol

The `/product-os:new-project` command runs the full pipeline:

```
1. INTAKE
   └── Generate intake.md
   └── **CHECKPOINT:** Human approves problem framing
   
2. PM
   └── Generate prd.md, project-brief.md, project-plan.md, raci.md, gantt.md
   └── **CHECKPOINT:** Human approves PRD and plan
   
3. DESIGN
   └── Generate design-brief.md, user-flows.md, wireframes.md, prototype-spec.md, figma-handoff.md
   └── **CHECKPOINT:** Human approves design direction
   
4. CRITIQUE
   └── Generate design-critique.md
   └── **CHECKPOINT:** Human addresses critical findings
   
5. DELIVERY
   └── Generate epics.md, stories.md
   └── **CHECKPOINT:** Human approves stories
   
6. PUBLISH
   └── Create Confluence pages and Jira issues
   └── **CHECKPOINT:** Human confirms publication
```

At each checkpoint, the orchestrator:
1. Presents artifacts for review
2. Waits for explicit approval (`approved`, `yes`, `continue`) or feedback
3. If feedback given, revises artifacts and re-presents
4. Only proceeds after approval

---

## Conventions

### Naming
- Initiative slugs: `kebab-case`, e.g., `customer-onboarding`
- Project slugs: `kebab-case`, e.g., `self-serve-signup`
- File names: Exact match to template names

### Versioning
- All artifacts versioned in git before publishing
- Confluence pages updated (not duplicated) on re-publish
- Jira issues updated via key lookup

### Linking
- All artifacts cross-reference each other
- PRD requirements have unique IDs (e.g., `REQ-001`)
- Stories trace to requirements and designs

### Quality Gates
- No artifact proceeds without meeting its quality checklist
- Critical design critique findings block delivery
- Stories without acceptance criteria are rejected

---

## Extending Product OS

To add a new agent or tool:

1. Create agent definition in `.claude/agents/`
2. Create command in `.claude/commands/`
3. Create template in `templates/`
4. Add documentation in `docs/guides/`
5. Update this file with agent specification
6. Add to command reference in `docs/reference/commands.md`
