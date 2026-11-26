# Command Reference

Complete reference for all 48 Product OS slash commands.

In Claude Code, commands come from the `product-os` plugin and are always namespaced as `/jdlt-product-os:<command>` (see the README for enabling the plugin). In Cursor, read the agent file listed for each command instead (role-based invocation).

Each entry shows the usage from the command file in `.claude/commands/<command>.md`; see that file for full arguments, examples, and outputs.

---

## Contents

- **Guided Mode & Sessions:** `guide`, `status`, `next`, `handover`
- **Full Pipeline:** `new-project`
- **Intake & Discovery:** `intake`, `propose`, `opportunity-tree`, `hypotheses`, `market`, `competitive`, `research`, `experiment`
- **Prioritize & Strategy:** `prioritize`, `roadmap`, `okrs`, `prfaq`
- **Define:** `prd`, `review-prd`, `brief`, `plan`, `metrics`, `tracking`, `risks`, `dependencies`
- **Design:** `design-brief`, `flows`, `wireframes`, `prototype`, `figma`, `artifacts`
- **Review & Gates:** `critique`, `ux-review`, `a11y`, `gate`
- **Deliver & Publish:** `deliver`, `publish`, `jira-sync`
- **Launch:** `launch`, `comms`, `release-gate`
- **Measure & Learn:** `review-launch`, `retro`
- **Governance & Code Shipping:** `decision`, `debt`, `cleanup`, `audit-intent`

---

## Guided Mode & Sessions

### /jdlt-product-os:guide

Start or resume guided mode, or jump to a specific phase.

```
/jdlt-product-os:guide --initiative <slug> --project <slug>
/jdlt-product-os:guide <phase>
/jdlt-product-os:guide --skip [<document|phase>]
```

