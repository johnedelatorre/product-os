# Release Gate Skill

> Before ship/deploy/release: the gate, owner's preview, go/no-go, verify, and rollback. Code releases require independent review.

**Attribution:** Adapted from [phuryn/product-engineering](https://github.com/phuryn/product-engineering) release-gate skill (MIT License, Copyright 2026 Pawel Huryn). See NOTICE.md.

## Core Principle

**A release is a decision: the owner says go; the agent supplies the evidence.**

This skill defines evidence needed at each shipping step, the promotion procedure, and how to prove the reviewed build serves.

## Conditional Application

| Workflow | Gate Required? |
|----------|----------------|
| PM/research/design artifacts only | No release gate needed |
| Any code being shipped | **Yes — mandatory** |
| Configuration changes affecting access/data | Yes |
| Infrastructure changes | Yes |

## Three Moments, Three Bars

| Moment | What It Owes |
|--------|--------------|
| **Stage is done** | Done-when holds, gate is green on your own run, tests and docs landed with change |
| **Push to deploying branch** | Clean independent review covering everything the push adds |
| **Promotion to production** | Every precondition, go/no-go, promote, verify |

## Owner Click-Through Scripts

**When a stage or change affects what a person sees:**

### 1. Provide Link and Flows

Send owner a link and short list of what to try:

```markdown
## Ready for Review

**URL:** [deployed development or tunnel URL]

### Flows to Try (10-15 min)

| # | Flow | Action | Expected Result |
|---|------|--------|-----------------|
| 1 | [flow name] | [what to do] | [what should happen] |
| 2 | [flow name] | [what to do] | [what should happen] |

### Not Yet Built
- [Feature] — coming in [stage]
- [Feature] — coming in [stage]

### Evidence Needed
Please confirm:
- [ ] Flow 1 worked as expected
- [ ] Flow 2 worked as expected
- [ ] Look and feel acceptable
```

### 2. Prerequisites Before Owner Review

- [ ] Independent review clean or running
- [ ] Fresh-eyes walkthrough completed (newcomer can explain screens)
- [ ] Rendered pass and screenshot critique done
- [ ] Your own gate is green

### 3. What Owner Finds Gets Fixed

Fix findings within same stage. Review fixes like any other change.

## Go/No-Go Protocol

### Silence Is Never Go

Post explicit go/no-go with:
1. Checklist of preconditions with evidence
2. One paragraph summary
3. Request for owner's explicit answer

```markdown
## Go/No-Go: [Release Name]

### Preconditions

| Condition | Status | Evidence |
|-----------|--------|----------|
| Tests passing | ✅ | [link to run] |
| Independent review clean | ✅ | [findings: 0 introduced] |
| Owner click-through | ✅ | [date completed] |
| Docs current | ✅ | [commit] |
| Intent matches implementation | ✅ | [audit result] |

### Summary

[One paragraph: what's shipping, what it does, any waivers]

### Request

Please reply with explicit GO or NO-GO.
```

### Waivers Remain Waivers

A waived precondition is recorded as **waived**, never ticked as completed:

| Condition | Status | Notes |
|-----------|--------|-------|
| Performance audit | ⚠️ Waived | Owner accepted: "not blocking for MVP" |

Waivers are not Pass. They remain visible.

## Independent Review (Mandatory for Code)

**Before every deploying push and before production promotion.**

### Requirements

1. **Fresh session** — never saw the build
2. **No checklist** — unprimed reader finds what they notice
3. **Subject from git** — computed, not described
4. **Read-only** — reviewer cannot modify code
5. **Highest reasoning effort** — use best available model

### If Reviewer/Tools Unavailable

**Mark as Not Verified and block release.** Don't claim independence that doesn't exist.

| Status | Meaning |
|--------|---------|
| ✅ Reviewed | Independent review completed |
| 🔍 Not Verified | Review couldn't run — **blocks release** |
| ⚠️ Same-Family Review | Fresh session of same model family (note limitation) |

### Review Loop

1. Run independent review on unreleased range
2. Classify findings: INTRODUCED vs PRE-EXISTING
3. Fix INTRODUCED findings
4. Rerun review
5. Stop when: no INTRODUCED above Low, no High/Critical of any age

**Bound iterations:** If findings persist after [3-5] rounds, escalate to owner with summary. Don't loop infinitely.

## Verify: Reviewed Build Is Serving

### 1. Prove New Build Serves

A failed build can leave old deploy serving. Find something diff adds AND something it removes:
- Addition present in response
- Removal absent from response

**"200 OK" cannot establish build identity.**

### 2. Prove Code and Schema Agree

Request unguessable ID through public route:
- Expect 404 with product's not-found (proves DB round trip)
- Any other answer = failed probe

### 3. Check All Runtimes

Workers, edge hosts, boxes — compare each build identity with reviewed commit.

## Stack-Specific Validation

**Identify actual project stack.** Generic checks apply to all; stack-specific validations may be needed:

```markdown
## Stack Analysis

**Detected stack:** [frameworks, services]

**Supported validations:**
- [what this skill can verify]

**Stack-specific checklists needed:**
- [what may need additional validation]

**Unsupported validations (remain unverified):**
- [what cannot be checked with available tools]
```

**Don't assume vendor integrations.** No Netlify/Railway/Supabase mechanics unless project actually uses them.

## Release Checklist Template

```markdown
# Release: [Name/Version]

## Pre-Release

| Check | Status | Evidence | Notes |
|-------|--------|----------|-------|
| Tests passing | | [link] | |
| Intent vs. implementation audit | | [result] | |
| Independent review | | [round count, findings] | |
| Owner click-through | | [date] | |
| Docs current | | [commit] | |

## Go/No-Go

- [ ] Preconditions posted with evidence
- [ ] Owner gave explicit GO
- [ ] Waivers documented as waivers

## Promote

- [ ] Migrations applied (if any)
- [ ] Production branch updated
- [ ] All runtimes deployed

## Verify

- [ ] New build confirmed serving (probe: [what])
- [ ] Code/schema agreement confirmed
- [ ] All runtimes at correct version
- [ ] Smoke tests passing

## Post-Release

- [ ] Tag created: [tag]
- [ ] Release notes published
- [ ] Monitoring confirmed
```

## Never

- Force-push production branch
- Promote with skipped suite, stale doc, or unrun local gate
- Infer go from ambiguous reply
- Run authenticated smoke with real user credentials
- Test against production data
- Claim independent review when reviewer unavailable

## Integration with Product OS Gates

| Gate | This Skill's Role |
|------|-------------------|
| DoR | Verify release preconditions exist |
| DoD | Verify implementation complete |
| Publishing Gate | **Required** — full release-gate process |

## Quality Checklist

- [ ] All preconditions have evidence (not just checks)
- [ ] Owner gave explicit go (not inferred)
- [ ] Independent review completed or marked Not Verified
- [ ] Waivers recorded as waivers, not Pass
- [ ] Build verified as serving (not just deployed)
- [ ] Stack identified and unsupported validations stated
