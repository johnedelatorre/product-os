# Guided Workflow Skill

> Track PM progress through all 9 phases using `progress.yaml` state files. Missing information never blocks progress: defer it, keep going, resolve it later.

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
schema_version: "1.2"        # For migration compatibility
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
    status: enum             # not_started | in_progress | complete | complete_with_open_items | skipped
    started: ISO 8601 datetime
    completed: ISO 8601 datetime
    documents:
      <filename>:
        status: enum         # not_started | in_progress | complete | skipped | deferred
        created: ISO 8601 datetime
        skip_reason: string  # if skipped
        # if deferred ("come back later"):
        missing: string      # what information is missing
        owner: string        # who can provide it ("TBD" if unknown)
        revisit_by: enum     # phase by which to revisit (a phase name)
        deferred_on: ISO 8601 datetime
        open_item: string    # id of the matching entry in open_items
    exit_criteria:
      <criterion>:
        status: enum         # pass | fail | conditional | na | not_verified | deferred
        evidence: string     # what proves this
        notes: string        # additional context
        # if deferred: missing, owner, revisit_by, deferred_on, open_item (as for documents)
    exit_criteria_passed: boolean
    skip_reason: string      # if phase skipped
    skip_risks: list[string] # risks of skipping

gates_passed: list[string]   # e.g., intake_approved, priority_confirmed, prd_review_complete

# Everything deferred, across all phases
open_items:
  - id: string               # e.g., OI-1
    phase: string            # phase where the item was deferred
    item: string             # document filename or exit criterion key
    missing: string          # what information is missing
    owner: string            # who can provide it ("TBD" if unknown)
    revisit_by: string       # phase by which to revisit
    status: enum             # open | resolved
    resolved_on: ISO 8601 datetime   # if resolved
    accepted_risk:           # if carried past the pre-launch decision
      by: string             # who accepted the risk
      on: ISO 8601 datetime

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

Migrate on load, oldest first. Migration is non-destructive: all existing data preserved.

**From `1.0` to `1.1`** (no `schema_version`):
1. Set `schema_version: "1.1"`
2. Default `artifact_stages.prd` to `defined` if PRD exists
3. Default `artifact_stages.estimation` to `fibonacci` if stories exist
4. Convert boolean exit_criteria to structured format
5. Add empty `reviews` section

