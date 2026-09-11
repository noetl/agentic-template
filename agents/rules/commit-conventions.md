# Commit Conventions

Use these prefixes for commits:

- `memory(add): <topic>` — new memory inbox entry
- `memory(compact): <scope or date>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <short-sha>` — linked-repo pointer update
- `docs(agents): <description>` — instruction/agent doc changes
- `handoff(open): <slug>` — first `round-NN-prompt.md` in a thread
- `handoff(prompt): <slug> round NN` — follow-up prompt
- `handoff(result): <slug> round NN` — result written by executor
- `handoff(close): <slug>` — archive completed handoff thread
- `spec(new): <slug>` — new spec opened under `specs/active/`
- `spec(tasks): <slug>` — spec's plan converted into tracked issues
- `prompt(add): <name>` — new prompt added to the library
- `prompt(iterate): <name> vN` — prompt revised (version bump)
- `loop(open): <slug>` — new loop definition opened under `loops/active/`
- `loop(close): <slug>` — loop outcome recorded and archived
- `eval(new): <slug>` — new regression scenario added under `evals/scenarios/`
- `eval(record): <slug>` — scenario run outcome appended

## Issue references in commits

Substantive commits should cite the issue/ticket they relate to when the
project uses a tracker. Use the tracker-native close keyword only when the
commit fully satisfies the issue's acceptance criteria; use a non-closing
reference for partial progress.

For multi-round umbrella work, reserve close keywords for the final change
that ships the last required piece. Pointer bumps that close an issue should
put the close keyword in the body, not the subject.
