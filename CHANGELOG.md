# Changelog

All notable changes to Product OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
