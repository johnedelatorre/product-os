# Product OS in claude.ai

> **TL;DR:** Create a Claude Project, paste [`project-instructions.md`](project-instructions.md) into its Instructions, upload the 22 starter files listed below as Knowledge, then say "Start Product OS guided mode for initiative X, project Y." Add more agent files later as you need them.

## Setup

1. **Download Product OS.** On GitHub choose Code → Download ZIP, then unzip it.
2. **Show hidden folders.** The agent and skill files live in a folder named `.claude`, which is hidden by default. On a Mac, press **Cmd+Shift+.** in Finder to show it. On Windows, turn on **View → Show → Hidden items** in File Explorer.
3. **Create a Project** in claude.ai (for example "Product OS – Growth team").
4. **Instructions:** open [`project-instructions.md`](project-instructions.md), copy everything below its line, and paste it into the project's **Instructions**. Fill in your Confluence space and Jira project under "Our team", or delete those lines.
5. **Knowledge:** upload the starter files below.
6. **Confluence and Jira (optional):** enable the Atlassian connector if your workspace offers it. Claude shows the publish plan and waits for your OK before any write.
7. **Start:** open a chat in the project and say *"Start Product OS guided mode for initiative customer-onboarding, project self-serve-signup."*

**Tip:** before uploading, copy the starter files into one new folder (for example `product-os-starter`). Then you upload one folder's contents in one go, and you don't have to dig through hidden folders in the upload dialog.

## Starter Knowledge Set

These files cover guided mode and the core path: intake, PRD, metrics, design, reviews and stories. All paths are relative to the unzipped Product OS folder.

**Agent roles** (`.claude/agents/`)

| File | Role |
|------|------|
| `.claude/agents/guide.md` | Guide: runs guided mode through the nine phases |
| `.claude/agents/intake-analyst.md` | Intake Analyst: turns a request into a problem statement |
| `.claude/agents/prd-author.md` | PRD Author: writes the PRD |
| `.claude/agents/metrics-designer.md` | Metrics Designer: north star, inputs, guardrails, stop criteria |
| `.claude/agents/product-designer.md` | Product Designer: design brief |
| `.claude/agents/flow-designer.md` | Flow Designer: user flow diagrams |
| `.claude/agents/wireframer.md` | Wireframer: low-fi wireframes |
| `.claude/agents/prototyper.md` | Prototyper: clickable prototype |
| `.claude/agents/design-critic.md` | Design Critic: visual design critique |
| `.claude/agents/ux-reviewer.md` | UX Reviewer: usability review |
| `.claude/agents/accessibility-auditor.md` | Accessibility Auditor: WCAG 2.2 AA audit |
| `.claude/agents/delivery-agent.md` | Delivery Agent: epics and stories |

**Playbooks and format** (`.claude/skills/`, `docs/`)

| File | What it sets |
|------|--------------|
| `.claude/skills/clear-output.md` | How every reply and document is written |
| `.claude/skills/doc-hygiene.md` | Current state only, no version history |
| `.claude/skills/guided-workflow.md` | Phases, `progress.yaml` and open items |
| `docs/reference/document-format.md` | The standard header, Confluence page tree, Jira epic and story formats |

**Templates** (`templates/`)

| File | Document |
|------|----------|
| `templates/pm/prd.md` | PRD |
| `templates/pm/metrics-framework.md` | Metrics framework |
| `templates/design/design-brief.md` | Design brief |
| `templates/design/design-critique.md` | Design critique |
| `templates/delivery/epic.md` | Jira epic |
| `templates/delivery/user-story.md` | Jira story |

## Add More Agents Later

Upload more files from `.claude/agents/`, `.claude/skills/` and `templates/` when you reach a step that needs them. For example:

| When you need | Upload |
|---------------|--------|
| Discovery | `.claude/agents/opportunity-tree.md`, `.claude/agents/hypothesis-logger.md`, `.claude/agents/market-analyst.md` |
| Prioritization and roadmap | `.claude/agents/strategist.md`, `.claude/agents/roadmap-agent.md`, `.claude/skills/prioritization.md` |
| Project brief and plan | `.claude/agents/project-brief.md`, `.claude/agents/project-planner.md` |
| Definition of Ready gate | `.claude/agents/gate-keeper.md` |
| Publishing | `.claude/agents/confluence-publisher.md`, `.claude/agents/jira-sync.md` |
| Launch and measure | `.claude/agents/launch-manager.md`, `.claude/agents/post-launch-reviewer.md` |

If you ask for an agent whose file isn't uploaded, Claude tells you which file to add.

## Working in claude.ai

1. **Ask by name or purpose:** "Run intake on this Slack thread", "Act as the Wireframer and make wireframes from flows.md".
2. **No slash commands.** The `/product-os:` commands and flags such as `--targets claude-artifact,figjam` are Claude Code only. Here, ask in plain language.
3. **Diagrams:** if a flow diagram doesn't render, ask Claude to "show this flow as an artifact" or "as a diagram".
4. **Save progress:** at the end of a session, ask for the updated `progress.yaml` and a `HANDOVER.md`. Download both and upload them to the next chat (or to the project knowledge) to pick up where you left off.
5. **Keep documents:** download them, publish them to Confluence after you approve, or add them to the project knowledge so later chats can build on them.

Full platform comparison: [Installation and Platform Setup → claude.ai](../docs/setup/installation.md#claudeai-setup).
