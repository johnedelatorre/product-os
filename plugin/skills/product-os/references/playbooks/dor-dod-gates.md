# Skill: Definition of Ready / Definition of Done

Enforce quality gates for stories before sprint.

## When to Use

- Sprint planning (DoR)
- Story completion (DoD)
- Quality improvement
- Process compliance

## Quick Start

```
/jdlt-product-os:gate --stories stories.md --gate dor
```

## Definition of Ready (DoR)

**Required** — Story cannot enter sprint without:

| Criterion | Check |
|-----------|-------|
| User story format | "As a... I want... So that..." |
| Problem line | One or two sentences under the user story |
| Acceptance criteria | A "Done when" checklist of at least 3 testable lines |
| Story points | Estimated, 1–5; an 8 has a written reason; no 13. Backend estimates may be "proposed; engineering confirms" |
| Discipline label | frontend/backend/fullstack |
| Dependencies | Documented and tracked |
| Designs | Each UI story links to its own page or frame in the main design file |
| Organization | The PM accepted the ticket tree; steps inside a ticket are sub-tasks |
| Technical approach | Discussed with eng. On backend tickets, "Engineering to complete" is filled in by the engineers before the sprint starts |

**Recommended:**
- Edge cases documented
- Analytics events defined

## Definition of Done (DoD)

**Required** — Story cannot be marked done without:

| Criterion | Check |
|-----------|-------|
| AC met | All acceptance criteria pass |
| Code reviewed | PR approved |
| Tests written | Unit + integration |
| No critical bugs | No P0/P1 open |
| Docs updated | If needed |
| Tracking verified | Events firing |
| Product approved | PM sign-off |

**Recommended:**
- Performance tested
- Accessibility checked

## Gate Report Format

```markdown
## Summary
| Status | Count |
|--------|-------|
| ✅ Ready | 8 |
| ⚠️ Gaps | 3 |
| ❌ Not Ready | 1 |

## Has Gaps
### PROJ-104
| Criterion | Status |
|-----------|--------|
| User story | ✅ |
| Dependencies | ⚠️ Missing |

**To fix:** Add dependency to register
```

## Compliance Tracking

Track pass rates over time:

```
Sprint 10: 55% DoR pass
Sprint 11: 62% DoR pass
Sprint 12: 67% DoR pass ↑
```

## Best Practices

1. **Be consistent** — Same criteria every sprint
2. **No exceptions** — Gate is gate
3. **Fix before sprint** — Not during
4. **Track trends** — Improve process

## Related

- `/jdlt-product-os:gate` — Run gate check
- `/jdlt-product-os:deliver` — Create stories
- `.claude/agents/gate-keeper.md` — Full spec
