# Installation and Platform Setup

> **TL;DR:** In claude.ai, create a Project with the instructions and starter files in `claude-ai/`. In Claude Code or Cursor, run `./scripts/install.sh /path/to/your/project --register-plugin`, then start with `/product-os:guide` (Claude Code) or the Guide agent (Cursor). This page covers all three platforms, install options, switching platforms and upgrades.

## Platform Support

Product OS works in **claude.ai**, **Claude Code** and **Cursor**.

| Platform | Setup | Slash Commands | Agents | Files on disk |
|----------|-------|----------------|--------|---------------|
| claude.ai | A Claude Project (`claude-ai/project-instructions.md` + starter knowledge files) | No, ask in plain language | One role at a time, from project knowledge | No; documents live in the chat, download them to keep |
| Claude Code | Installer + plugin | Yes (plugin, `/product-os:*`) | Native subagents (agents with frontmatter) | Yes, `initiatives/` |
| Cursor | Installer + Cursor rules | Role-based | 3 native adapters + role-based | Yes, `initiatives/` |

## claude.ai Setup

claude.ai has no installer. A Claude Project gives Claude the Product OS instructions plus the agent roles, playbooks and templates you upload, and every chat in that project can use them. Full guide: [Product OS in claude.ai](../../claude-ai/README.md).

1. **Get the files:** on GitHub choose Code → Download ZIP, then unzip. On a Mac, press **Cmd+Shift+.** in Finder to show the hidden `.claude` folder.
2. **Create a project** in claude.ai (for example "Product OS – Growth team").
3. **Instructions:** paste [`claude-ai/project-instructions.md`](../../claude-ai/project-instructions.md) (everything below its line) into the project instructions. Fill in your Confluence space and Jira project under "Our team", or delete those lines. Do not paste `CLAUDE.md`: it is written for Claude Code and refers to slash commands and repo files.
4. **Knowledge:** upload the starter knowledge set listed in [`claude-ai/README.md`](../../claude-ai/README.md#starter-knowledge-set): 12 agent files, 3 skills, the format standard and 6 templates. Add more agent files later as you need them. Tip: copy the starter files into one folder first, then upload that folder's contents.
5. **Confluence and Jira (optional):** enable the Atlassian connector in claude.ai if your workspace offers it. Claude shows the pages and issues it will write and waits for your approval, the same rule as on every platform.
6. **Start:** open a chat in the project and say *"Start Product OS guided mode for initiative customer-onboarding, project self-serve-signup."*

**Working in claude.ai:**
- Ask for any command by its name or purpose: "Run Product OS intake on this Slack thread", "Write the PRD", "Do a UX review of these wireframes".
- Ask for any agent by name: "Act as the Product OS Strategist and score these features with RICE."
- Progress and handovers: ask Claude for the current `progress.yaml` or a `HANDOVER.md` at the end of a session, and upload it to the next chat (or the project knowledge) to pick up where you left off.
- Keep finished documents by downloading them, publishing them to Confluence, or adding them to the project knowledge so later chats can build on them.
- Flow diagrams: if a Mermaid diagram doesn't render in the chat, ask Claude to show the flow as an artifact or diagram. Flags such as `--targets claude-artifact,figjam` are Claude Code only.
- If you ask for an agent whose file isn't uploaded, Claude names the file to add from `.claude/agents/`.
- What claude.ai does not do: slash commands, subagents running in parallel, or writing files into a repo. For those, use Claude Code.

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
# C. Inside Claude Code
/plugin marketplace add johnedelatorre/product-os
/plugin install product-os@product-os
```

**Why a plugin?** Copying commands into `.claude/commands/` registers them un-namespaced (`/status`, `/plan`, `/next`), which collide with Claude Code built-ins. Plugin commands are always prefixed with `/product-os:`.

## What Gets Installed

| Platform | Files Installed |
|----------|-----------------|
| Every platform (`--platform both`, `claude` or `cursor`) | `.claude/agents/` (registered subagents in Claude Code), `.claude/skills/` (reference docs), `.claude/product-os/commands/` (reference copy of commands), `CLAUDE.md`, `AGENTS.md`, `templates/`, `initiatives/`, `product-os.config.yaml`, `.env.example`, `scripts/atlassian-fallback.py`, `scripts/doc-hygiene-check.py` |
| Claude Code | Nothing extra on disk. Commands come from the plugin (`--register-plugin`, or see [Enabling the Claude Code Plugin](#enabling-the-claude-code-plugin)). |
| Cursor (`both` or `cursor`) | `.cursor/rules/product-os.mdc` and `.cursor/agents/` (the 3 native adapters: `product-os-guide.md`, `prd-author.md`, `intake-analyst.md`) |

This is copy mode, the default. In submodule mode (`--submodule`) the shared content stays in the submodule and is linked rather than copied.

Existing `CLAUDE.md`, `AGENTS.md`, `product-os.config.yaml` and `.env.example` are never overwritten (see below).

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
├── claude-ai/
│   ├── README.md             # claude.ai setup and starter knowledge set
│   └── project-instructions.md  # Paste into the Claude Project instructions
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
