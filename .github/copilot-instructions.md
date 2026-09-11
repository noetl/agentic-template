# GitHub Copilot Instructions

This is the coordination repository for the **{{PROJECT_NAME}}** project template.

## Required reading

Read these files at session start:

1. `AGENTS.md` — mandatory rules
2. `agents/README.md` — agent mapping and shared source-of-truth layout
3. `agents/rules/execution-model.md` — foundational architecture boundary
4. `memory/current.md` — active working state
5. `agents/profiles/` — your working profile
6. `agents/rules/` — all rule files

## Rules

Read and follow all files in `agents/rules/`, especially:

- Safety (`safety.md`)
- Allowed content (`allowed-content.md`)
- Commit conventions (`commit-conventions.md`)
- Memory workflow (`memory-workflow.md`)
- Repository/link handling (`submodules.md`)
- Handoffs (`handoffs.md`)
- Issue tracking (`issue-tracking.md`)
- Roadmap boards (`roadmap-boards.md`) when your project uses boards
- Wiki maintenance (`wiki-maintenance.md`) when your project uses wiki/docs memory
- Writing style (`writing-style.md`)
- Spec-driven development (`spec-driven-development.md`) for non-trivial changes
- Loop engineering (`loop-engineering.md`) for repeatable agent loops
- Prompt engineering (`prompt-engineering.md`) for reusable/versioned prompts
- Context engineering (`context-engineering.md`) for what belongs in an agent's context
- Agent regression testing (`agent-regression-testing.md`) before changing shared behavior
- Tool and MCP governance (`tool-governance.md`) before adding a new tool to a profile
- Definition of Done (`definition-of-done.md`) for small, same-session work

## Skills

Read the `SKILL.md` in each directory under `agents/skills/`:

- `agents/skills/memory-add/`
- `agents/skills/memory-compact/`
- `agents/skills/sync-note/`
- `agents/skills/bump-pointer/`
- `agents/skills/handoff-open/`
- `agents/skills/handoff-result/`
- `agents/skills/issue-open/`
- `agents/skills/issue-close/`
- `agents/skills/spec-new/`
- `agents/skills/spec-to-tasks/`
- `agents/skills/prompt-new/`
- `agents/skills/prompt-iterate/`
- `agents/skills/loop-new/`
- `agents/skills/loop-close/`
- `agents/skills/eval-new/`
- `agents/skills/eval-record/`

## Key commands

- Add entries: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact: `./scripts/memory_compact.sh`
- Current state: `memory/current.md`
