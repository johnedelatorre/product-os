# Session Handover Skill

> Write the handover a fresh session starts from: state, evidence, next action, blockers, and decisions awaiting owner.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) handover and flight-deck skills (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## When to Use

- Session ending or context running out
- Work continues tomorrow or in fresh session
- Handing off to another agent
- Long-running work spanning multiple sessions
- Background jobs or waiting on decisions

## Core Principle

An agent's memory of what it's doing is the first casualty of a long session. Tool output scrolls away, context gets summarized, and what remains is plausible narrative with operational details sanded off.

**The fix is not better memory. It is writing state down where it cannot be summarized.**

## Steps

### 1. Reconcile with Reality First

Before writing a word, check what this session believes against what is there:

| Check | How |
|-------|-----|
| **Disk state** | `git status`, branch, commits this session, files touched |
| **What's running** | Background jobs, servers, watchers — still running? Exit code? |
| **Project state files** | Plan status, progress.yaml, existing handover |

**Uncommitted work is named as uncommitted.**

**An inherited report is a claim, this session's own memory included.** Verify before copying.

### 2. Write What Next Session Needs

| Section | Contains |
|---------|----------|
| **Objective** | What the work is for, in a line, and who asked |
| **Where it stands** | What is true now: built, committed, pushed, deployed |
| **Evidence** | What was actually run and observed: command, exit code, verdict. Not intended. Unverified says so |
| **Left to do** | In order, each small enough to start on |
| **Open decisions** | Each with options, recommendation, and whose decision |
| **Where things are** | Branches, files, logs, URLs, processes still running |
| **Next action** | One concrete first step. Never "continue" |

**Keep it short enough to stay true.** Evidence is the part that costs most to lose.

### 3. Put It Where Project Keeps Such Things

Use project's existing location:
- Status board or progress file
- Existing handoff file
- Plan status lines

**With none:** One `HANDOVER.md` at repo root, rewritten in place each time.

**Nothing secret goes in it:** No keys, tokens, passwords — only where they're kept.

### 4. Tell Owner How to Start Next Session

End with the one line to give next session:

> Read `HANDOVER.md` and start from its next action.

List anything left running.

## Handover Template

```markdown
# Session Handover

**Date:** [timestamp]
**Session:** [identifier if available]
**Author:** [agent]

## Objective

[What the work is for, in one line, and who asked]

## Where It Stands

| Aspect | Status |
|--------|--------|
| Branch | [branch name] |
| Commits | [committed/uncommitted] |
| Pushed | [yes/no] |
| PR | [URL or none] |
| Tests | [passing/failing/not run] |

## Evidence

| What | Result | Verified |
|------|--------|----------|
| [command/check] | [outcome] | ✅ / 🔍 Not Verified |

## Left to Do

1. [Next task - specific enough to start]
2. [Following task]
3. [...]

## Open Decisions (Awaiting Owner)

| Decision | Options | Recommendation | Reason |
|----------|---------|----------------|--------|
| [decision] | [A, B, C] | [recommendation] | [why] |

## Where Things Are

| Thing | Location |
|-------|----------|
| Branch | [name] |
| Log files | [path] |
| Running processes | [what, how to stop] |
| Artifacts | [paths] |

## Next Action

[One concrete command or file to open — never "continue"]

## To Resume

```
[Exact instruction for next session, e.g.:]
Read HANDOVER.md and start from its next action.
```
```

## Status Board (For Long-Running Work)

For work spanning hours or multiple sessions, use `STATUS.md`:

```markdown
# Status Board

## RESUME
- **Repository:** [path and branch]
- **Recent sessions:** [date: summary] for last 3
- **To resume:** Open agent, read STATUS.md first

## RUNNING NOW
| Process | PID | Log | Waiting On |
|---------|-----|-----|------------|
| [name] | [pid] | [path] | [what] |

## QUEUED
1. [Next in order]
2. [...]

## BLOCKED
| Item | Blocked By | Unblocked When |
|------|------------|----------------|
| [item] | [blocker] | [condition] |

## AWAITING OWNER
| Question | Options | Recommendation |
|----------|---------|----------------|
| [question] | [options] | [recommendation] |

## DONE
- [Completed item, enough to prevent redoing]

## EVIDENCE
| Measurement | Value | Source | Date |
|-------------|-------|--------|------|
| [metric] | [value] | [where from] | [when] |
```

**Update STATUS.md on every state change** — job starts, finishes, fails, decision lands. Not "at the end."

## Integration with Product OS Progress

Product OS tracks progress in `progress.yaml`. Handover complements but doesn't duplicate:

| File | Purpose |
|------|---------|
| `progress.yaml` | Guided workflow phase/status tracking |
| `HANDOVER.md` | Session-specific state for next session |
| `STATUS.md` | Long-running work status board |

**Handover references progress.yaml state, doesn't redefine it.**

## What NOT to Include

- Secret values (keys, tokens, passwords)
- User-global memory (stays in agent, not shared)
- Speculation presented as fact
- Lengthy explanations (be terse)
- Duplicate of chat history

## Quality Checklist

- [ ] Reconciled with disk before writing
- [ ] Uncommitted work named as uncommitted
- [ ] Evidence verified or marked unverified
- [ ] Next action is concrete (not "continue")
- [ ] No secrets in handover
- [ ] Owner decisions have recommendations
- [ ] Resume instruction provided

## How You Can Tell It Worked

A fresh session given only the handover can:
- Say what the work is for
- Know what is verified and what is not
- Run the next action without asking what happened
