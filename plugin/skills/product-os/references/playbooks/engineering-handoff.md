# Guided Questions and Engineering Handoff Skill

> **TL;DR:** Product OS asks before it writes, and it asks little: seven questions at the start, two at the handoff, one after it. The first answers say who will read the work, what the PM's role is and which design system to follow, and those answers decide what is made and how it looks. The PM hands over everything they have in one step, sees what Product OS understood, and confirms it before a document is written. The handoff is the short set the readers get: PRD, project brief, user flows, the final design, an end-to-end clickable prototype, and the epic with its tickets. The epic links to all of it. The PM's own documents stay in the PM workspace. After the handoff, Product OS asks what the readers said and saves it for the next project.

## When to Use

- At the start of a project, to ask the seven start questions
- Before writing epics and tickets (Phase 7, Deliver)
- Before publishing to Confluence or Jira
- When building the prototype the team will click through
- After the epic is shared, to record what the readers said

## Readers and the PM

Everything Product OS writes is for someone. The PM says who at the start (question 2), and that answer sets what is made, how it is written and where it goes.

| Audience | What they get | Where |
|----------|---------------|-------|
| **The readers** (the team: engineers, a head of product, designers, or whoever the PM names) | The handoff set for their group, and nothing else | The epic, its tickets and the project's links page |
| **The PM** | The other documents they asked for | The **PM workspace** page in Confluence and the project folder |

The team's pages and tickets never link into the PM workspace. Documents that already exist are kept.

## Guided Questions: One at a Time

Product OS asks, it does not assume. This skill covers the questions at the start of a project, at the handoff and after it. Between them the questions do not stop: every agent asks the decisions its own document needs, until that document is finished (`.claude/skills/guided-questions.md`).

1. **One question at a time.** Wait for the answer before asking the next. Never show a wall of questions.
2. **Say where the PM is.** Every question opens with its place: "Question 2 of 7".
3. **Short numbered options, the recommended one marked.** The PM can answer with a number, "recommended", or their own words. Word every question as an invitation ("What do you already have?"), never as a command.
4. **Never ask for what is saved.** A saved answer is confirmed in one line, not asked again.
5. **Confirm before writing.** Nothing is written until the PM accepts the playback (question 7).

