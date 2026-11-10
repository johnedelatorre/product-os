# Product OS — Agent Orchestration

> This document defines how Product OS agents work together. **PM rigor leads; design serves product strategy.**

## Platform Compatibility

Product OS works in both **Claude Code** and **Cursor**:

| Platform | Agents | Commands | Skills | Native Adapters |
|----------|--------|----------|--------|-----------------|
| Claude Code | 40 (subagents) | 47 (plugin slash commands, `/product-os:*`) | 41 (reference docs) | Full (Task tool) |
| Cursor | 40 | Role-based invocation | 41 | 3 (`.cursor/agents/`) |

### Cursor Native Adapters

Product OS provides 3 native Cursor agent adapters:
- `product-os-guide.md` — Start/resume workflow
- `prd-author.md` — Write PRDs
- `intake-analyst.md` — Structure requirements

### Role-Based Invocation (All 40 Roles)

For any role not in `.cursor/agents/`, use:
```
Read .claude/agents/[agent-name].md and [task]
```

See `docs/guides/platform-compatibility.md` for full setup.

## Global Output Style

**All agents follow the Clear Output Style** defined in `.claude/skills/clear-output.md`. This is always on—no command needed.

Key rules: Lead with the next action. Number multi-step tasks. End with one concrete next step. No preamble, no recap, no closers. Cap lists to 5 items. Give specific time estimates.

Documents include TL;DR blocks, scannable headings, and numbered steps while maintaining full depth.

**Current state only.** Docs, Confluence pages, epics and tickets show the final state: no version banners, history blocks, change narratives or retired items. See `.claude/skills/doc-hygiene.md`; `/product-os:cleanup` cleans docs that already carry history.

---

## Agent Roster (40 Agents)

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

### Governance Agents (6)

| Agent | File | Role | Command |
|-------|------|------|---------|
| Artifact Registry | `artifact-registry.md` | Track design artifacts | `/product-os:artifacts` |
| Dependency Tracker | `dependency-tracker.md` | Dependencies + risks + RACI | `/product-os:dependencies` |
| Risk Manager | `risk-manager.md` | Risk register | `/product-os:risks` |
| Debt Tracker | `debt-tracker.md` | Tech and design debt | `/product-os:debt` |
| Decision Logger | `decision-logger.md` | ADR-style decisions | `/product-os:decision` |
| Doc Cleaner | `doc-cleaner.md` | Strip version history from docs, pages and tickets | `/product-os:cleanup` |

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

The orchestrator runs 7 stages (plus an optional PRD review), matching `.claude/agents/orchestrator.md`:

```
┌─────────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATOR                                  │
│              /product-os:new-project                                │
│         Coordinates pipeline, enforces checkpoints                  │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
 1. INTAKE ──▶ 2. PRODUCT MANAGEMENT ──▶ (2B. PRD REVIEW) ──▶ 3. DESIGN
                                                                   │
                                                                   ▼
 7. PUBLISHING ◀── 6. DELIVERY ◀── 5. DESIGN REVIEW ◀── 4. PROTOTYPE & FIGMA
 (human approval required before any Confluence/Jira write)
```

## Pipeline Flow

### Stage 1: Intake
**Agent:** `.claude/agents/intake-analyst.md`  
**Command:** `/product-os:intake`  
**Input:** Raw requirement from any source  
**Output:** `intake.md` — structured problem/opportunity statement  
**Checkpoint:** Human approves problem framing before PM work begins

### Stage 2: Product Management
**Agents:** `.claude/agents/prd-author.md`, `.claude/agents/strategist.md`, `.claude/agents/project-brief.md`, `.claude/agents/project-planner.md`  
**Commands:** `/product-os:prd`, `/product-os:prioritize`, `/product-os:brief`, `/product-os:plan`  
**Input:** Approved intake document  
**Output:** `prd.md`, priority scores, `project-brief.md`, `project-plan.md`, `raci.md`, `gantt.md`  
**Checkpoint:** Human approves PRD stage and plan before design begins

### Stage 2B: PRD Review (if PRD stage is Defined or Delivery-ready)
**Command:** `/product-os:review-prd`  
**Output:** `prd-review.md` — blockers, gaps, suggestions, conflicts  
**Checkpoint:** Blockers resolved before proceeding (skipped for Early PRDs)

