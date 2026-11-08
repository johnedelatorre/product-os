# Changelog

All notable changes to Product OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-11-08

### Added
- **Claude Code plugin** — `.claude-plugin/plugin.json` (plugin `product-os`, commands from `./.claude/commands/`) and `.claude-plugin/marketplace.json` (marketplace `product-os`). Commands load namespaced as `/product-os:<command>`.
- **Installer `--register-plugin`** — Enables the plugin in the target project (`claude plugin marketplace add … --scope project` + `claude plugin install product-os@product-os --scope project`).
- **YAML frontmatter** on all 46 commands and 39 agents; agents now register as Claude Code subagents.
- **Validator checks** — `scripts/validate.sh` verifies command/agent frontmatter, plugin manifests, and that every `/product-os:<command>` reference resolves to a real command file.
- **Guide agent doc** — `docs/guides/agents/guide.md`; agent index now lists all 39 agents.
- **Full command reference** — `docs/reference/commands.md` documents all 46 commands, grouped by phase.
- **Guide existing-work detection** — On start, the guide scans the project directory and marks existing artifacts `complete`/`in_progress` in `progress.yaml` instead of recreating them.

### Changed
- **Renamed commands** — The 19 `product-os-*.md` command files dropped the prefix (`guide.md`, `status.md`, `next.md`, `gate.md`, `handover.md`, …) so `/product-os:<x>` maps to `.claude/commands/<x>.md`.
- **Installer** — No longer copies commands into the target's `.claude/commands/` (un-namespaced `/status`, `/plan`, `/next` collided with Claude Code built-ins). A reference copy goes to `.claude/product-os/commands/` (symlinked in submodule mode). The installer lists old Product OS command files left in `.claude/commands/` so they can be removed.
- **Atlassian integration** — Confluence Publisher and Jira Sync agents/skills prefer connected Atlassian MCP tools, search before creating, update in place, record IDs in `publish-manifest.json` / `jira-sync-manifest.json`, read field IDs from the instance, handle team-managed Jira projects (`parent` field, "Story point estimate"), and always show proposed changes and require explicit human approval before any write. `.env` is only needed for the REST fallback.
- **Atlassian REST fallback** — Cloud search path fixed.
- **progress.yaml location** standardized on `initiatives/<initiative>/<project>/progress.yaml`; guide example updated to schema v1.1.
- **Accessibility** — WCAG 2.2 AA everywhere; touch targets 24×24 CSS px minimum (2.5.8, AA), 44×44 px recommended.

### Fixed
- 26 references to nonexistent commands (e.g. `/product-os:rice`, `/product-os:stories`, `/product-os:resume`) now point to real commands (`/product-os:prioritize --framework rice`, `/product-os:deliver`, re-running `/product-os:new-project`, …).
- AGENTS.md pointed at nonexistent agent files and a 6-stage pipeline; it now references the real agent files and matches the orchestrator's 7 stages.
- README: plugin install flow, "Upgrading from ≤1.4" note, approval-gated publishing wording, all 40 skills listed, PRD section count (19).
- CLAUDE.md: workspace file list (`flows.yaml`/`flows.md`, `prototype.html`, `progress.yaml`, `HANDOVER.md`), Atlassian MCP-first configuration.
- `shipping-artifacts` skill is now linked from `/product-os:audit-intent` and `/product-os:release-gate`.
- Guide: `--skip` and `<phase>` documented; `/product-os:prd --continue` replaced with a real invocation; Context Freshness links its skill.

## [1.4.0] - 2026-11-08

### Added

#### PRD Quality Improvements
- **PRD Template** — New comprehensive 19-section template at `templates/pm/prd.md`
- **PRD Stages** — Early (hypotheses), Defined (requirements), Delivery-ready (evidence-backed)
- **Testable Hypotheses** — New section with validation status and provenance
- **Alternatives Considered** — Document options not chosen with trade-offs
- **Stop Criteria** — Define halt/kill conditions with owners and SLAs
- **AI Feature Specification** — Optional section for AI/ML features

#### Multi-Perspective PRD Review
- **PRD Review Template** — `templates/pm/prd-review.md` for synthesis
- **Review Command** — `/product-os:review-prd` synthesizes 6 perspectives
- **Structured Output** — Blockers, gaps, suggestions, conflicts with resolution ownership
- **Perspectives** — Feasibility, UX, strategy, research, privacy/security, customer

#### Estimation Improvements
- **Estimation Skill** — New `.claude/skills/estimation.md` with phase-appropriate methods
- **T-shirt Sizing** — For initiative/roadmap level (±100%)
- **Range Estimates** — For epic level with confidence (±50%)
- **Fibonacci Points** — For sprint-ready stories (±30%)
- **Spike Handling** — TBD stories with provisional estimates

