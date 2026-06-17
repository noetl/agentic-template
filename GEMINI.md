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

## Project structure

```
agents/                          # SHARED (all agents)
  README.md                      #   agent mapping and adapter explanation
  rules/                         #   modular rule files
  skills/                        #   workflow definitions
  profiles/                      #   per-agent behavioral profiles
memory/                          # Git-tracked shared memory
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

## Mandatory workflow

1. Check `memory/current.md` at the start of any task.
2. Check `memory/inbox/` for latest uncompacted context.
3. Read `agents/README.md` to understand shared files versus tool adapters.
4. Follow the execution-model boundary before architecture, integration, deployment, or operational changes.
5. Keep local memory, issues/tickets, boards, and docs memory aligned when those systems are in use.
6. Follow all rules in `AGENTS.md` and `agents/rules/*.md`.
