# Cross-agent handoffs

Convention for passing work between AI agents (Claude Code, Copilot/Codex,
Cursor, Gemini, and others) using files instead of chat.

## Layout

```
handoffs/
  README.md
  templates/
    prompt.md
    result.md
  active/
    <YYYY-MM-DD-slug>/
      round-01-prompt.md
      round-01-result.md
      round-02-prompt.md
      round-02-result.md
  archive/
    <YYYY-MM-DD-slug>/
```

## Rules

1. One thread per topic (`<YYYY-MM-DD-short-topic>`).
2. One round is one prompt + one result file.
3. Never rewrite old rounds; append new rounds.
4. Keep content secret-free regardless of repo visibility (no secrets or credentials).
5. Commit prompt and result files as durable artifacts.

## Lifecycle

1. Dispatcher creates `round-01-prompt.md` from `templates/prompt.md`.
2. Executor reads the prompt and writes `round-01-result.md`.
3. Dispatcher either closes the thread (move to `archive/`) or opens a new round.

See also `agents/rules/handoffs.md`.