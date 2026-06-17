---
name: issue-close
description: Close a tracked issue only after acceptance criteria are met.
argument-hint: "<number>"
allowed-tools:
  - Bash
  - Read
---

# Close Tracked Issue

Close a tracked issue once the work has actually landed. The close comment
cites the landing PR and pointer-bump commit so a future reader can
reconstruct what closed it.

## Steps

1. Parse `$ARGUMENTS` as the issue number or tracker ID.
2. Fetch the issue body and read the `## Goal` section.
3. Confirm every acceptance bullet is actually satisfied. If any are still
   open, abort and tell the user which bullet remains.
4. Identify landing artifacts, typically:
   - A merged PR in the owning repository.
   - A pointer-bump commit in this coordination repository.
   - A docs/wiki update if the work changed a public surface.
5. Close with a citation comment referencing those artifacts.
6. If the project uses roadmap boards, move the item to Done.
7. Print the closed issue URL.

## Hard constraints

- Do not close on intent alone. The work must be merged and referenced.
- Do not close if pointer bumps or docs updates required by project rules are
  still missing.
- Do not reopen issues from this skill. If the work regressed, open a new
  issue that links back.
- The citation comment is required.
