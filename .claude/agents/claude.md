---
name: claude
description: Claude Code agent for orchestration, memory management, and cross-repo coordination
model: sonnet
tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - Task
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
---

@agents/profiles/claude.md
