# Changelog

All notable changes to Product OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.9.3] - 2026-11-26

### Changed
- **The guide follows common UX practice** — it is short by default: four steps, with what each badge means and what to say in the chat one click away. It shows on a first visit, "Got it, hide the guide" closes it, the Guide button in the header brings it back, and the board remembers the choice in the reader's browser. Keyboard focus moves to the Guide button when the guide closes. Buttons are at least 44 px tall on touch screens.

## [1.9.2] - 2026-11-26

### Added
- **A guide at the top of the board** — "How Product OS works", a one-minute read: four steps, what each badge means, and five things to say in the chat.

## [1.9.1] - 2026-11-26

### Changed
- **The repo root is a marketplace, not a plugin** — the plugin people add from this repo is now the folder `marketplace/product-os/`, a clean copy with the skill, the agents, the commands, a README and the license. Accounts that had added the repo stopped receiving updates once the repo also held `plugin/`, the copy for Claude's directory: a plugin cannot hold a second plugin. The root `.claude-plugin/plugin.json` and the root `skills/` folder are removed. The version is now set under `metadata` in `.claude-plugin/marketplace.json`.

## [1.9.0] - 2026-11-26

### Added
- **Agents view on the board** — all 41 roles by phase, what each one does, and what to say in the chat to call it. `scripts/build-plugin-skill.py` writes the list into the board from `.claude/agents/`, and fails when an agent is missing from it.
- **Light, dark or auto** — a switch at the top of the board. The choice is kept in the reader's browser.
- **Open in new tab** — a button at the top of the board opens the board in its own browser tab, and every document link carries a new-tab sign. Claude writes the board's own link to `project/state` as `board`.

### Changed
- **A wider board with larger type** — the page uses the width of the screen, and every text size is larger.
- **Badges and chips for every state** — Done, In progress, Questions for you, Ready for your review, Not started, Skipped, the number of TBDs still missing, the agent on each document, where each document is published, and each connector. Each badge has a sign and a word.

## [1.8.2] - 2026-11-26

### Added
- **Privacy page** — `PRIVACY.md`: Product OS collects nothing, and everything stays in the PM's own Claude, Atlassian and Figma accounts. The directory copy links to it and carries keywords, a support link and a documentation link.

### Changed
- **The board loads nothing from outside Claude** — it no longer fetches web fonts and uses the fonts on the reader's device.

## [1.8.1] - 2026-11-26

### Changed
- **Title in Claude's directory** — the directory copy in `plugin/` is titled "Product OS by JDLT". The directory's check held the title "Product OS" as too close to an existing listing.

## [1.8.0] - 2026-11-26

### Added
- **A copy for Claude's plugin directory** — `plugin/`, built by `scripts/build-directory-plugin.py` from the same sources as the rest of Product OS. It holds only what the directory accepts from an organization that is not Verified: the skill, the agents, the commands, a README, the license and the icon, as Markdown, text, JSON, YAML and one image. Its name in the directory is `jdlt-product-os`, and its title stays "Product OS". `scripts/validate.sh` checks it (check 19).

### Changed
- **`/product-os:propose`** — its description no longer uses an escaped character, which the directory's check could not read.

## [1.7.3] - 2026-11-26

### Added
- **Plugin icon** — `.claude-plugin/icon.png`: the letters OS above the nine-phase bar, in the board's colours.
- **What Data It Handles** — a README section that says what Product OS sends and where: your own Claude account, your own Atlassian and Figma connectors, and the board's database.

## [1.7.2] - 2026-11-26

### Changed
- **Choices to tap, first** — in Claude, every question goes through the tool that shows tappable choices. Claude looks for that tool before the first question and writes a numbered list only when there is none (`skills/product-os/SKILL.md`, "How you work, on every turn").

## [1.7.1] - 2026-11-26

### Added
- **The version is visible** — the plugin's overview (its description in Claude), the first line of a new project in Claude, the bottom of the board and the line under the README title all show the version. It is set in one place, `"version"` in `.claude-plugin/plugin.json`; `scripts/build-plugin-skill.py` writes it everywhere else, and `scripts/validate.sh` fails when a place is out of date.

## [1.7.0] - 2026-11-26

