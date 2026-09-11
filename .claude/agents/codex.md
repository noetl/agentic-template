---
name: codex
description: Claude Code subagent for Codex-style code work inside project source trees
model: sonnet
tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
skills:
  - memory-add
  - memory-compact
  - sync-note
  - bump-pointer
  - handoff-open
  - handoff-result
  - issue-open
  - issue-close
  - spec-new
  - spec-to-tasks
  - prompt-new
  - prompt-iterate
  - loop-new
  - loop-close
  - eval-new
  - eval-record
---

@agents/profiles/codex.md