#### Traceability
- **Traceability Template** — `templates/delivery/traceability.md`
- **REQ → Epic → Story → Test** linkage
- **Review Finding Resolution** tracking
- **Gap Documentation** — Explicit reasons required, not just missing

#### Enhanced Gates
- **Gate Status Types** — Pass, Fail, Conditional, N/A, Not Verified
- **Evidence Requirements** — Each criterion needs proof
- **Not Verified Handling** — Investigation plan required

#### Decision Records
- **Reversibility Assessment** — Easy, Hard, Irreversible
- **Review Triggers** — Conditions for re-evaluation
- **Trade-off Summary** — Table comparing options
- **Decision Roles** — Separate from project RACI

#### Context Freshness
- **Context Freshness Skill** — `.claude/skills/context-freshness.md`
- **Staleness Thresholds** — Per context type
- **Verification Checklist** — Pre-launch context validation

#### Installer Improvements
- **Non-destructive** — Backs up modified files, preserves CLAUDE.md/AGENTS.md
- **Skills Included** — Fixed bug where skills were omitted
- **Idempotent** — Safe for repeat runs
- **Test Suite** — `scripts/test-install.sh` with 14 test cases

#### Validation
- **Static Validation** — `scripts/validate.sh` checks template paths, completeness
- **Template Integrity** — Verifies referenced templates exist
- **Agent Coverage** — Verifies clear-output style applied

### Changed

#### Workflow Updates
- **Orchestrator** — Added PRD Review stage, traceability generation, estimation guidance
- **Guide Agent** — Updated phases with PRD stages, review, enhanced gates
- **Guided Workflow Skill** — Schema v1.1 with artifact stages, structured exit criteria
- **Progress Schema** — Added `schema_version`, `artifact_stages`, `reviews`, structured `exit_criteria`

#### Agent Improvements
- **Delivery Agent** — Added spike stories, TBD handling, testing/observability requirements, rollout requirements
- **Gate Keeper** — Pass/fail/NA/not-verified with evidence
- **Decision Logger** — Reversibility, review triggers, trade-off summary
- **Metrics Designer** — Stop criteria with owners and SLAs
- **UX Researcher** — Contradictions, unsupported assumptions, evidence gaps

#### Documentation
- **README** — What's New section, artifact connection diagram, installation guide
- **Guided Workflow Playbook** — Updated phases, PRD stages, estimation, gates

### Counts
- Agents: 39 (unchanged)
- Skills: 26 → 29
- Commands: 41 → 42

---

## [1.3.0] - 2026-11-06

### Added

#### Guided Mode
- **Guide Agent** — Walks PMs through all 9 phases step-by-step with progress tracking
- **`progress.yaml`** — Per-initiative state file tracking current phase, document status, and exit criteria
- **Phase System** — 9 phases: Intake → Discovery → Prioritize → Define → Design → Review → Deliver → Launch → Measure
- **Skip Handling** — Optional phases can be skipped with documented risks

#### Commands
- `/product-os:guide` — Start or resume guided mode, or jump to a specific phase
- `/product-os:status` — Show current progress through the 9 phases
- `/product-os:next` — Execute the next recommended step automatically

#### Skills
- **Guided Workflow Skill** — Progress schema, phase order, exit criteria, and state management

#### Documentation
- `docs/guides/guided-workflow.md` — Full playbook with phase-by-phase checklists
- Mermaid sequence diagram showing Guide ↔ Specialist ↔ Progress flow

### Changed
- Agent count increased from 38 to 39
- Skill count increased from 26 to 27
- Command count increased from 38 to 41
- CLAUDE.md updated with Guided Mode section
- Orchestrator updated to reference Guide agent for phase transitions
- README updated with Guided Mode section and sequence diagram

---

## [1.2.0] - 2026-11-06

### Added

#### Clear Output Style (Always On)
- **Clear Output Skill** — 10 rules for actionable output, adapted from ayghri/i-have-adhd (MIT)
- **TL;DR Blocks** — Every document template now starts with problem, solution, next action
- **NOTICE.md** — Third-party attribution file

#### Style Rules
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

### Changed
- All 38 agents now reference clear-output.md as a global rule
- CLAUDE.md includes output style section
- AGENTS.md includes global output style section
- All templates include TL;DR blocks at top
- README includes output style section with 10 rules
- Skill count increased from 25 to 26

---

## [1.1.0] - 2026-11-06

### Added

#### Discovery Agents
- **Opportunity Tree Agent** — Outcome-opportunity-solution trees for structured discovery
- **Hypothesis Logger Agent** — Track assumptions through validation with outcomes
- **Market Analyst Agent** — TAM/SAM/SOM sizing, trends, segments, positioning

#### Metrics & Measurement Agents
- **Metrics Designer Agent** — North star, input metrics, guardrails, success criteria
- **Event Tracker Agent** — Analytics tracking plans for Pendo, Amplitude, Mixpanel, Segment
- **Post-Launch Reviewer Agent** — Compare results to PRD goals, create follow-up intake

