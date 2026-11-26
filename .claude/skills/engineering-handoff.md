# Guided Questions and Engineering Handoff Skill

> **TL;DR:** Product OS asks before it writes: what you are building and what you already have, which documents you want for yourself, and what goes to the team. It can write many documents. The team needs a few, and the PM picks the rest. The handoff is the short set product and engineering get: PRD, project brief, user flows, the final design, an end-to-end clickable prototype, and the epic with its tickets. The epic links to all of it. The PM chooses which other documents to create for themselves; those stay in the PM workspace. Every run ends with one list of what was made and for whom.

## When to Use

- At the start of a project, to ask what the PM is building and what they already have
- At the start of a project, to ask which documents the PM wants for themselves
- Before writing epics and tickets (Phase 7, Deliver)
- Before publishing to Confluence or Jira
- When building the prototype the team will click through

## Two Audiences

| Audience | What they get | Where |
|----------|---------------|-------|
| **The team** (engineering, head of product) | The handoff set below, and nothing else | The epic, its tickets and the project's links page |
| **The PM** | Every other document Product OS writes | The **PM workspace** page in Confluence and the project folder |

The team's pages and tickets never link into the PM workspace. Nothing is deleted: the PM keeps the full set.

## Guided Questions: One at a Time

Product OS asks, it does not assume. Ask each question on its own, with short numbered options and the recommended one marked, and wait for the answer before asking the next. Never show a wall of questions. The PM can answer with a number, "recommended", or their own words.

## The Context Question

Ask first, at the start of a project, before intake and before any document is written. The more Product OS knows, the less it has to assume. The PM can answer each question with files, links, pasted text or "I don't have that". Nothing here is required.

| # | Ask | What it is used for |
|---|-----|---------------------|
| 1 | **What are you building, and for whom?** One or two sentences. | The frame for everything else |
| 2 | **The request.** Proposals, emails, meeting notes, tickets, customer feedback. | Intake: the problem and its evidence, in the requester's own words |
| 3 | **How the product works today.** Existing PRDs, platform or product documentation, the roadmap. | PRD: what already exists, so requirements do not repeat or contradict it |
| 4 | **Technical context.** The tech stack, architecture documents, backend schemas, API documentation. | Feasibility, backend tickets that link to real schemas, and the schema the PM can attach to the epic |
| 5 | **Design context.** Existing designs, a design system or component library, a previous project to follow, brand guidelines. | Design brief, wireframes and the final design: what the product should look like |
| 6 | **Data.** Analytics, metric baselines, research findings. | Success metrics with real baselines instead of TBDs |
| 7 | **Constraints.** The deadline, who builds it (how many engineers, frontend and backend), compliance or legal limits. | Scope, estimates and the plan |

End with: **"Is there anything else I should read?"**

Save what the PM gave in `progress.yaml`:

```yaml
context:
  building: "Self-serve signup for small teams, so they can start without a sales call"
  sources:
    - kind: request          # request | product | technical | design | data | constraints | other
      ref: "emails/ceo-ask-2026-11-02.md"
      note: "The original ask"
    - kind: technical
      ref: "https://example.com/wiki/backend-schema"
      note: "Current accounts schema"
  not_provided: [data]       # kinds the PM said they do not have
```

Rules:
1. **Read everything the PM gave before writing.** Each agent reads the sources of the kinds it uses.
2. **Say where facts come from.** A fact taken from a source names it ("per the accounts schema").
3. **Never invent what a source does not say.** A gap is a named TBD: what is missing and who provides it.
4. **"I don't have that" never blocks.** Record the kind under `not_provided` and continue. The PM can add a source any time.
5. **Do not ask twice.** On resume, ask only for kinds that are neither in `sources` nor in `not_provided`.

## The PM Documents Question

Ask at the start of a project, after the context question and before any optional document is written. Resumed projects with no `pm_documents` entry in `progress.yaml` are asked once on resume. Documents that already exist are never removed.

**1. How much do you want for yourself?**

