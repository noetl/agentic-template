# Claude Code Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `agents/README.md` — agent mapping and shared source-of-truth layout
3. `agents/rules/execution-model.md` — architecture and boundary guardrails
4. `memory/current.md` — active working state
5. Latest entries in `memory/inbox/` — recent uncompacted work
6. Open tracked work items, if your project uses them
7. Linked roadmap boards, if your project uses them
8. Linked wiki/doc surfaces for impacted areas, if your project uses them
9. `sync/issues/` — in-flight coordination notes, if your project uses them
10. `handoffs/active/` — in-flight handoff rounds whose latest result is missing, partial, or blocked
11. `specs/active/` — specs currently being drafted or implemented against
12. `loops/active/` — loops currently running or paused

## Project structure

```
agents/                          # SHARED (all agents)
  README.md                      #   agent mapping and adapter explanation
  rules/                         #   modular rule files (auto-loaded via .claude/rules symlink)
  skills/                        #   workflow definitions (auto-loaded via .claude/skills symlink)
  profiles/                      #   per-agent behavioral profiles
.claude/
  settings.json                  #   Claude Code permissions, hooks, env
  rules -> ../agents/rules       #   symlink to shared rules
  skills -> ../agents/skills     #   symlink to shared skills
  agents/                        #   Claude-specific subagent definitions (frontmatter + @import)
.github/copilot-instructions.md  # Copilot entry point (references agents/)
.cursorrules                     # Cursor entry point (references agents/)
memory/                          # Git-tracked shared memory
specs/                           # spec-driven development (active/, archive/, templates/)
prompts/                         # versioned prompt library (library/, templates/)
loops/                           # agent loop definitions (active/, archive/, templates/)
evals/                           # agent regression scenarios (scenarios/, templates/)
playbooks/                       # operational runbooks
scripts/                         # memory_add.sh, memory_compact.sh
sync/                            # cross-repo coordination notes
repos/                           # linked repositories or source trees
```

## Skills (slash commands)

- `/memory-add "<title>" "<summary>" "<tags>"` — create and commit a memory entry
- `/memory-compact` — compact inbox entries into a summary
- `/sync-note "<topic>"` — create a sync note from the template
- `/bump-pointer "<repo>"` — update a linked-repo pointer after upstream merge
- `/handoff-open <slug> "<description>"` — open a cross-agent handoff thread
- `/handoff-result <slug>` — scaffold the matching handoff result file
- `/issue-open "<title>" "<repo>"` — open tracked long-running issue
- `/issue-close <number>` — close tracked issue with landing citations
- `/spec-new <slug> "<problem statement>"` — open a new spec
- `/spec-to-tasks <slug>` — convert an approved spec's plan into tracked issues
- `/prompt-new <name> "<intent>"` — create a new versioned prompt
- `/prompt-iterate <name>` — revise a prompt (version bump + changelog + eval note)
- `/loop-new <slug> "<goal>"` — open a new agent loop with stop conditions
- `/loop-close <slug>` — record a loop's outcome and archive it
- `/eval-new <slug> "<behavior>"` — add a regression scenario for a rule/skill/profile
- `/eval-record <slug>` — log a scenario run's pass/fail outcome

## Daily operating checks

At the start of work:

- Verify local memory and open tasks are aligned when those systems are in use.
- Verify impacted wiki/confluence pages are identified when those systems are in use.

Before pointer bumps:

- Confirm merged PR range.
- Confirm tracked issue/ticket updates.
- Confirm wiki/confluence updates for changed public surfaces when those systems are in use.

## Quick commands (manual)

- Add memory: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact memory: `./scripts/memory_compact.sh`
- Submodule status: `git submodule status --recursive`
- Bump pointer: `git submodule update --remote repos/<name> && git add repos/<name>`

## Commit conventions

- `memory(add): <topic>`
- `memory(compact): <scope>`
- `memory(curate): <scope>`
- `chore(sync): bump <repo> to <short-sha>`
- `docs(agents): <description>`
- `handoff(open): <slug>` — when writing `round-01-prompt.md`
- `handoff(prompt): <slug> round NN` — when writing a follow-up prompt
- `handoff(result): <slug> round NN` — when writing a result
- `handoff(close): <slug>` — when moving a thread to `handoffs/archive/`
- `spec(new): <slug>` / `spec(tasks): <slug>`
- `prompt(add): <name>` / `prompt(iterate): <name> vN`
- `loop(open): <slug>` / `loop(close): <slug>`
- `eval(new): <slug>` / `eval(record): <slug>`