#### Launch & GTM Agents
- **Launch Manager Agent** — Release notes, sales/support enablement, changelog entries

#### Governance Agents
- **Artifact Registry Agent** — Track Figma, FigJam, Loom, prototypes with link validation
- **Dependency Tracker Agent** — Dependencies and risks integrated with RACI
- **Gate Keeper Agent** — Definition of Ready and Definition of Done validation
- **Debt Tracker Agent** — Technical and design debt with prioritization

#### Skills
- Artifact registry management
- Opportunity solution trees
- Hypothesis logging and validation
- Metrics framework design
- Event tracking specifications
- Post-launch review process
- Launch and GTM materials
- Dependency and risk tracking
- DoR/DoD gate criteria
- Tech and design debt tracking

#### Commands
- `/product-os:artifacts` — Manage artifact registry
- `/product-os:opportunity-tree` — Create opportunity trees
- `/product-os:hypotheses` — Manage hypothesis log
- `/product-os:market` — Create market analysis
- `/product-os:metrics` — Design metrics framework
- `/product-os:tracking` — Create event tracking plan
- `/product-os:review-launch` — Post-launch review
- `/product-os:launch` — Create launch materials
- `/product-os:dependencies` — Manage dependencies
- `/product-os:gate` — Run DoR/DoD checks
- `/product-os:debt` — Manage debt tracker

### Changed

- Expanded orchestrator to include all new agents
- Updated README with new PM-led workflow diagram
- Reorganized agent documentation by category
- Increased agent count from 27 to 38
- Increased skill count from 15 to 25
- Increased command count from 25 to 38

---

## [1.0.0] - 2026-11-06

### Added

#### Core Pipeline
- **Orchestrator Agent** — Coordinates full pipeline with human checkpoints
- **Intake Analyst Agent** — Structures raw requirements into problem statements
- **PRD Author Agent** — Generates comprehensive PRDs with 18 sections
- **Project Brief Agent** — Creates one-page executive summaries
- **Strategist Agent** — RICE, WSJF, MoSCoW, and Kano prioritization
- **Project Planner Agent** — RACI matrix, Gantt charts, project timelines

#### Design Agents
- **Product Designer Agent** — Design briefs from PRD
- **Flow Designer Agent** — User flows, journey maps, sitemaps with multi-target rendering
- **Wireframer Agent** — ASCII and HTML low-fidelity wireframes
- **Prototyper Agent** — Clickable HTML/React prototypes with Claude artifact support
- **Figma Agent** — Figma MCP integration for tokens, audit, and FigJam generation

#### Review Agents
- **Design Critic Agent** — Structured visual critique with severity ratings
- **UX Reviewer Agent** — Nielsen's heuristics, Laws of UX, pattern evaluation
- **Accessibility Auditor Agent** — WCAG 2.2 AA checklist with axe-core automation

#### Delivery & Publishing
- **Delivery Agent** — Epics and stories with discipline labels (frontend/backend/fullstack)
- **Confluence Publisher Agent** — Full Confluence hierarchy with backlog tables
- **Jira Sync Agent** — Idempotent sync with Gantt dates and dependencies

#### Tool Agents
- **OKR Agent** — Objectives, Key Results, and metric trees
- **Roadmap Agent** — Now/Next/Later roadmaps
- **Competitive Analyst Agent** — Feature matrices and SWOT
- **Experiment Designer Agent** — A/B test design with sample size formulas
- **Risk Manager Agent** — Risk register with mitigations
- **Decision Logger Agent** — ADR-style decision records
- **Retro Facilitator Agent** — Retrospective templates
- **PR/FAQ Author Agent** — Amazon-style press release + FAQ
- **UX Researcher Agent** — Research plans and synthesis
- **Stakeholder Comms Agent** — Updates, release notes, launch communications

#### Features
- **Canonical Flow Spec** — YAML format as single source of truth
- **Multi-target Flow Rendering** — Mermaid, Claude artifacts, FigJam, Excalidraw, draw.io, Lucidchart, Miro, Whimsical
- **Discipline Labels** — Frontend/backend/fullstack with story point subtotals
- **Gantt-to-Jira Integration** — Dates and dependencies flow to Jira Plans
- **Claude Artifact Prototypes** — Single-file clickable prototypes with prompt pack
- **Figma MCP Integration** — With graceful fallback

#### Documentation
- Comprehensive README with quick start
- CLAUDE.md and AGENTS.md for agent orchestration
- Command reference for all slash commands
- Setup guides for Confluence, Jira, and Figma MCP
- Worked example project (Acme Dashboard)

#### Infrastructure
- `product-os.config.yaml` — Full configuration template
- `.env.example` — Environment variables template
- `scripts/install.sh` — Installation script (copy, submodule, symlink)
- `scripts/atlassian-fallback.py` — REST API fallback for Confluence and Jira