### Added
- **Name and brand** — `TRADEMARKS.md` says who owns what: the code and documents are under the MIT License, and the name "Product OS™" and its look are not part of it, so a changed version that is shared needs its own name. The README, `NOTICE.md` and the board carry the copyright line.
- **Engineering handoff** — `.claude/skills/engineering-handoff.md`. Built on direct feedback from four engineers and a head of product: the full document set was too much to read, and tickets had to be reorganized by hand. The team now gets a short set (PRD, project brief, user flows, one final design, an end-to-end prototype, the epic and its tickets) and everything else stays with the PM.
- **Start questions** — seven questions at the start of a project, asked one at a time, each with its place ("Question 2 of 7"): what the PM is building and who will use it; who will read what Product OS writes (engineers, a head of product, designers, executives or investors, a client, or only the PM); the PM's role; the design system to follow and the existing designs to match (each in Figma, in Claude Design, or both; a coded component library and screenshots also count), saved under `design_system` and followed by every design, ticket, critique and UX writing pass; where the initiative came from; everything the PM has, taken in one step and sorted into Found and Missing; and a playback of what was understood and what will be made, which the PM accepts before anything is written. Readers, role and the design system are saved for the team in `product-os.config.yaml` (`audience`, `design_system`) and confirmed in one line on later projects. Every source is cited in the PRD by default; the PM turns a citation off at PRD review. New optional `audience` and `design_system` blocks and `context.users`, `context.origin`, `context.confirmed` in `progress.yaml` (schema stays `1.2`).
- **Guided questions, always on** — `.claude/skills/guided-questions.md`, referenced by every agent. Each agent says how many questions it has (at most 5), asks the decisions its document needs, and confirms what was decided before the document is finished. No decision is made by the agent alone, and the PM never has to ask for questions. The outputs question at Deliver is one confirmation built from the readers answer (what each reader group gets, extras, the one final design, the ticket shape saved for the team) plus the ticket tree. After the handoff the guide asks what the team said (`handoff.feedback`) and saves changes as team defaults with the PM's yes; when the team moves tickets in Jira, their board wins.
- **UX writing pass** — new agent `ux-writer`, command `/product-os:ux-writing`, skill `.claude/skills/ux-writing.md` and template `templates/design/ux-writing-guide.md`. The pass is paired with the design critique: critique first, the PM decides the findings, then the pass runs on the design with the accepted fixes. It starts from how the product already writes (prior designs, screenshots, a style guide) and works from the designs alone when there is none. Outputs: the final designs with the copy in them, and the UX writing guide (`ux-writing.md`). The epic's Handoff table links to the guide, and every ticket with a screen carries the line "Copy: use the copy in the design as is. It has been through the UX writing pass."
- **Epic: readers** — a Start here line for each reader group and a closing Feedback line.
- **Start Here** — the README opens with three steps: pick your path (Claude, ChatGPT, Claude Code, Cursor), have these ready, follow the flow. The steps for each path come next, and everything else sits under Reference.
- **Claude runs it, with a live board** — in the Claude app, Claude is the Product OS agent: it leads the PM through the nine phases, checks the connectors and walks the PM through the missing ones, has an agent take over each step, makes each output in its real form (Claude docs, Claude Design files, whiteboards or FigJam, Figma, a clickable prototype), publishes to Confluence and Jira after the PM's yes and reads the result back (`skills/product-os/SKILL.md`). `artifact/product-os-board.html` is a read-only board that Claude makes as the PM's own artifact and keeps up to date through its database: where the project is, the next step, the numbers, insights, every task, a table of every document with its link, what is published and what is connected.
- **Agent conversation and status board** — on every interface the question comes from the agent in a conversation, with quick replies (choices to tap in Claude, numbered options in Claude Code and ChatGPT), worded as an invitation ("What do you already have?", "Does this look right?"). Every turn opens with where the PM is and the task counts; the whole board (Start plus the nine phases, each done, in progress or not started, with its numbers) shows at the start of a session, when a task finishes and on request (`guided-workflow.md` → "The Status Board", `/product-os:status`).
- **The plugin carries all of Product OS** — `skills/product-os/` holds every agent, playbook, command and template plus the board page as files a Claude chat can read, so a PM who adds the plugin to their own Claude account (Customize > Plugins: Add marketplace `johnedelatorre/product-os`, or Upload plugin with the repo ZIP) has all 41 agents in chat, on a phone, in Cowork and in Claude Code. Built by `scripts/build-plugin-skill.py`; the plugin manifest also registers the agents.
- **On a phone** — the board, each task and every document are one tap or one word away: in Claude the board page fits a phone, Claude chat and ChatGPT answer `board`, `task <n>` and `docs` with short lists, and Claude Code has `/product-os:status --compact` (`guided-workflow.md` → "On a Phone").
- **Connectors and settings** — one place on every interface for what is connected (Confluence, Jira, Figma), what happens without each one, and the saved team settings: the board in Claude, `connectors` and `settings` in chat, `/product-os:status --connectors` and `--settings` in Claude Code. The agent checks each connector itself and walks the PM through the missing ones.
- **Header image and mobile** — the README opens with the board on a desktop screen and a phone (`docs/images/hero.jpg`). Start Here, `claude-ai/` and `chatgpt/` say that the Claude and ChatGPT paths also run in the iOS and Android apps.
- **ChatGPT** — `chatgpt/README.md`, `chatgpt/project-instructions.md` (under 8,000 characters, so it also fits a custom GPT) and `chatgpt/pack/`: the core agents, skills, formats and templates bundled into 8 files by `scripts/build-chatgpt-pack.py`, to fit a ChatGPT Project (25 files on Go and Plus) and a custom GPT (20 files).
- **Validation** — `scripts/validate.sh` checks that every agent references the guided questions skill, that the ChatGPT pack matches its source files and that the plugin skill matches its source files (19 checks).
- **Ticket tree** — the Delivery Agent proposes which work sits under which ticket, says what it merged or split and why, and the PM accepts the tree or moves items before anything reaches Jira. Steps inside a ticket become Jira sub-tasks.
- **Handoff prototype** — `prototype-handoff.html` (`/product-os:prototype --handoff`): pick a user, then one straight path end to end. `prototype.html` stays the full version for design review.
- **Final output list** — every Deliver run and every publish ends with one list: for the team (one link to share, the epic), for the PM, and what was not created.
- **Config** — a `handoff` block (default outputs, extras, final design, ticket organization, sub-task kinds, largest ticket size) and `jira.issue_types.subtask` in `product-os.config.yaml`.
- **Deferred items in guided mode ("Come back later")** — any document or exit criterion in any phase, required phases included, can be deferred when the PM doesn't have the information yet. The guide asks one short question (what's missing, owner, revisit phase; owner may be TBD), records an open item and keeps going. Documents still get written with each gap as a named TBD. Failed criteria can be fixed or deferred.
- **Open items** — top-level `open_items` in `progress.yaml`. `/product-os:status` lists them first; `/product-os:next` reports the count and offers to resolve items due in the current phase; the PM can resolve any item any time. Before Launch, the PM resolves each item or carries it forward as an accepted risk (recorded with who accepted it). Handovers list open items.
- **Tests** — `tests/test-schema-migration.sh` covers schema `1.1` → `1.2` migration and a `1.2` fixture with a deferred document, a deferred criterion and open items.
- **Standard document format** — `docs/reference/document-format.md`: every document and Confluence page opens with Title, Subtitle, Description, Problem Statement, Solution, Success Metrics and Next Action; the body never repeats the header. Defines the Confluence structure (one hub page per project plus four groups: 1. Strategy & Definition, 2. Design, 3. Delivery, 4. Decisions & Launch) and the Jira epic and story description layouts.
- **Design workflow guide** — `docs/guides/design-workflow.md` ("From PRD to Reviewed Designs"): design brief, user flow diagrams, wireframes, clickable prototype, optional Figma, the three reviews on the real designs, the review exit check, and the Definition of Ready gate in Deliver; each step lists the command, output file, how to view or share it and what the PM checks.
- **Acme example gallery** — `examples/acme-dashboard/`: one filled-in project showing every format: Confluence hub page, intake, project brief, PRD, metrics framework with validation plan, user flows (`flows.md`, `flows.yaml`), wireframes, clickable prototype (`prototype.html`), design critique, UX review, accessibility audit, Jira epic and stories.
- **claude.ai project setup files** — `claude-ai/README.md` (setup steps and the starter Knowledge file list) and `claude-ai/project-instructions.md` (text to paste into a Claude Project's Instructions).

### Changed
- **The epic is the team's hub** — the Jira epic is now a short summary, who it is for, and a Handoff table of links (PRD, project brief, user flows, final design, end-to-end prototype, extras). Each output is also added as a web link on the epic. It no longer repeats the PRD's problem statement, scope lists or metrics tables.
- **Short tickets** — a story is now: user story, a one- or two-sentence Problem, Requirements (3–5 lines), UX and design requirements, a link to that ticket's own design page or frame, a "Done when" checklist, an Estimate line and optional Sub-tasks. Given/When/Then scenarios, the Validation table and the estimate reasoning are no longer in the ticket; the reasoning, tests, tracking and rollout go in PM notes at the end of `stories.md`, which is never sent to Jira.
- **Backend tickets are completed by the engineers** — Product OS writes what the backend must do at a high level, marks the estimate as proposed, and leaves an empty "Engineering to complete" section. A re-sync never overwrites what the engineers wrote there.
- **Specific, not generic** — every ticket line names a real screen, component, field, rule or value; filler and analysis are not allowed; lists stop at 5 lines. The epic opens with a "Start here" line. The epic and every ticket get a final Clear Output pass and a ready-to-run check before they are shown.
- **Ticket sizing** — tickets aim for 1–5 points; an 8 needs a written reason; a 13 is split or becomes a spike.
- **Confluence layout** — one links page per project with the Handoff table and the team's pages directly under it (PRD, Project Brief, User Flows, extras, Epics & Stories), and one PM workspace page for every other document. The Epics & Stories page is now the ticket tree with Jira links. Projects published with the earlier four-group layout keep their pages until the PM approves the moves.
- **Deliver exit criteria and the Definition of Ready** follow the new formats (outputs question answered, epic links complete, "Done when" checklist, ticket tree accepted).
- **Acme example** — `jira/epic.md`, `jira/stories.md`, `confluence/00-hub-page.md` and the page tree use the new formats; `design/prototype-handoff.html` added.
- **Counts** — 41 agents, 48 commands, 44 skills across README, AGENTS.md, the agent index, command reference, platform guide, Cursor rules and plugin manifest.
- **Guided mode no longer stops on missing information** — phases with deferred items advance as `complete_with_open_items`. Exit-criteria tables read "Yes (or defer)". `/product-os:new-project` checkpoints accept deferrals the same way. Hard stops kept: publishing to Confluence/Jira needs explicit approval; code-shipping release gates (Not Verified blocks release, owner explicit GO) are unchanged.
- **`progress.yaml` schema 1.2** — adds `open_items`, the `deferred` status for documents and exit criteria, and the `complete_with_open_items` phase status. Migration from 1.1 (and 1.0 via 1.1) adds an empty `open_items` list and converts documents with status `tbd` to `deferred` with an open item. Non-destructive.
- **README guided-mode table** — "Can skip?" column replaced: Discovery can be skipped, every phase lets you defer items and come back later, with a "Missing information? Keep going" paragraph.
- **README rewritten for PMs and Heads of Product** — informational and instructional: what Product OS does, who it's for, where it runs (claude.ai, Claude Code, Cursor) with a quick start for each, the workflow and guided-mode diagrams, every command grouped by phase, every agent, every skill grouped by area, PM practices built in, and every document. Per-release "What's New" sections removed (this file is the release history).
- **claude.ai setup documented** — `docs/setup/installation.md` and `docs/guides/platform-compatibility.md` cover running Product OS in a Claude Project (instructions + knowledge files, plain-language commands, Atlassian connector, progress and handover by upload).
- **New `docs/setup/installation.md`** — install options, Claude Code plugin, Cursor setup, cross-platform workflow, upgrades from command-copy installs, and repository layout (moved out of the README).
- **Standard format applied everywhere** — templates, artifact-writing agents, skills, commands and agent guides use the standard header. Confluence publishing creates the hub page and four groups, and splits long documents at their own sections, named for their content, never "Part N". Jira Sync writes epics (Subtitle, Description, Problem Statement, Solution, Success Metrics, Stories, Dependencies, Links) and stories (user story line, Description, Problem Statement, Solution, Acceptance Criteria, Design, Validation, Details, Links) as one complete description each.
- **Design reviews run on real designs only** — design critique, UX review and accessibility audit need a Figma link, screenshots, `prototype.html` or wireframes, and stop to ask when none is given. Each report opens with a **What was reviewed** table, every finding cites the exact screen, frame and element, and anything the reviewer could not inspect is marked **Not Verified**.
- **Review and gate placement** — Phase 6 (Review) ends with the review exit check (every critique, UX and accessibility finding resolved or accepted with a written risk); the Definition of Ready gate runs in Phase 7 (Deliver), on the stories.
- **Guided README** — adds Key Terms, a step-by-step first project (each step: command, prompt for claude.ai or Cursor, what you get, where it lives, what to check, example), "What Success Looks Like: Validation and Metrics", "What Every Document and Page Looks Like", "Examples You Can Copy" and "Rolling It Out to a Team".

## [1.6.0] - 2026-11-10

### Added
- **Doc hygiene skill** — `.claude/skills/doc-hygiene.md`: docs, Confluence pages, epics and Jira tickets show the current state only. Ten rules with bad/good examples, the cleanup procedure for repo docs, Confluence pages and Jira issues, verification, parallel cleanup with one coordinator, and approval gates.
- **Doc Cleaner agent** — `.claude/agents/doc-cleaner.md` strips version banners, history blocks, change narratives, disposition tags and retired items, and rewrites vague TBDs to name what is undecided. Updates pages and issues in place, only after human approval.
- **`/product-os:cleanup`** — `--project <path> [--confluence] [--jira] [--dry-run]`.
- **`scripts/doc-hygiene-check.py`** (stdlib only) — `lint` flags history patterns, odd code fences, unbalanced `<details>` and broken anchors (skipping inline code, URLs, API paths, filenames and library versions); `guard` lists words a cleanup inserted that the original never had (`--against`, `--against-dir` or `--git-ref`). Installed with the copy-mode installer.
- **Tests** — `tests/test-doc-hygiene.sh` with fixtures, run in CI.
- **Agent guide** — `docs/guides/agents/doc-cleaner.md`.

### Changed
- **Current state only rule** — `.claude/skills/clear-output.md` (always on) now requires current-state-only docs and points to the doc-hygiene skill. Artifact-writing agents (PRD Author, Project Brief, Project Planner, Intake Analyst, Product Designer, Flow Designer, Wireframer, Metrics Designer, Event Tracker, Roadmap Agent, PR/FAQ Author, Risk Manager, Dependency Tracker, Decision Logger, Delivery Agent, Confluence Publisher, Jira Sync) carry a one-line rule.
- **Always-on docs** — `CLAUDE.md`, `AGENTS.md`, `docs/guides/clear-output-style.md`, the Cursor rules file and the Cursor PRD Author and Intake Analyst adapters point to the doc-hygiene skill.
- **Counts** — 40 agents, 47 commands, 41 skills across README, AGENTS.md, agent index, command reference, platform guide, Cursor rules and plugin manifest.

## [1.5.0] - 2026-11-08

### Added
- **Claude Code plugin** — `.claude-plugin/plugin.json` (plugin `product-os`, commands from `./.claude/commands/`) and `.claude-plugin/marketplace.json` (marketplace `product-os`). Commands load namespaced as `/product-os:<command>`.
- **Installer `--register-plugin`** — Enables the plugin in the target project (`claude plugin marketplace add … --scope project` + `claude plugin install product-os@product-os --scope project`).
- **YAML frontmatter** on all 46 commands and 39 agents; agents now register as Claude Code subagents.
- **Validator checks** — `scripts/validate.sh` verifies command/agent frontmatter, plugin manifests, and that every `/product-os:<command>` reference resolves to a real command file.
- **Guide agent doc** — `docs/guides/agents/guide.md`; agent index now lists all 39 agents.
- **Full command reference** — `docs/reference/commands.md` documents all 46 commands, grouped by phase.
- **Guide existing-work detection** — On start, the guide scans the project directory and marks existing artifacts `complete`/`in_progress` in `progress.yaml` instead of recreating them.

### Changed
- **Renamed commands** — The 19 `product-os-*.md` command files dropped the prefix (`guide.md`, `status.md`, `next.md`, `gate.md`, `handover.md`, …) so `/product-os:<x>` maps to `.claude/commands/<x>.md`.
- **Installer** — No longer copies commands into the target's `.claude/commands/` (un-namespaced `/status`, `/plan`, `/next` collided with Claude Code built-ins). A reference copy goes to `.claude/product-os/commands/` (symlinked in submodule mode). The installer lists old Product OS command files left in `.claude/commands/` so they can be removed.
- **Atlassian integration** — Confluence Publisher and Jira Sync agents/skills prefer connected Atlassian MCP tools, search before creating, update in place, record IDs in `publish-manifest.json` / `jira-sync-manifest.json`, read field IDs from the instance, handle team-managed Jira projects (`parent` field, "Story point estimate"), and always show proposed changes and require explicit human approval before any write. `.env` is only needed for the REST fallback.
- **Atlassian REST fallback** — Cloud search path fixed.
- **progress.yaml location** standardized on `initiatives/<initiative>/<project>/progress.yaml`; guide example updated to schema v1.1.
- **Accessibility** — WCAG 2.2 AA everywhere; touch targets 24×24 CSS px minimum (2.5.8, AA), 44×44 px recommended.

### Fixed
- 26 references to nonexistent commands (e.g. `/product-os:rice`, `/product-os:stories`, `/product-os:resume`) now point to real commands (`/product-os:prioritize --framework rice`, `/product-os:deliver`, re-running `/product-os:new-project`, …).
- AGENTS.md pointed at nonexistent agent files and a 6-stage pipeline; it now references the real agent files and matches the orchestrator's 7 stages.
- README: plugin install flow, "Upgrading from ≤1.4" note, approval-gated publishing wording, all 40 skills listed, PRD section count (19).
- CLAUDE.md: workspace file list (`flows.yaml`/`flows.md`, `prototype.html`, `progress.yaml`, `HANDOVER.md`), Atlassian MCP-first configuration.
- `shipping-artifacts` skill is now linked from `/product-os:audit-intent` and `/product-os:release-gate`.
- Guide: `--skip` and `<phase>` documented; `/product-os:prd --continue` replaced with a real invocation; Context Freshness links its skill.

## [1.4.0] - 2026-11-08

### Added

#### PRD Quality Improvements
- **PRD Template** — New comprehensive 19-section template at `templates/pm/prd.md`
- **PRD Stages** — Early (hypotheses), Defined (requirements), Delivery-ready (evidence-backed)
- **Testable Hypotheses** — New section with validation status and provenance
- **Alternatives Considered** — Document options not chosen with trade-offs
- **Stop Criteria** — Define halt/kill conditions with owners and SLAs
- **AI Feature Specification** — Optional section for AI/ML features

#### Multi-Perspective PRD Review
- **PRD Review Template** — `templates/pm/prd-review.md` for synthesis
- **Review Command** — `/product-os:review-prd` synthesizes 6 perspectives
- **Structured Output** — Blockers, gaps, suggestions, conflicts with resolution ownership
- **Perspectives** — Feasibility, UX, strategy, research, privacy/security, customer

#### Estimation Improvements
- **Estimation Skill** — New `.claude/skills/estimation.md` with phase-appropriate methods
- **T-shirt Sizing** — For initiative/roadmap level (±100%)
- **Range Estimates** — For epic level with confidence (±50%)
- **Fibonacci Points** — For sprint-ready stories (±30%)
- **Spike Handling** — TBD stories with provisional estimates

#### Traceability
- **Traceability Template** — `templates/delivery/traceability.md`
- **REQ → Epic → Story → Test** linkage
- **Review Finding Resolution** tracking
- **Gap Documentation** — Explicit reasons required, not just missing

#### Enhanced Gates
- **Gate Status Types** — Pass, Fail, Conditional, N/A, Not Verified
- **Evidence Requirements** — Each criterion needs proof
- **Not Verified Handling** — Investigation plan required

#### Decision Records
- **Reversibility Assessment** — Easy, Hard, Irreversible
- **Review Triggers** — Conditions for re-evaluation
- **Trade-off Summary** — Table comparing options
- **Decision Roles** — Separate from project RACI

#### Context Freshness
- **Context Freshness Skill** — `.claude/skills/context-freshness.md`
- **Staleness Thresholds** — Per context type
- **Verification Checklist** — Pre-launch context validation

#### Installer Improvements
- **Non-destructive** — Backs up modified files, preserves CLAUDE.md/AGENTS.md
- **Skills Included** — Fixed bug where skills were omitted
- **Idempotent** — Safe for repeat runs
- **Test Suite** — `scripts/test-install.sh` with 14 test cases

#### Validation
- **Static Validation** — `scripts/validate.sh` checks template paths, completeness
- **Template Integrity** — Verifies referenced templates exist
- **Agent Coverage** — Verifies clear-output style applied

### Changed

#### Workflow Updates
- **Orchestrator** — Added PRD Review stage, traceability generation, estimation guidance
- **Guide Agent** — Updated phases with PRD stages, review, enhanced gates
- **Guided Workflow Skill** — Schema v1.1 with artifact stages, structured exit criteria
- **Progress Schema** — Added `schema_version`, `artifact_stages`, `reviews`, structured `exit_criteria`

#### Agent Improvements
- **Delivery Agent** — Added spike stories, TBD handling, testing/observability requirements, rollout requirements
- **Gate Keeper** — Pass/fail/NA/not-verified with evidence
- **Decision Logger** — Reversibility, review triggers, trade-off summary
- **Metrics Designer** — Stop criteria with owners and SLAs
- **UX Researcher** — Contradictions, unsupported assumptions, evidence gaps

#### Documentation
- **README** — What's New section, artifact connection diagram, installation guide
- **Guided Workflow Playbook** — Updated phases, PRD stages, estimation, gates

### Counts
- Agents: 39 (unchanged)
- Skills: 26 → 29
- Commands: 41 → 42

---

## [1.3.0] - 2026-11-06

### Added

#### Guided Mode
- **Guide Agent** — Walks PMs through all 9 phases step-by-step with progress tracking
- **`progress.yaml`** — Per-initiative state file tracking current phase, document status, and exit criteria
- **Phase System** — 9 phases: Intake → Discovery → Prioritize → Define → Design → Review → Deliver → Launch → Measure
- **Skip Handling** — Optional phases can be skipped with documented risks

#### Commands
- `/product-os:guide` — Start or resume guided mode, or jump to a specific phase
- `/product-os:status` — Show current progress through the 9 phases
- `/product-os:next` — Execute the next recommended step automatically

#### Skills
- **Guided Workflow Skill** — Progress schema, phase order, exit criteria, and state management

#### Documentation
- `docs/guides/guided-workflow.md` — Full playbook with phase-by-phase checklists
- Mermaid sequence diagram showing Guide ↔ Specialist ↔ Progress flow

### Changed
- Agent count increased from 38 to 39
- Skill count increased from 26 to 27
- Command count increased from 38 to 41
- CLAUDE.md updated with Guided Mode section
- Orchestrator updated to reference Guide agent for phase transitions
- README updated with Guided Mode section and sequence diagram

---

## [1.2.0] - 2026-11-06

### Added

#### Clear Output Style (Always On)
- **Clear Output Skill** — 10 rules for actionable output, adapted from ayghri/i-have-adhd (MIT)
- **TL;DR Blocks** — Every document template now starts with problem, solution, next action
- **NOTICE.md** — Third-party attribution file

#### Style Rules
1. Lead with the next action
2. Number multi-step tasks
3. End with one concrete next step
4. Suppress tangents
5. Restate state every turn
6. Give specific time estimates
7. Make wins visible
8. State errors matter-of-factly
9. Cap lists to 5 items
10. No preamble, no recap, no closers

### Changed
- All 38 agents now reference clear-output.md as a global rule
- CLAUDE.md includes output style section
- AGENTS.md includes global output style section
- All templates include TL;DR blocks at top
- README includes output style section with 10 rules
- Skill count increased from 25 to 26

---

## [1.1.0] - 2026-11-06

### Added

#### Discovery Agents
- **Opportunity Tree Agent** — Outcome-opportunity-solution trees for structured discovery
- **Hypothesis Logger Agent** — Track assumptions through validation with outcomes
- **Market Analyst Agent** — TAM/SAM/SOM sizing, trends, segments, positioning

#### Metrics & Measurement Agents
- **Metrics Designer Agent** — North star, input metrics, guardrails, success criteria
- **Event Tracker Agent** — Analytics tracking plans for Pendo, Amplitude, Mixpanel, Segment
- **Post-Launch Reviewer Agent** — Compare results to PRD goals, create follow-up intake

#### Launch & GTM Agents
- **Launch Manager Agent** — Release notes, sales/support enablement, changelog entries

#### Governance Agents
- **Artifact Registry Agent** — Track Figma, FigJam, Loom, prototypes with link validation
- **Dependency Tracker Agent** — Dependencies and risks integrated with RACI
- **Gate Keeper Agent** — Definition of Ready and Definition of Done validation
- **Debt Tracker Agent** — Technical and design debt with prioritization

#### Skills
- Artifact registry management
- Opportunity solution trees
- Hypothesis logging and validation
- Metrics framework design
- Event tracking specifications
- Post-launch review process
- Launch and GTM materials
- Dependency and risk tracking
- DoR/DoD gate criteria
- Tech and design debt tracking

#### Commands
- `/product-os:artifacts` — Manage artifact registry
- `/product-os:opportunity-tree` — Create opportunity trees
- `/product-os:hypotheses` — Manage hypothesis log
- `/product-os:market` — Create market analysis
- `/product-os:metrics` — Design metrics framework
- `/product-os:tracking` — Create event tracking plan
- `/product-os:review-launch` — Post-launch review
- `/product-os:launch` — Create launch materials
- `/product-os:dependencies` — Manage dependencies
- `/product-os:gate` — Run DoR/DoD checks
- `/product-os:debt` — Manage debt tracker

### Changed

- Expanded orchestrator to include all new agents
- Updated README with new PM-led workflow diagram
- Reorganized agent documentation by category
- Increased agent count from 27 to 38
- Increased skill count from 15 to 25
- Increased command count from 25 to 38

---

## [1.0.0] - 2026-11-06

### Added

#### Core Pipeline
- **Orchestrator Agent** — Coordinates full pipeline with human checkpoints
- **Intake Analyst Agent** — Structures raw requirements into problem statements
- **PRD Author Agent** — Generates comprehensive PRDs with 18 sections
- **Project Brief Agent** — Creates one-page executive summaries
- **Strategist Agent** — RICE, WSJF, MoSCoW, and Kano prioritization
- **Project Planner Agent** — RACI matrix, Gantt charts, project timelines

#### Design Agents
- **Product Designer Agent** — Design briefs from PRD
- **Flow Designer Agent** — User flows, journey maps, sitemaps with multi-target rendering
- **Wireframer Agent** — ASCII and HTML low-fidelity wireframes
- **Prototyper Agent** — Clickable HTML/React prototypes with Claude artifact support
- **Figma Agent** — Figma MCP integration for tokens, audit, and FigJam generation

#### Review Agents
- **Design Critic Agent** — Structured visual critique with severity ratings
- **UX Reviewer Agent** — Nielsen's heuristics, Laws of UX, pattern evaluation
- **Accessibility Auditor Agent** — WCAG 2.2 AA checklist with axe-core automation

#### Delivery & Publishing
- **Delivery Agent** — Epics and stories with discipline labels (frontend/backend/fullstack)
- **Confluence Publisher Agent** — Full Confluence hierarchy with backlog tables
- **Jira Sync Agent** — Idempotent sync with Gantt dates and dependencies

#### Tool Agents
- **OKR Agent** — Objectives, Key Results, and metric trees
- **Roadmap Agent** — Now/Next/Later roadmaps
- **Competitive Analyst Agent** — Feature matrices and SWOT
- **Experiment Designer Agent** — A/B test design with sample size formulas
- **Risk Manager Agent** — Risk register with mitigations
- **Decision Logger Agent** — ADR-style decision records
- **Retro Facilitator Agent** — Retrospective templates
- **PR/FAQ Author Agent** — Amazon-style press release + FAQ
- **UX Researcher Agent** — Research plans and synthesis
- **Stakeholder Comms Agent** — Updates, release notes, launch communications

#### Features
- **Canonical Flow Spec** — YAML format as single source of truth
- **Multi-target Flow Rendering** — Mermaid, Claude artifacts, FigJam, Excalidraw, draw.io, Lucidchart, Miro, Whimsical
- **Discipline Labels** — Frontend/backend/fullstack with story point subtotals
- **Gantt-to-Jira Integration** — Dates and dependencies flow to Jira Plans
- **Claude Artifact Prototypes** — Single-file clickable prototypes with prompt pack
- **Figma MCP Integration** — With graceful fallback

#### Documentation
- Comprehensive README with quick start
- CLAUDE.md and AGENTS.md for agent orchestration
- Command reference for all slash commands
- Setup guides for Confluence, Jira, and Figma MCP
- Worked example project (Acme Dashboard)

#### Infrastructure
- `product-os.config.yaml` — Full configuration template
- `.env.example` — Environment variables template
- `scripts/install.sh` — Installation script (copy, submodule, symlink)
- `scripts/atlassian-fallback.py` — REST API fallback for Confluence and Jira
