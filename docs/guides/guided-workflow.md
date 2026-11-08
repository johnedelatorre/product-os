# Guided Workflow Playbook

> **TL;DR:** Run `/product-os:guide` to walk through all 9 phases step-by-step. Progress tracked in `progress.yaml`. Skip phases with documented risks. Check status with `/product-os:status`.

---

## Quick Start

```bash
# Start guided mode for a new initiative
/product-os:guide --initiative customer-onboarding --project signup

# Resume where you left off
/product-os:guide

# Check progress
/product-os:status

# Do the next step
/product-os:next
```

---

## The 9 Phases

| # | Phase | Purpose | Can Skip? |
|---|-------|---------|-----------|
| 1 | **Intake** | Transform raw requirements into clear problem statement | No |
| 2 | **Discovery** | Explore problem space before committing | Yes |
| 3 | **Prioritize** | Decide if and when to build | No |
| 4 | **Define** | PRD, brief, metrics, plan | No |
| 5 | **Design** | Flows, wireframes, prototype | No |
| 6 | **Review** | Critique, UX review, accessibility, gates | No |
| 7 | **Deliver** | Epics, stories, Confluence, Jira | No |
| 8 | **Launch** | Release notes, enablement | No |
| 9 | **Measure** | Post-launch review, follow-ups | No |

---

## Phase Flow

```mermaid
sequenceDiagram
    participant PM as Product Manager
    participant Guide as Guide Agent
    participant Spec as Specialist Agent
    participant Progress as progress.yaml

    PM->>Guide: /product-os:guide
    Guide->>Progress: Load or create state
    Guide->>PM: Show current phase, explain purpose
    
    loop For each document in phase
        Guide->>PM: Ask key questions
        PM->>Guide: Provide inputs
        Guide->>Spec: Delegate document creation
        Spec->>Guide: Return document
        Guide->>Progress: Update document status
        Guide->>PM: Show result, ask for review
    end
    
    Guide->>Progress: Check exit criteria
    alt Exit criteria passed
        Guide->>Progress: Mark phase complete
        Guide->>PM: Advance to next phase
    else Exit criteria not met
        Guide->>PM: Show gaps, suggest fixes
    end
```

---

## What Gets Created

### Phase 1: Intake

| Document | Agent | Template |
|----------|-------|----------|
| `intake.md` | intake-analyst | `templates/intake/intake.md` |

**Exit Criteria:**
- [ ] Problem stated without solution bias
- [ ] Evidence documented
- [ ] Stakeholders identified
- [ ] PM approved problem framing

**After Intake: Routing Decision**

The Guide routes based on intake type:

| Intake Type | Route | Reason |
|-------------|-------|--------|
| **New idea** | → Proposal (1.5) | Needs research, interface-first thinking |
| **Agreed change** | → Discovery (2) or Define (4) | Solution direction known |
| **Bug fix** | → Deliver (7) | Skip PM phases |
| **Small tweak** | → Direct implementation | No full workflow needed |

---

### Phase 1.5: Proposal (For New Ideas)

| Document | Agent | Template |
|----------|-------|----------|
| `proposal.md` | (via skill) | See `.claude/skills/proposal.md` |

**When Required:**
- New product idea
- Major feature requiring research
- Direction not yet agreed

**Exit Criteria:**
- [ ] Research phase complete with claim types documented
- [ ] Feasibility rough-checked
- [ ] Interface draft shows key screens
- [ ] Jobs-screen mapping complete
- [ ] Proposal accepted, rejected, or deferred

**If Rejected:** Archive with reason, stop workflow.
**If Deferred:** Park for later, stop workflow.
**If Accepted:** Continue to Discovery or Define.

See `.claude/skills/proposal.md` for the full proposal process.

---

### Phase 2: Discovery (Optional)

| Document | Agent | Template |
|----------|-------|----------|
| `opportunity-tree.yaml` | opportunity-tree | — |
| `hypothesis-log.yaml` | hypothesis-logger | — |
| `market-analysis.md` | market-analyst | `templates/discovery/market-analysis.md` |
| `research-synthesis.md` | ux-researcher | — |

**Exit Criteria:**
- [ ] Key hypotheses documented
- [ ] At least one opportunity identified with evidence

**Skip Risks (if skipping):**
- Hypotheses not formally validated
- May miss edge cases in user journeys
- Competitive blind spots possible

---

### Phase 3: Prioritize