**From `1.1` to `1.2`:**
1. Set `schema_version: "1.2"`
2. Add empty `open_items` list if absent
3. For each document with status `tbd`:
   - Set status `deferred`
   - Set `missing` to `tbd_reason` (keep `tbd_reason` as is)
   - Set `owner: TBD`, `revisit_by: launch` (or the document's own phase if that comes after launch), `deferred_on` to the file's `last_updated`
   - Add a matching `open_items` entry with status `open` and link it with `open_item`

## Phase Order

```yaml
phases:
  1: intake       # Required (items can be deferred)
  2: discovery    # Optional (can be skipped)
  3: prioritize   # Required (items can be deferred)
  4: define       # Required (items can be deferred)
  5: design       # Required (items can be deferred)
  6: review       # Required (items can be deferred)
  7: deliver      # Required (items can be deferred)
  8: launch       # Required (items can be deferred)
  9: measure      # Required (items can be deferred)
```

## Status Transitions

```
Documents and exit criteria:
  not_started | in_progress → deferred      (PM: "I don't have this yet, come back later")
  fail → deferred                           (criterion failed; PM chooses defer over fix now)
  deferred → complete | pass                (PM resolves the open item)

Phases:
  not_started → in_progress → complete
  in_progress → complete_with_open_items    (rest complete or N/A, at least one item deferred)
  complete_with_open_items → complete       (all its open items resolved)
  not_started → skipped                     (optional phases only)
```

A phase can advance when every document and exit criterion is complete/pass, N/A, skipped or deferred.

## Deferring Items ("Come back later")

Any document or exit criterion in any phase can be deferred, required phases included.

1. Ask the PM in one short question: what is missing, who can provide it, and by which phase to revisit.
2. Default `revisit_by` to the next phase that depends on the item, or `launch`.
3. Never block on owner being unknown. Record `owner: TBD` and continue.
4. Record the deferral on the document or criterion and add an `open_items` entry.
5. Move on to the next step.

**Documents with gaps still get written.** When information is missing inside a document, the specialist writes the rest and marks the gap inline as a named TBD: what is missing and the owner, for example `**Baseline:** TBD (activation-rate baseline from Data team)`. Follow rule 8 of `.claude/skills/doc-hygiene.md`: a TBD names what is undecided. Each such gap becomes an open item.

**A failed criterion** (`fail`) means fix or defer. Deferring it records the same fields and creates an open item. `not_verified` behaviour for release gates is unchanged.

## Open Items

| When | What the guide does |
|------|---------------------|
| `/product-os:status` | Shows open items prominently, above the phase list |
| `/product-os:next` | Says how many items are open |
| PM reaches an item's `revisit_by` phase | Offers to resolve it first. An offer, never forced |
| PM says "I have it now" (any time) | Completes the document or criterion, sets the item `resolved` with `resolved_on` |
| Phase's last open item resolved | Moves the phase from `complete_with_open_items` to `complete` |

### Before Launch: Decide per Item

When the PM enters Launch, the guide lists every open item. For each, the PM chooses:

1. **Resolve now** — provide the information; the item becomes `resolved`
2. **Carry forward as an accepted risk** — the item stays `open` with `accepted_risk.by` (who accepted) and `accepted_risk.on`

This is a decision point, not a block.

## What Stays a Hard Stop

| Rule | Why |
|------|-----|
| Nothing is published to Confluence or Jira without explicit approval | Published pages and tickets reach other teams; a human owns what goes out |
| Code-shipping release gates: Not Verified blocks release, owner explicit GO required (`CLAUDE.md` "Code Shipping Requirements", `.claude/agents/gate-keeper.md`) | Shipping unverified code to users is not reversible by a doc edit |

Deferring an item never bypasses either rule.

## Exit Criteria by Phase

Each criterion has a status: `pass` | `fail` | `conditional` | `na` | `not_verified` | `deferred`

"Yes (or defer)" means the criterion must pass, or be deferred as an open item.

### Intake
| Criterion | Required |
|-----------|----------|
| Problem stated without solution bias | Yes (or defer) |
| Evidence documented | Yes (or defer) |
| Stakeholders identified | Yes (or defer) |
| PM approved problem framing | Yes (or defer) |

### Discovery (skippable)
| Criterion | Required |
|-----------|----------|
| Key hypotheses documented | Yes (or defer, or skip phase with risks) |
| At least one opportunity with evidence | Yes (or defer, or skip phase with risks) |

### Prioritize
| Criterion | Required |
|-----------|----------|
| Priority score calculated | Yes (or defer) |
| Roadmap placement decided | Yes (or defer) |
| Stakeholders aligned | Yes (or defer) |

### Define
| Criterion | Required |
|-----------|----------|
| PRD stage appropriate (Early/Defined/Delivery-ready) | Yes (or defer) |
| PRD review complete (if stage ≥ Defined) | Conditional (or defer) |
| PRD review blockers resolved | Conditional (or defer) |
| Success metrics have baselines and targets | Yes (or defer) |
| Stop criteria defined with owners | Yes (or defer) |
| RACI has one R per row | Yes (or defer) |
| Timeline has dependencies mapped | Yes (or defer) |

### Design
| Criterion | Required |
|-----------|----------|
| Flows cover happy path + errors | Yes (or defer) |
| Wireframes address all PRD requirements | Yes (or defer) |
| Prototype is testable | Yes (or defer) |

### Review (review exit check)
| Criterion | Required |
|-----------|----------|
| Every critique, UX and accessibility finding resolved (or accepted with documented risk) | Yes (or defer) |
| No critical design issues left open | Yes (or defer) |
| WCAG 2.2 AA compliance verified | Yes (or defer) |
| Not-verified items have investigation plan | Conditional (or defer) |

### Deliver
| Criterion | Required |
|-----------|----------|
| Stories have testable AC (Gherkin) | Yes (or defer) |
| Stories have points with rationale | Yes (or defer) |
| Spikes created for unknown scope | Conditional (or defer) |
| Testing requirements specified | Yes (or defer) |
| Observability requirements specified | Yes (or defer) |
| Traceability matrix complete | Yes (or defer) |
| Definition of Ready gate report complete with evidence | Yes (or defer) |
| Human approved publish | Yes (or defer; nothing publishes until approved) |

### Launch
| Criterion | Required |
|-----------|----------|
| Release notes published | Yes (or defer) |
| Support team enabled | Yes (or defer) |
| Monitoring and alerting in place | Yes (or defer) |
| Rollback procedure documented | Yes (or defer) |
| Stop criteria defined with owners | Yes (or defer) |
| Context verified fresh | Yes (or defer) |

### Measure
| Criterion | Required |
|-----------|----------|
| Metrics compared to targets with evidence | Yes (or defer) |
| Guardrails verified | Yes (or defer) |
| Learnings documented | Yes (or defer) |
| Decision review triggers evaluated | Yes (or defer) |
| Follow-up items created (or none needed) | Yes (or defer) |

## Commands

| Command | Action |
|---------|--------|
| `/product-os:guide` | Start or resume guided mode |
| `/product-os:status` | Show current progress |
| `/product-os:next` | Execute next recommended step |

## Example Progress File

```yaml
schema_version: "1.2"
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
    status: complete_with_open_items
    started: 2026-11-06T18:20:00Z
    completed: 2026-11-06T18:30:00Z
    documents:
      prioritization.md:
        status: complete
        created: 2026-11-06T18:30:00Z
    exit_criteria:
      priority_score_calculated:
        status: pass
        evidence: "prioritization.md §RICE"
      stakeholders_aligned:
        status: deferred
        missing: "Sales leadership sign-off on Q1 placement"
        owner: TBD
        revisit_by: define
        deferred_on: 2026-11-06T18:30:00Z
        open_item: OI-1
    exit_criteria_passed: false
    
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

open_items:
  - id: OI-1
    phase: prioritize
    item: stakeholders_aligned
    missing: "Sales leadership sign-off on Q1 placement"
    owner: TBD
    revisit_by: define
    status: open

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

    if all_docs_settled(current_phase):   # complete, skipped or deferred
        check_exit_criteria(current_phase)

def defer(item, missing, owner="TBD", revisit_by=None):
    # item is a document or an exit criterion (including one that failed)
    revisit_by = revisit_by or next_dependent_phase(item) or "launch"
    oi = {"id": next_open_item_id(), "phase": current_phase, "item": item.key,
          "missing": missing, "owner": owner, "revisit_by": revisit_by,
          "status": "open"}
    progress.open_items.append(oi)
    item.update(status="deferred", missing=missing, owner=owner,
                revisit_by=revisit_by, deferred_on=now(), open_item=oi["id"])
    progress.last_updated = now()

def resolve(open_item_id, evidence):
    oi = find_open_item(open_item_id)
    oi.status = "resolved"
    oi.resolved_on = now()
    item = find_item(oi.phase, oi.item)
    item.status = "pass" if item.is_criterion else "complete"
    item.evidence = evidence
    phase = progress.phases[oi.phase]
    if phase.status == "complete_with_open_items" and not open_items_in(oi.phase):
        phase.status = "complete"
    progress.last_updated = now()

def can_advance(phase):
    settled = {"complete", "pass", "na", "skipped", "deferred"}
    return all(i.status in settled for i in docs_and_criteria(phase))

def advance_phase():
    phase = progress.phases[current_phase]
    phase.status = "complete_with_open_items" if open_items_in(current_phase) else "complete"
    phase.completed = now()
    progress.current_phase = next_phase()
    progress.phases[current_phase].status = "in_progress"
    progress.phases[current_phase].started = now()
    progress.last_updated = now()
    due = [oi for oi in open_items() if oi.revisit_by == current_phase]
    if due:
        offer_to_resolve(due)          # an offer; PM may continue without resolving
    if current_phase == "launch":
        decide_open_items()            # per item: resolve now, or accept risk (by, on)
```