**The budget:** seven questions at the start (four for a team whose readers, role and design system are saved), two at Deliver (three on a team's first project), one after the handoff.

## The Start Questions

Ask at the start of a project, before intake and before any document is written.

| # | Ask | What it is used for |
|---|-----|---------------------|
| 1 | **What are you building, and who will use it?** One or two sentences. | The frame for everything else, and the users |
| 2 | **Who will read what I write?** Pick any: engineers · a head of product or another product leader · designers · executives or investors · a client · only me. | Which outputs are made, how they are written, and where each reader starts |
| 3 | **What is your role on this project?** Product manager · design lead · both · founder · something else. | The documents recommended for the PM |
| 4 | **Is there a design system to follow, and are there existing designs to match?** Each can be in Figma, in Claude Design, or both (below). | Every design Product OS or the PM makes, in Claude Design or in Figma: the design brief, wireframes, prototype and final design, and the components named in tickets |
| 5 | **Where did this come from?** Who asked, when, and why now: a customer, an executive, a data signal, a competitor move. | Intake: the origin of the initiative, stated plainly |
| 6 | **What do you already have?** One step, any order (below). | The evidence everything else is written from |
| 7 | **Does this look right?** The playback (below). | The PM confirms what was understood and what will be made |

"Who will use it" is the product's users. "Who will read what I write" is the people who receive the documents. Keep the two apart in every question and every document.

### Questions 2 and 3: Readers and Role

The answers pick the defaults. The PM changes any of them at the playback.

| Readers | What they get | Where they start |
|---------|---------------|------------------|
| **Engineers** | The standard handoff: PRD, project brief, user flows, final design, UX writing guide, end-to-end prototype, epic and tickets | The end-to-end prototype, then the first ticket |
| **Head of product** (or another product leader) | Project brief, PRD and the epic, plus the project plan and Gantt chart linked from the epic | The project brief |
| **Designers** | Design brief, user flows, low-fidelity wireframes, final design, UX writing guide | The design brief |
| **Executives or investors** | The project brief, and nothing else | The project brief |
| **A client** | Project brief and the end-to-end prototype | The end-to-end prototype |
| **Only me** | Nothing is published for a team. Everything stays in the project folder. | — |

| The PM's role | Recommended for the PM |
|---------------|------------------------|
| **Product manager** | Project plan, Gantt chart, metrics framework |
| **Design lead** | Design brief, low-fidelity wireframes, design critique |
| **Both** | Project plan, Gantt chart, design brief, design critique, metrics framework |
| **Founder** | Project plan, metrics framework |
| **Something else** | Nothing else. Only what the readers need. |

A document a reader group gets is not repeated in the PM's list.

**Saved for the team.** Readers and role are saved under `audience` in `product-os.config.yaml`, and the design system under `design_system`. On the next project the three questions become one line: "Same as on the last project: engineers and a head of product as readers, you as PM and design lead, the Acme Figma library, and the Acme app designs in Figma?" With a yes, that project has four start questions.

### Question 4: The Design System and Existing Designs

Ask at the very start, before any design is made, whether Product OS or the PM makes the designs, and whether they are made in Claude Design or in Figma. The question has two parts. Ask both.

**Part 1 · Is there a design system to follow?**

| Option | What Product OS does with it |
|--------|------------------------------|
| **A · A Figma library** | Ask for the link. The Figma Agent reads its components, variables and styles through the Figma MCP. |
| **B · A design system in Claude Design** | List the design systems available to the PM and ask which one. Read its colors, type, spacing and components. |
| **C · Both** | Take both, and ask which one wins when they disagree. Record it as the source of truth. |
| **D · A coded component library** | Ask for the link (Storybook, a repo, documentation). Read the component names and props. |
| **E · None yet** | Record it. Designs use plain, accessible defaults, and the playback says so. Offer to start a design system from the existing designs in part 2. |

**Part 2 · Are there existing designs to match?** The pages and screens already designed for this product.

| Option | What Product OS does with it |
|--------|------------------------------|
| **A · Design files in Figma** | Ask for the links. The Figma Agent reads the pages and frames through the Figma MCP. |
| **B · Designs in Claude Design** | List the PM's designs and ask which ones. Read their screens. |
| **C · Both** | Take both, and ask which is current where they differ. |
| **D · Screenshots only** | Take the images. Read layout, components and copy from them. |
| **E · None** | Record it. This project's designs are the first. |

Existing designs are context, not a template: new screens match their layout, components and wording, and a place where the new design departs from them is named with the reason.

What it is used for:

1. **Design brief, wireframes, prototype and final design** use the system's components, tokens and names, and match the existing designs, whether the new design is made in Claude Design or in Figma. Nothing is invented that the system already has.
2. **Tickets** name the system's real components in "UX and design requirements".
3. **The design critique** checks the design against the system and cites any place it departs from it.
4. **The UX writing pass** follows the system's content guidelines when it has them, and reads the existing designs to learn how the product already writes.
5. **A gap** (a component the project needs and the system lacks) is named in the design brief with who decides, never filled in silently.

Save it in `product-os.config.yaml` and in the project's `progress.yaml`:

```yaml
design_system:
  sources:
    - kind: figma            # figma | claude | code
      ref: "https://www.figma.com/design/abc123/Acme-Design-System"
      note: "Components, variables and text styles"
    - kind: claude
      ref: "Acme Design System"
      note: "Colors, type, spacing, components"
  source_of_truth: figma     # which source wins when two disagree
  status: provided           # provided | none
  existing_designs:          # pages and screens already designed for this product
    - kind: figma            # figma | claude | screenshots
      ref: "https://www.figma.com/design/def456/Acme-App"
      note: "Signup and onboarding pages"
```

### Question 6: What You Already Have

Ask it as an invitation, never as a demand: "What do you already have?" One step, not one question per kind of document. The PM drops files, links and pasted text in any order. Product OS reads all of it, sorts it into the kinds below, and answers with one list:

```
Found
1. Request: emails/ceo-ask-2026-11-02.md (the original ask)
2. Data: pendo/signup-funnel-2026-10.csv (signup funnel, last 30 days)
3. Technical: the accounts schema (link)

Missing
1. Customer feedback
2. Market
3. Design context
4. Constraints: the deadline and who builds it

Add anything, answer a missing item in one line, or say "that is all".
```

| Kind | What counts | What it is used for |
|------|-------------|---------------------|
| **Request** | Proposals, emails, meeting notes, tickets | Intake: the problem and its evidence, in the requester's own words |
| **Customer feedback** | Interview notes, support tickets, survey results, call recordings or summaries | The evidence for the problem, and the users it affects |
| **Market** | Competitive analysis, market research, analyst notes | PRD background, positioning and what "good" looks like elsewhere |
| **Data** | Product analytics (Pendo or another tool), metric baselines, research findings | Success metrics with real baselines instead of TBDs |
| **Product today** | Existing PRDs, platform or product documentation, the roadmap | PRD: what already exists, so requirements do not repeat or contradict it |
| **Technical** | The tech stack, architecture documents, backend schemas, API documentation | Feasibility, backend tickets that link to real schemas, and the schema attached to the epic |
| **Design** | Existing designs, a design system or component library, a previous project to follow, brand guidelines | Design brief, wireframes and the final design: what the product should look like |
| **Constraints** | The deadline, who builds it (how many engineers, frontend and backend), compliance or legal limits | Scope, estimates and the plan |

Rules:
1. **Sort, do not ask.** Never ask for the kinds one by one. A file that fits no kind is listed as "other".
2. **"That is all" never blocks.** Record the missing kinds under `not_provided` and continue. The PM can add a source any time.
3. **Read everything before writing.** Each agent reads the sources of the kinds it uses.
4. **Never invent what a source does not say.** A gap is a named TBD: what is missing and who provides it.
5. **Do not ask twice.** On resume, list as missing only the kinds that are neither in `sources` nor in `not_provided`.

### Question 7: The Playback

One screen, before anything is written. It is the PM's chance to catch a wrong assumption before ten documents carry it.

```
Question 7 of 7 · Here is what I understood
1. Building: self-serve signup, so small teams can start without a sales call
2. Users: small teams of 2 to 10 people
3. Readers: engineers and a head of product. Your role: PM and design lead.
   Design system: the Acme Figma library.
4. Came from: the CEO, 2 November, after three lost deals
5. I have the request, the signup funnel data and the accounts schema.
   Missing: customer feedback, market, design context.

Here is what I will make
1. For the engineers: PRD, project brief, user flows, final design, UX writing guide,
   end-to-end prototype, epic and tickets
2. For the head of product: the same epic, plus the project plan and Gantt chart
3. For you: design brief, design critique, metrics framework
4. Not made: RACI chart, risk register, UX review. Ask for any of them, any time.

Does this look right? Say yes, or tell me what to change.
```

The PM can change what is made in four ways:

| The PM says | What happens |
|-------------|--------------|
| **"Lean"** | Nothing is made for the PM. Only what the readers need. |
| **"Everything"** | Every document Product OS can write |
| **"Let me pick"** | Go through the four groups below, one question each |
| A document by name | It is added to the list, or left out of it |

| Group | Documents |
|-------|-----------|
| Planning | Project plan · RACI chart · Gantt chart · Risk register · Dependencies |
| Discovery | Market analysis · Competitive analysis · Opportunity tree · Hypothesis log · Research plan |
| Design | Design brief · Low-fidelity wireframes · Design critique · UX review · Accessibility audit |
| Measurement and launch | Metrics framework · Event tracking plan · Decision log · Release notes · Post-launch review |

Rules:
1. **Nothing is written before the yes.** Set `context.confirmed: true` when the PM accepts.
2. **Always created, never asked:** intake, PRD, project brief, user flows, the UX writing guide (for a project with screens), the end-to-end prototype, the epic and its tickets.
3. **Not listed means not created.** Mark the document `skipped` with `skip_reason: "not requested"`, and mark exit criteria that depend on it `na`. If the PM skips a design review, say in one line what is not being checked, then continue.
4. **The PM can add a document any time** by asking for it or running its command. Add it to `pm_documents`.
5. **Resumed projects** with no `audience` or `pm_documents` entry are shown the playback once on resume. Documents that already exist are never removed.

### What Is Saved

In the project's `progress.yaml`:

```yaml
audience:
  readers: [engineers, product-lead]   # engineers | product-lead | designers | executives | client | self
  role: pm-and-design                  # pm | design-lead | pm-and-design | founder | other

context:
  building: "Self-serve signup for small teams, so they can start without a sales call"
  users: "Small teams of 2 to 10 people"
  origin: "The CEO, 2 November, after three lost deals"
  sources:
    - kind: request          # origin | request | feedback | market | data | product | technical | design | constraints | other
      ref: "emails/ceo-ask-2026-11-02.md"
      note: "The original ask"
      in_prd: true           # cited in the PRD; the PM can turn a citation off
    - kind: data
      ref: "pendo/signup-funnel-2026-10.csv"
      note: "Signup funnel, last 30 days"
      in_prd: true
    - kind: technical
      ref: "https://example.com/wiki/backend-schema"
      note: "Current accounts schema"
      in_prd: true
  not_provided: [feedback, market, design]   # kinds the PM does not have
  confirmed: true            # the PM accepted the playback

pm_documents: [design-brief, design-critique, metrics-framework]
```

### Sources in the PRD

1. **Every source is cited by default.** `in_prd` starts as `true`.
2. **Say where facts come from.** A fact taken from a source names it ("per the accounts schema", "Pendo, last 30 days").
3. **The PM turns a citation off when they review the PRD**, not before it exists. When the PRD is shown for review, list the sources it cites; the PM names any they do not want shown, and that source is set to `in_prd: false`.
4. **A source that is not cited still informs the work.** It is used to get things right, without being quoted.

## The Outputs Question

Ask once per project, at the start of Deliver, before any epic or ticket is written. `/jdlt-product-os:deliver` and `/jdlt-product-os:new-project` ask it too when `progress.yaml` has no `handoff` block yet. It is two steps. Both are confirmations, built from what is already known.

**1. Is this what goes to the team?**

```
Question 1 of 2 · Here is what goes to the team
1. Engineers: PRD, project brief, user flows, final design (Figma), UX writing guide,
   end-to-end prototype, epic and tickets
2. Head of product: the same epic, plus the project plan and Gantt chart
3. Also attached: the accounts schema you gave me at the start
4. Tickets: parent tickets with sub-tasks for frontend and backend,
   the shape saved for your team

Say yes, or tell me what to change.
```

What each line is built from:

| Line | Comes from | The PM can |
|------|------------|------------|
| What each reader group gets | The readers answer (question 2 at the start) | Add or remove a document, or say "everything" to link every approved document |
| Also attached | Documents that exist for this project and fit the readers: a schema, low-fidelity wireframes, the design brief, the metrics framework, the accessibility audit | Add or remove any, or name another document or link |
| Final design | One design. Figma when both a Figma file and a Claude design exist; the other stays in the PM workspace | Switch to the Claude design |
| Tickets | The shape saved for the team in `product-os.config.yaml` | Change it for this project |

**On a team's first project, ask how tickets are organized, once**, before step 1:

| Option | What it means |
|--------|---------------|
| **A · Parent tickets with sub-tasks** (recommended) | One ticket per thing a user can see or do. The steps inside it are sub-tasks. |
| **B · Flat list** | Every piece of work is its own ticket. No sub-tasks. |

With option A, also ask which kinds of work go under a parent as sub-tasks. Offer: frontend, backend, design, testing, tracking. Save the answer as the team's shape (`handoff.organization`, `handoff.subtask_kinds` and `handoff.organization_confirmed: true` in `product-os.config.yaml`). Later projects state it in step 1 and do not ask.

**2. Is this ticket tree right?** After the tickets are drafted: see "Organizing Tickets" below.

Save the answers in `progress.yaml`:

```yaml
handoff:
  outputs: standard            # standard | everything
  extras: [schema]             # documents attached to the epic besides each reader group's set
  final_design: figma          # figma | claude
  organization: subtasks       # subtasks | flat
  subtask_kinds: [frontend, backend]
  organization_approved: false # true once the PM accepts the proposed ticket tree
  feedback: []                 # what the readers said after the handoff (see "After the Handoff")
```

No `handoff` block means the question has not been asked. Projects that skip guided mode use the `handoff` defaults in `product-os.config.yaml`.

## The Standard Handoff Set

| # | Output | Rule |
|---|--------|------|
| 1 | **PRD** | Well detailed. The one place for the problem, the requirements, testing, rollout and success metrics. |
| 2 | **Project brief** | One page. |
| 3 | **User flows** | The diagrams, one per user journey. |
| 4 | **Final design** | One link: the Figma file, or the Claude design when there is no Figma. |
| 5 | **UX writing guide** | The voice, the words and the final copy for every screen, from the UX writing pass (`.claude/skills/ux-writing.md`). The final design already carries this copy. |
| 6 | **End-to-end prototype** | Clickable, one straight path per user (see below). The Figma prototype when the final design is in Figma, otherwise `prototype-handoff.html`. |
| 7 | **Epic and tickets** | The epic links to 1–6. Each ticket links to its own design page and says to use the copy as is. |
| 8 | **Links page** | The project page in Confluence: the same links as the epic, in one table. |

Low-fidelity wireframes and a schema are optional. Attach them when the PM keeps or adds them in step 1 of the outputs question.

## The Epic Is the Hub

An engineer opens the epic and finds everything. Layout: `docs/reference/document-format.md` §3. Template: `templates/delivery/epic.md`.

1. **Start here**: one line per reader group, from the readers answer. Engineers: open the end-to-end prototype, then pick up the first ticket. Head of product: read the project brief, then the Gantt chart. With one reader group it is a single line.
2. **What and why**: 2–4 sentences.
3. **Who it is for**: each user in one line.
4. **Handoff**: one table of links to the PRD, project brief, user flows, final design, UX writing guide, end-to-end prototype, any extras, and the links page.
5. **Tickets**: the list in build order, with discipline and points, and one estimate line.
6. **Dependencies**: only when there are any.
7. **Feedback**: one closing line asking the readers what was missing and what was too much (see "After the Handoff").

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
| **Requirements** | 3–5 short lines: what to build. Name the labels, components, rules and data an engineer needs. |
| **UX and design requirements** | Design-system components, copy, the states to show, accessibility. "None: no UI" for backend-only work. |
| **Design** | A link to this ticket's own page or frame in the main Figma file, and its step in the prototype. |
| **Copy** | One line under Design, on every ticket with a screen: "use the copy in the design as is. It has been through the UX writing pass", with a link to the UX writing guide. Written only when the ticket's screens are marked applied in the guide; otherwise a named TBD. Left out of backend-only tickets. |
| **Done when** | 3–5 checklist lines a tester can check. Plain sentences, not Given/When/Then. |
| **Estimate** | Points, discipline, PRD requirement, dependencies. One line. |
| **Sub-tasks** | Optional. One line each. |
| **Engineering to complete** | Backend tickets only. Left empty for the engineers. |

Every ticket stays high level. Left out on purpose: a long description, a solution paragraph, test and rollout tables, and the reasoning behind the estimate. The PRD holds the first three. The reasoning goes in **PM notes** at the end of `stories.md`, which is never sent to Jira.

## Specific, Not Generic

Engineers told us that generated tickets read as generic, and that they spend time working out what to delete. A ticket that needs decoding has failed.

1. **Every line names something real in this project:** a screen, a component, a field, a label, a rule, a value. "Show the `WidgetProblem` component with the text 'Couldn't load'", not "Display an appropriate error".
2. **The paste test.** If a line could be pasted into a different project's ticket unchanged, delete it or make it specific.
3. **No filler.** Never write "handle errors gracefully", "ensure a good user experience", "follow best practices", "should be performant" or "consider edge cases". Say which error, which state, which number.
4. **No analysis in the ticket.** Background, options considered and reasoning live in the PRD and in PM notes. The ticket says what to build.
5. **One home for each fact.** If the PRD says it, link to the requirement. Do not restate it.

## The Last Pass: Clear Output on the Epic and Every Ticket

Before the epic and tickets are shown to the PM, run them through the Clear Output style (`.claude/skills/clear-output.md`), one at a time. This is the final step of writing them, not an optional polish.

| Rule | In the epic | In a ticket |
|------|-------------|-------------|
| **Lead with the action** | The first line is **Start here:** open the prototype, then pick up the first ticket | The user story and the Problem line come first; nothing above them |
| **Number steps** | Tickets are listed in build order | Requirements are numbered when the order matters |
| **Cap lists at 5** | "Who it is for" has at most 5 users | Requirements, UX and design requirements, Done when and Sub-tasks have at most 5 lines each. More than 5 means the ticket is two tickets |
| **No preamble, no recap** | No introduction, no summary of the PRD | No "This ticket covers…", no closing notes |
| **Short sentences** | One idea per line | One idea per line |

Then the **ready-to-run check**, per ticket, reading it as the engineer who picks it up:

1. Can I start without asking anyone a question?
2. Do I know which screen to open and which design to follow?
3. Do I know when I am done?
4. Is there a line I would delete? If so, delete it now.

A ticket passes when the answers are yes, yes, yes, no. Once the PM hands over the epic, the team should be able to run with the tickets as they are.

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

The Delivery Agent does the organizing in the shape saved for the team, and the PM confirms it. Engineers should never have to work out which ticket belongs under which. When they do move tickets after the handoff, their shape becomes the team's default (see "After the Handoff").

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

## After the Handoff: Ask the Readers

The readers are the test of a handoff. Product OS asks them, and what they say sets the defaults for the next project.

1. **The epic asks.** Its last line is: "**Feedback:** what was missing, and what was too much? Comment on this epic."
2. **The guide asks the PM, once.** On the first resume after the epic is shared, and at the latest at the start of Launch: "What did the team say about the handoff?"

   | Option | What happens |
   |--------|--------------|
   | **A · Nothing to change** | Recorded. No defaults change. |
   | **B · Something was missing** | The PM names it. Offer to attach it to every handoff for this team. |
   | **C · Something was too much** | The PM names it. Offer to leave it out of every handoff for this team. |
   | **D · They moved tickets** | Compare the board with the accepted tree and show what moved. Offer to save their shape. |

3. **Save what was said** under `handoff.feedback` in `progress.yaml`:

   ```yaml
   handoff:
     feedback:
       - from: engineers
         said: "The schema should be on every epic"
         change: "extras: add schema"
         saved_as_default: true
   ```

4. **Change a team default only with the PM's yes.** Team defaults live under `audience` and `handoff` in `product-os.config.yaml`.
5. **The team's board wins.** When Jira Sync reads the board and the tree differs from the accepted one, show the differences, keep the team's version, and never move a ticket back.

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

## Before a Large Publish: Say the Size

Publishing many pages or tickets is a phase with many repeated steps. Before the first one is created, follow `.claude/skills/multi-chat.md`.

1. **Say the size**: how many pages, how many tickets and sub-tasks, and how many rounds. The cost follows the number of steps.
2. **Propose the rounds**, the team's pages and the epic first.
3. **Ask once, with choices to tap**, if the publish can be staged.
4. **Propose a second chat** only when the split rule applies: more than about 50 tool steps, a chat already summarized once, or a chat whose work so far was a different kind.
5. **A small handoff gets one line and no question**: "1 epic, 6 tickets, 7 pages: one round."

## The Final Output List

End every run of Deliver, and every publish, with one list. The PM should never have to hunt for what was made.

```
For the team · share this one link: [epic URL]
1. PRD: [link]
2. Project brief: [link]
3. User flows: [link]
4. Final design (Figma): [link]
5. UX writing guide: [link]
6. End-to-end prototype: [link]
7. Project plan and Gantt chart (for the head of product): [link]
8. Epic and 6 tickets: [link]

For you
1. Design brief: [link or file path]
2. Design critique: [link or file path]
3. Metrics framework: [link or file path]

Not created (you did not ask for them): RACI chart, risk register, UX review

Next: after the team has used it, tell me what they said about the handoff.
```

Before publishing, show file paths. After publishing, show the Confluence and Jira links.

## Quality Checklist

- [ ] The start questions were asked one at a time, each with its place ("Question 2 of 7"), and no saved answer was asked again
- [ ] The readers, the PM's role and the design system are saved, for the project and as the team default
- [ ] The PM was asked for existing designs in Figma and in Claude Design, and they are saved
- [ ] Every design uses the saved design system and matches the existing designs; a gap or a departure is named with who decides
- [ ] The PM's material was taken in one step and played back as Found and Missing; every source was read, and nothing was invented beyond them
- [ ] The PM accepted the playback before any document was written; only the documents listed in it were created
- [ ] The outputs question was asked as two confirmations and the answers are in `progress.yaml`
- [ ] The epic has a Start here line for each reader group and ends with the Feedback line
- [ ] The epic links to every handoff output, in its description and as Jira web links, and every link opens
- [ ] The links page in Confluence shows the same table and links back to the epic
- [ ] The PM was given one link to share: the epic
- [ ] The team gets one final design, not two
- [ ] Every ticket has a user story, a problem line, requirements, a design link (or "No UI"), a Done when list and an estimate
- [ ] The epic links to the UX writing guide, and every ticket with a screen has the Copy line
- [ ] Backend tickets are high level, with "Engineering to complete" left empty and the estimate marked as proposed
- [ ] Every ticket line is specific to this project; nothing generic, no filler, no analysis
- [ ] The Clear Output pass was run on the epic and every ticket: action first, lists of 5 or fewer, no preamble
- [ ] Every ticket passed the ready-to-run check
- [ ] No ticket is over 5 points without a reason; none is 13
- [ ] Steps inside a ticket are sub-tasks, not extra tickets
- [ ] The PM saw the proposed ticket tree and accepted it
- [ ] The prototype runs end to end for each user with no dead ends
- [ ] Nothing on the team's pages links into the PM workspace
- [ ] The run ended with the final output list: for the team, for the PM, and what was not created
- [ ] After the handoff, the PM was asked what the readers said, and the answer is saved under `handoff.feedback`
