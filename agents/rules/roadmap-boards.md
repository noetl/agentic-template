# Roadmap Boards

Projects that use GitHub Projects, Jira boards, or another roadmap system must
keep board state aligned with the underlying issue/ticket lifecycle.

This rule is the board sibling of [`issue-tracking.md`](issue-tracking.md) and
[`wiki-maintenance.md`](wiki-maintenance.md): issue, board, and docs state move
together when substantive work moves.

## Board registry

When specializing this template, list the project boards here:

| ID | Name | URL | Scope | Status field options |
| :-- | :-- | :-- | :-- | :-- |
| TBD | TBD | TBD | Cross-repo or project-scoped tasks | Todo / In progress / Done |

The registry is the source of truth for which board owns which work.

## Rule 1: every tracked issue lands on its board

When `issue-tracking.md` says to open an issue, add the issue to its scoped
board in the same working session. If automation does this, verify the item is
present rather than assuming.

## Rule 2: status sync on lifecycle transitions

The board status must match the issue/ticket lifecycle:

| Issue transition | Board status |
| :-- | :-- |
| New task opened, nobody working yet | Todo |
| Work started, PR opened, branch pushed, validation begun, or handoff dispatched | In progress |
| Acceptance criteria satisfied and issue closed | Done |
| Blocked on external action | Keep current status and record blocker on the issue |

## Rule 3: pointer bumps check the board

Before committing a pointer bump:

1. Look up linked issues/tickets in the merged range.
2. Verify their board items exist.
3. Move closed or completed work to Done.
4. Move newly active work to In progress.

## Rule 4: boards reflect present work

Boards are a present-tense view, not a history log. Use issue comments, sync
notes, memory entries, and release/session logs for history.
