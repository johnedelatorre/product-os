# Independent Review Skill

> Genuinely independent code review: fresh reviewer that never saw the build, unsteered, with bounded iterations.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) independent-review skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## Core Principle

**Fresh reviewer independence requires genuinely separate reviewer and context.** Don't claim self-review is independent.

A session that already argued the code is correct will argue it again. The value is what an unprimed reader notices.

## When Required

| Workflow | Independent Review? |
|----------|---------------------|
| PM/research/design artifacts | Not required |
| Any code being shipped | **Mandatory** |
| Configuration affecting access/data | Required |
| Before every deploying push | Required |
| Before production promotion | Required |

## Requirements for Independence

### 1. Fresh Session

- **Never saw the build** — not the thread that wrote the code
- **Not a resume, fork, or subagent** of the building session
- **No carried-over memory** — fresh context

### 2. No Steering

- **No checklist** — unprimed reader finds what they notice
- **No prior findings** — don't convert independent sample into confirmation pass
- **No argument for the design** — no defense of choices

### 3. Computed Subject

- **Define from git** — `git log --oneline <last-release>..HEAD`
- **Include working tree** — uncommitted changes are part of subject
- **Never prose description** — computed subjects don't drift

### 4. Read-Only

- **Reviewer cannot modify code**
- **No write tools available**
- **Analysis only**

### 5. Highest Effort

- **Use strongest available model/reasoning**
- **Note which model actually ran**

## If Reviewer Unavailable

**Mark as Not Verified and block release.**

| Status | Meaning | Blocks? |
|--------|---------|---------|
| ✅ Independent Review | Fresh, unsteered, separate reviewer | No |
| ⚠️ Same-Family Review | Fresh session of same model family | No (with noted limitation) |
| 🔍 Not Verified | Couldn't run independent review | **Yes** |
| ❌ No Review | Skipped entirely | **Yes** |

**Never claim independence that doesn't exist.**

## Review Loop

### Bounded Iterations

1. Run review on unreleased range
2. Classify: INTRODUCED vs PRE-EXISTING
3. Fix INTRODUCED findings
4. Rerun review (fresh session again)
5. **Stop when:** No INTRODUCED above Low, no High/Critical of any age

### Escalation (Don't Loop Forever)

**After [3-5] rounds with persistent findings:**

1. Document remaining findings
2. Escalate to owner with summary
3. Owner decides: fix, waive, or defer
4. Waivers recorded as waivers (not Pass)

```markdown
## Review Escalation

**Rounds completed:** [n]
**Remaining findings:** [count]

### Persistent Findings

| Finding | Severity | Rounds Present | Notes |
|---------|----------|----------------|-------|
| [finding] | [sev] | [n] | [context] |

### Recommended Action

[Fix / Waive with reason / Defer to backlog]

### Owner Decision Required

Please reply with decision for each finding.
```

## Finding Classification

| Classification | Meaning | Blocks Release? |
|----------------|---------|-----------------|
| **INTRODUCED** | This change added the issue | Yes (above Low) |
| **PRE-EXISTING** | Issue existed before this change | Only if High/Critical |

## Review Output Template

```markdown
# Independent Review: [Scope]

## Metadata

- **Reviewer:** [model/session ID]
- **Subject:** [git range]
- **Round:** [n]
- **Date:** [timestamp]

## Independence Verification

| Requirement | Status |
|-------------|--------|
| Fresh session (never saw build) | ✅ / ❌ |
| No checklist provided | ✅ / ❌ |
| Subject computed from git | ✅ / ❌ |
| Read-only access | ✅ / ❌ |
| Different from builder | ✅ / ❌ (note if same family) |

## Summary

- **Total findings:** [n]
- **INTRODUCED:** [n] (Critical: [n], High: [n], Medium: [n], Low: [n])
- **PRE-EXISTING:** [n]

## Findings

### [CRITICAL/HIGH/MEDIUM/LOW] [Finding Title]

**Classification:** INTRODUCED / PRE-EXISTING

**Location:** [file:line]

**Issue:** [description]

**Sequence that triggers:** [how to reproduce]

**Recommendation:** [fix]

---

## Verdict

[ ] Clean — no INTRODUCED above Low, no High/Critical open
[ ] Needs fixes — [count] findings require attention
[ ] Escalate — persistent findings after [n] rounds
```

## Integration

| Gate | This Skill's Role |
|------|-------------------|
| DoD | Independent review part of "done" for code |
| Release Gate | Required before any code promotion |
| Publishing Gate | Part of release verification |

## What This Is NOT

- **Not self-review** — builder reviewing own code isn't independent
- **Not checklist confirmation** — steering defeats the purpose
- **Not proof of no bugs** — it's one sample, not exhaustive
- **Not infinite** — bounded iterations with escalation

## Quality Checklist

- [ ] Reviewer never saw the build
- [ ] No checklist or prior findings provided
- [ ] Subject computed from git (not described)
- [ ] Model/session documented
- [ ] If unavailable, marked Not Verified and blocked
- [ ] Iterations bounded with escalation path
- [ ] Waivers recorded as waivers
