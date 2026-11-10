# Platform Compatibility Guide

> Product OS works in claude.ai, Claude Code and Cursor. This guide explains setup, capabilities, and differences.

## TL;DR

- **Shared canonical content:** `.claude/` contains all agents, skills, commands
- **Claude Code commands:** served by the `product-os` plugin (`.claude-plugin/`) as `/product-os:<command>`
- **Both platforms read CLAUDE.md/AGENTS.md** automatically
- **Cursor native support:** `.cursor/rules/` (MDC format) + `.cursor/agents/`
- **Progress/handover:** Portable across platforms

## Platform Capabilities

| Capability | claude.ai | Claude Code | Cursor | Notes |
|------------|-----------|-------------|--------|-------|
| Read `.claude/` content | ✅ Uploaded as project knowledge | ✅ | ✅ | Canonical location |
| Read CLAUDE.md/AGENTS.md | ✅ CLAUDE.md as project instructions | ✅ | ✅ Auto-applied | |
| Slash commands | ❌ Ask in plain language | ✅ Via the `product-os` plugin (`/product-os:*`) | ❌ | Role-based invocation instead |
| Native subagents | ❌ One role at a time | ✅ `.claude/agents/*.md` (YAML frontmatter) | Partial | Cursor: 3 adapters in `.cursor/agents/` |
| Project rules | Project instructions | N/A | ✅ `.cursor/rules/*.mdc` | MDC format with frontmatter |
| Native agents | N/A | N/A | ✅ `.cursor/agents/*.md` | YAML frontmatter |
| Confluence / Jira | Atlassian connector (if enabled) | Atlassian MCP or REST fallback | Atlassian MCP or REST fallback | Approval before every write |
| Progress tracking | Ask for `progress.yaml`; re-upload to resume | ✅ | ✅ | Shared `progress.yaml` |
| Session handover | Ask for `HANDOVER.md`; re-upload to resume | ✅ | ✅ | Shared `HANDOVER.md` |

