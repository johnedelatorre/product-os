# From PRD to Reviewed Designs

**A step-by-step guide for PMs: where flows, wireframes and the clickable prototype are made, how to open them, and how they get reviewed.**

| Initiative | Project | Owner | Status | Last updated |
|------------|---------|-------|--------|--------------|
| Product OS | Design workflow guide | John De La Torre-Ugarte | Approved | 2026-11-11 |

## Description
This page walks through the design phase of Product OS in order: design brief, user flow diagrams, wireframes, clickable prototype, optional Figma, then design critique, UX review and accessibility audit on those real artifacts, then the review exit check. The Definition of Ready gate runs later, on the stories, in Deliver. Each step lists the command, what you get, the file, how to view or share it, and what you check before moving on.

## Problem Statement
PMs need to know where user flow diagrams and clickable low-fidelity wireframes are created and how to open them, and need to trust that design reviews are based on the real designs, not invented ones.

## Solution
One page that names every design command, output file and viewer, and states the rule that every review runs on the actual design files and cites the screen it is about.

## Success Metrics
| Metric | Baseline | Target | How we measure |
|--------|----------|--------|----------------|
| PMs who can open flows, wireframes and prototype without help | TBD: John collects from the next PM onboarding | TBD: John sets the target | Onboarding check-in |
| Review findings with a screen/frame citation | TBD: John samples current reviews | 100% | Spot-check `design-critique.md`, `ux-review.md`, `accessibility-audit.md` |

## Next Action
Run step 1 (`/product-os:design-brief`) on your approved PRD.

---

## Where Everything Lives

Every design file is written to your project folder: `initiatives/<initiative>/<project>/`. After approval, `/product-os:publish` puts each one on its own page under **2. Design** in the project's Confluence hub (see `docs/reference/document-format.md`).

## The Steps at a Glance

| # | Step | Command | You get | Open it with |
|---|------|---------|---------|--------------|
| 1 | Design brief | `/product-os:design-brief` | `design-brief.md` | Any Markdown viewer |
| 2 | User flows | `/product-os:flows` | `flows.md` (diagrams), `flows.yaml` | GitHub, claude.ai or a Mermaid preview |
| 3 | Wireframes | `/product-os:wireframes` | `wireframes.md` | Any Markdown viewer |
| 4 | Clickable prototype | `/product-os:prototype` | `prototype.html` | Your browser |
| 5 | Figma (optional) | `/product-os:figma` | FigJam board, Figma frames | Figma |
| 6 | Reviews | `/product-os:critique`, `/product-os:ux-review`, `/product-os:a11y` | Three review reports | Any Markdown viewer |
| 7 | Review exit check (Phase 6) | Guided mode checks the Phase 6 exit criteria | Findings resolved or accepted | `progress.yaml` |
| 8 | Definition of Ready gate (Deliver, once stories exist) | `/product-os:gate --stories stories.md --gate dor` | Gate result | `gate-report.md` |

Guided mode (`/product-os:guide`) runs steps 1 to 7 in order as phases 5 and 6, then step 8 in phase 7 (Deliver), and tracks them in `progress.yaml`.

---

## Step 1: Design Brief

| | |
|---|---|
| **Command** | `/product-os:design-brief --from initiatives/<initiative>/<project>/prd.md` |
| **What you get** | Design goals, principles with trade-off guidance, constraints (technical, business, accessibility, platform), design system patterns, success criteria |
| **File** | `design-brief.md` (template: `templates/design/design-brief.md`) |
| **View / share** | Any Markdown viewer (GitHub, VS Code, claude.ai). Confluence: **Design Brief** page |
| **Agent** | `product-designer` |

**PM checks:**
1. Every PRD requirement has a design implication.
2. One primary design goal, with a metric.
3. Accessibility target is WCAG 2.2 AA.

## Step 2: User Flows (Diagrams)

