# Insights Assistant PRD

## TL;DR

**Problem:** Sales teams cannot answer sponsor questions quickly.

## Requirements

| ID | Requirement | Status |
|----|-------------|--------|
| FR-101 | Chat answers sponsor questions | Active |
| FR-103 | Weekly digest | Deferred |

**Note:** answers cite their sources.

**Analytics tool:** TBD (owner picks during E10). Events are tool-agnostic.

Calls `GET /v1/insights` and ships in `prd-v2.md`; charts use d3 v7.8.5.

See [requirements](#requirements) and the [API docs](https://example.com/v2/docs).

```gherkin
Scenario: Weekly run fires on its schedule slot
```
