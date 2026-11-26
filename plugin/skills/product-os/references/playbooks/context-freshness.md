# Skill: Context Freshness

Verify that context, baselines, and assumptions are current before decisions or launch.

## When to Use

- Before launch (verify PRD reflects what was built)
- Before metrics review (verify baselines are recent)
- Before estimation (verify dependencies are current)
- Before decisions (verify context hasn't changed)

## Freshness Check Template

```yaml
context_check:
  checked_by: [Name]
  checked_at: [ISO 8601 datetime]
  
  items:
    - item: "PRD requirements"
      source: "prd.md"
      last_updated: [datetime]
      status: current | stale | unknown
      notes: "Section 8 updated after design phase"
      
    - item: "Metrics baselines"
      source: "metrics-framework.md"
      last_updated: [datetime]
      status: current | stale | unknown
      notes: "Baseline from Q3; need Q4 numbers"
      
    - item: "Dependency status"
      source: "Auth API team"
      last_updated: [datetime]
      status: current | stale | unknown
      notes: "Confirmed deployed in prod"
```

## Freshness Thresholds

| Context Type | Stale After | Action When Stale |
|--------------|-------------|-------------------|
| Metrics baselines | 30 days | Re-pull from dashboards |
| Competitive analysis | 90 days | Refresh key competitors |
| User research | 6 months | Consider new research |
| Technical dependencies | 7 days pre-launch | Re-confirm with team |
| PRD vs implementation | Any delta | Update PRD or flag deviation |

## Common Staleness Issues

### PRD Drift
PRD says one thing, implementation does another.

**Fix:**
1. Document deviation in PRD (don't pretend original spec)
2. Or update implementation to match PRD
3. Or log decision record explaining change

### Baseline Decay
Metrics baseline from 3 months ago; current state unknown.

**Fix:**
1. Re-pull current baseline before launch
2. Document baseline date in metrics framework
3. Note confidence level if data quality is uncertain

### Dependency Surprise
Assumed API ready; team actually delayed.

**Fix:**
1. Verify dependencies within 7 days of launch
2. Get explicit confirmation, not assumption
3. Have contingency if dependency slips

## Verification Checklist

Before launch, verify:

- [ ] PRD reflects what was actually built
- [ ] Metrics baselines are within 30 days
- [ ] All critical dependencies confirmed ready
- [ ] Rollback procedure still valid for current architecture
- [ ] Monitoring dashboards still point to correct services

## Source Confidence

When context source is uncertain:

```yaml
source_confidence:
  high:
    - Direct measurement (dashboard, database)
    - Official documentation (published API docs)
    - Confirmed in writing (Slack/email from owner)
    
  medium:
    - Verbal confirmation (meeting notes)
    - Similar past experience
    - Second-hand report
    
  low:
    - Assumption without verification
    - Outdated documentation
    - Unconfirmed memory
```

Document confidence level when context is not directly verified.

## Related

- `metrics-framework.md` — Baselines and targets
- `dependency-tracking.md` — Dependency status
- `decision-logger.md` — Context for decisions
