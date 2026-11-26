# Skill: Confluence Publishing

Publish project artifacts to Confluence with proper hierarchy.

## When to Use

- After artifacts are approved
- Before Jira sync (to get Confluence links)
- Sharing documentation with stakeholders
- Archiving project documentation

## Ground Rules

1. **Approval first** — Show the publish plan (each page: create or update, location, change summary). Write nothing until the human explicitly approves.
2. **Atlassian MCP preferred** — Use the connected MCP tools (no credentials needed).
3. **Search before create** — Find pages by `publish-manifest.json` IDs, then by title/CQL search; update in place.
4. **Check the instance** — Confirm space, parent page, and available macros before publishing.
5. **Record IDs** in `publish-manifest.json`.
6. **Standard format** — Links page, the team's pages and the PM workspace; standard header on every page (see Page Rules below and `docs/reference/document-format.md`).

## Quick Start

```
/jdlt-product-os:publish --project initiatives/onboarding/signup/
```

## Confluence Hierarchy

One links page per project for the team, and one PM workspace page for everything else (`docs/reference/document-format.md` §2, `.claude/skills/engineering-handoff.md`):

```
Product Space (PROD)
└── Initiatives
    └── [Initiative Name]
        └── [Project Name]                   ← Links page: standard header + "Handoff" table
            ├── PRD
            ├── Project Brief
            ├── User Flows
            ├── [Extras the PM attached]     ← for example Wireframes, Schema, Gantt Chart
            ├── Epics & Stories              ← the ticket tree, with Jira links
            └── PM workspace                 ← the documents the PM asked for, for themselves
                ├── 1. Strategy & Definition ← Intake, Proposal, Metrics Framework
                ├── 2. Design                ← Design Brief, Wireframes & Prototype, Design Critique, UX Review, Accessibility Audit
                ├── 3. Delivery              ← Project Plan (RACI, Gantt Chart, Risks, Dependencies as child pages), Traceability
                └── 4. Decisions & Launch    ← Decision Log, Event Tracking Plan, Release Notes, Post-Launch Review
```

## Page Rules

1. **Standard header on every page.** The links page and the PRD carry the full header; every other page carries Title, Subtitle, header table, Description and the PRD link line. Gaps are named TBDs, never invented.
2. **Links page** carries the "Handoff" table: What | Link | Status. The same rows as the Jira epic, plus a line pointing to the epic: the team starts there.
3. **The team's pages never link into the PM workspace**, unless the PM chose "Everything" in the outputs question.
4. **PM workspace group pages** list every page under them with a one-line description.
5. **Titles name the thing:** `[Project] — [Document]`. No numbers, file names or version tags.
6. **Creation order:** pages and table rows follow the order the PM creates them (`docs/reference/document-format.md` §2).
7. **Final documents only:** never publish working notes such as `prd-review.md`, or the PM notes section of `stories.md`. Supporting documents are child pages of the document they support.
8. **Split long documents at their own sections**, named for their content ("PRD — Functional Requirements"), never "Part 1".
9. **Existing projects keep their pages.** The publish plan lists each page that would move under PM workspace; nothing moves until the PM approves.

## Epics & Stories Page Structure

One short page, below its standard header: what each epic delivers, the handoff links, and the ticket tree.

```markdown
## EPIC-001: Self-Serve Signup — Users finish signup without sales help · [PROJ-101]

[What and why, 2–4 sentences.]

**Handoff:** [PRD] · [Project brief] · [User flows] · [Final design] · [Prototype]

| Ticket | Summary | Discipline | Points | Jira |
|--------|---------|------------|--------|------|
| STORY-001 | Create an account with email | fullstack | 3 | [PROJ-111] |
| ↳ sub-task | [frontend] Signup form and inline validation | | | [PROJ-113] |
| ↳ sub-task | [backend] Create-account endpoint | | | [PROJ-114] |

**Estimate:** 2 tickets · 8 points · about 1 sprint at 21 points per sprint
```

Point totals by discipline and the sprint allocation are in the Project Plan, in the PM workspace.

## Configuration

In `product-os.config.yaml`:

```yaml
confluence:
  base_url: "https://company.atlassian.net/wiki"
  space_key: "PROD"
  initiatives_parent_page_id: "123456789"
```

## Finding Parent Page ID

1. Navigate to the Initiatives page in Confluence
2. Click ⋯ menu → Page Information
3. Copy the Page ID from URL or page

## Idempotent Publishing

Re-running publish updates existing pages:

1. Checks for existing page by manifest page ID, then by title
2. If exists: Updates content, preserves ID
3. If new: Creates page
4. Records in `publish-manifest.json`

## Manifest Output

```json
{
  "project": "initiatives/onboarding/signup",
  "published_at": "2026-11-06T15:30:00Z",
  "pages": {
    "project-brief": {
      "page_id": "123456",
      "title": "Signup — Project Brief",
      "url": "https://company.atlassian.net/wiki/spaces/PROD/pages/123456"
    },
    "prd": {
      "page_id": "123457",
      "title": "Signup — PRD",
      "url": "..."
    }
  }
}
```

## Markdown to Confluence

| Markdown | Confluence |
|----------|------------|
| `# Heading` | `<h1>` |
| `**bold**` | `<strong>` |
| `[link](url)` | `<a href="url">` |
| Mermaid code blocks | Mermaid macro (or image) |
| Tables | HTML tables |

## Quality Checklist

- [ ] All artifacts in project folder
- [ ] Config has correct space key
- [ ] the Atlassian connector connected
- [ ] Human approved the publish plan
- [ ] Hierarchy will be correct (links page → the team's pages and Epics & Stories → PM workspace → 4 groups)
- [ ] Every page opens with the standard header; the links page lists every handoff output and points to the epic
- [ ] The team's pages do not link into the PM workspace
- [ ] Long docs split at named sections, no "Part N"
- [ ] No numbered titles; pages and table rows in creation order
- [ ] Epics & Stories page shows the approved ticket tree

## Tips

1. **Publish before Jira sync** — Confluence links go in Jira
2. **Review hierarchy first** — harder to move pages later
3. **Use labels** — product-os, initiative-slug, project-slug
4. **Check Mermaid** — ensure macro is available or falls back to image

## Related

- `/jdlt-product-os:publish` — Publish to Confluence
- `/jdlt-product-os:jira-sync` — Create Jira issues after publishing
- `.claude/agents/confluence-publisher.md` — Full agent specification
