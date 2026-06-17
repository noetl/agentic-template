# {{PROJECT_NAME}} AI Instructions

This file defines mandatory behavior for AI agents operating in this repository.

## Scope

- Applies to the entire `{{PROJECT_NAME}}` coordination repository.

## Mission

- Orchestrate changes across project areas, repositories, or workstreams.
- Keep shared instructions, skills, and rules consistent.
- Maintain reproducible references for linked repos, releases, or other external dependencies.

## Foundational execution model — read first

Before designing any feature, integration, deployment change, or operational
fix, measure the proposal against the execution-model boundary:
**gateway = gatekeeper, worker = atomic compute, workflow/playbook =
ephemeral blueprint, shared cache/state = explicit state vehicle, event log =
source of truth.**

- Behavioral rule for AI agents: `agents/rules/execution-model.md`.
- Optional full architecture docs belong in the owning project docs surface.

If a proposal moves business data touches into a gateway/client layer, holds
process state across external waits, or introduces hidden long-lived runtime
state without replay semantics, reshape the proposal before implementation.

## Hard rules

1. This repository is public. Never store secrets or sensitive values.
2. Keep product code in its owning source tree; this repo may own code only when intentionally used as an active project repo.
3. Allowed content:
   - AI instruction files
   - orchestration docs and checklists
   - linked-repo pointer updates or deterministic source references
   - AI memory entries and compactions
   - cross-agent handoff threads (`handoffs/active/`, `handoffs/archive/`)
4. Keep memory updates append-only through Git history.
5. Keep pointer updates minimal and deterministic.
6. Never rewrite history on `main`.
7. Cross-agent handoffs are append-only: never edit a prior round's prompt or result; open a new round instead.
8. For substantive changes, update issue/ticket state and docs/wiki state in the same change set when those systems are in use.

## Memory ownership

- Keep `memory/` focused on durable project decisions, coordination state,
  linked-repository pointer state, deployment state, and cross-repo outcomes.
- Keep product-specific implementation notes in the owning source tree when
  this repo is only acting as a coordination layer.
- If a downstream project requires a platform or template change, record the
  downstream context in that project's memory and record only the shared
  platform/template decision here.

## Repository workflow

- Make code changes in the repository or project area that owns the code.
- Open PRs and merge in the upstream repository or main branch you actually use.
- After merge, update any pointer, link, or reference in this repo if your workflow tracks that state here.
- For linked repositories, run from the repository root and use:
  - `git submodule sync --recursive`
  - `git submodule update --init --recursive`

## Commit conventions

- `memory(add): <topic>` — new memory inbox entry
- `memory(compact): <scope or date>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <short-sha>` — linked-repo or pointer update
- `docs(agents): <description>` — instruction/agent doc changes
- `handoff(open): <slug>` — open handoff thread
- `handoff(prompt): <slug> round NN` — follow-up handoff prompt
- `handoff(result): <slug> round NN` — publish handoff result
- `handoff(close): <slug>` — archive completed thread

## Memory workflow

1. Add entries: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
2. Commit: `git add memory/inbox && git commit -m "memory(add): <topic>"`
3. Compact: `./scripts/memory_compact.sh`
4. Commit: `git add memory && git commit -m "memory(compact): <scope>"`

## Extended memory systems

Use these as supported extensions to repository memory:

- GitHub Issues: durable issue lifecycle and acceptance criteria
- Jira: project management state and dependency tracking
- GitHub Wiki: repository-scoped technical memory
- Confluence: broader architecture and operations memory

Operational rule: when a substantive task progresses, update local memory and the linked issue/ticket/wiki in the same working session.

## Agent rules

All agents must:

- Read `AGENTS.md` at session start
- Read `agents/README.md` for the shared source-of-truth layout
- Read `memory/current.md` for active working state
- Follow commit conventions above
- Never store secrets or credentials
- Work in the source tree that owns the code for changes
- Use the memory pipeline for decisions and outcomes
- Use file-based handoffs for multi-session or cross-agent work

Detailed modular rules are in `agents/rules/`. Behavioral profiles are in `agents/profiles/`.

## Cross-agent handoffs

When work spans sessions or tools:

1. Write prompt to `handoffs/active/<slug>/round-NN-prompt.md`
2. Execute based on that prompt only (self-contained brief)
3. Write report to `handoffs/active/<slug>/round-NN-result.md`
4. Open a new round instead of rewriting earlier files
5. Move completed thread to `handoffs/archive/<slug>/`

See `handoffs/README.md` and `agents/rules/handoffs.md`.

## Validation before merge

- Changed pointers map to merged commits in upstream repos.
- Instruction docs remain internally consistent.
- Runtime-impacting changes have local validation evidence.
- Public-surface changes have matching docs/wiki updates when those systems are in use.

## Logging hygiene

- Keep logs minimal by default.
- Avoid INFO-level logs for high-frequency health/internal polling paths.
- When adding new health/check/poll endpoints, suppress noisy access logs or log at DEBUG with rate limiting/sampling.
- Any change that can increase request log volume must include a quick flood check and an explicit rationale.
