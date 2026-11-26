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

# Optional. Who reads the documents, and the PM's role (start questions 2 and 3).
# Saved for the team under `audience` in product-os.config.yaml, and confirmed in one line on later projects.
audience:
  readers: list[string]      # engineers | product-lead | designers | executives | client | self
  role: enum                 # pm | design-lead | pm-and-design | founder | other

# Optional. What the PM is building and the material they provided (the start questions, asked first).
context:
  building: string           # one or two sentences: what is being built
  users: string              # who will use it
  origin: string             # who asked, when, and why now
  confirmed: boolean         # true once the PM accepts the playback
  sources:
    - kind: enum             # origin | request | feedback | market | data | product | technical | design | constraints | other
      ref: string            # file path or link
      note: string
      in_prd: boolean        # cited in the PRD; true by default, the PM can turn it off at PRD review
  not_provided: list[string] # kinds the PM said they do not have

# Optional. The design system to follow and the existing designs to match (start question 4). Saved for the team under `design_system`
# in product-os.config.yaml, and confirmed in one line on later projects.
design_system:
  sources:
    - kind: enum             # figma | claude | code
      ref: string            # link, or the name of the Claude design system
      note: string
  source_of_truth: enum      # figma | claude | code: which source wins when two disagree
  status: enum               # provided | none
  existing_designs:          # pages and screens already designed for this product
    - kind: enum             # figma | claude | screenshots
      ref: string
      note: string

# Optional. The documents made for the PM, as accepted in the playback (start question 7).
# Absent means the playback has not been accepted yet.
pm_documents: list[string]   # e.g. project-plan, gantt, raci, design-brief, metrics-framework

# Optional. What goes to the team (the outputs question, asked at the start of Deliver).
# Absent means the question has not been asked yet. See .claude/skills/engineering-handoff.md.
handoff:
  outputs: enum              # standard | everything
  extras: list[string]       # documents attached to the epic besides the standard set
  final_design: enum         # figma | claude
  organization: enum         # subtasks | flat
  subtask_kinds: list[string]      # frontend | backend | design | testing | tracking
  organization_approved: boolean   # true once the PM accepts the proposed ticket tree
  feedback:                        # what the readers said after the handoff
    - from: string                 # the reader group
      said: string
      change: string               # what it changes, e.g. "extras: add schema"
      saved_as_default: boolean    # true once the PM saved it as the team's default
```

`audience`, `design_system`, `context`, `pm_documents` and `handoff` are optional in schema `1.2`: files without them are valid and need no migration. The guide asks the matching question when one is missing. A document the PM did not ask for is `skipped` with `skip_reason: "not requested"`, and exit criteria that depend on it are `na`.

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

## The Status Board

Product OS is driven by a conversation with an agent. The agent asks, the PM answers, and the board shows where the project stands. Every interface shows the same board: as a panel in the Claude artifact, and as text in Claude Code, Claude chat and ChatGPT.

**Tasks.** The board has ten tasks: **Start** (the seven start questions) and the nine phases. Each task has a status and its own numbers.

| Status | Mark | Meaning |
|--------|------|---------|
| Done | ✓ | Every document is complete, or the phase passed its exit check |
| In progress | ● | The agent is asking about it or writing it now |
| Next | → | The task that follows the one in progress |
| Not started | ○ | Nothing asked or written yet |
| Skipped | – | Skipped, with the reason recorded |

**On every turn, open with two lines:** where the PM is, and the task counts.

```
Self-serve signup · Phase 4 of 9 · Define · PRD, question 2 of 3
Tasks: 3 done · 1 in progress · 6 not started · Open items: 2
```

**Show the whole board** when the PM asks ("show the board", `/product-os:status`), when a task finishes, and at the start of a session:

```
Self-serve signup · Phase 4 of 9 · Define
Tasks: 3 done · 1 in progress · 6 not started · Open items: 2

