---
globs:
  - "memory/**"
  - "scripts/**"
---

# Memory Workflow Rules

## Adding entries

- Use `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"` to create entries.
- Each entry gets a unique timestamped filename.
- One topic per entry.
- Keep entries factual and actionable.
- Commit with `memory(add): <topic>`.

## Compaction

- Run `./scripts/memory_compact.sh` periodically (daily/weekly, or after significant work).
- Commit with `memory(compact): <scope>`.
- Only one compaction at a time (no concurrent compactors).

## Curation

- Periodically review and update `memory/current.md` to keep it focused.
- Commit with `memory(curate): <scope>`.

## Rules

- Never delete or overwrite inbox entries — append only.
- Never store secrets, tokens, or credentials in memory entries.
- Use the `## Related` section to cross-reference sync notes and other entries.
- Keep shared memory focused on durable project decisions, coordination state, and outcomes.
- Store implementation-specific memory near the owning source tree when the project has multiple repos or modules.

## External memory synchronization

Use `agents/rules/external-memory-systems.md` as companion guidance.

For substantive work, keep these synchronized in the same session:

- Local memory (`memory/`)
- Local coordination notes (`sync/issues/`)
- Work tracker (`GitHub Issues` and/or `Jira`)
- Documentation memory (`GitHub Wiki` and/or `Confluence`) when public surfaces changed

Suggested `## Related` entries include:

- GitHub issue URL
- Jira ticket key/URL
- Wiki/confluence page URL
- submodule PR URL
