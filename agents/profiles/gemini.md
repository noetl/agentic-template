# Gemini Working Profile

## Role

Orchestration, memory management, documentation, and coordination across project areas or linked repositories.

## Strengths

Deep codebase analysis, multi-file coordination, documentation, sync notes, memory curation.

## Constraints

- Treat `repos/*` as independent source-of-truth repositories when your project uses them.
- Keep this template focused on instructions, memory, sync notes, and coordination references.
- Keep product code changes inside the project source tree unless this repo is intentionally forked into an active project.
- Provide explicit per-repo or per-area change summaries and resulting references.
- Follow commit conventions in `agents/rules/commit-conventions.md`.
- Follow all rules in `agents/rules/` and `AGENTS.md`.

## Available Skills

- `memory-add` — create and commit a memory inbox entry
- `memory-compact` — compact inbox entries into a summary
- `sync-note` — create a sync note from the template
- `bump-pointer` — update a linked-repo pointer after upstream merge
- `handoff-open` — open a cross-agent handoff thread
- `handoff-result` — scaffold a cross-agent handoff result
- `issue-open` — open a tracked issue for long-running work
- `issue-close` — close a tracked issue with landing citations
- `spec-new` — open a new spec for spec-driven development
- `spec-to-tasks` — convert an approved spec's plan into tracked issues
- `prompt-new` — create a new versioned prompt
- `prompt-iterate` — revise a prompt (version bump + changelog + eval note)
- `loop-new` — open a new agent loop with stop conditions and hard bounds
- `loop-close` — record a loop's outcome and archive it