✓ Start          7 of 7 steps
✓ 1 Intake       1 of 1 document
– 2 Discovery    skipped: time-sensitive
✓ 3 Prioritize   1 of 1 document
● 4 Define       1 of 5 documents · PRD in progress
○ 5 Design       0 of 4 documents
○ 6 Review       0 of 2 documents
○ 7 Deliver      0 of 1 document
○ 8 Launch       0 of 2 documents
○ 9 Measure      0 of 1 document
```

Rules:
1. **The numbers come from `progress.yaml`**, never from memory. Documents counted are the ones in the PM's accepted playback.
2. **When a task finishes, show its result**: each document with its link or file name, and one line on what it decided.
3. **One task is in progress at a time.** Say which, and which question of how many.
4. **The board is a status table, not a list of advice.** It is the one place where a list runs past five lines.
5. **Never show a task as done** while a document in it is in progress or an exit criterion has failed.

### On a Phone

PMs also work from a phone: in the Claude and ChatGPT apps, and in Claude Code. The board, each task and every document are one short reply away on every interface.

| Interface | How the PM opens it |
|-----------|---------------------|
| Claude artifact | "Tasks and documents" in the bar at the top. The board slides out over the conversation. "Close" returns to the question. |
| Claude chat, ChatGPT | Reply `board`, `task 4` or `docs` |
| Claude Code | `/product-os:status --compact`, or the same three words |

Three short views:

```
board
Self-serve signup
Phase 4 of 9 · Define
3 done · 1 in progress · 6 to go

✓ Start · 7 of 7
✓ 1 Intake · 1 of 1
– 2 Discovery · skipped
✓ 3 Prioritize · 1 of 1
● 4 Define · 1 of 5
○ 5 Design · 0 of 4
○ 6 Review · 0 of 2
○ 7 Deliver · 0 of 1
○ 8 Launch · 0 of 2
○ 9 Measure · 0 of 1
```

```
task 4
● 4 Define · 1 of 5 documents
✓ project-brief.md
● prd.md · 15 of 19 sections
○ metrics-framework.md
○ project-plan.md
○ raci.md
```

`docs` lists every document under its phase, with its status mark and its link or file name.

Rules for a narrow screen:
1. **No tables.** One item per line, the status mark first.
2. **Lines under 40 characters.**
3. **Claude chat and ChatGPT always use these short views.** Claude Code uses the wide board unless the PM asks for `--compact` or says they are on a phone.
4. **After a view, repeat the open question** with its quick replies, so the PM answers without scrolling back.
5. **Name the three words** (`board`, `task <n>`, `docs`) at the start of a session and when a task finishes.

## Connectors and Settings

Every interface has one place that shows what Product OS is connected to and how it is set up. In the Claude artifact it is under More on the board: the page checks the PM's own Atlassian and Figma connectors and shows the real status, and the PM picks the Jira project and Confluence space from their real lists. In Claude chat and ChatGPT the PM replies `connectors` or `settings`. In Claude Code it is `/product-os:status --connectors` or `--settings`.

**Connectors**

| Connector | Used for | Without it |
|-----------|----------|------------|
| Confluence | Publishing the documents, after approval | The agent gives each page to paste |
| Jira | Creating the epic and the tickets, after approval | The agent gives the tickets to paste or import |
| Figma | Reading the design system and the designs | The PM attaches screenshots or exports |
| Claude Design | Reading the design system and the designs | The PM shares the link or attaches the file |

Each connector is `connected`, `not connected` or `not used`.

```
connectors
✓ Confluence · connected
✓ Jira · connected
○ Figma · not connected
   I work from the screenshots
   you attach.
– Claude Design · not used
```

**Settings**

| Setting | Where it is saved |
|---------|-------------------|
| Readers and the PM's role | `audience` in `progress.yaml` and `product-os.config.yaml` |
| Design system and its source of truth | `design_system` |
| Confluence space and Jira project | `confluence.space_key`, `jira.project_key` |
| Ticket size (up to 5 points) | `handoff.max_points` |
| Accessibility level (WCAG 2.2 AA) | `accessibility.wcag_level` |

Rules:
1. **Check, never assume.** A connector is `connected` only when the agent has that tool in this session. When it cannot tell, it says "not checked" and asks.
2. **A missing connector never blocks.** Say what happens without it, from the table above.
3. **Show the connectors in one line at the start of a session**, in full on request, and again before any step that needs one.
4. **A setting changes through a question** with quick replies, and the answer is saved for the team.
5. **Approval before publishing is not a setting.** It is always on.
6. **In Claude chat and ChatGPT there is no config file.** Show the values the PM gave, and mark the others "not set".

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
| UX writing pass done, and the final design carries the copy from the UX writing guide | Yes (or defer) |
| Not-verified items have investigation plan | Conditional (or defer) |

### Deliver
| Criterion | Required |
|-----------|----------|
| Outputs question answered and saved in `handoff` | Yes |
| The epic links to every handoff output; one final design | Yes (or defer) |
| Stories have a testable "Done when" checklist | Yes (or defer) |
| Stories have points; backend estimates marked as proposed | Yes (or defer) |
| PM accepted the proposed ticket tree | Yes (before Jira sync) |
| Spikes created for unknown scope | Conditional (or defer) |
| Testing, tracking and rollout recorded in the PRD and PM notes | Yes (or defer) |
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
