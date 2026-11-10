# Skill: Doc Hygiene

Keep specs, Confluence pages, epics and Jira tickets in their current state only, and clean up the ones that are not.

**Prevention is always on.** Every agent that writes or publishes a doc or ticket follows the rules below (see the "Current state only" rule in `.claude/skills/clear-output.md`). The cleanup procedure runs through `/product-os:cleanup` and `.claude/agents/doc-cleaner.md`.

## When to Use

- After a scope change, re-plan or decision that touched many docs and tickets
- Readers say a page is confusing, or they cannot tell which part is current
- Before publishing or syncing artifacts that went through several revisions
- Any time a doc carries version banners, history blocks or change tags

## Why

A spec is read to answer "what are we building now?" Version banners, superseded summaries and change tags force every reader to diff the doc in their head. Confluence page history, git history and Jira issue history already keep every earlier version. The body shows the final state only, so the doc stays scannable.

## Scope

| Applies to (living specs) | Does not apply to (records of change) |
|---------------------------|----------------------------------------|
| Intake, PRD, project brief, project plan, RACI, Gantt | `CHANGELOG.md`, release notes, launch comms |
| Design brief, flows, wireframes, tracking plan, metrics | Stakeholder updates, retros, post-launch reviews |
| Epics, stories, backlog, traceability | Session handovers and status files |
| Confluence pages built from these docs | A decision record's own Status / Supersedes fields |
| Jira epic and issue summaries and descriptions | |

---

## Ground Rules

1. **Current state only.** The body states what is true now. History lives in Confluence page history, git and Jira issue history.
2. **Invent nothing.** A cleanup only deletes text or minimally rewords existing text. No new facts, numbers, names, owners or rationale.
3. **Use the doc's own markers.** Remove an item only when the doc itself marks it retired, superseded, replaced, removed or dropped. Never guess.
4. **Human approval before any Confluence or Jira write.** Show the cleaned content, the guard report and the list of removed items. Write nothing until the human explicitly approves. Approval covers only what was shown.
5. **Update in place.** Republish to the same page IDs and edit the same issue keys. Never create a replacement page or ticket. Never delete a page or ticket; deletion is a human action.

---

## The 10 Rules

### 1. Delete version banners and history blocks

Delete version banners, `text below kept as history` notes, `<details>` history blocks and superseded TL;DRs. Keep one TL;DR, the current one, headed just `## TL;DR`.

| Bad | Good |
|-----|------|
| `> **v3 — DEC-016 (2026-11-10): scope narrowed to chat. v2 text below kept as history.**` | *(deleted)* |
| `## TL;DR (v2, kept)` plus a second summary | One `## TL;DR` with the current summary |
| `<details><summary>v2 TL;DR (history)</summary>…</details>` | *(deleted, open and close tags together)* |

### 2. State the current value, not the change

Delete change narratives: `was X, now Y`, `renamed from`, `previously called`, `replaces the old`, `changed from`.

| Bad | Good |
|-----|------|
| `The panel was called Insights Hub, now Ask AI.` | `The panel is called Ask AI.` |
| `Weekly digest (replaces the v1 daily email)` | `Weekly digest` |

### 3. Remove retired and superseded items entirely

Delete retired sections, table rows, list items, events, stories, catalog entries and "retired index" tables. Before deleting a retired ID, search the other docs in the project for it so every doc drops it together.

| Bad | Good |
|-----|------|
| `\| FR-102 \| Task cards \| Retired (DEC-016) \|` | *(row deleted)* |
| `## Retired events (kept for history)` | *(section deleted)* |

### 4. Keep Deferred and Parked items, labelled plainly

Deferred and Parked are current status. Keep them, labelled just `Deferred` or `Parked`.

| Bad | Good |
|-----|------|
| `ST-210 — Deferred (re-scoped in DEC-016)` | `ST-210 — Deferred` |

### 5. Drop disposition tags

Drop Re-scoped / New / Unchanged / Amended / Updated tags from headings, rows and scenario titles. An Amended tag that changes wording: apply the wording to the text, then drop the tag.

