# Gemini Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `agents/rules/execution-model.md` — architecture and boundary guardrails
3. `memory/current.md` — active working state
4. `agents/profiles/gemini.md` — Gemini profile
5. `agents/rules/` — modular rule set
6. Open tracked work items (`GitHub Issues` and/or `Jira`) for durable task state
7. `sync/issues/` — in-flight cross-repo tracking
8. Linked wiki/doc surfaces (`GitHub Wiki` and/or `Confluence`) for impacted modules

## Workflow highlights

- Use `agents/skills/` workflows when available.
- Use file-based handoffs in `handoffs/` for cross-session work.
- Keep product code changes inside `repos/<name>` only.
- Keep local memory, issues/tickets, and docs memory synchronized for substantive changes.

## Quick checks

- Verify local memory and open tasks are aligned before starting work.
- Verify impacted wiki/confluence pages are identified before pointer bumps.
- Confirm tracked issue/ticket updates and docs updates for changed public surfaces.

## Quick commands

- Add memory: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact memory: `./scripts/memory_compact.sh`
- Submodule status: `git submodule status --recursive`