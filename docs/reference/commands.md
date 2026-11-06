# Command Reference

Complete reference for all Product OS slash commands.

---

## Pipeline Commands

### /product-os:new-project

Run the full pipeline from intake to publication.

```
/product-os:new-project \
  --initiative <slug> \
  --project <slug> \
  --input "<requirement>" \
  [--skip-stages <list>] \
  [--targets <list>]
```

| Argument | Required | Description |
|----------|----------|-------------|
| `--initiative` | Yes | Initiative slug (kebab-case) |
| `--project` | Yes | Project slug (kebab-case) |
| `--input` | Yes | Raw requirement text or file path |
| `--skip-stages` | No | Stages to skip (comma-separated) |
| `--targets` | No | Flow render targets |

---

### /product-os:intake

Structure raw requirements into problem statement.

```
/product-os:intake --input "<requirement>" [--source "<source>"]
```

**Agent:** `intake-analyst.md`
**Output:** `intake.md`

---

### /product-os:prd

Generate comprehensive PRD.

```
/product-os:prd --from <intake.md>
```

**Agent:** `prd-author.md`
**Output:** `prd.md`

---

### /product-os:brief

Create one-page project brief.

```
/product-os:brief --from <prd.md>
```

**Agent:** `project-brief.md`
**Output:** `project-brief.md`

---

### /product-os:plan

Create project plan, RACI, and Gantt.

```
/product-os:plan --from <prd.md>
```

**Agent:** `project-planner.md`
**Output:** `project-plan.md`, `raci.md`, `gantt.md`

---

### /product-os:design-brief

Create design brief from PRD.

```
/product-os:design-brief --from <prd.md>
```

**Agent:** `product-designer.md`
**Output:** `design-brief.md`

---

### /product-os:flows

Generate user flows with multi-target rendering.

```
/product-os:flows --from <prd.md> [--targets <list>]
```

| Target | Output |
|--------|--------|
| mermaid | `flows.md` (always) |
| claude-artifact | `flows-artifact.html` |
| figjam | FigJam board (via MCP) |
| excalidraw | `flows.excalidraw` |
| drawio | `flows.drawio` |
| lucidchart | `flows-lucidchart.csv` |
| miro | `flows-miro.json` |
| whimsical | `flows-whimsical.md` |

**Agent:** `flow-designer.md`
**Output:** `flows.yaml`, `flows.md`, `journey-map.md`, `sitemap.md`

---

### /product-os:wireframes

Create low-fidelity wireframes.

```
/product-os:wireframes --from <flows.yaml> --brief <design-brief.md>
```

**Agent:** `wireframer.md`
**Output:** `wireframes.md`

---

### /product-os:prototype

Generate clickable prototypes.

```
/product-os:prototype --from <wireframes.md> --flows <flows.yaml>
```

**Agent:** `prototyper.md`
**Output:** `prototype.html`, `prototype-react.tsx`, `prompt-pack.md`

---

### /product-os:critique

Perform visual design critique.

```
/product-os:critique --designs <path> --prd <prd.md> [--figma-url <url>]
```

**Agent:** `design-critic.md`
**Output:** `design-critique.md`

---

### /product-os:ux-review

Evaluate against UX heuristics.

```
/product-os:ux-review --designs <path> --flows <flows.md>
```

**Agent:** `ux-reviewer.md`
**Output:** `ux-review.md`

---

### /product-os:a11y

Run accessibility audit.

```
/product-os:a11y --target <prototype.html|url> [--wcag <level>]
```

**Agent:** `accessibility-auditor.md`
**Output:** `accessibility-audit.md`, `a11y-issues.csv`

---

### /product-os:deliver

Generate epics and stories.

```
/product-os:deliver --from <prd.md> --designs <files>
```

**Agent:** `delivery-agent.md`
**Output:** `epics.md`, `stories.md`, `backlog.csv`

---

### /product-os:publish

Publish to Confluence.

```
/product-os:publish --project <path>
```

**Agent:** `confluence-publisher.md`
**Output:** Confluence pages, `publish-manifest.json`

---

### /product-os:jira-sync

Create/update Jira issues.

```
/product-os:jira-sync --project <path>
```

**Agent:** `jira-sync.md`
**Output:** Jira issues, `jira-sync-manifest.json`

---

## Tool Commands

### /product-os:prioritize

Apply prioritization frameworks.

```
/product-os:prioritize --items <prd.md> --framework <rice|wsjf|moscow|kano>
```

**Agent:** `strategist.md`

---

### /product-os:okrs

Define OKRs and metric trees.

```
/product-os:okrs [--context <strategy.md>]
```

**Agent:** `okr-agent.md`

---

### /product-os:roadmap

Create Now/Next/Later roadmap.

```
/product-os:roadmap --items <prioritized-items>
```

**Agent:** `roadmap-agent.md`

---

### /product-os:competitive

Create competitive analysis.

```
/product-os:competitive --competitors <list> --features <list>
```

**Agent:** `competitive-analyst.md`

---

### /product-os:experiment

Design A/B test.

```
/product-os:experiment --hypothesis "<hypothesis>" --metric <metric> --baseline <value>
```

**Agent:** `experiment-designer.md`

---

### /product-os:risks

Create risk register.

```
/product-os:risks --from <prd.md>
```

**Agent:** `risk-manager.md`

---

### /product-os:decision

Log a product decision.

```
/product-os:decision --title "<title>" --options "<options>" --decision "<outcome>"
```

**Agent:** `decision-logger.md`

---

### /product-os:retro

Facilitate retrospective.

```
/product-os:retro --context "<scope>"
```

**Agent:** `retro-facilitator.md`

---

### /product-os:prfaq

Write Amazon-style PR/FAQ.

```
/product-os:prfaq --product "<name>" --customer "<who>" --benefit "<why>"
```

**Agent:** `prfaq-author.md`

---

### /product-os:comms

Generate stakeholder communications.

```
/product-os:comms --type <exec-summary|update|release-notes|launch> --from <artifacts>
```

**Agent:** `stakeholder-comms.md`

---

### /product-os:research

Create research plan or synthesize findings.

```
/product-os:research plan --questions "<questions>"
/product-os:research synthesize --transcripts <files>
```

**Agent:** `ux-researcher.md`

---

### /product-os:figma

Interact with Figma via MCP.

```
/product-os:figma <tokens|audit|figjam|push> --url <figma-url> [options]
```

**Agent:** `figma-agent.md`