### Stage 3: Design
**Agents:** `.claude/agents/product-designer.md`, `.claude/agents/flow-designer.md`, `.claude/agents/wireframer.md`  
**Commands:** `/product-os:design-brief`, `/product-os:flows`, `/product-os:wireframes`  
**Input:** Approved PRD  
**Output:** `design-brief.md`, `flows.yaml`, `flows.md`, `wireframes.md`  
**Checkpoint:** Human approves design direction

### Stage 4: Prototype & Figma
**Agents:** `.claude/agents/prototyper.md`, `.claude/agents/figma-agent.md` (parallel when Figma MCP is available)  
**Commands:** `/product-os:prototype`, `/product-os:figma`  
**Input:** Approved wireframes and flows  
**Output:** `prototype.html`, `prototype-react.tsx`, Figma sync  
**Checkpoint:** Human approves prototype

### Stage 5: Design Review
**Agents:** `.claude/agents/design-critic.md`, `.claude/agents/ux-reviewer.md`, `.claude/agents/accessibility-auditor.md`  
**Commands:** `/product-os:critique`, `/product-os:ux-review`, `/product-os:a11y`  
**Input:** Design artifacts + PRD  
**Output:** `design-critique.md`, `ux-review.md`, `accessibility-audit.md`  
**Checkpoint:** Human addresses critical findings before delivery

### Stage 6: Delivery
**Agents:** `.claude/agents/delivery-agent.md`, `.claude/agents/gate-keeper.md`  
**Commands:** `/product-os:deliver`, `/product-os:gate`  
**Input:** Approved design + PRD  
**Output:** `epics.md`, `stories.md`, `backlog.csv`, `gate-report.md`, `traceability.md`  
**Checkpoint:** Human approves stories and gate status (DoR failures block sprint entry)

### Stage 7: Publishing
**Agents:** `.claude/agents/confluence-publisher.md`, `.claude/agents/jira-sync.md`  
**Commands:** `/product-os:publish`, `/product-os:jira-sync`  
**Input:** All approved artifacts  
**Output:** Confluence pages, Jira epics/stories with links, `publish-manifest.json`, `jira-sync-manifest.json`  
**Checkpoint:** Proposed changes are shown first; nothing is written to Confluence or Jira without explicit human approval

---

## Agent Definitions

The definitions below summarize each pipeline role. The full instructions live in the agent files listed under each heading.

### Intake Agent

**File:** `.claude/agents/intake-analyst.md`

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

### PM Agents

**Files:** `.claude/agents/prd-author.md`, `.claude/agents/strategist.md`, `.claude/agents/project-brief.md`, `.claude/agents/project-planner.md`

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

### Design Agents

**Files:** `.claude/agents/product-designer.md`, `.claude/agents/flow-designer.md`, `.claude/agents/wireframer.md`, `.claude/agents/prototyper.md`, `.claude/agents/figma-agent.md`

**Role:** Translate PRD requirements into design artifacts that solve user problems within product constraints.

**Inputs:**
- Approved PRD
- Design system/brand guidelines (if available)
- Existing UI patterns in the product

**Outputs:**
- `design-brief.md` — Design goals, constraints, principles for this project
- `flows.yaml` + `flows.md` — Canonical flow spec and Mermaid diagrams for all flows
- `wireframes.md` — ASCII or HTML/SVG low-fidelity wireframes
- `prototype.html` / `prototype-react.tsx` — Clickable prototype
- Figma sync (tokens, audit, FigJam flows) when Figma MCP is connected

**Quality Checklist:**
- [ ] Design brief ties every decision to PRD requirements
- [ ] User flows cover: happy path, errors, edge cases, empty states
- [ ] Wireframes annotated with interaction notes
- [ ] Accessibility considerations embedded (not an afterthought)
- [ ] Responsive behavior specified
- [ ] Prototype includes all states and transitions
- [ ] Figma sync (if used) reflects component specs, spacing, typography

---

### Design Review Agents

**Files:** `.claude/agents/design-critic.md`, `.claude/agents/ux-reviewer.md`, `.claude/agents/accessibility-auditor.md`

**Role:** Evaluate design artifacts against established heuristics, accessibility standards, consistency rules, and PRD alignment.

**Inputs:**
- Design artifacts (brief, flows, wireframes)
- PRD for alignment check
- Design system (if available)

