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
initiative: string           # e.g., "customer-onboarding"
project: string              # e.g., "self-serve-signup"
created: ISO 8601 datetime
last_updated: ISO 8601 datetime

current_phase: enum          # intake | discovery | prioritize | define | design | review | deliver | launch | measure
current_document: string     # filename currently in progress

phases:
  <phase-name>:
    status: enum             # not_started | in_progress | complete | skipped
    started: ISO 8601 datetime
    completed: ISO 8601 datetime
    documents:
      <filename>:
        status: enum         # not_started | in_progress | complete | skipped
        created: ISO 8601 datetime
        skip_reason: string  # if skipped
    exit_criteria_passed: boolean
    skip_reason: string      # if phase skipped
    skip_risks: list[string] # risks of skipping

gates_passed: list[string]   # e.g., intake_approved, priority_confirmed

artifacts_registered: list
  - id: string
    type: string
    url: string
```

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

### Intake
- Problem stated without solution bias
- Evidence documented
- Stakeholders identified
- PM approved problem framing

### Discovery (skippable)
- Key hypotheses documented OR skip risks acknowledged

### Prioritize
- Priority score calculated
- Roadmap placement decided
- Stakeholders aligned

### Define
- PRD approved by stakeholders
- Success metrics have baselines and targets
- RACI has one R per row
- Timeline has dependencies mapped

### Design
- Flows cover happy path + errors
- Wireframes address all PRD requirements
- Prototype is testable

### Review
- No critical design issues
- WCAG 2.2 AA compliance
- All stories pass Definition of Ready

### Deliver
- Stories have acceptance criteria
- Stories have points and discipline labels
- Confluence pages published
- Jira issues created

### Launch
- Release notes published
- Support team enabled
- Monitoring in place

### Measure
- Metrics compared to targets
- Learnings documented
- Follow-up items created

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
