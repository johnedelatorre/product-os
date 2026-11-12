# Acme Dashboard — Example Gallery

**A complete, fictional Product OS project you can read end to end and copy as templates.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Platform Performance | Dashboard Performance | Priya Shah (PM) | Approved | 2026-11-11 |

> **Fictional example.** Acme Corp, every person, number and link in this project are invented to show the Product OS format. Nothing here is real company or customer data.

## Description
This folder holds every document one project produces, from the first request to Jira stories, filled in with realistic content. Each file opens with the standard header (`docs/reference/document-format.md`), so you can see what a finished intake, PRD, metrics framework, user flow, wireframe, clickable prototype, design critique, UX review, accessibility audit, hub page, epic and story look like. Read them in the order below; it is the order Product OS creates them.

## Problem Statement
PMs and Heads of Product new to Product OS could not see what a finished Confluence page, epic or Jira story should look like, where flows and clickable wireframes are made, or where validation and metrics live. Without examples, every team invents its own format.

## Solution
One fictional project, Dashboard Performance (slow enterprise dashboards at a customer called Acme Corp), carried through every step. Each example names the command that produces it and where it ends up, so you can copy the file, replace the content and keep the structure.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| A new PM can find the example for any document type | — | In one click from this page | The table below |

## Next Action
Open [confluence/00-hub-page.md](confluence/00-hub-page.md) to see the project as a stakeholder sees it, then follow the table below in order.

---

## The gallery, in workflow order

| # | Example | What it is | Produced by | Ends up in |
|---|---------|-----------|-------------|------------|
| 1 | [intake/intake.md](intake/intake.md) | The raw request structured into a problem, evidence and affected users | `/product-os:intake` · `intake-analyst` | Confluence · 1. Strategy & Definition |
| 2 | [pm/project-brief.md](pm/project-brief.md) | One-page executive summary | `/product-os:brief` · `project-brief` | Confluence · 1. Strategy & Definition |
| 3 | [pm/prd.md](pm/prd.md) | Requirements, hypotheses, success metrics, rollout | `/product-os:prd` · `prd-author` | Confluence · 1. Strategy & Definition |
| 4 | [pm/metrics-framework.md](pm/metrics-framework.md) | North star, inputs, guardrails, stop criteria, **validation plan** | `/product-os:metrics` · `metrics-designer` | Confluence · 1. Strategy & Definition |
| 5 | [design/flows.md](design/flows.md) + [flows.yaml](design/flows.yaml) | User flows as Mermaid diagrams with step tables; YAML is the source | `/product-os:flows` · `flow-designer` | Confluence · 2. Design (YAML stays local) |
| 6 | [design/wireframes.md](design/wireframes.md) | Low-fi ASCII wireframes with annotations | `/product-os:wireframes` · `wireframer` | Confluence · 2. Design |
| 7 | [design/prototype.html](design/prototype.html) | Clickable low-fi prototype; open it in a browser | `/product-os:prototype` · `prototyper` | Confluence · 2. Design (attached to the Wireframes & Prototype page) |
| 8 | [design/design-critique.md](design/design-critique.md) | Critique of the actual prototype; every finding cites a screen and element | `/product-os:critique` · `design-critic` | Confluence · 2. Design |
| 9 | [design/ux-review.md](design/ux-review.md) | Heuristic evaluation of the same prototype; every finding cites screen, element and line | `/product-os:ux-review` · `ux-reviewer` | Confluence · 2. Design |
| 10 | [design/accessibility-audit.md](design/accessibility-audit.md) | WCAG 2.2 AA source audit of the same prototype; untestable checks marked Not Verified | `/product-os:a11y` · `accessibility-auditor` | Confluence · 2. Design |
| 11 | [jira/epic.md](jira/epic.md) | One epic: Summary + Description as Jira shows it | `/product-os:deliver` · `delivery-agent` | Jira (synced by `/product-os:jira-sync`); summarized in Confluence · 3. Delivery |
| 12 | [jira/stories.md](jira/stories.md) | Four stories with Gherkin acceptance criteria and design links | `/product-os:deliver` · `delivery-agent` | Jira; summarized in Confluence · 3. Delivery |
| 13 | [confluence/00-hub-page.md](confluence/00-hub-page.md) | The project hub page with the "Documents in this project" table | `/product-os:publish` · `confluence-publisher` | Confluence · project root page |

[confluence/README.md](confluence/README.md) shows the full Confluence page tree.

**Locally**, in your own repo, the same files live flat in `initiatives/<initiative>/<project>/` (here: `initiatives/platform-performance/dashboard-performance/prd.md`, `flows.yaml`, `prototype.html`, …). This gallery groups them into folders only to make it easier to browse.

## Looking for something specific?

| Question | Look here |
|----------|-----------|
| What does every page start with? | Any file: Title, Subtitle, header table, Description, Problem Statement, Solution, Success Metrics, Next Action |
| Where is validation? What does success look like? | [Metrics framework §5 and §7](pm/metrics-framework.md#7-validation-plan) and [PRD §2 Hypotheses & Validation](pm/prd.md#2-hypotheses--validation) |
| Where are user flow diagrams made? | [design/flows.md](design/flows.md), from [flows.yaml](design/flows.yaml) |
| Where are clickable wireframes? | [design/prototype.html](design/prototype.html) (open in a browser; ← → keys move between screens) |
| What does a real design critique look like? | [design/design-critique.md](design/design-critique.md) §1 "What was reviewed" and the line-level findings |
| What do a UX review and an accessibility audit look like? | [design/ux-review.md](design/ux-review.md), [design/accessibility-audit.md](design/accessibility-audit.md) (Not Verified checks say what is needed) |
| What does a Jira epic or story look like? | [jira/epic.md](jira/epic.md), [jira/stories.md](jira/stories.md) |
| How do the pieces trace to each other? | REQ-### (PRD) → FLOW-### → SCR-### (prototype `#scr-###`) → DASH-### stories; MET-### metrics |

## Using these as templates

1. Copy the file you need into `initiatives/<initiative>/<project>/`.
2. Keep the header and section headings; replace the content.
3. Write a missing number as a named TBD (what is missing, who provides it, by when), as in [metrics framework MET-012](pm/metrics-framework.md#3-outcome-metrics-lagging).
4. Or skip copying: run `/product-os:guide` and the agents produce these documents for your project in this format.

Blank templates: `templates/`. Format rules: `docs/reference/document-format.md`.