| Option | What gets created besides the handoff |
|--------|----------------------------------------|
| **A · Lean** | Nothing else. Only what the team needs. |
| **B · Planning set** (recommended) | Project plan, Gantt chart, design brief, metrics framework |
| **C · Everything** | Every document Product OS can write |
| **D · Let me pick** | Go through the four groups below, one question each |

**2–5. With "Let me pick", one question per group.** The PM picks any, or none:

| Group | Documents |
|-------|-----------|
| Planning | Project plan · RACI chart · Gantt chart · Risk register · Dependencies |
| Discovery | Market analysis · Competitive analysis · Opportunity tree · Hypothesis log · Research plan |
| Design | Design brief · Low-fidelity wireframes · Design critique · UX review · Accessibility audit |
| Measurement and launch | Metrics framework · Event tracking plan · Decision log · Release notes · Post-launch review |

**6. Should any of these also go to the team?** For example the Gantt chart for the head of product. Whatever the PM names is added to `handoff.extras` and linked from the epic.

Save the answer:

```yaml
pm_documents: [project-plan, gantt, design-brief, metrics-framework]
```

Rules:
1. **Always created, never asked:** intake, PRD, project brief, user flows, the end-to-end prototype, the epic and its tickets.
2. **Not picked means not created.** Mark the document `skipped` with `skip_reason: "not requested"`, and mark exit criteria that depend on it `na`. If the PM skips a design review, say in one line what is not being checked, then continue.
3. **The PM can add a document any time** by asking for it or running its command. Add it to `pm_documents`.

## The Outputs Question

Ask once per project, at the start of Deliver, before any epic or ticket is written. `/product-os:deliver` and `/product-os:new-project` ask it too when `progress.yaml` has no `handoff` block yet.

**1. What goes to the team?**

| Option | The team gets |
|--------|---------------|
| **A · Standard handoff** (recommended) | PRD · project brief · user flows · final design · end-to-end prototype · epic and tickets · links page |
| **B · Everything** | Option A, plus every other approved document linked from the epic and the links page |

**2. Any other outputs to attach to the epic?** List only documents that exist for this project. Common picks:

1. Low-fidelity wireframes
2. Schema (data model)
3. Design brief
4. Metrics framework
5. Accessibility audit

The PM can name any other document or link.

**3. Which design is final?** Ask only when both a Figma file and a Claude design exist. The team gets one. Recommend Figma. The other stays in the PM workspace.

**4. How should tickets be organized?**

| Option | What it means |
|--------|---------------|
| **A · Parent tickets with sub-tasks** (recommended) | One ticket per thing a user can see or do. The steps inside it are sub-tasks. |
| **B · Flat list** | Every piece of work is its own ticket. No sub-tasks. |

With option A, also ask which kinds of work go under a parent as sub-tasks. Offer: frontend, backend, design, testing, tracking. The PM picks any.

Save the answers in `progress.yaml`:

```yaml
handoff:
  outputs: standard            # standard | everything
  extras: [wireframes, schema] # documents attached to the epic besides the standard set
  final_design: figma          # figma | claude
  organization: subtasks       # subtasks | flat
  subtask_kinds: [frontend, backend, design]
  organization_approved: false # true once the PM accepts the proposed ticket tree
```

No `handoff` block means the question has not been asked. Projects that skip guided mode use the `handoff` defaults in `product-os.config.yaml`.

## The Standard Handoff Set

| # | Output | Rule |
|---|--------|------|
| 1 | **PRD** | Well detailed. The one place for the problem, the requirements, testing, rollout and success metrics. |
| 2 | **Project brief** | One page. |
| 3 | **User flows** | The diagrams, one per user journey. |
| 4 | **Final design** | One link: the Figma file, or the Claude design when there is no Figma. |
| 5 | **End-to-end prototype** | Clickable, one straight path per user (see below). The Figma prototype when the final design is in Figma, otherwise `prototype-handoff.html`. |
| 6 | **Epic and tickets** | The epic links to 1–5. Each ticket links to its own design page. |
| 7 | **Links page** | The project page in Confluence: the same links as the epic, in one table. |

Low-fidelity wireframes and a schema are optional. Attach them when the PM picks them in question 2.

