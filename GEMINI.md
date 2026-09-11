# Gemini CLI Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `agents/README.md` — agent mapping and shared source-of-truth layout
3. `agents/rules/execution-model.md` — foundational architecture boundary
4. `memory/current.md` — active working state
5. Latest entries in `memory/inbox/` — recent uncompacted work
6. `agents/profiles/gemini.md` — Gemini profile
7. `agents/rules/` — modular rule set
8. Open tracked work items, if your project uses them
9. `sync/issues/` — in-flight coordination notes, if your project uses them
10. `handoffs/active/` — in-flight cross-agent handoffs
11. `specs/active/` — specs currently being drafted or implemented against
12. `loops/active/` — loops currently running or paused

## Project structure

```
agents/                          # SHARED (all agents)
  README.md                      #   agent mapping and adapter explanation
  rules/                         #   modular rule files
  skills/                        #   workflow definitions
  profiles/                      #   per-agent behavioral profiles
memory/                          # Git-tracked shared memory
specs/                           # spec-driven development (active/, archive/, templates/)
prompts/                         # versioned prompt library (library/, templates/)
loops/                           # agent loop definitions (active/, archive/, templates/)
playbooks/                       # operational runbooks
scripts/                         # memory_add.sh, memory_compact.sh
sync/                            # cross-repo coordination notes
repos/                           # linked repositories or source trees
```

## Skills

- `memory-add` — create a memory entry
- `memory-compact` — compact inbox entries into a summary
- `sync-note` — create a sync note from the template
- `bump-pointer` — update a linked-repo pointer after upstream merge
- `handoff-open` — open a cross-agent handoff thread
- `handoff-result` — scaffold the matching handoff result file
- `issue-open` — open a tracked issue for long-running work
- `issue-close` — close a tracked issue with landing citations
- `spec-new` — open a new spec for spec-driven development
- `spec-to-tasks` — convert an approved spec's plan into tracked issues
- `prompt-new` — create a new versioned prompt
- `prompt-iterate` — revise a prompt (version bump + changelog + eval note)
- `loop-new` — open a new agent loop with stop conditions and hard bounds
- `loop-close` — record a loop's outcome and archive it

## Mandatory workflow

1. Check `memory/current.md` at the start of any task.
2. Check `memory/inbox/` for latest uncompacted context.
3. Read `agents/README.md` to understand shared files versus tool adapters.
4. Follow the execution-model boundary before architecture, integration, deployment, or operational changes.
5. Keep local memory, issues/tickets, boards, and docs memory aligned when those systems are in use.
6. For non-trivial or cross-repo changes, write a spec (`spec-new`) before
   implementation; see `agents/rules/spec-driven-development.md`.
7. For repeatable agent loops, declare stop conditions and hard bounds
   (`loop-new`) before running iterations; see `agents/rules/loop-engineering.md`.
8. Follow all rules in `AGENTS.md` and `agents/rules/*.md`.
