# Doc Cleaner Agent

Strips version history out of docs, Confluence pages and Jira tickets so readers see the current state only.

## What It Does

Removes version banners, superseded TL;DRs, history blocks, change narratives, disposition tags and retired items from existing project docs. Rewrites vague TBDs to name what is undecided. Verifies with a lint and an invention guard, then (after your approval) republishes Confluence pages and updates Jira issues in place.

## When to Use

- After a scope change left every page and ticket full of `v2` / `v3` notes
- The team says a page is confusing or they cannot tell which part is current
- Before publishing artifacts that went through several revisions

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `--project` | Yes | Project folder to clean |
| `--confluence` | No | Also clean and republish the project's Confluence pages |
| `--jira` | No | Also clean the project's epic and issue summaries and descriptions |
| `--dry-run` | No | Lint and list proposed changes only |

## Outputs

- Project docs cleaned in place
- `.cleanup/` — original and cleaned copies of fetched pages and issues
- Cleanup report — size before → after, retired IDs removed, kept hits, unsure points
- Confluence pages and Jira issues updated in place (after approval)

## Example

```bash
/product-os:cleanup --project initiatives/onboarding/signup/ --dry-run
/product-os:cleanup --project initiatives/onboarding/signup/ --confluence --jira
```

## How It Checks Its Work

1. **Lint** — `python3 scripts/doc-hygiene-check.py lint <files>` flags history patterns, odd code fences and broken anchors.
2. **Invention guard** — `python3 scripts/doc-hygiene-check.py guard <files> --git-ref HEAD` lists any inserted words the original never had. You review it before anything is published.

## Tips

1. **Commit first** — the guard compares with the committed version
2. **Clean source docs before Confluence** — pages are rebuilt from them
3. **Leftover split pages** are retitled `Archived — <title>`; delete them yourself
4. **Unsure items are listed, not guessed** — decide them, then rerun

## Related

- [Confluence Publisher](confluence-publisher.md) — republishes cleaned pages in place
- [Jira Sync](jira-sync.md) — keeps issues in sync after cleanup
- [Decision Logger](decision-logger.md) — superseded decisions keep a one-line stub
