# Changelog

All notable changes to Product OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
