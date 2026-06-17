# Handoff Routing

This rule sits beside [`handoffs.md`](handoffs.md). `handoffs.md` says how to
write a durable brief; this file says when to write one.

## Default rule

Do the work in the current session when it is small enough, sufficiently
understood, and within the current agent's tool access. Open a handoff only
when durable cross-session or cross-agent coordination is worth the overhead.

## Use a handoff when

- The receiver will not have the current chat context.
- The work has gated or destructive phases.
- The dispatcher needs a structured report at a known path.
- A future agent or teammate may need to pick up the thread.
- Work must be isolated in another tool, worktree, or runtime.

## Stay in chat when

- The current agent can finish the task end to end.
- The task is a one-shot edit or explanation.
- A handoff would only restate context already available in this session.

## Project-specific routing

Specialized projects may add stricter routing rules here, such as "do not
delegate Rust code changes" or "use a specific agent for design review only."
Put those overrides in this file when the template is specialized, and keep
them explicit enough that a future agent knows when they fire.

## Coordination with other rules

- [`handoffs.md`](handoffs.md) defines prompt/result structure.
- [`commit-conventions.md`](commit-conventions.md) defines handoff commit
  subjects.
- [`issue-tracking.md`](issue-tracking.md) applies when the task will outlive
  the current session.
