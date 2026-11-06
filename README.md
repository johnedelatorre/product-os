# Product OS

> A portable product management and design operating system for AI-assisted product development.

**PM rigor leads; design serves product strategy.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## What is Product OS?

Product OS is a comprehensive system of AI agents, commands, and templates that guides you from raw requirement to shipped, measured feature. It embeds product management discipline—strategy alignment, business outcomes, prioritization, metrics, stakeholder management, roadmaps, decision-making, and delivery accountability—into every artifact.

**Built for:** Product managers, product designers, and heads of product who want to spend less time on artifact creation and more time on strategic decisions.

**Owner:** John De La Torre-Ugarte — Head of Product / Product Design Lead (25+ years experience, ex-frontend engineer)

---

## Quick Start

### 1. Install into Your Project

**Option A: Clone (recommended)**
```bash
git clone https://github.com/johnedelatorre/product-os.git
cd product-os
./scripts/install.sh /path/to/your/project
```

**Option B: Git Submodule**
```bash
cd your-project
git submodule add https://github.com/johnedelatorre/product-os.git product-os
./product-os/scripts/install.sh . --submodule
```

### 2. Configure

```bash
# Copy environment template
cp .env.example .env

# Edit with your Atlassian credentials
# Get API token: https://id.atlassian.com/manage-profile/security/api-tokens
vim .env

# Edit configuration
vim product-os.config.yaml
```

### 3. Run Your First Project

```bash
# In Claude Code, run the orchestrator
/product-os:new-project \
  --initiative customer-onboarding \
  --project self-serve-signup \
  --input "Users are abandoning signup at 34% rate. Need to improve conversion."
```

The orchestrator guides you through the full pipeline with human checkpoints at each stage.

---

## Pipeline Overview

```
Raw Requirement → Intake → PRD → Design → Prototype → Critique → Delivery → Publish
                    ↓       ↓       ↓         ↓          ↓          ↓         ↓
               intake.md  prd.md  flows.md  prototype  critique  stories  Confluence
                          brief   wireframes   .html    a11y      .md      + Jira
                          plan                review
```

### Stages

| Stage | What Happens | Output |
|-------|--------------|--------|
| **Intake** | Structure raw requirements into problem statement | `intake.md` |
| **PM** | Deep PRD, project brief, plan, RACI, Gantt | `prd.md`, `project-brief.md`, `raci.md`, `gantt.md` |
| **Design** | Design brief, user flows, wireframes | `design-brief.md`, `flows.yaml`, `wireframes.md` |
| **Prototype** | Clickable HTML/React prototype | `prototype.html`, `prompt-pack.md` |
| **Review** | Design critique, UX review, accessibility audit | `design-critique.md`, `ux-review.md`, `accessibility-audit.md` |
| **Delivery** | Epics and stories with acceptance criteria | `epics.md`, `stories.md` |
| **Publish** | Confluence pages + Jira issues | Live docs and tickets |

---

## Agent Roster

### Core Pipeline Agents

| Agent | Command | Purpose |
|-------|---------|---------|
| Orchestrator | `/product-os:new-project` | Run full pipeline with checkpoints |
| Intake Analyst | `/product-os:intake` | Structure raw requirements |
| PRD Author | `/product-os:prd` | Write comprehensive PRD |
| Project Brief | `/product-os:brief` | One-page executive summary |
| Strategist | `/product-os:prioritize` | RICE/WSJF/MoSCoW/Kano |
| Project Planner | `/product-os:plan` | RACI, Gantt, timeline |
| Flow Designer | `/product-os:flows` | User flows, journey maps |
| Wireframer | `/product-os:wireframes` | Lo-fi wireframes |
| Prototyper | `/product-os:prototype` | Clickable prototypes |
| Design Critic | `/product-os:critique` | Visual design critique |
| UX Reviewer | `/product-os:ux-review` | Heuristics evaluation |
| Accessibility Auditor | `/product-os:a11y` | WCAG 2.2 AA audit |
| Delivery Agent | `/product-os:deliver` | Epics and stories |
| Confluence Publisher | `/product-os:publish` | Publish to Confluence |
| Jira Sync | `/product-os:jira-sync` | Create Jira issues |

### Tool Agents

| Agent | Command | Purpose |
|-------|---------|---------|
| OKR Agent | `/product-os:okrs` | Define OKRs and metric trees |
| Roadmap Agent | `/product-os:roadmap` | Now/Next/Later roadmap |
| Competitive Analyst | `/product-os:competitive` | Competitive analysis |
| Experiment Designer | `/product-os:experiment` | A/B test design |
| Risk Manager | `/product-os:risks` | Risk register |
| Decision Logger | `/product-os:decision` | ADR-style decisions |
| Stakeholder Comms | `/product-os:comms` | Updates, release notes |

---

## Key Features

### Discipline Labels on Stories

Every story gets a discipline label (`frontend`, `backend`, `fullstack`) with rationale:

```markdown
**Label:** `backend`
**Rationale:** New API endpoint with aggregation logic. Frontend will consume in separate story.
```