| | |
|---|---|
| **Command** | `/product-os:flows --from prd.md` (in Claude Code, add `--targets claude-artifact,figjam` for extra formats) |
| **What you get** | Task flows, user flows with error/empty/permission/timeout paths, system swimlanes, journey map, sitemap, PRD traceability |
| **Files** | `flows.md` (Mermaid diagrams, always), `flows.yaml` (source of truth), `journey-map.md`, `sitemap.md`, `flow-traceability.md` |
| **View / share** | `flows.md` renders as diagrams on GitHub, in claude.ai and in editors with a Mermaid preview. In claude.ai, if a diagram doesn't render, ask Claude to show the flow as an artifact or diagram (the `--targets` flag is Claude Code only). The `claude-artifact` target gives interactive HTML: open in a browser or as a claude.ai artifact. The `figjam` target gives a FigJam board (Figma MCP needed). Confluence: **User Flows** page, diagrams via the Mermaid macro (or PNG if the macro is not installed) |
| **Agent** | `flow-designer` |

**PM checks:**
1. Every use case in the PRD has a flow.
2. Each flow has a happy path and error paths; no dead ends.
3. Traceability maps every flow step to a requirement.

## Step 3: Wireframes

| | |
|---|---|
| **Command** | `/product-os:wireframes --from flows.yaml --brief design-brief.md` |
| **What you get** | Screen inventory (`SCR-###` IDs) and one grayscale lo-fi wireframe per screen, annotated for interactions, responsive behaviour, accessibility and states |
| **File** | `wireframes.md` (ASCII by default; ask for HTML wireframes, e.g. `wireframes/registration.html`, when you need higher fidelity) |
| **View / share** | Any Markdown viewer; HTML wireframes open in a browser. Confluence: **2. Design → Wireframes & Prototype** page |
| **Agent** | `wireframer` |

**PM checks:**
1. Every screen named in the flows is in the inventory.
2. Real content, no lorem ipsum.
3. Empty, loading, error and success states are drawn.

## Step 4: Clickable Prototype (Low-Fi)

| | |
|---|---|
| **Command** | `/product-os:prototype --from wireframes.md --flows flows.yaml` |
| **What you get** | The wireframed screens made clickable: navigation between screens, simulated states, toggleable annotations with flow and PRD references. It tests flows, not final visual design |
| **Files** | `prototype.html` (self-contained), `prototype-react.tsx` (claude.ai Artifact version), `prompt-pack.md` (prompts for claude.ai) |
| **View / share** | Double-click `prototype.html` to open it in any browser; no install or server. Keys: `→`/`←` move through the flow, `a` toggles annotations. Share the file, or host it as static HTML. Paste `prototype-react.tsx` into claude.ai to get a shareable Artifact. Confluence: **2. Design → Wireframes & Prototype** page, with the prototype attached or linked (TBD: attach vs hosted link is not yet defined by the publisher; the PM decides per project) |
| **Agent** | `prototyper` |

**PM checks:**
1. Click through every flow end to end.
2. Error and empty states are reachable.
3. Annotations point to the right PRD requirements.

## Step 5: Figma (Optional)

| | |
|---|---|
| **Command** | `/product-os:figma <tokens\|audit\|figjam\|push> --url <figma-url>`; for flows: `/product-os:figma figjam --flows flows.yaml --url <figma-url>` |
| **What you get** | `figjam`: a FigJam board of the flows. `push`: wireframe frames in Figma as a starting point. `audit`: `figma-audit.md`, Figma designs checked against the PRD. `tokens`: `design-tokens.yaml` |
| **View / share** | Open the Figma or FigJam link. Link boards and frames from the User Flows and Wireframes & Prototype pages in Confluence |
| **Agent** | `figma-agent` (needs the Figma MCP, see `docs/setup/figma-mcp.md`) |

**PM checks:**
1. The Figma link is recorded so reviewers can read real frames.
2. Audit shows no missing requirements, or each gap is tracked.

