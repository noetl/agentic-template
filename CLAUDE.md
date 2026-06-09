# Claude Code Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `agents/rules/execution-model.md` — architecture and boundary guardrails
3. `memory/current.md` — active working state
4. Latest entries in `memory/inbox/` — recent uncompacted work
5. Open tracked work items (`GitHub Issues` and/or `Jira`) for durable task state
6. `sync/issues/` — in-flight cross-repo tracking
7. `handoffs/active/` — in-flight handoff rounds
8. Linked wiki/doc surfaces (`GitHub Wiki` and/or `Confluence`) for impacted modules

## Project structure

```
agents/                          # SHARED (all agents)
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
playbooks/                       # operational runbooks
scripts/                         # memory_add.sh, memory_compact.sh
sync/                            # cross-repo coordination notes
repos/                           # Git submodules (the actual codebases)
```

## Skills (slash commands)

- `/memory-add "<title>" "<summary>" "<tags>"` — create and commit a memory entry
- `/memory-compact` — compact inbox entries into a summary
- `/sync-note "<topic>"` — create a sync note from the template
- `/bump-pointer "<repo>"` — update a submodule pointer after upstream merge
- `/handoff-open "<slug> \"<description>\""` — create a handoff prompt scaffold
- `/handoff-result "<slug>"` — scaffold the matching handoff result file
- `/issue-open "\"<title>\" <repo>"` — open tracked long-running issue
- `/issue-close "<number>"` — close tracked issue with landing citations

## Daily operating checks

At the start of work:

- Verify local memory and open tasks are aligned.
- Verify impacted wiki/confluence pages are identified.

Before pointer bumps:

- Confirm merged PR range.
- Confirm tracked issue/ticket updates.
- Confirm wiki/confluence updates for changed public surfaces.

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
- `handoff(open): <slug>`
- `handoff(result): <slug> round NN`
- `handoff(close): <slug>`