The Confluence backlog page shows **story point subtotals by discipline**, and Jira sync applies labels automatically.

### Gantt-to-Jira Integration

Gantt chart dates and dependencies flow into Jira:
- **Start Date** and **Due Date** fields populated
- **Issue links** created for dependencies (blocks/is blocked by)
- **Jira Plans/Timeline** automatically visualizes the schedule

### Multi-Target Flow Rendering

User flows render from a canonical YAML spec to multiple targets:

```bash
/product-os:flows --from prd.md --targets mermaid,claude-artifact,figjam,excalidraw
```

| Target | Output |
|--------|--------|
| Mermaid | Always generated (source of truth) |
| Claude Artifact | Interactive HTML/SVG |
| FigJam | Via Figma MCP |
| Excalidraw | `.excalidraw` file |
| draw.io | `.drawio` file |
| Lucidchart | CSV import format |

### Figma MCP Integration

When Figma MCP is connected:
- Pull design tokens and frame data
- Audit Figma designs against PRD
- Generate FigJam user flows
- Push wireframes to Figma

Falls back gracefully with manual instructions when MCP is unavailable.

### Claude Artifact Prototypes

Generate single-file, clickable prototypes:
- Self-contained HTML with CSS and JS
- React version for Claude.ai artifacts
- Prompt pack for manual artifact creation
- All screens linked with navigation

---

## Local Workspace Convention

All work is versioned locally before publishing:

```
initiatives/
└── customer-onboarding/          # Initiative
    └── self-serve-signup/        # Project
        ├── intake.md
        ├── prd.md
        ├── project-brief.md
        ├── project-plan.md
        ├── raci.md
        ├── gantt.md
        ├── design-brief.md
        ├── flows.yaml             # Canonical flow spec
        ├── flows.md
        ├── wireframes.md
        ├── prototype.html
        ├── design-critique.md
        ├── ux-review.md
        ├── accessibility-audit.md
        ├── epics.md
        ├── stories.md
        ├── publish-manifest.json  # Confluence page IDs
        └── jira-sync-manifest.json # Jira issue keys
```

---

## Confluence Structure

```
Product Space
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]
            ├── Project Brief
            ├── PRD
            ├── Project Plan
            ├── RACI
            ├── Gantt Chart
            ├── Design Brief
            ├── User Flows
            ├── Wireframes
            ├── Design Critique
            ├── UX Review
            ├── Accessibility Audit
            ├── Backlog  ← With discipline columns
            └── Decision Log
```

---

## Configuration

### product-os.config.yaml

```yaml
confluence:
  base_url: "https://yourcompany.atlassian.net/wiki"
  space_key: "PROD"
  initiatives_parent_page_id: "123456789"

jira:
  base_url: "https://yourcompany.atlassian.net"
  project_key: "PROJ"
  custom_fields:
    story_points: "customfield_10016"
    epic_link: "customfield_10014"
  discipline_mapping: "labels"  # or "components"
```

### .env

```
ATLASSIAN_EMAIL=your@email.com
ATLASSIAN_API_TOKEN=your-api-token
```

See `docs/setup/` for detailed configuration guides.

---

## Documentation

| Document | Description |
|----------|-------------|
| [CLAUDE.md](CLAUDE.md) | Root agent instructions |
| [AGENTS.md](AGENTS.md) | Agent orchestration and roster |
| [docs/guides/](docs/guides/) | Deep-dive guides per capability |
| [docs/reference/](docs/reference/) | Command reference |
| [docs/setup/](docs/setup/) | Confluence, Jira, Figma MCP setup |
| [examples/](examples/) | Worked example project |

---

## Repository Structure

```
product-os/
├── CLAUDE.md                 # Root agent instructions
├── AGENTS.md                 # Agent orchestration
├── README.md                 # This file
├── LICENSE                   # MIT License
├── CHANGELOG.md              # Version history
├── CONTRIBUTING.md           # How to contribute
├── product-os.config.yaml    # Configuration template
├── .env.example              # Environment variables template
├── .gitignore
├── .claude/
│   ├── agents/               # 27 specialist agents
│   └── commands/             # Slash commands
├── templates/                # Document templates
│   ├── intake/
│   ├── pm/
│   ├── design/
│   ├── delivery/
│   └── tools/
├── docs/                     # Documentation
│   ├── guides/
│   ├── reference/
│   └── setup/
├── examples/                 # Worked example
│   └── acme-dashboard/
├── initiatives/              # Your project workspace
└── scripts/
    ├── install.sh            # Installation script
    └── atlassian-fallback.py # REST API fallback
```

---

## GitHub Repository

**Description:** Product management and design operating system for AI-assisted product development

**Topics:** `product-management`, `product-design`, `claude-code`, `ai-agents`, `prd`, `user-flows`, `wireframes`, `confluence`, `jira`, `design-system`

---

## License

MIT License © 2026 John De La Torre-Ugarte

See [LICENSE](LICENSE) for full text.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