| Document | Agent | Template |
|----------|-------|----------|
| `prioritization.md` | strategist | `templates/pm/prioritization.md` |
| `roadmap.md` | roadmap-agent | `templates/pm/roadmap.md` |

**Exit Criteria:**
- [ ] Priority score calculated (RICE/WSJF)
- [ ] Roadmap placement decided
- [ ] Stakeholders aligned on priority

---

### Phase 4: Define

| Document | Agent | Template |
|----------|-------|----------|
| `prd.md` | prd-author | `templates/pm/prd.md` |
| `prd-review.md` | (multi-perspective) | `templates/pm/prd-review.md` |
| `project-brief.md` | project-brief | `templates/pm/project-brief.md` |
| `metrics-framework.md` | metrics-designer | `templates/pm/metrics-framework.md` |
| `project-plan.md` | project-planner | `templates/pm/project-plan.md` |

**PRD Stages:**
| Stage | When to Use | PRD Review Required |
|-------|-------------|---------------------|
| Early | Exploring, hypotheses only | No (optional) |
| Defined | Requirements complete | Yes |
| Delivery-ready | Evidence gathered, metrics baselined | Yes |

**Exit Criteria:**
- [ ] PRD stage matches intent (Early for exploration, Defined+ for design)
- [ ] PRD review complete with blockers resolved (if stage ≥ Defined)
- [ ] Success metrics have baselines (with dates) and targets
- [ ] Stop criteria defined with owners
- [ ] RACI has one R per row
- [ ] Timeline has dependencies mapped

---

### Phase 5: Design

| Document | Agent | Template |
|----------|-------|----------|
| `design-brief.md` | product-designer | `templates/design/design-brief.md` |
| `flows.yaml` | flow-designer | — |
| `wireframes.md` | wireframer | — |
| `prototype.html` | prototyper | — |

**Exit Criteria:**
- [ ] Flows cover happy path + error states
- [ ] Wireframes address all PRD requirements
- [ ] Prototype is testable

---

### Phase 6: Review & Gates

| Document | Agent | Template |
|----------|-------|----------|
| `design-critique.md` | design-critic | `templates/design/design-critique.md` |
| `ux-review.md` | ux-reviewer | `templates/design/ux-review.md` |
| `accessibility-audit.md` | accessibility-auditor | `templates/design/accessibility-audit.md` |
| `gate-report.md` | gate-keeper | — |

**Gate Status Key:**
| Status | Meaning |
|--------|---------|
| ✅ Pass | Criteria met with evidence |
| ⚠️ Conditional | Minor gaps, can proceed with conditions |
| ❌ Fail | Critical missing, cannot proceed |
| N/A | Not applicable (documented reason) |
| 🔍 Not Verified | Cannot confirm, investigate first |

**Exit Criteria:**
- [ ] No critical design issues (or accepted with documented risk)
- [ ] WCAG 2.2 AA compliance verified
- [ ] Gate report complete with evidence for each criterion
- [ ] Not-verified items have investigation plan

---

### Phase 7: Deliver

| Document | Agent | Template |
|----------|-------|----------|
| `epics.md` | delivery-agent | `templates/delivery/epic.md` |
| `stories.md` | delivery-agent | `templates/delivery/user-story.md` |
| `traceability.md` | — | `templates/delivery/traceability.md` |
| `tracking-plan.yaml` | event-tracker | — |
| Confluence pages | confluence-publisher | — |
| Jira issues | jira-sync | — |

**Estimation Guidance:**
| Level | Method | Who |
|-------|--------|-----|
| Epic | T-shirt (S/M/L/XL) or weeks range | Tech Lead |
| Story | Fibonacci (1-13) | Delivery team |
| Unknown | Spike first | Team |

**Exit Criteria:**
- [ ] Stories have testable acceptance criteria (Gherkin)
- [ ] Stories have points with rationale
- [ ] Spikes created for unknown scope (no fabricated AC)
- [ ] Testing and observability requirements specified
- [ ] Traceability matrix complete (gaps have reasons)
- [ ] **Human approved** Confluence/Jira publish

---

### Phase 8: Launch

| Document | Agent | Template |
|----------|-------|----------|
| `release-notes.md` | launch-manager | `templates/launch/release-notes.md` |
| `enablement.md` | launch-manager | — |
| `launch-checklist.md` | launch-manager | — |
| `decision-log.md` | decision-logger | — |

**Context Freshness Check:**
Before launch, verify:
- [ ] PRD reflects what was actually built
- [ ] Metrics baselines are recent (within 30 days)
- [ ] Dependencies confirmed ready
- [ ] Rollback procedure still valid

