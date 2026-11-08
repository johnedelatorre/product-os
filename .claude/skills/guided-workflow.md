# Guided Workflow Skill

> Track PM progress through all 9 phases using `progress.yaml` state files.

## When to Use

- PM wants step-by-step guidance
- Working on a complex initiative spanning multiple phases
- Need to track what's done and what's next

## Progress File Location

```
initiatives/<initiative-slug>/<project-slug>/progress.yaml
```

## Progress Schema

```yaml
schema_version: "1.1"        # For migration compatibility
initiative: string           # e.g., "customer-onboarding"
project: string              # e.g., "self-serve-signup"
created: ISO 8601 datetime
last_updated: ISO 8601 datetime

current_phase: enum          # intake | discovery | prioritize | define | design | review | deliver | launch | measure
current_document: string     # filename currently in progress

# Artifact stages track completeness
artifact_stages:
  prd: enum                  # early | defined | delivery_ready
  estimation: enum           # tshirt | ranges | fibonacci

phases:
  <phase-name>:
    status: enum             # not_started | in_progress | complete | skipped
    started: ISO 8601 datetime
    completed: ISO 8601 datetime
    documents:
      <filename>:
        status: enum         # not_started | in_progress | complete | skipped | tbd
        created: ISO 8601 datetime
        skip_reason: string  # if skipped
        tbd_reason: string   # if tbd (blocked on what)
    exit_criteria:
      <criterion>:
        status: enum         # pass | fail | conditional | na | not_verified
        evidence: string     # what proves this
        notes: string        # additional context
    exit_criteria_passed: boolean
    skip_reason: string      # if phase skipped
    skip_risks: list[string] # risks of skipping

gates_passed: list[string]   # e.g., intake_approved, priority_confirmed, prd_review_complete

# Review synthesis results
reviews:
  prd_review:
    status: enum             # not_started | complete | skipped
    blockers_resolved: boolean
    recommendation: enum     # approve | conditional | revise | not_ready

artifacts_registered: list
  - id: string
    type: string
    url: string
    freshness: ISO 8601 datetime  # when last verified current
```

### Schema Migration

If loading a v1.0 progress file (no schema_version):
1. Add `schema_version: "1.1"`
2. Default `artifact_stages.prd` to `defined` if PRD exists
3. Default `artifact_stages.estimation` to `fibonacci` if stories exist
4. Convert boolean exit_criteria to structured format
5. Add empty `reviews` section

Migration is non-destructive: all existing data preserved.

## Phase Order

```yaml
phases:
  1: intake       # Required
  2: discovery    # Optional
  3: prioritize   # Required
  4: define       # Required
  5: design       # Required
  6: review       # Required
  7: deliver      # Required
  8: launch       # Required
  9: measure      # Required
```

## Status Transitions

```
not_started → in_progress → complete
not_started → skipped (optional phases only)
in_progress → complete
```

## Exit Criteria by Phase

Each criterion has a status: `pass` | `fail` | `conditional` | `na` | `not_verified`

### Intake
| Criterion | Required |
|-----------|----------|
| Problem stated without solution bias | Yes |
| Evidence documented | Yes |
| Stakeholders identified | Yes |
| PM approved problem framing | Yes |

### Discovery (skippable)
| Criterion | Required |
|-----------|----------|
| Key hypotheses documented | Yes (or skip with risks) |
| At least one opportunity with evidence | Yes (or skip with risks) |

### Prioritize
| Criterion | Required |
|-----------|----------|
| Priority score calculated | Yes |
| Roadmap placement decided | Yes |
| Stakeholders aligned | Yes |

### Define
| Criterion | Required |
|-----------|----------|
| PRD stage appropriate (Early/Defined/Delivery-ready) | Yes |
| PRD review complete (if stage ≥ Defined) | Conditional |
| PRD review blockers resolved | Conditional |
| Success metrics have baselines and targets | Yes |
| Stop criteria defined with owners | Yes |
| RACI has one R per row | Yes |
| Timeline has dependencies mapped | Yes |