**Outputs:**
- `design-critique.md`, `ux-review.md`, `accessibility-audit.md` — Severity-rated findings

**Evaluation Dimensions:**
1. **Nielsen's Heuristics** — Visibility, match to real world, user control, consistency, error prevention, recognition over recall, flexibility, aesthetic minimalism, error recovery, help/docs
2. **Accessibility (WCAG 2.2 AA)** — Perceivable, operable, understandable, robust
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

**Files:** `.claude/agents/delivery-agent.md`, `.claude/agents/gate-keeper.md`

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

### Publishing Agents

**Files:** `.claude/agents/confluence-publisher.md`, `.claude/agents/jira-sync.md`

**Role:** After explicit human approval of the proposed changes, publish artifacts to Confluence and create or update the corresponding Jira issues.

**Inputs:**
- All approved artifacts
- `product-os.config.yaml` — Confluence/Jira configuration
- Connected Atlassian MCP tools (preferred; no credentials needed), or `.env` credentials for the REST fallback

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
            ├── 10. Prototype
            ├── 11. Design Critique
            ├── 12. Epics & Stories
            └── 13. Decision Log
```

**Jira Structure:**
- Epic per PRD goal
- Stories linked to parent epic (team-managed projects use the `parent` field)
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
| RICE Scoring | `/product-os:prioritize --framework rice` | Prioritize features by Reach × Impact × Confidence ÷ Effort |
| WSJF Scoring | `/product-os:prioritize --framework wsjf` | Weighted Shortest Job First prioritization |
| MoSCoW | `/product-os:prioritize --framework moscow` | Must/Should/Could/Won't categorization |
| Kano Analysis | `/product-os:prioritize --framework kano` | Basic/Performance/Delighter classification |
| OKRs | `/product-os:okrs` | Objectives and Key Results definition |
| Metric Tree | `/product-os:okrs` (includes metric tree) | Hierarchical metric decomposition |
| Roadmap | `/product-os:roadmap` | Now/Next/Later roadmap |
| Opportunity Solution Tree | `/product-os:opportunity-tree` | Map opportunities to solutions |
| Competitive Analysis | `/product-os:competitive` | Feature/positioning matrix |
| User Research Plan | `/product-os:research plan` | Study design and recruitment |
| Interview Synthesis | `/product-os:research synthesize` | Qualitative data analysis |
| Experiment Design | `/product-os:experiment` | A/B test with sample size formula |
| Stakeholder Update | `/product-os:comms --type update` | Exec summary and status |
| Launch Checklist | `/product-os:launch` | GTM and launch readiness |
| Release Notes | `/product-os:comms --type release-notes` (or `/product-os:launch`) | User-facing changelog |
| Retrospective | `/product-os:retro` | Post-launch reflection |
| Decision Log | `/product-os:decision` | ADR-style product decisions |
| Risk Register | `/product-os:risks` | Track and mitigate risks |
| PR/FAQ | `/product-os:prfaq` | Amazon-style press release + FAQ |

---

## Orchestration Protocol

The `/product-os:new-project` command runs the full pipeline (see `.claude/agents/orchestrator.md`):

```
1. INTAKE
   └── Generate intake.md
   └── **CHECKPOINT:** Human approves problem framing

2. PRODUCT MANAGEMENT
   └── Generate prd.md, priority scores, project-brief.md, project-plan.md, raci.md, gantt.md
   └── **CHECKPOINT:** Human approves PRD stage and plan

2B. PRD REVIEW (Defined / Delivery-ready PRDs only)
   └── Generate prd-review.md
   └── **CHECKPOINT:** Blockers resolved

3. DESIGN
   └── Generate design-brief.md, flows.yaml, flows.md, wireframes.md
   └── **CHECKPOINT:** Human approves design direction

4. PROTOTYPE & FIGMA
   └── Generate prototype.html, prototype-react.tsx; Figma sync if MCP connected
   └── **CHECKPOINT:** Human approves prototype

5. DESIGN REVIEW
   └── Generate design-critique.md, ux-review.md, accessibility-audit.md
   └── **CHECKPOINT:** Human addresses critical findings

6. DELIVERY
   └── Generate epics.md, stories.md, gate-report.md, traceability.md
   └── **CHECKPOINT:** Human approves stories and gate status

7. PUBLISHING
   └── Show proposed Confluence pages and Jira issues, then write only after approval
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
