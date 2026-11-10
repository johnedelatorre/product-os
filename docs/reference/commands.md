# Command Reference

Complete reference for all 47 Product OS slash commands.

In Claude Code, commands come from the `product-os` plugin and are always namespaced as `/product-os:<command>` (see the README for enabling the plugin). In Cursor, read the agent file listed for each command instead (role-based invocation).

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

### /product-os:guide

Start or resume guided mode, or jump to a specific phase.

```
/product-os:guide --initiative <slug> --project <slug>
/product-os:guide <phase>
/product-os:guide --skip [<document|phase>]
```

Missing information for a step? Say so and keep going: the guide records an open item (what's missing, owner, revisit by) and moves on. Only Discovery can be skipped as a phase; any document or exit criterion can be deferred. Publishing and code-shipping release gates stay hard stops.

**Agent:** `guide.md`

---

### /product-os:status

Show current progress through guided mode. Open items are listed first, with what's missing, owner and revisit phase.

```
/product-os:status
/product-os:status --initiative <slug> --project <slug>
/product-os:status --verbose
```

**Agent:** `guide.md`

---

### /product-os:next

Execute the next recommended step in guided mode. Says how many items are open and offers (never forces) to resolve those due in the current phase.

```
/product-os:next
/product-os:next --initiative <slug> --project <slug>
```

**Agent:** `guide.md`

---

### /product-os:handover

Write the handover for next session: state, evidence, next action, blockers, owner decisions.

```
/product-os:handover
/product-os:handover --initiative <slug> --project <slug>
/product-os:handover --what-next "finish billing stage"
```

**Skill:** `session-handover.md`

---

## Full Pipeline

### /product-os:new-project

Run the full Product OS pipeline from intake to publication.

```
/product-os:new-project --initiative <slug> --project <slug> --input "<requirement>"
```

**Agent:** `orchestrator.md`

---

## Intake & Discovery

### /product-os:intake

Structure a raw requirement into a problem/opportunity statement.

```
/product-os:intake --input "<requirement>" [--source "<source>"]
```

**Agent:** `intake-analyst.md`

---

### /product-os:propose

Research an idea and propose what to build, interface first. For new ideas — not agreed changes or bugs.

```
/product-os:propose --idea "I have an idea for..." --initiative <slug> --project <slug>
/product-os:propose --next --initiative <slug> --project <slug>  # Product in use, new evidence
```

**Skill:** `beachhead-segment.md`, `proposal.md`

---

### /product-os:opportunity-tree

Create an opportunity solution tree for discovery.

```
/product-os:opportunity-tree --outcome <outcome> [--context <path>]
```

**Agent:** `opportunity-tree.md`

---

### /product-os:hypotheses

Manage the hypothesis log for a project.

```
/product-os:hypotheses --project <path> [--action <action>]
```

**Agent:** `hypothesis-logger.md`

---

### /product-os:market

Create a market analysis brief.

```
/product-os:market --market <market> [--depth <level>]
```

**Agent:** `market-analyst.md`

---

### /product-os:competitive

Create competitive analysis.

```
/product-os:competitive --competitors <list> --features <list>
```

**Agent:** `competitive-analyst.md`

---

### /product-os:research

Create research plan or synthesize findings.

```
/product-os:research plan --questions "<research questions>"
/product-os:research synthesize --transcripts <files>
```

**Agent:** `ux-researcher.md`

---

### /product-os:experiment

Design A/B test with sample size calculation.

```
/product-os:experiment --hypothesis "<hypothesis>" --metric <metric> --baseline <value>
```

**Agent:** `experiment-designer.md`

---

## Prioritize & Strategy

### /product-os:prioritize

Score and prioritize features using frameworks.

```
/product-os:prioritize --items <prd.md|features.md> --framework <rice|wsjf|moscow|kano>
```

**Agent:** `strategist.md`

---

### /product-os:roadmap

Create Now/Next/Later roadmap.

```
/product-os:roadmap --items <prioritized-items>
```

**Agent:** `roadmap-agent.md`

---

### /product-os:okrs

Define OKRs and metric trees.

```
/product-os:okrs [--context <strategy.md>]
```

**Agent:** `okr-agent.md`

---

### /product-os:prfaq

Write Amazon-style PR/FAQ.

```
/product-os:prfaq --product "<name>" --customer "<who>" --benefit "<why>"
```

**Agent:** `prfaq-author.md`

---

## Define

### /product-os:prd

Generate a comprehensive Product Requirements Document.

```
/product-os:prd --from <intake.md> [--context <files>]
```

**Agent:** `prd-author.md`

---

### /product-os:review-prd

Conduct a multi-perspective PRD review synthesizing feasibility, UX, strategy, research, privacy, and customer perspectives.

```
/product-os:review-prd --from prd.md
/product-os:review-prd --from prd.md --perspectives feasibility,ux,strategy
```


---

### /product-os:brief

Create a one-page executive project brief.

```
/product-os:brief --from <prd.md>
```

**Agent:** `project-brief.md`

---

### /product-os:plan

Create project plan, RACI, and Gantt chart.

```
/product-os:plan --from <prd.md> [--stories <stories.md>]
```

**Agent:** `project-planner.md`

---

### /product-os:metrics

Design success metrics framework with north star and guardrails.

```
/product-os:metrics --from <prd> [--goals <goals>]
```

**Agent:** `metrics-designer.md`

---

### /product-os:tracking

Create an event tracking plan for analytics platforms.

```
/product-os:tracking --from <source> [--platform <platform>]
```

**Agent:** `event-tracker.md`

---

### /product-os:risks

Create and maintain risk register.

```
/product-os:risks --from <prd.md|project-plan.md>
```

**Agent:** `risk-manager.md`

---

### /product-os:dependencies

Manage project dependencies and risks.

```
/product-os:dependencies --project <path> [--action <action>]
```

**Agent:** `dependency-tracker.md`

---

## Design

### /product-os:design-brief

Create design brief from PRD.

```
/product-os:design-brief --from <prd.md>
```

**Agent:** `product-designer.md`

---

### /product-os:flows

Generate comprehensive user flows from PRD.

```
/product-os:flows --from <prd.md> [--targets <list>]
```

**Agent:** `flow-designer.md`

---

### /product-os:wireframes

Create low-fidelity wireframes from flows.

```
/product-os:wireframes --from <flows.yaml> --brief <design-brief.md>
```

**Agent:** `wireframer.md`

---

### /product-os:prototype

Generate clickable HTML/React prototypes from wireframes.

```
/product-os:prototype --from <wireframes.md> --flows <flows.yaml>
```

**Agent:** `prototyper.md`

---

### /product-os:figma

Interact with Figma via MCP.

```
/product-os:figma <action> --url <figma-url> [options]
```

**Agent:** `figma-agent.md`

---

### /product-os:artifacts

Manage the design artifact registry for a project.

```
/product-os:artifacts --project <path> [--action <action>]
```

**Agent:** `artifact-registry.md`

---

## Review & Gates

### /product-os:critique

Perform structured visual design critique.

```
/product-os:critique --designs <path> --prd <prd.md> [--figma-url <url>]
```

**Agent:** `design-critic.md`

---

### /product-os:ux-review

Evaluate designs against UX heuristics and patterns.

```
/product-os:ux-review --designs <path> --flows <flows.md>
```

**Agent:** `ux-reviewer.md`

---

### /product-os:a11y

Run comprehensive accessibility audit.

```
/product-os:a11y --target <prototype.html|url> [--wcag <level>]
```

**Agent:** `accessibility-auditor.md`

---

### /product-os:gate

Check Definition of Ready or Definition of Done for stories.

```
/product-os:gate --stories <path> --gate <dor|dod> [--strict]
```

**Agent:** `gate-keeper.md`

---

## Deliver & Publish

### /product-os:deliver

Generate epics and user stories with acceptance criteria.

```
/product-os:deliver --from <prd.md> --designs <design-brief.md,wireframes.md>
```

**Agent:** `delivery-agent.md`

---

### /product-os:publish

Publish all project artifacts to Confluence.

```
/product-os:publish --project <path> [--config <config.yaml>]
```

**Agent:** `confluence-publisher.md`

---

### /product-os:jira-sync

Create and sync epics/stories to Jira.

```
/product-os:jira-sync --project <path> [--config <config.yaml>]
```

**Agent:** `jira-sync.md`

---

## Launch

### /product-os:launch

Create go-to-market materials for launch.

```
/product-os:launch --project <path> [--version <version>] [--audience <audience>]
```

**Agent:** `launch-manager.md`

---

### /product-os:comms

Generate stakeholder communications.

```
/product-os:comms --type <exec-summary|update|release-notes|launch> --from <artifacts>
```

**Agent:** `stakeholder-comms.md`

---

### /product-os:release-gate

Run the release gate: owner preview, go/no-go, independent review, verify build serves.

```
/product-os:release-gate --initiative <slug> --project <slug>
/product-os:release-gate --stage <stage-name> --initiative <slug> --project <slug>
```

**Skill:** `release-gate.md`, `shipping-artifacts.md`

---

## Measure & Learn

### /product-os:review-launch

Conduct post-launch review comparing results to PRD goals.

```
/product-os:review-launch --project <path> --prd <prd> [--days <days>]
```

**Agent:** `post-launch-reviewer.md`

---

### /product-os:retro

Facilitate retrospective and capture learnings.

```
/product-os:retro --context "<what we're reflecting on>"
```

**Agent:** `retro-facilitator.md`

---

## Governance & Code Shipping

### /product-os:decision

Log a product decision (ADR style).

```
/product-os:decision --title "<title>" --options "<options>" --decision "<outcome>"
```

**Agent:** `decision-logger.md`

---

### /product-os:debt

Manage technical and design debt tracker.

```
/product-os:debt [--project <path>] [--action <action>] [--type <type>]
```

**Agent:** `debt-tracker.md`

---

### /product-os:cleanup

Clean version history out of project docs, Confluence pages and Jira tickets so they show the current state only.

```
/product-os:cleanup --project <path> [--confluence] [--jira] [--dry-run]
```

**Agent:** `doc-cleaner.md` · **Skill:** `doc-hygiene.md`

---

### /product-os:audit-intent

Audit code against documented intent: find gaps between what docs promise and what code enforces.

```
/product-os:audit-intent --scope <path> --docs <path>
/product-os:audit-intent --scope src/ --docs docs/
```

**Skill:** `intended-vs-implemented.md`, `shipping-artifacts.md`

---

## Related

- [Pipeline Overview](../guides/pipeline-overview.md)
- [Agent Guides](../guides/agents/index.md)
- [Guided Workflow](../guides/guided-workflow.md)
