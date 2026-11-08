# Platform Compatibility Guide

> Product OS works in both Claude Code and Cursor. This guide explains setup, capabilities, and differences.

## TL;DR

- **Shared content:** Skills, templates, and workflows are identical
- **Platform adapters:** Thin native configuration for each platform
- **Capability differences:** Native subagent delegation varies by platform
- **Progress/handover:** Portable across platforms

## Supported Platforms

| Platform | Support Level | Native Subagents | Slash Commands |
|----------|---------------|------------------|----------------|
| Claude Code | Full | Yes (Task tool) | Yes (`.claude/commands/`) |
| Cursor | Full | Partial (some subagent_types) | Role-based invocation |

## Installation

### Fresh Install (Both Platforms)

```bash
# Clone or download Product OS
git clone https://github.com/johnedelatorre/product-os.git

# Run installer
cd product-os
./scripts/install.sh --mode copy --target /path/to/your/project
```

### Installer Modes

| Mode | Platform | What It Does |
|------|----------|--------------|
| `--platform both` | Default | Installs `.claude/` and `.cursor/rules/` |
| `--platform claude` | Claude Code only | Installs `.claude/` only |
| `--platform cursor` | Cursor only | Installs `.cursor/rules/` only |

### Non-Destructive Behavior

The installer:
- **Preserves existing CLAUDE.md/AGENTS.md** (saves Product OS versions as `.product-os.md`)
- **Preserves existing agents/skills/templates** (merges, doesn't overwrite)
- **Preserves existing .cursor/ configuration** (adds `rules/product-os.mdc`)
- **Backs up modified files** before updating

## Claude Code Usage

### Slash Commands

Product OS registers slash commands in `.claude/commands/`:

```
/product-os:guide --initiative my-initiative --project my-project
/product-os:prd
/product-os:propose
/product-os:handover
```

### Specialist Agents

Claude Code can delegate to specialist agents via Task tool:

```
Use the prd-author agent to create a PRD for the signup feature
```

### Full Command List

See `CLAUDE.md` or run `/product-os:help` for all commands.

## Cursor Usage

### Project Rules

Cursor reads `.cursor/rules/product-os.mdc` for project-level configuration.

### Invoking Specialists

In Cursor, invoke specialists by reading their agent file:

```
Read .claude/agents/prd-author.md and create a PRD for [project]
```

### Available Subagents

Some Product OS roles are available as Cursor subagent_types:
- `accessibility-auditor`
- `competitive-analyst`
- `delivery-agent`
- `design-critic`
- `gate-keeper`
- `guide`
- `market-analyst`
- `product-designer`
- `ux-reviewer`

Use via Task tool for parallel or specialized work.

### Sequential vs. Parallel

| Approach | When to Use | How |
|----------|-------------|-----|
| Sequential | Single-threaded workflow | Read agent file, follow instructions |
| Subagent | Parallel or specialized | Task tool with subagent_type |

## Shared Artifacts

These artifacts are portable across platforms:

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

`STATUS.md` for multi-session work:

```markdown
# Status Board

## RUNNING NOW
| Process | PID | Log | Waiting On |

## QUEUED
1. [Next task]

## AWAITING OWNER
| Question | Options | Recommendation |
```

## Capability Matrix

| Capability | Claude Code | Cursor | Notes |
|------------|-------------|--------|-------|
| Read skills/agents | ✅ | ✅ | Identical content |
| Slash commands | ✅ Native | ⚠️ Role-based | Cursor uses natural language |
| Native subagents | ✅ Full | ⚠️ Partial | Some roles available |
| Progress tracking | ✅ | ✅ | Shared `progress.yaml` |
| Session handover | ✅ | ✅ | Shared `HANDOVER.md` |
| Templates | ✅ | ✅ | Identical |
| Code shipping gates | ✅ | ✅ | Skill-based, portable |

### Subagent Availability

| Role | Claude Code | Cursor |
|------|-------------|--------|
| prd-author | ✅ Via Task | ⚠️ Role-based |
| delivery-agent | ✅ Via Task | ✅ subagent_type |
| gate-keeper | ✅ Via Task | ✅ subagent_type |
| design-critic | ✅ Via Task | ✅ subagent_type |
| guide | ✅ Via Task | ✅ subagent_type |
| (other specialists) | ✅ Via Task | ⚠️ Role-based |

**Role-based:** Read agent file and follow instructions (sequential execution)
**subagent_type:** Native parallel delegation available

## Limitations

### Runtime/GUI Tests

- Native subagent behavior cannot be verified from file existence alone
- Runtime testing requires actual platform execution
- This documentation states capability based on platform documentation, not runtime verification

### Platform-Specific Features

- **Claude Code artifacts:** Some artifact types may be Claude-specific
- **Cursor extensions:** Some Cursor extensions may not have Claude equivalents
- **MCP servers:** Availability varies by platform configuration

## Troubleshooting

### Cursor Not Reading Rules

1. Check `.cursor/rules/product-os.mdc` exists
2. Verify file has `.mdc` extension (not `.md`)
3. Restart Cursor to reload rules

### Claude Commands Not Found

1. Check `.claude/commands/` contains command files
2. Verify command filename matches expected pattern
3. Check CLAUDE.md references the command

### Progress Not Syncing

Progress files are local. For multi-platform work:
1. Commit `progress.yaml` and `HANDOVER.md`
2. Pull before switching platforms
3. Use shared `STATUS.md` for coordination

## Migration

### From Claude Code to Cursor

1. Run installer with `--platform both`
2. Commit any in-progress `progress.yaml`
3. Create `HANDOVER.md` before switching
4. In Cursor, read `.cursor/rules/product-os.mdc`

### From Cursor to Claude Code

1. Ensure `.claude/` exists (installer adds it)
2. Commit any in-progress `progress.yaml`
3. Create `HANDOVER.md` before switching
4. In Claude Code, use `/product-os:guide` to resume

## Updates

### Updating Product OS

```bash
# Pull latest (submodule mode)
git submodule update --remote product-os

# Or re-run installer (copy mode)
./product-os/scripts/install.sh --mode copy --force
```

The installer backs up modified files before updating.