## The Epic Is the Hub

An engineer opens the epic and finds everything. Layout: `docs/reference/document-format.md` §3. Template: `templates/delivery/epic.md`.

1. **What and why**: 2–4 sentences.
2. **Who it is for**: each user in one line.
3. **Handoff**: one table of links to the PRD, project brief, user flows, final design, end-to-end prototype, any extras, and the links page.
4. **Tickets**: the list with discipline and points, and one estimate line.
5. **Dependencies**: only when there are any.

The epic does not repeat the PRD. No problem statement, scope lists or metrics tables in the epic.

**The links live in three places, and they match:**

| Where | What |
|-------|------|
| The epic's description in Jira | The Handoff table |
| The epic's links in Jira | Each handoff output added as a web link on the epic, so it shows in the epic's links panel |
| The links page in Confluence | The same table, plus a link back to the epic |

**Share one link with the team: the epic.** Do not send the team a Confluence page and ask them to find things. When a run finishes, the last line to the PM is the epic's URL, ready to share.

## Lean Tickets

A ticket is short enough to read without help. Layout: `docs/reference/document-format.md` §4. Template: `templates/delivery/user-story.md`.

| Part | Rule |
|------|------|
| **User story** | One line: As a / I want / so that. |
| **Problem** | One or two sentences: what is broken or missing for this user today. |
| **Requirements** | 3–6 short lines: what to build. Name the labels, components, rules and data an engineer needs. |
| **UX and design requirements** | Design-system components, copy, the states to show, accessibility. "None: no UI" for backend-only work. |
| **Design** | A link to this ticket's own page or frame in the main Figma file, and its step in the prototype. |
| **Done when** | 3–6 checklist lines a tester can check. Plain sentences, not Given/When/Then. |
| **Estimate** | Points, discipline, PRD requirement, dependencies. One line. |
| **Sub-tasks** | Optional. One line each. |
| **Engineering to complete** | Backend tickets only. Left empty for the engineers. |

Every ticket stays high level. Left out on purpose: a long description, a solution paragraph, test and rollout tables, and the reasoning behind the estimate. The PRD holds the first three. The reasoning goes in **PM notes** at the end of `stories.md`, which is never sent to Jira.

## Backend Tickets: Engineers Complete Them

Product OS does not design the backend. A backend ticket, and a backend sub-task, says what the work is for and stops there.

1. **Product OS writes:** the user story the work serves, the problem, the requirements at a high level (what the backend must do, the data in and out, the rules), and the Done when list.
2. **Product OS leaves empty:** the **Engineering to complete** section, with three prompts: Approach, API and data changes, Risks and unknowns.
3. **The estimate is proposed.** Write "[n] points (proposed; engineering confirms)".
4. **Never invent** endpoints, table names, schemas or architecture. If the PRD or an attached schema names one, link to it.

A ticket labelled `fullstack` follows the same rule for its backend sub-tasks: one line each, no technical design.

## Slicing: Split, Merge, Sub-tasks

Engineers should not have to re-cut the backlog.

1. **One ticket is one thing a user can see or do, end to end.** Do not cut a slice into a frontend ticket and a backend ticket.
2. **Keep tickets at 1–5 points.** An 8 needs a one-line reason in PM notes. A 13 is split, or becomes a spike first.
3. **Merge what cannot ship alone.** A label, a tooltip or a single field belongs in the ticket for the screen it sits on.
4. **Use sub-tasks for the steps inside a ticket.** When the work divides by discipline or by step, list sub-tasks under the ticket, tagged with their kind: `[frontend]`, `[backend]`, `[design]`, `[testing]` or `[tracking]`. Sub-tasks carry no points; the ticket holds the estimate.
5. **A ticket with frontend and backend sub-tasks is labelled `fullstack`.**

## Organizing Tickets: Propose, Then Ask

The Delivery Agent does the organizing, and the PM confirms it. Engineers should never have to work out which ticket belongs under which.