## Step 6: Reviews on the Real Designs

All three reviews run on the files from steps 3 to 5, never on a described or imagined screen. Each report opens with the standard header and a **What was reviewed** table (sources, frame/screen IDs, version, review date). Every finding cites the exact screen, frame and element. Anything the reviewer could not inspect is marked **Not Verified**. If no design is available, the agent stops and asks you for one.

| Review | Command | Reviews | File | Agent |
|--------|---------|---------|------|-------|
| Design critique | `/product-os:critique --designs wireframes.md --prd prd.md` (or `--figma-url <url>`) | Hierarchy, layout, typography, colour, spacing, consistency, content, PRD and brand alignment | `design-critique.md` | `design-critic` |
| UX review | `/product-os:ux-review --designs prototype.html --flows flows.md` | Nielsen's 10 heuristics, Laws of UX, pattern best practices | `ux-review.md` | `ux-reviewer` |
| Accessibility audit | `/product-os:a11y --target prototype.html` | WCAG 2.2 AA; automated scans, keyboard and screen reader need the prototype in a browser or a live URL | `accessibility-audit.md`, `a11y-issues.csv` | `accessibility-auditor` |

What can be verified depends on what you give the reviewer:

| You provide | Verified | Not Verified |
|-------------|----------|--------------|
| `wireframes.md` only | Layout, hierarchy, content, PRD alignment, labels, heading order | Colour, contrast, typography, brand, interaction, keyboard, screen reader |
| `prototype.html` | Above, plus navigation, states, interaction heuristics, automated scans, keyboard | Final colour and brand (low-fi), screen reader unless run with one |
| Figma link | Colour, contrast, typography, spacing, brand, component use | Interaction, keyboard, screen reader |

**PM checks:**
1. The **What was reviewed** table lists the files you expect, with screen IDs.
2. Every finding names a screen and element you can find in the design.
3. Not Verified items each have an owner or a follow-up review.

## Step 7: Review Exit Check (Phase 6)

| | |
|---|---|
| **What happens** | Guided mode checks the Phase 6 exit criteria before Deliver starts |
| **What you get** | Each criterion marked passed, N/A or deferred as an open item, recorded in `progress.yaml` |
| **Agent** | `guide` |

**PM checks (Phase 6 exit criteria):**
1. Every critique, UX and accessibility finding is resolved, or accepted with a written risk.
2. No critical design issue left open.
3. WCAG 2.2 AA compliance verified.
4. Not Verified items each have an owner or a follow-up review.

## Step 8: Definition of Ready Gate (Deliver)

| | |
|---|---|
| **When** | In Phase 7 (Deliver), once `/product-os:deliver` has written `epics.md` and `stories.md` |
| **Command** | `/product-os:gate --stories stories.md --gate dor` checks Definition of Ready, including "Designs available" for UI stories |
| **What you get** | Pass / Conditional / Fail / N/A / Not Verified per criterion, each with evidence; Not Verified items need an investigation plan |
| **File** | `gate-report.md` |
| **Agent** | `gate-keeper` |

**PM checks:**
1. Gate report has evidence for each criterion.
2. Not Verified items have an investigation plan.

Then publish: `/product-os:publish --project initiatives/<initiative>/<project>/` shows the plan, and nothing is written to Confluence until you approve.

## Related

- [Guided Workflow](guided-workflow.md) — all nine phases
- [Document Format Standard](../reference/document-format.md) — the header every document uses
- Agent guides: [Product Designer](agents/product-designer.md), [Flow Designer](agents/flow-designer.md), [Wireframer](agents/wireframer.md), [Prototyper](agents/prototyper.md), [Figma Agent](agents/figma-agent.md), [Design Critic](agents/design-critic.md), [UX Reviewer](agents/ux-reviewer.md), [Accessibility Auditor](agents/accessibility-auditor.md)
