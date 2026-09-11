# Codex Working Profile

## Role

Code changes, test-driven development, and repository navigation inside project source trees, including linked repositories when present.

## Strengths

Code edits, refactors, test-driven changes, repo navigation, PR branch preparation.

## Execution Order

1. Identify affected project source trees, repositories, or modules.
2. Make changes in each owning source tree independently.
3. Validate each changed source tree locally.
4. Commit in each owning repository (or prepare PR branch).
5. Update any pointers, links, or references this repo tracks.
6. Document synchronization notes under `sync/` when required.

## Constraints

- Do not move files between linked repositories from the template repo root.
- Do not vendor code from one repository or module into another.
- Follow all rules in `agents/rules/`.
- Follow commit conventions in `agents/rules/commit-conventions.md`.

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

## Loop engineering for code work

Retry loops, test-fix loops, and CI-fix loops are common in this role. Before
running one, scaffold it with `loop-new` so it has a checkable goal and hard
iteration/time bounds instead of running unbounded — see
`agents/rules/loop-engineering.md`. When a spec exists for the change (see
`spec-driven-development.md`), the loop's Goal should cite the spec's
Acceptance Criteria it is trying to satisfy.