claude.ai setup steps: [Installation and Platform Setup → claude.ai](../setup/installation.md#claudeai-setup).

## Installation

### Fresh Install (Both Platforms)

```bash
git clone https://github.com/johnedelatorre/product-os.git
cd product-os
./scripts/install.sh /path/to/your/project --register-plugin
```

`--register-plugin` enables the Claude Code plugin in the target project (needs the `claude` CLI). Skip it for Cursor-only installs.

### Installer Modes

| Mode | What Gets Installed |
|------|---------------------|
| `--platform both` (default) | `.claude/` + `.cursor/` + CLAUDE.md + AGENTS.md |
| `--platform claude` | `.claude/` + CLAUDE.md + AGENTS.md |
| `--register-plugin` (with `claude`/`both`) | Also enables the `product-os` plugin for the project |
| `--platform cursor` | `.claude/` + `.cursor/` + CLAUDE.md + AGENTS.md |

**Note:** All modes install `.claude/` because it contains the canonical content that both platforms read: `.claude/agents/`, `.claude/skills/`, and a reference copy of the commands in `.claude/product-os/commands/`. Commands are not copied into `.claude/commands/`, because un-namespaced `/status`, `/plan`, `/next` would collide with Claude Code built-ins.

### Non-Destructive Behavior

The installer:
- Preserves existing CLAUDE.md/AGENTS.md (saves Product OS as `.product-os.md`)
- Preserves existing `.cursor/rules/` and `.cursor/agents/`
- Backs up modified files before updating

## Claude Code Usage

### Enabling the Plugin

Claude Code gets Product OS commands from the `product-os` plugin. Plugin commands are always namespaced as `/product-os:<file-stem>`, where the file stem matches `.claude/commands/<file-stem>.md` in the Product OS repo. Enable it one of three ways:

```bash
# A. Installer
./scripts/install.sh /path/to/your/project --platform claude --register-plugin

# B. Manually, from your project directory
claude plugin marketplace add /path/to/product-os --scope project   # or: johnedelatorre/product-os
claude plugin install product-os@product-os --scope project
```

```
# C. Inside Claude Code (≥ 2.1.275)
/plugin install product-os --marketplace johnedelatorre/product-os
```

Upgrading from ≤1.4: delete the old Product OS files from `.claude/commands/` (the installer lists them).

### Slash Commands

| Invocation | What it does |
|------------|--------------|
| `/product-os:guide --initiative my-init --project my-proj` | Start or resume guided mode |
| `/product-os:prd --from intake.md` | Create a PRD |
| `/product-os:propose --idea "..." --initiative my-init --project my-proj` | Research an idea, propose a solution |
| `/product-os:handover` | Write a session handover |
| `/product-os:release-gate --initiative my-init --project my-proj` | Run the release gate |

### Agents and Skills

- Agents in `.claude/agents/` have YAML frontmatter and register as Claude Code subagents.
- Skills in `.claude/skills/` are reference documents that agents read by path; they are not registered Claude Code skills.

### Full Command List

See [`docs/reference/commands.md`](../reference/commands.md) (all 47 commands).

## Cursor Usage

### Project Rules

Cursor reads `.cursor/rules/product-os.mdc` automatically (has `alwaysApply: true`).

This provides:
- Philosophy and workflow overview
- Links to canonical content in `.claude/`
- Output style reminders
- Key skill references

### Native Cursor Agents

Product OS includes `.cursor/agents/` with key specialists:
- `product-os-guide.md` — Workflow navigation
- `prd-author.md` — PRD creation
- `intake-analyst.md` — Requirement intake

These use Cursor's native agent format (YAML frontmatter + markdown body).

### Role-Based Invocation

For agents not in `.cursor/agents/`, use role-based invocation:

```
Read .claude/agents/strategist.md and prioritize this feature list
```

```
Read .claude/skills/proposal.md and research this idea: [idea]
```

### Workflow Example

**Start a project:**
```
Read .claude/agents/guide.md and help me start a project called "signup-v2"
in initiative "customer-onboarding"
```

**Resume work:**
```
Read HANDOVER.md and continue from the next action
```

**Create PRD:**
```
Read .claude/agents/prd-author.md and create a PRD for self-serve signup
```

**End session:**
```
Read .claude/skills/session-handover.md and create a handover
```

## Delegation Approach

### Claude Code

Uses the Task tool for native subagent delegation; Product OS agents register as subagents via their frontmatter.

### Cursor

Uses one of these approaches (in order of preference):

1. **Native `.cursor/agents/`** — If an agent file exists in `.cursor/agents/`, Cursor can invoke it natively
2. **Role-based invocation** — Read the `.claude/agents/*.md` file and follow its instructions (sequential execution)
3. **Explore subagent** — Use Cursor's built-in `explore` subagent for codebase analysis

**Important:** Native parallel delegation depends on platform runtime. When unavailable, use sequential role-based execution. Don't claim parallel execution without verifying platform support.

## Shared Artifacts

These files are portable across platforms:

### Progress Tracking

`initiatives/<initiative>/<project>/progress.yaml`:

```yaml
initiative: customer-onboarding
project: self-serve-signup
current_phase: define
current_document: prd
schema_version: "1.1"
```

### Session Handover

`HANDOVER.md` at project or repo root:

```markdown
# Session Handover

## Objective
[What the work is for]

## Where It Stands
[Built, committed, pushed]

## Next Action
[One concrete step]
```

### Status Board (Long-Running Work)

`STATUS.md` for multi-session work — see `.claude/skills/session-handover.md`.

## Cursor File Formats

### Rules (`.cursor/rules/*.mdc`)

```markdown
---
description: "Description for agent to decide relevance"
alwaysApply: true
---

Rule content here...
```

| Field | Type | Effect |
|-------|------|--------|
| `alwaysApply: true` | boolean | Always included |
| `description` | string | Agent decides when relevant |
| `globs` | string | Auto-attached for matching files |

### Agents (`.cursor/agents/*.md`)

```markdown
---
name: my-agent
description: "Short description for delegation"
model: inherit
---

Agent instructions here...
```

| Field | Required | Default |
|-------|----------|---------|
| `name` | No | From filename |
| `description` | No | — |
| `model` | No | `inherit` |
| `readonly` | No | `false` |

## Switching Platforms

### From Claude Code to Cursor

1. Ensure `.cursor/` exists (installer adds it)
2. Commit in-progress `progress.yaml`
3. Create `HANDOVER.md` before switching
4. In Cursor, rules auto-apply; use role-based invocation for commands

### From Cursor to Claude Code

1. Ensure `.claude/` exists (always installed)
2. Commit in-progress `progress.yaml`
3. Create `HANDOVER.md` before switching
4. In Claude Code, use `/product-os:guide` to resume

## Limitations

### Runtime Testing

- Native subagent behavior verified only via Cursor documentation
- Actual runtime behavior depends on Cursor version and configuration
- This guide is based on Cursor docs, not runtime verification

### Platform-Specific Features

- Claude Code artifacts may not render in Cursor
- Cursor extensions may not have Claude equivalents
- MCP server availability varies by platform

### Delegation

- True parallel delegation requires platform support
- When unavailable, use sequential role-based execution
- Don't claim independence for same-session reviews

## Updates

### Updating Product OS

```bash
# Re-run installer (backs up modified files)
./scripts/install.sh /path/to/your/project

# Or for submodule mode
git submodule update --remote product-os
```
