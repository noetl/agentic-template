---
name: issue-open
description: Open a tracked issue for long-running or cross-session work.
argument-hint: "\"<title>\" <repo>"
allowed-tools:
  - Bash
  - Read
  - Write
---

# Open Tracked Issue

Open a tracker issue so the work survives session compaction and is visible to
every agent that picks up next.

## When to use

Open an issue if any of these are true:

- A future session needs to pick it up.
- Work is blocked on a human decision, external action, or another PR landing.
- Multiple agents may touch the same task.
- The user might reasonably ask for status days from now.

If the work is a one-shot side task this session can finish now, do it inline.

## Steps

1. Parse `$ARGUMENTS` as `"<title>" <repo>`.
2. Validate that the title is an imperative action phrase under 70 characters.
3. Check for duplicate open issues before creating a new one.
4. Draft the body in conversation with the user before opening. The body must
   contain:
   - `## Context`
   - `## Goal`
   - `## Pointers`
   - `## Blocked on`
   - `## Links`
5. Public-safety check: scan for secrets, tokens, customer data, and sensitive
   diagnostic values. Mask before opening.
6. Create the issue using the project's tracker command and labels, for example:
   ```
   gh issue create --title "<title>" --label task --label area:<repo> --body-file <body-file>
   ```
   Use the tracker labels your project defines; do not assume this example's
   labels exist.
7. If the project uses roadmap boards, add the issue to the correct board.
8. Print the issue URL.

## Hard constraints

- Do not open duplicate issues. Search first.
- Do not create new repo labels unless the user or project rules define them.
- Do not auto-close someone else's issue from this skill.
- Do not open an issue with missing required sections.
- Never include secrets. This repo is public.
