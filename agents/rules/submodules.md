---
globs:
  - "repos/**"
---

# Submodule Rules

## Working in linked repositories

- Code changes happen **inside** the relevant `repos/<name>` linked repository.
- Open PRs and merge in the linked repository's upstream repository.
- Never move files between linked repositories from the template repo root.
- Never vendor code from one linked repository into another.
- Keep pointer updates small and deterministic where possible.

## Updating pointers

- After upstream PRs are merged, update the pointer:
  ```
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule update --remote repos/<name>
  git add repos/<name>
  git commit -m "chore(sync): bump <name> to <short-sha>"
  ```
- Always verify the diff before committing pointer updates.

Before committing a pointer bump for substantive changes, verify:

- Linked issue/ticket has a status update (`GitHub` and/or `Jira`).
- Linked roadmap board state is current when your project uses boards.
- Linked docs memory (`GitHub Wiki` and/or `Confluence`) reflects changed public surfaces.
- A sync note exists or is updated under `sync/issues/` for cross-project changes.

## Adding new linked repositories

- Add with: `git submodule add <remote-url> repos/<name>`
- Commit with: `chore(sync): add <name> linked repository`