**Exit Criteria:**
- [ ] Release notes published
- [ ] Support team enabled
- [ ] Monitoring and alerting in place
- [ ] Rollback procedure documented and tested
- [ ] Stop criteria defined with owners

---

### Phase 9: Measure

| Document | Agent | Template |
|----------|-------|----------|
| `post-launch-review.md` | post-launch-reviewer | `templates/pm/post-launch-review.md` |
| `decision-log.md` | decision-logger | — |
| `followup-intake.md` | intake-analyst | `templates/intake/intake.md` |

**Metrics Review:**
| Check | Evidence Required |
|-------|-------------------|
| Did we hit targets? | Actual vs target with dashboard link |
| Did guardrails breach? | Guardrail metrics status |
| Should we stop/rollback? | Stop criteria evaluation |
| Decision review triggers met? | Check each logged decision |

**Exit Criteria:**
- [ ] Metrics compared to targets **with evidence**
- [ ] Guardrails verified (not assumed ok)
- [ ] Learnings documented with specifics
- [ ] Decision review triggers evaluated
- [ ] Follow-up items created (or explicit "none needed")

---

## Commands Reference

| Command | Description |
|---------|-------------|
| `/product-os:guide` | Start or resume guided mode |
| `/product-os:guide <phase>` | Jump to a specific phase |
| `/product-os:guide --skip` | Skip current phase with documented risks |
| `/product-os:status` | Show current progress |
| `/product-os:status --verbose` | Show detailed document status |
| `/product-os:next` | Execute next recommended step |

---

## Progress Tracking

Progress is tracked in `initiatives/<slug>/<project>/progress.yaml`:

```yaml
initiative: customer-onboarding
project: self-serve-signup
current_phase: define
current_document: prd.md

phases:
  intake:
    status: complete
    exit_criteria_passed: true
  discovery:
    status: skipped
    skip_reason: "Time-sensitive feature"
    skip_risks:
      - "May miss edge cases"
  define:
    status: in_progress
    documents:
      prd.md:
        status: in_progress

gates_passed:
  - intake_approved
  - priority_confirmed
```

---

## Best Practices

### 1. Don't Skip Too Much

Discovery is optional, but skipping it has risks. Document why you're skipping and what could go wrong.

### 2. Review Exit Criteria

Each phase has exit criteria. Don't advance until they're met — or explicitly document why you're proceeding anyway.

### 3. Use Verbose Status

`/product-os:status --verbose` shows exactly which sections of which documents need attention.

### 4. Trust the Flow

Guided mode is designed to ensure nothing falls through the cracks. Let it prompt you for what's next.

---

## Bringing Existing Work

### Existing PRD

If you already have a PRD and want to use guided mode:

1. Copy your PRD to `initiatives/<initiative>/<project>/prd.md`
2. Run `/product-os:guide --initiative <slug> --project <slug>`
3. Guide detects `prd.md` exists and marks Define phase partially complete
4. Continue from current state

### Existing Progress

If you have a `progress.yaml` from an earlier version:

1. Guide auto-migrates v1.0 schemas to v1.1
2. New fields get sensible defaults
3. All existing progress preserved
4. Review the migrated file to add new optional fields

### Mid-Project Start

You don't have to start at Intake:

1. Run `/product-os:guide <phase>` to jump directly to any phase
2. Prior phases marked as skipped (you can fill them in later)
3. Guide warns about missing dependencies but doesn't block

---

## FAQ

**Q: Can I jump around phases?**
A: Yes. Run `/product-os:guide <phase>` to jump. Progress is tracked per-phase, so you can always go back.

**Q: What if I already have some documents?**
A: Guide will detect existing files and mark them complete in `progress.yaml`.

**Q: Can I use Product OS without guided mode?**
A: Of course. Run individual commands like `/product-os:prd` directly. Guided mode is optional.

**Q: How do I restart from scratch?**
A: Delete the `progress.yaml` file and run `/product-os:guide` again.

**Q: What if PRD review finds blockers?**
A: Blockers must be resolved before design phase. Guide tracks blocker status in `progress.yaml` and won't advance until cleared.

**Q: Can I have an Early-stage PRD and still proceed?**
A: Yes. Early PRDs can skip PRD Review and proceed to design for exploration. Mark the PRD as Defined once requirements are solid.

**Q: What about publishing to Confluence/Jira?**
A: Publishing always requires explicit human approval. Guide will prompt; never auto-publishes.
