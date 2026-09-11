# Safety Rules

## Template vs. project repo visibility

- The upstream template ([noetl/agentic-template](https://github.com/noetl/agentic-template))
  is intentionally public.
- Any project repo created *from* this template (via `init.sh` or GitHub's "Use this
  template") should default to **private** — set that at repo-creation time, not as an
  afterthought (e.g. `gh repo create <org>/<slug>-meta --template noetl/agentic-template
  --private`). Only make a project instance public for a deliberate, stated reason.
- Because visibility varies per instance, don't assume either way from memory — check
  the actual repo (`gh repo view --json visibility`) before treating "it's private, so
  X is fine" as true.

## Rules

- Never store secrets, tokens, credentials, or sensitive values in this repository,
  regardless of whether it is public or private.
- Keep product code in the source tree that owns it; this repo may own code only when
  intentionally used as an active project repo.
- Never rewrite history on `main`.
- Memory updates must be append-only through Git history.
- Cross-agent handoffs are durable, widely-read artifacts; prompts and results must not
  contain secrets, private customer data, or credentials, regardless of repo
  visibility.