Missing information for a step? Say so and keep going: the guide records an open item (what's missing, owner, revisit by) and moves on. Only Discovery can be skipped as a phase; any document or exit criterion can be deferred. Publishing and code-shipping release gates stay hard stops.

**Agent:** `guide.md`

---

### /jdlt-product-os:status

Show current progress through guided mode. Open items are listed first, with what's missing, owner and revisit phase.

```
/jdlt-product-os:status
/jdlt-product-os:status --initiative <slug> --project <slug>
/jdlt-product-os:status --verbose
```

**Agent:** `guide.md`

---

### /jdlt-product-os:next

Execute the next recommended step in guided mode. Says how many items are open and offers (never forces) to resolve those due in the current phase.

```
/jdlt-product-os:next
/jdlt-product-os:next --initiative <slug> --project <slug>
```

**Agent:** `guide.md`

---

### /jdlt-product-os:handover

Write the handover for next session: state, evidence, next action, blockers, owner decisions.

```
/jdlt-product-os:handover
/jdlt-product-os:handover --initiative <slug> --project <slug>
/jdlt-product-os:handover --what-next "finish billing stage"
```

**Skill:** `session-handover.md`

---

## Full Pipeline

### /jdlt-product-os:new-project

Run the full Product OS pipeline from intake to publication.

```
/jdlt-product-os:new-project --initiative <slug> --project <slug> --input "<requirement>"
```

**Agent:** `orchestrator.md`

---

## Intake & Discovery

### /jdlt-product-os:intake

Structure a raw requirement into a problem/opportunity statement.

```
/jdlt-product-os:intake --input "<requirement>" [--source "<source>"]
```

**Agent:** `intake-analyst.md`

---

### /jdlt-product-os:propose

Research an idea and propose what to build, interface first. For new ideas, not agreed changes or bugs.

```
/jdlt-product-os:propose --idea "I have an idea for..." --initiative <slug> --project <slug>
/jdlt-product-os:propose --next --initiative <slug> --project <slug>  # Product in use, new evidence
```

**Skill:** `beachhead-segment.md`, `proposal.md`

---

### /jdlt-product-os:opportunity-tree

Create an opportunity solution tree for discovery.

```
/jdlt-product-os:opportunity-tree --outcome <outcome> [--context <path>]
```

**Agent:** `opportunity-tree.md`

---

### /jdlt-product-os:hypotheses

Manage the hypothesis log for a project.

```
/jdlt-product-os:hypotheses --project <path> [--action <action>]
```

**Agent:** `hypothesis-logger.md`

---

### /jdlt-product-os:market

Create a market analysis brief.

```
/jdlt-product-os:market --market <market> [--depth <level>]
```

**Agent:** `market-analyst.md`

---

### /jdlt-product-os:competitive

Create competitive analysis.

```
/jdlt-product-os:competitive --competitors <list> --features <list>
```

**Agent:** `competitive-analyst.md`

---

### /jdlt-product-os:research

Create research plan or synthesize findings.

```
/jdlt-product-os:research plan --questions "<research questions>"
/jdlt-product-os:research synthesize --transcripts <files>
```

**Agent:** `ux-researcher.md`

---

### /jdlt-product-os:experiment

Design A/B test with sample size calculation.

```
/jdlt-product-os:experiment --hypothesis "<hypothesis>" --metric <metric> --baseline <value>
```

**Agent:** `experiment-designer.md`

---

## Prioritize & Strategy

### /jdlt-product-os:prioritize

Score and prioritize features using frameworks.

```
/jdlt-product-os:prioritize --items <prd.md|features.md> --framework <rice|wsjf|moscow|kano>
```

**Agent:** `strategist.md`

---

### /jdlt-product-os:roadmap

Create Now/Next/Later roadmap.

```
/jdlt-product-os:roadmap --items <prioritized-items>
```

**Agent:** `roadmap-agent.md`

---

### /jdlt-product-os:okrs

Define OKRs and metric trees.

```
/jdlt-product-os:okrs [--context <strategy.md>]
```

**Agent:** `okr-agent.md`

---

### /jdlt-product-os:prfaq

Write Amazon-style PR/FAQ.

```
/jdlt-product-os:prfaq --product "<name>" --customer "<who>" --benefit "<why>"
```

**Agent:** `prfaq-author.md`

---

## Define

### /jdlt-product-os:prd

Generate a comprehensive Product Requirements Document.

```
/jdlt-product-os:prd --from <intake.md> [--context <files>]
```

**Agent:** `prd-author.md`

---

### /jdlt-product-os:review-prd

Conduct a multi-perspective PRD review synthesizing feasibility, UX, strategy, research, privacy, and customer perspectives.

```
/jdlt-product-os:review-prd --from prd.md
/jdlt-product-os:review-prd --from prd.md --perspectives feasibility,ux,strategy
```


---

### /jdlt-product-os:brief

Create a one-page executive project brief.

```
/jdlt-product-os:brief --from <prd.md>
```

**Agent:** `project-brief.md`

---

### /jdlt-product-os:plan

Create project plan, RACI, and Gantt chart.

```
/jdlt-product-os:plan --from <prd.md> [--stories <stories.md>]
```

**Agent:** `project-planner.md`

---

### /jdlt-product-os:metrics

Design success metrics framework with north star and guardrails.

```
/jdlt-product-os:metrics --from <prd> [--goals <goals>]
```

**Agent:** `metrics-designer.md`

---

### /jdlt-product-os:tracking

Create an event tracking plan for analytics platforms.

```
/jdlt-product-os:tracking --from <source> [--platform <platform>]
```

**Agent:** `event-tracker.md`

---

### /jdlt-product-os:risks

Create and maintain risk register.

```
/jdlt-product-os:risks --from <prd.md|project-plan.md>
```

**Agent:** `risk-manager.md`

---

### /jdlt-product-os:dependencies

Manage project dependencies and risks.

```
/jdlt-product-os:dependencies --project <path> [--action <action>]
```

**Agent:** `dependency-tracker.md`

---

## Design

### /jdlt-product-os:design-brief

Create design brief from PRD.

```
/jdlt-product-os:design-brief --from <prd.md>
```

**Agent:** `product-designer.md`

---

### /jdlt-product-os:flows

Generate comprehensive user flows from PRD.

```
/jdlt-product-os:flows --from <prd.md> [--targets <list>]
```

**Agent:** `flow-designer.md`

---

### /jdlt-product-os:wireframes

Create low-fidelity wireframes from flows.

```
/jdlt-product-os:wireframes --from <flows.yaml> --brief <design-brief.md>
```

**Agent:** `wireframer.md`

---

### /jdlt-product-os:prototype

Generate clickable HTML/React prototypes from wireframes.

```
/jdlt-product-os:prototype --from <wireframes.md> --flows <flows.yaml>
```

**Agent:** `prototyper.md`

---

### /jdlt-product-os:figma

Interact with Figma via MCP.

```
/jdlt-product-os:figma <action> --url <figma-url> [options]
```

**Agent:** `figma-agent.md`

---

### /jdlt-product-os:artifacts

Manage the design artifact registry for a project.

```
/jdlt-product-os:artifacts --project <path> [--action <action>]
```

**Agent:** `artifact-registry.md`

---

## Review & Gates

### /jdlt-product-os:critique

Perform structured visual design critique.

```
/jdlt-product-os:critique --designs <path> --prd <prd.md> [--figma-url <url>]
```

**Agent:** `design-critic.md`

---

### /jdlt-product-os:ux-review

Evaluate designs against UX heuristics and patterns.

```
/jdlt-product-os:ux-review --designs <path> --flows <flows.md>
```

**Agent:** `ux-reviewer.md`

---

### /jdlt-product-os:ux-writing

Run the UX writing pass on the real designs and write the UX writing guide: the voice, the words, and the final copy for every screen. Paired with `/jdlt-product-os:critique`. Asks first for prior designs, screenshots or a style guide that show how the product already writes; with none, it works from the designs alone.

```
/jdlt-product-os:ux-writing --designs <path> --prd <prd.md> [--prior <paths>] [--critique <design-critique.md>]
```

**Output:** `ux-writing.md`, and the designs with the approved copy in them

**Agent:** `ux-writer.md`

---

### /jdlt-product-os:a11y

Run comprehensive accessibility audit.

```
/jdlt-product-os:a11y --target <prototype.html|url> [--wcag <level>]
```

**Agent:** `accessibility-auditor.md`

---

### /jdlt-product-os:gate

Check Definition of Ready or Definition of Done for stories.

```
/jdlt-product-os:gate --stories <path> --gate <dor|dod> [--strict]
```

**Agent:** `gate-keeper.md`

---

## Deliver & Publish

### /jdlt-product-os:deliver

Generate the engineering handoff: an epic that links to everything, lean tickets with estimates, and a ticket tree you approve. Confirms what goes to each reader group first.

```
/jdlt-product-os:deliver --from <prd.md> --designs <design-brief.md,wireframes.md>
```

**Agent:** `delivery-agent.md`

---

### /jdlt-product-os:publish

Publish to Confluence: a links page and the team's pages, with the documents you asked for under one PM workspace page.

```
/jdlt-product-os:publish --project <path> [--config <config.yaml>]
```

**Agent:** `confluence-publisher.md`

---

### /jdlt-product-os:jira-sync

Create and sync the epic (with its handoff links), stories and sub-tasks to Jira. Ends with the one link to share with the team: the epic.

```
/jdlt-product-os:jira-sync --project <path> [--config <config.yaml>]
```

**Agent:** `jira-sync.md`

---

## Launch

### /jdlt-product-os:launch

Create go-to-market materials for launch.

```
/jdlt-product-os:launch --project <path> [--version <version>] [--audience <audience>]
```

**Agent:** `launch-manager.md`

---

### /jdlt-product-os:comms

Generate stakeholder communications.

```
/jdlt-product-os:comms --type <exec-summary|update|release-notes|launch> --from <artifacts>
```

**Agent:** `stakeholder-comms.md`

---

### /jdlt-product-os:release-gate

Run the release gate: owner preview, go/no-go, independent review, verify build serves.

```
/jdlt-product-os:release-gate --initiative <slug> --project <slug>
/jdlt-product-os:release-gate --stage <stage-name> --initiative <slug> --project <slug>
```

**Skill:** `release-gate.md`, `shipping-artifacts.md`

---

## Measure & Learn

### /jdlt-product-os:review-launch

Conduct post-launch review comparing results to PRD goals.

```
/jdlt-product-os:review-launch --project <path> --prd <prd> [--days <days>]
```

**Agent:** `post-launch-reviewer.md`

---

### /jdlt-product-os:retro

Facilitate retrospective and capture learnings.

```
/jdlt-product-os:retro --context "<what we're reflecting on>"
```

**Agent:** `retro-facilitator.md`

---

## Governance & Code Shipping

### /jdlt-product-os:decision

Log a product decision (ADR style).

```
/jdlt-product-os:decision --title "<title>" --options "<options>" --decision "<outcome>"
```

**Agent:** `decision-logger.md`

---

### /jdlt-product-os:debt

Manage technical and design debt tracker.

```
/jdlt-product-os:debt [--project <path>] [--action <action>] [--type <type>]
```

**Agent:** `debt-tracker.md`

---

### /jdlt-product-os:cleanup

Clean version history out of project docs, Confluence pages and Jira tickets so they show the current state only.

```
/jdlt-product-os:cleanup --project <path> [--confluence] [--jira] [--dry-run]
```

**Agent:** `doc-cleaner.md` · **Skill:** `doc-hygiene.md`

---

### /jdlt-product-os:audit-intent

Audit code against documented intent: find gaps between what docs promise and what code enforces.

```
/jdlt-product-os:audit-intent --scope <path> --docs <path>
/jdlt-product-os:audit-intent --scope src/ --docs docs/
```

**Skill:** `intended-vs-implemented.md`, `shipping-artifacts.md`

---

## Related

- [Pipeline Overview](../guides/pipeline-overview.md)
- [Agent Guides](../guides/agents/index.md)
- [Guided Workflow](../guides/guided-workflow.md)
