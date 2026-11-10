---
description: "Clean version history out of project docs, Confluence pages and Jira tickets so they show the current state only."
argument-hint: "--project <path> [--confluence] [--jira] [--dry-run]"
---
# /product-os:cleanup

Clean version history out of project docs, Confluence pages and Jira tickets so they show the current state only.

## Usage

```
/product-os:cleanup --project <path> [--confluence] [--jira] [--dry-run]
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--project` | Yes | Path to project folder |
| `--confluence` | No | Also clean and republish the project's Confluence pages (from `publish-manifest.json`) |
| `--jira` | No | Also clean the summaries and descriptions of the project's epics and issues (from `jira-sync-manifest.json`) |
| `--dry-run` | No | Lint and list proposed changes only; edit and write nothing |

Without `--confluence` or `--jira`, only the local project docs are cleaned.

## What Gets Removed

- Version banners, superseded TL;DRs and `<details>` history blocks (one `## TL;DR` stays)
- Change narratives: `was X, now Y`, `renamed from`, `replaces the old`
- Retired and superseded items, using the doc's own markers (Deferred and Parked items stay)
- Disposition tags (`Re-scoped`, `New`, `Unchanged`, `Amended`); amended wording is applied first
- Version tokens in prose (never in IDs, filenames, API paths, library versions or Jira keys)
- Vague TBDs, rewritten to name what is undecided

Full rules with bad/good examples: `.claude/skills/doc-hygiene.md`.

## Verification

```bash
python3 scripts/doc-hygiene-check.py lint <files…>                      # history patterns, fences, anchors
python3 scripts/doc-hygiene-check.py guard <files…> --git-ref HEAD       # repo docs: nothing invented
python3 scripts/doc-hygiene-check.py guard <clean/*.md> --against-dir <orig/>  # fetched pages or tickets
```

## Output

- Project docs cleaned in place
- `.cleanup/confluence/` and `.cleanup/jira/` — original and cleaned copies of fetched pages and issues
- Cleanup report: per item, size before → after, retired IDs removed, kept hits, unsure points
- Confluence pages and Jira issues updated in place (after approval)

## Example

```
/product-os:cleanup --project initiatives/onboarding/signup/ --dry-run
/product-os:cleanup --project initiatives/onboarding/signup/ --confluence --jira
```

## Agent

Uses: `doc-cleaner.md`

## Prerequisites

- Project docs committed (the guard compares with `HEAD`)
- For `--confluence` / `--jira`: Atlassian MCP connected (preferred; no credentials needed), OR `ATLASSIAN_EMAIL` and `ATLASSIAN_API_TOKEN` in `.env` (REST fallback only)

## Approval

The agent first shows the cleaned content, the invention-guard report and the removed items. Nothing is written to Confluence or Jira until you explicitly approve. Pages and issues are updated in place; nothing is created or deleted. Leftover split pages are retitled `Archived — <title>` for you to delete.

## See Also

- `/product-os:publish` — Republish cleaned docs to Confluence
- `/product-os:jira-sync` — Sync epics and stories to Jira
