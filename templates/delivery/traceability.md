# Traceability Matrix: [Project Name]

> **TL;DR:** Links requirements to epics, stories, tests, and review findings. Use to verify coverage and identify gaps.

---

## Coverage Summary

| Category | Total | Covered | Gaps | Coverage |
|----------|-------|---------|------|----------|
| Requirements | | | | % |
| Use Cases | | | | % |
| NFRs | | | | % |

---

## Requirements Traceability

| REQ ID | Requirement | Epic | Stories | Tests | Review Findings | Status |
|--------|-------------|------|---------|-------|-----------------|--------|
| REQ-001 | [Brief description] | EPIC-001 | STORY-001, STORY-002 | [Test IDs or N/A] | [Finding IDs or None] | Covered / Partial / Gap |
| REQ-002 | | | | N/A: backend-only | | |
| REQ-003 | | | TBD: needs spike | | | Pending |

### Gap Explanation

| REQ ID | Reason | Resolution Plan | Owner |
|--------|--------|-----------------|-------|
| [ID with gap] | [Why not covered] | [What will be done] | |

---

## Use Case Coverage

| UC ID | Use Case | Stories | Test Scenarios | Status |
|-------|----------|---------|----------------|--------|
| UC-1 | [Name] | STORY-001, STORY-003 | [Test IDs] | Covered |
| UC-2 | | | N/A: future phase | Deferred |

---

## Metrics to Instrumentation

| Metric | Events Required | Stories | Verified | Owner |
|--------|-----------------|---------|----------|-------|
| [Metric name] | [event_name] | STORY-XXX | Yes/No/N/A | |

---

## Review Findings Linkage

| Finding ID | Source | Severity | Linked REQ | Resolution Story | Status |
|------------|--------|----------|------------|------------------|--------|
| UX-001 | UX Review | Major | REQ-003 | STORY-010 | Fixed |
| A11Y-002 | Accessibility | Critical | REQ-007 | TBD | Open |
| CRIT-003 | Design Critique | Minor | N/A: polish | Backlogged | Deferred |

---

## Story to Requirement Reverse Lookup

| Story | Requirements Addressed | Status |
|-------|------------------------|--------|
| STORY-001 | REQ-001, REQ-002 | Ready |
| STORY-002 | REQ-003 | Ready |
| STORY-003 | None (technical enabler) | N/A |

### Stories Without Requirements

| Story | Justification |
|-------|---------------|
| STORY-003 | Technical prerequisite for REQ-004 implementation |
| STORY-010 | Bug fix from review finding UX-001 |

---

## Testing Coverage

| Test Type | Scope | Stories Covered | Automation Status |
|-----------|-------|-----------------|-------------------|
| Unit | Code coverage | All | Automated |
| Integration | API contracts | STORY-002, STORY-005 | Automated |
| E2E | Critical paths | UC-1, UC-2 | Partial |
| Manual | Edge cases | [List] | Manual |

### Observability Requirements

| Requirement | Implementation | Story | Verified |
|-------------|----------------|-------|----------|
| Error logging | Sentry integration | STORY-008 | Yes |
| Performance monitoring | Datadog APM | STORY-009 | No |
| Audit trail | [Approach] | N/A: future | Deferred |

---

## Ownership Summary

| Area | Owner | Status |
|------|-------|--------|
| Requirements (REQ-*) | [PM] | Approved |
| Stories (STORY-*) | [PM/Eng Lead] | In progress |
| Tests | [QA Lead] | Pending |
| Review findings | [Design Lead] | In progress |

---

## How to Use This Matrix

1. **Before sprint planning:** Verify all Must requirements have stories
2. **During development:** Update story status, link tests
3. **Before launch:** Confirm all Critical findings resolved
4. **For audits:** Show requirement → implementation → verification chain

### Status Key

| Status | Meaning |
|--------|---------|
| Covered | Story exists and is estimated |
| Partial | Some aspects covered, gaps remain |
| Gap | No coverage, needs attention |
| Pending | Blocked on spike or decision |
| Deferred | Explicitly moved to future phase |
| N/A | Not applicable with documented reason |

---

## Reconciliation Checklist

- [ ] Every Must requirement has at least one story
- [ ] Every Critical review finding has a resolution story
- [ ] Every metric has instrumentation story assigned
- [ ] Gaps have documented reasons (not just missing)
- [ ] N/A entries have justification
- [ ] Deferred items have a target phase
