# Copilot Instructions

This is the ai-meta coordination repository for the **{{PROJECT_NAME}}** ecosystem.

## Mandatory rules

Read and follow `AGENTS.md` at the repository root. Key constraints:

- This repo is public — never store secrets, tokens, or credentials.
- Do not commit product code — only instructions, memory, playbooks, sync notes, and submodule pointers.
- Never rewrite history on `main`.

## Detailed rules

Read the modular rule files in `agents/rules/` for detailed guidance on:

- Safety (`safety.md`)
- Allowed content (`allowed-content.md`)
- Commit conventions (`commit-conventions.md`)
- Memory workflow (`memory-workflow.md`)
- Submodule handling (`submodules.md`)
- Handoffs (`handoffs.md`)
- Issue tracking (`issue-tracking.md`)
- External memory systems (`external-memory-systems.md`)
- Writing style (`writing-style.md`)

## Behavioral profile

Read `agents/profiles/claude.md` or `agents/profiles/codex.md` for the appropriate agent profile.

## Memory workflow

- Add entries: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact: `./scripts/memory_compact.sh`
- Current state: `memory/current.md`
- Keep linked GitHub/Jira issue state current for active tasks
- Keep linked GitHub Wiki/Confluence pages current for changed public surfaces

## Commit conventions

- `memory(add): <topic>`
- `memory(compact): <scope>`
- `memory(curate): <scope>`
- `chore(sync): bump <repo> to <short-sha>`
- `docs(agents): <description>`
- `handoff(open): <slug>`
- `handoff(result): <slug> round NN`
- `handoff(close): <slug>`