| Bad | Good |
|-----|------|
| `## Requirements — Re-scoped (DEC-016)` | `## Requirements` |
| `## Weekly digest — New (DEC-016)` | `## Weekly digest` |
| `Scenario: Weekly run [Amended (DEC-016): "trigger" reads "schedule slot"]` | `Scenario: Weekly run fires on its schedule slot` |

### 6. Turn version notes into plain notes or delete them

A `v2 note` whose content is still current becomes `**Note:**`. One that describes a retired item is deleted. Delete carry-over lines.

| Bad | Good |
|-----|------|
| `v2 note (DEC-012): answers cite their sources.` | `**Note:** answers cite their sources.` |
| `*Carried from v1 (ID stable); wording updated in v2.*` | *(deleted)* |

### 7. Remove version tokens from prose, never from identifiers

Remove `v1`, `v2`, `(v3)`, `rev 4.1` and `Version: 0.3 draft (v3)` from headings and text. Keep `Last updated: <date>`.

Never change: IDs (`FR-`, `ST-`, `DEC-`, `Q-` …), filenames (`prd-v2.md`), API paths (`/v1/insights`), contract or library versions (`d3 v7.8.5`), URLs, and Jira keys and links (`· Jira [PROJ-163](…)` stays byte-identical).

| Bad | Good |
|-----|------|
| `## Agent contract v2` | `## Agent contract` |
| `Version: 0.3 draft (v3, DEC-016)` | `Last updated: 2026-11-10` *(only if the doc already has that date)* |

### 8. Make every TBD name what is undecided

A TBD says exactly what is open and, when the doc says it, who decides and when. Use only words already in the doc. Drop source notes on TBDs.

| Bad | Good |
|-----|------|
| `**Platform:** TBD` *(meant the analytics tool; readers thought it meant the dashboard)* | `**Analytics tool:** TBD (owner picks during E10). Events are tool-agnostic.` |
| `Owner: TBD (not specified in DEC-016 inputs)` | `Owner: TBD` |

### 9. Keep decision citations as sources, not as narrative

`DEC-016`, `FR-301` or `handoff §4` may stay where they cite the source of a current rule. Delete them when they are part of a change narrative. A decision log keeps every decision; a fully superseded one shrinks to its title plus `Superseded by DEC-0xx.`

| Bad | Good |
|-----|------|
| `Re-scoped by DEC-016: background reads now serve weekly runs only.` | `Background reads serve weekly runs only (DEC-016).` |

### 10. Leave the doc valid

Fix cross-references and anchor links that pointed at deleted sections. Keep code fences balanced, tables with header and separator rows, no orphan `</details>`. If a deletion makes a stated count wrong ("32 events"), delete the count clause rather than recompute it, unless the correct current count is already stated in the same doc.

---

## Verification

Run both checks on every cleaned file. Both scripts are stdlib-only Python.

### 1. Lint (history patterns and structure)

```bash
python3 scripts/doc-hygiene-check.py lint initiatives/<initiative>/<project>/*.md
```

Flags version tokens and banners, history labels and blocks, duplicate or labelled TL;DRs, disposition and Amended tags, change narratives, retired items, bare TBDs, odd fence counts, unbalanced `<details>` and anchor links that no longer resolve. It skips inline code, URLs, API paths, filenames and `x.y.z` library versions. Exit code 1 means hits remain.

