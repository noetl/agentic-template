---
name: bump-pointer
status: active
description: Update a linked-repo pointer after upstream merge. Checks docs/wiki, issue/ticket state, and roadmap board state when those systems are in use.
argument-hint: "<repo-name>"
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
---

# Bump Submodule Pointer

Update a linked repository to its latest remote commit and commit the pointer
change. The bump is the checkpoint where three trails are reconciled:

1. **Code** — the submodule pointer itself.
2. **Docs/wiki** — public-surface documentation remains accurate.
3. **Issue/board trail** — tracker and roadmap state match what landed.

Skipping any of these is how coordination drift compounds.

## Steps

1. **Sync first.** Pull latest:
   ```
   git pull --ff-only
   ```

2. **Update the target submodule.**
   ```
   git submodule update --remote repos/$ARGUMENTS
   ```

3. **Inspect what is landing.** Capture the SHA range:
   ```
   OLD_SHA=$(git ls-tree HEAD repos/$ARGUMENTS | awk '{print $3}')
   NEW_SHA=$(cd repos/$ARGUMENTS && git rev-parse HEAD)
   (cd repos/$ARGUMENTS && git log --oneline $OLD_SHA..$NEW_SHA)
   ```
   Show the user the SHA pair and commit summaries. If the range is
   empty, abort.

4. **Identify merged PRs in the range** when the linked repo uses PR merge commits:
   ```
   (cd repos/$ARGUMENTS && git log --merges --oneline $OLD_SHA..$NEW_SHA)
   ```

5. **Docs/wiki check.** For each substantive change in the range:
   - Identify the docs surface that owns the changed module.
   - If the merged code changed a documented public surface, update docs in
     the same change set as the pointer bump.
   - If no covered page exists yet, follow `agents/rules/wiki-maintenance.md`.
   - If the project does not use wiki/docs memory for this surface, record
     that explicitly in the commit body.

6. **Issue and board check.** For each substantive change in the range:
   - Find the linked issue/ticket, if one exists.
   - Update status/comments with the merged PR and pointer-bump SHA.
   - Close only when acceptance criteria are satisfied.
   - If the project uses roadmap boards, update board status in the same
     change set.
   - If no issue exists and the change is substantive, open one
     retroactively or explain why the work is intentionally inline.

7. **Commit the pointer bump.** Cite the issue(s), docs/wiki update, and
   validation result in the body:
   ```
   git add repos/$ARGUMENTS
   git commit -m "chore(sync): bump $ARGUMENTS to <short-sha>"
   ```

8. **Ask before pushing.** Pointer bumps touch shared coordination state.

## Hard constraints

- Never bump a pointer past code that has open acceptance criteria the new
  SHA does not satisfy.
- Never silently skip the docs/wiki check for a public-surface change.
- Never push to `origin/main` without explicit user go-ahead.