### Design
| Criterion | Required |
|-----------|----------|
| Flows cover happy path + errors | Yes |
| Wireframes address all PRD requirements | Yes |
| Prototype is testable | Yes |

### Review
| Criterion | Required |
|-----------|----------|
| No critical design issues (or accepted risk) | Yes |
| WCAG 2.2 AA compliance verified | Yes |
| Gate report complete with evidence | Yes |
| Not-verified items have investigation plan | Conditional |

### Deliver
| Criterion | Required |
|-----------|----------|
| Stories have testable AC (Gherkin) | Yes |
| Stories have points with rationale | Yes |
| Spikes created for unknown scope | Conditional |
| Testing requirements specified | Yes |
| Observability requirements specified | Yes |
| Traceability matrix complete | Yes |
| Human approved publish | Yes |

### Launch
| Criterion | Required |
|-----------|----------|
| Release notes published | Yes |
| Support team enabled | Yes |
| Monitoring and alerting in place | Yes |
| Rollback procedure documented | Yes |
| Stop criteria defined with owners | Yes |
| Context verified fresh | Yes |

### Measure
| Criterion | Required |
|-----------|----------|
| Metrics compared to targets with evidence | Yes |
| Guardrails verified | Yes |
| Learnings documented | Yes |
| Decision review triggers evaluated | Yes |
| Follow-up items created (or none needed) | Yes |

## Commands

| Command | Action |
|---------|--------|
| `/product-os:guide` | Start or resume guided mode |
| `/product-os:status` | Show current progress |
| `/product-os:next` | Execute next recommended step |

## Example Progress File

```yaml
initiative: customer-onboarding
project: self-serve-signup
created: 2026-11-06T18:00:00Z
last_updated: 2026-11-06T19:30:00Z

current_phase: define
current_document: prd.md

phases:
  intake:
    status: complete
    started: 2026-11-06T18:00:00Z
    completed: 2026-11-06T18:15:00Z
    documents:
      intake.md:
        status: complete
        created: 2026-11-06T18:15:00Z
    exit_criteria_passed: true
    
  discovery:
    status: skipped
    skip_reason: "Time-sensitive feature, user research already done"
    skip_risks:
      - "May miss edge cases"
      - "Hypotheses not formally validated"
    
  prioritize:
    status: complete
    started: 2026-11-06T18:20:00Z
    completed: 2026-11-06T18:30:00Z
    documents:
      prioritization.md:
        status: complete
        created: 2026-11-06T18:30:00Z
    exit_criteria_passed: true
    
  define:
    status: in_progress
    started: 2026-11-06T18:30:00Z
    documents:
      prd.md:
        status: in_progress
      project-brief.md:
        status: not_started
      metrics-framework.md:
        status: not_started
      project-plan.md:
        status: not_started
        
  design:
    status: not_started
    documents:
      design-brief.md:
        status: not_started
      flows.yaml:
        status: not_started
      wireframes.md:
        status: not_started
      prototype.html:
        status: not_started
        
  review:
    status: not_started
  deliver:
    status: not_started
  launch:
    status: not_started
  measure:
    status: not_started

gates_passed:
  - intake_approved
  - priority_confirmed

artifacts_registered:
  - id: figma-mockups
    type: figma-design
    url: "https://figma.com/file/xxx"
```

## Updating Progress

After each action, update `progress.yaml`:

```python
# Pseudo-code for progress updates
def complete_document(doc):
    progress.phases[current_phase].documents[doc].status = "complete"
    progress.phases[current_phase].documents[doc].created = now()
    progress.last_updated = now()
    
    if all_docs_complete(current_phase):
        check_exit_criteria(current_phase)
        
def advance_phase():
    progress.phases[current_phase].status = "complete"
    progress.phases[current_phase].completed = now()
    progress.current_phase = next_phase()
    progress.phases[current_phase].status = "in_progress"
    progress.phases[current_phase].started = now()
    progress.last_updated = now()
```