Every remaining hit is fixed or justified. A line that is correct as written (for example a vendor's product name that contains a version) gets `<!-- hygiene-ok -->` at its end.

### 2. Invention guard (nothing new was added)

```bash
# Repo docs: compare with the committed version
python3 scripts/doc-hygiene-check.py guard initiatives/<initiative>/<project>/prd.md --git-ref HEAD

# Fetched pages or tickets: compare clean copies with saved originals
python3 scripts/doc-hygiene-check.py guard .cleanup/jira/clean/*.md --against-dir .cleanup/jira/orig
```

Lists every inserted run that contains words the original never had. Each listed run must be a justified minimal reword (rules 2, 5, 6, 8). Anything else is invented: revert it. The coordinator or the human reviews the guard report before anything is published.

---

## Cleanup Procedure

Order matters: repo source docs first, then Confluence, then Jira. Confluence pages are rebuilt from the repo docs, so cleaning the source first keeps the next publish clean.

### Step 1: Inventory

1. List the project's docs (`initiatives/<initiative>/<project>/*.md`; skip `inputs/` and `.yaml`/`.json`/`.csv`).
2. List published pages from `publish-manifest.json`, plus their descendants.
3. List issues from `jira-sync-manifest.json`, or a JQL search on the project's labels.
4. Run the lint on the docs to size the job.
5. Commit or stash any unrelated edits so `--git-ref HEAD` holds the originals.

### Step 2: Clean the repo docs

1. Apply the 10 rules file by file, in place.
2. Record every retired ID you delete and every point you were unsure about. Do not guess on unsure points; list them.
3. Reconcile retired IDs across all docs so each one is gone everywhere (a single coordinator owns this list).
4. Run lint until clean or justified, then run guard with `--git-ref HEAD`.

### Step 3: Confluence pages

1. Pages built from repo docs: rebuild from the cleaned docs and republish in place through `.claude/agents/confluence-publisher.md` (same page IDs).
2. Pages with no repo source: fetch the body to `.cleanup/confluence/orig/<page-id>.md`, write the cleaned body to `.cleanup/confluence/clean/<page-id>.md`, lint, then guard with `--against-dir`.
3. Leftover split pages (for example "Part 2" pages whose content now lives on one page): retitle `Archived — <title>` and replace the body with one line naming the page that holds the content and saying the page can be deleted. Deletion is a human action.
4. Show the human the page list (update / archive), the guard report and the removed items. Publish only after explicit approval.

### Step 4: Jira epics and issues

1. Fetch each issue's summary and description (markdown when the tool offers it). Save them exactly as returned to `.cleanup/jira/orig/<KEY>.md` and `.cleanup/jira/orig/<KEY>.summary.txt`.
2. Write cleaned copies to `.cleanup/jira/clean/` (an identical copy when nothing changes).
3. Lint the clean descriptions and guard with `--against-dir .cleanup/jira/orig`.
4. Show the human one row per issue: key, summary before → after, description words before → after, guard leftovers.
5. After explicit approval, update each issue's description and summary in place (`editJiraIssue`, or the REST fallback). Change nothing else: no transitions, links, fields or deletions.

Jira specifics:
- Never delete a ticket's own story. Remove only history and version material from it.
- Keep the summary prefix (for example `[E3] ST-104:`), Jira keys, links, tables and Gherkin fences intact.
- A change-narrative blockquote that holds a still-current rule becomes a plain sentence with the "now / narrowed / previously" framing removed.
- Mentions of retired items go; Deferred status stays.

### Step 5: Report

Per doc, page or issue: lines or words before → after, retired IDs removed, hits kept and why, unsure points. Delete the `.cleanup/` working folder once the human confirms.

---

## Working in Parallel

Large initiatives split well:

1. One subagent per file group (for example PRD + brief, design docs, delivery docs, a batch of Jira keys). Each gets these rules and only its own files.
2. One coordinator owns the retired-ID list, reconciles it across groups, runs the guard on everything and presents one approval request.
3. Subagents never write to Confluence or Jira. Only the coordinator publishes, after approval.

---

## Quality Checklist

- [ ] One `## TL;DR`, the current one
- [ ] No version banners, history blocks, carry-over lines or version notes
- [ ] No change narratives; every name and value is the current one
- [ ] No retired or superseded items; Deferred and Parked items labelled plainly
- [ ] No disposition or Amended tags; amended wording applied
- [ ] Version tokens gone from prose; IDs, filenames, API paths, library versions and Jira keys untouched
- [ ] Every TBD names what is undecided
- [ ] Cross-references and anchors resolve; fences and tables valid
- [ ] Lint clean or every hit justified
- [ ] Guard report reviewed; nothing invented
- [ ] Human approved before any Confluence or Jira write

## Related

- `.claude/skills/clear-output.md` — Always-on style, including the "Current state only" rule
- `.claude/agents/doc-cleaner.md` — Runs the cleanup procedure
- `.claude/skills/confluence-publishing.md` — Republishing pages in place
- `.claude/skills/jira-sync.md` — Updating issues in place
