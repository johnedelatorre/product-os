# Installation and Platform Setup

> **TL;DR:** Run `./scripts/install.sh /path/to/your/project --register-plugin`, then start with `/product-os:guide`. This page covers install options, Claude Code and Cursor setup, switching platforms, and upgrades.

## Platform Support

Product OS works in both **Claude Code** and **Cursor**.

| Platform | Support Level | Slash Commands | Native Subagents |
|----------|---------------|----------------|------------------|
| Claude Code | Full | Yes (plugin, `/product-os:*`) | Yes (agents with frontmatter) |
| Cursor | Full | Role-based | Partial |

## Fresh Install

```bash
# Clone Product OS
git clone https://github.com/johnedelatorre/product-os.git
cd product-os

# Install for both platforms (default)
./scripts/install.sh /path/to/your/project

# Or install for specific platform
./scripts/install.sh /path/to/your/project --platform claude
./scripts/install.sh /path/to/your/project --platform cursor

# Also enable the Claude Code plugin in the target (needs the claude CLI)
./scripts/install.sh /path/to/your/project --platform claude --register-plugin
```

The installer is idempotent (safe to run more than once) and tested by `scripts/test-install.sh`.

## Enabling the Claude Code Plugin

Claude Code gets its commands from the `product-os` plugin, namespaced as `/product-os:<command>`. Pick one:

```bash
# A. Let the installer do it
./scripts/install.sh /path/to/your/project --register-plugin

# B. Manually, from your project directory
claude plugin marketplace add /path/to/product-os --scope project   # or: johnedelatorre/product-os
claude plugin install product-os@product-os --scope project
```

```
# C. One step, inside Claude Code (≥ 2.1.275)
/plugin install product-os --marketplace johnedelatorre/product-os
```

**Why a plugin?** Copying commands into `.claude/commands/` registers them un-namespaced (`/status`, `/plan`, `/next`), which collide with Claude Code built-ins. Plugin commands are always prefixed with `/product-os:`.

## What Gets Installed

| Platform | Files Installed |
|----------|-----------------|
| Claude Code | `.claude/agents/` (registered subagents), `.claude/skills/` (reference docs), `.claude/product-os/commands/` (reference copy of commands), `CLAUDE.md`, `AGENTS.md`. Commands themselves come from the plugin. |
| Cursor | `.cursor/rules/product-os.mdc` |
| Both (shared) | `templates/`, `initiatives/`, `product-os.config.yaml` |

## Preserving Existing Files

The installer is non-destructive:
- **Existing CLAUDE.md** → Preserved; Product OS saved as `CLAUDE.product-os.md`
- **Existing .cursor/rules/** → Preserved; Product OS rules added alongside
- **Existing agents/skills/templates** → Preserved; Product OS content merged
- **Modified files** → Backed up before updating

## Update an Existing Installation

```bash
./scripts/install.sh /path/to/your/project
```

Modified files are backed up before overwriting. Config files are not overwritten.

In submodule mode (`--submodule`), `.claude/product-os/commands` is a symlink into the submodule instead of a copy.

### Older installs with commands in `.claude/commands/`

Older installs copied (or symlinked) command files into `.claude/commands/`, including `product-os-*.md` files. Those register un-namespaced commands that shadow Claude Code built-ins. To move to the plugin:

1. Rerun `./scripts/install.sh /path/to/your/project --register-plugin` (or enable the plugin manually).
2. The installer lists any old Product OS command files it finds in `.claude/commands/`. Delete them.
3. Use the namespaced commands: `/product-os:guide`, `/product-os:status`, `/product-os:next`, etc.

## Claude Code Setup

Every command is invoked as `/product-os:<command>`. Agents in `.claude/agents/` register as subagents. Skills in `.claude/skills/` are reference documents that agents read by path.

```bash
/product-os:guide --initiative my-initiative --project my-project   # Start guided mode
/product-os:status                                                   # Check status
/product-os:next                                                     # Do the next step
```

## Cursor Setup

### After Installation

1. **Restart Cursor** to load `.cursor/rules/product-os.mdc`
2. The rules file references shared content in `.claude/`

### Start Guided Mode

```
Read .claude/agents/guide.md and help me start a project called [name]
in initiative [initiative-name]
```

### Resume Work

```
Read HANDOVER.md and continue from the next action
```

### Use Specialist Agents

In Cursor, invoke specialists by reading their agent file:

```
Read .claude/agents/prd-author.md and create a PRD for [feature]
Read .claude/agents/intake-analyst.md and structure this requirement: [text]
Read .claude/skills/proposal.md and help me research this idea: [idea]
```

### Native Cursor Agents

Product OS provides 3 native Cursor agent adapters in `.cursor/agents/`:

| Adapter | File | Purpose |
|---------|------|---------|
| `product-os-guide` | `product-os-guide.md` | Start/resume workflow |
| `prd-author` | `prd-author.md` | Write PRDs |
| `intake-analyst` | `intake-analyst.md` | Structure requirements |

These work with Cursor's native agent picker. Every other role is available via role-based invocation (read the agent file, follow instructions).

**Note:** Cursor's built-in `subagent_type` options (e.g., `explore`) are platform-controlled and version-dependent. Product OS does not claim or rely on specific subagent_types beyond the 3 native adapters above.

### Session Handover

Before ending a session:

```
Read .claude/skills/session-handover.md and create a handover
```

This creates `HANDOVER.md` with state, evidence, and next action.

## Cross-Platform Workflow

These files are portable across platforms:
- `progress.yaml` — Guided workflow state
- `HANDOVER.md` — Session handover
- `STATUS.md` — Long-running status board
- All artifacts in `initiatives/`

To switch platforms:

1. Commit in-progress `progress.yaml`
2. Create `HANDOVER.md` before switching
3. In the new platform, read the handover to resume

See [platform-compatibility.md](../guides/platform-compatibility.md) for full details.

## Repository Structure

```
product-os/
├── CLAUDE.md                 # Root agent instructions
├── AGENTS.md                 # Agent orchestration
├── README.md
├── LICENSE                   # MIT License
├── CHANGELOG.md              # Release history
├── CONTRIBUTING.md
├── product-os.config.yaml    # Configuration template
├── .env.example              # Credentials template (REST fallback only)
│
├── .claude-plugin/
│   ├── plugin.json           # Claude Code plugin manifest (name: product-os)
│   └── marketplace.json      # Marketplace "product-os" (plugin source ./)
│
├── .claude/
│   ├── agents/               # Specialist agents (subagents, with frontmatter)
│   ├── commands/             # Commands, served by the plugin as /product-os:<name>
│   └── skills/               # Skills (reference docs)
│
├── .cursor/
│   ├── rules/product-os.mdc  # Cursor rules
│   └── agents/               # Native Cursor adapters
│
├── templates/                # Document templates (intake, pm, design, delivery, tools)
├── docs/                     # Guides, command reference, setup
├── examples/acme-dashboard/  # Worked example
├── initiatives/              # Your project workspace
│
└── scripts/
    ├── install.sh
    ├── validate.sh
    ├── test-install.sh
    ├── doc-hygiene-check.py  # Doc hygiene lint + invention guard
    └── atlassian-fallback.py
```
