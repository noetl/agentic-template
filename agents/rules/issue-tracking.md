# Issue Tracking

Use issues/tickets as the durable store for non-trivial tasks that may outlive one session.

In-session task lists are ephemeral. Durable tracking must live in external systems.

## Recommended two-tier model

1. Umbrella issue/ticket
	- GitHub issue in the coordination repository and/or a Jira epic/story
	- Captures goal, acceptance criteria, blockers, and cross-repo scope
2. Submodule round issues
	- Per-submodule issue/ticket for concrete implementation rounds
	- Closed by merged PRs in the owning repository

## Open an issue when

- Work needs follow-up in a later session.
- Work is blocked on external action or human decision.
- Multiple agents may touch the same task.

When in doubt, open one. The overhead is low and it prevents task loss.

## Issue body shape

Use these sections in this order:

1. `## Context`
2. `## Goal`
3. `## Pointers`
4. `## Blocked on`

## Update rules

- Comment when work starts, PR opens, and PR merges.
- Include pointer bump commit references when relevant.
- Close only after acceptance criteria are satisfied.

For substantive cross-repo work, update in the same session:

- Local memory (`memory/` and `sync/issues/`)
- Linked issue/ticket (`GitHub` and/or `Jira`)
- Linked docs memory (`GitHub Wiki` and/or `Confluence`) when public surfaces changed

## Suggested issue/ticket body shape

Use these sections in this order:

1. `## Context`
2. `## Goal`
3. `## Pointers`
4. `## Blocked on`
5. `## Links`

`## Links` should include submodule PRs, wiki/confluence pages, and local sync note path.

## Board workflow

If your org uses GitHub Projects or Jira boards, status must reflect issue/ticket lifecycle:

- New task -> Todo
- Active implementation -> In progress
- Accepted and landed -> Done

## Safety

- Never include secrets or sensitive values.
- Avoid duplicate issues; search open issues before creating a new one.