1. **Draft** the tickets from the PRD and the designs.
2. **Propose the tree.** Group every piece of work under the ticket it belongs to, using the slicing rules above. Show it as a tree:

   ```
   EPIC-001 Self-Serve Signup — Users finish signup without sales help
   ├── STORY-001 Create an account with email            3 pts · fullstack
   │   ├── [frontend] Signup form and inline validation
   │   ├── [backend]  Create-account endpoint
   │   └── [design]   Review the empty and error states
   ├── STORY-002 Verify the email address                5 pts · fullstack
   │   ├── [frontend] Verification screen and resend link
   │   └── [backend]  Token, expiry and resend limit
   └── STORY-003 See password rules while typing         2 pts · frontend
   ```

3. **Say what was moved and why**, in one line each: "Merged 'Add resend link' into STORY-002: it cannot ship alone." "Split 'Signup' into STORY-001 and STORY-002: 13 points."
4. **Ask the PM:** accept the tree, or move items. Offer the three moves: put a ticket under another one, promote a sub-task to its own ticket, merge two tickets.
5. **Apply the answer**, show the tree again if anything changed, and set `organization_approved: true` once accepted.

Nothing is sent to Jira before the tree is accepted. Jira Sync creates each sub-task under its parent, so the board matches the tree.

With a flat list (option B), skip sub-tasks: propose the order and the merges and splits only.

## The Handoff Prototype

The team's prototype is `prototype-handoff.html` (see `.claude/skills/prototype-generation.md` → "Handoff Prototype"):

1. It opens on **Who is using this?** One button per user type, with a one-line description of each.
2. Each user gets **one straight path**, first screen to last. Next and Back only.
3. No branching: no use-case switchers, option panels or annotations. A state (an error, an empty screen) appears only when a ticket builds it, and then as its own step on the path.
4. Every screen shows its ID (SCR-###), so a ticket can point at it.

When the final design is in Figma and the file has a prototype flow that does the same, link that flow instead and skip the HTML file. Either way the team gets one prototype.

The full version with every state and use case is `prototype.html`. It is for design review and stays in the PM workspace.

## Where Everything Else Goes

The documents the PM chose for themselves are published under one **PM workspace** page, below the project page, grouped as in `docs/reference/document-format.md` §2: project plan, RACI, Gantt, risk register, design brief, wireframes (unless attached), design critique, UX review, accessibility audit, metrics framework, hypothesis log, market analysis, traceability, decision log and the rest. The design files and the full prototype are the PM's too.

## The Final Output List

End every run of Deliver, and every publish, with one list. The PM should never have to hunt for what was made.

```
For the team · share this one link: [epic URL]
1. PRD: [link]
2. Project brief: [link]
3. User flows: [link]
4. Final design (Figma): [link]
5. End-to-end prototype: [link]
6. Gantt chart (you attached it): [link]
7. Epic and 6 tickets: [link]

For you
1. Project plan: [link or file path]
2. Design brief: [link or file path]
3. Metrics framework: [link or file path]

Not created (you did not ask for them): RACI chart, risk register, design critique
```

Before publishing, show file paths. After publishing, show the Confluence and Jira links.

## Quality Checklist

- [ ] The context question was asked; every source the PM gave was read, and nothing was invented beyond them
- [ ] The PM documents question was asked; only the chosen documents were created
- [ ] The outputs question was asked and the answers are in `progress.yaml`
- [ ] The epic links to every handoff output, in its description and as Jira web links, and every link opens
- [ ] The links page in Confluence shows the same table and links back to the epic
- [ ] The PM was given one link to share: the epic
- [ ] The team gets one final design, not two
- [ ] Every ticket has a user story, a problem line, requirements, a design link (or "No UI"), a Done when list and an estimate
- [ ] Backend tickets are high level, with "Engineering to complete" left empty and the estimate marked as proposed
- [ ] No ticket is over 5 points without a reason; none is 13
- [ ] Steps inside a ticket are sub-tasks, not extra tickets
- [ ] The PM saw the proposed ticket tree and accepted it
- [ ] The prototype runs end to end for each user with no dead ends
- [ ] Nothing on the team's pages links into the PM workspace
- [ ] The run ended with the final output list: for the team, for the PM, and what was not created
