# {{PROJECT_NAME}} AI Meta

Coordination repository and shared memory layer for the **{{PROJECT_NAME}}** ecosystem.

This repo tracks participating repositories as git submodules, keeps durable AI memory in Git, and provides shared rules, skills, and profiles for multiple coding agents.

It also includes a file-based cross-agent handoff protocol so long-running work can move between Claude, Copilot/Codex, Cursor, Gemini, and future tools without losing context.

## Bootstrap a New Agentic-Memory Repo

Use this template, then run the included initializer once to replace all placeholders and set up symlinks.

```bash
# 1) Clone your new meta repository created from this template
git clone {{REPO_PREFIX}}/{{PROJECT_SLUG}}-meta.git
cd {{PROJECT_SLUG}}-meta

# 2) Run initializer (interactive)
bash ./init.sh
```

What `init.sh` does:

- Replaces `{{PROJECT_NAME}}`, `{{PROJECT_SLUG}}`, `{{ORG_NAME}}`, and `{{REPO_PREFIX}}` across text files.
- Creates `.claude/rules` and `.claude/skills` symlinks to `agents/`.
- Marks memory scripts executable.
- Initializes git (if needed), creates an initial commit, and optionally sets `origin`.
- Removes `init.sh` after successful setup.

After initialization, use standard update flow:

```bash
git submodule sync --recursive
git submodule update --init --recursive
```

## What This Repo Contains

- **`repos/`** — all ecosystem repos as git submodules (pinned SHAs)
- **`memory/`** — Git-tracked long memory (inbox → compaction → current state)
- **`sync/`** — cross-repo "what changed" notes (PR links, SHAs, follow-ups)
- **`agents/`** — shared AI agent rules, skills, and profiles
- **`playbooks/`** — repeatable checklists for common tasks
- **`handoffs/`** — durable cross-agent prompt/result threads
- **`scripts/`** — automation helpers (memory_add.sh, memory_compact.sh)

## Memory Layers

This template uses layered memory, where Git remains durable source of truth for agent operations:

1. **Local repository memory (required)**
	- `memory/current.md`, `memory/inbox/`, `memory/compactions/`, `memory/timeline.md`
2. **Work-item memory (recommended)**
	- GitHub Issues and optionally Jira for durable task state, blockers, and acceptance criteria
3. **Knowledge memory (recommended)**
	- GitHub Wiki and/or Confluence for durable architecture, runbooks, and policy pages
4. **Coordination memory (recommended)**
	- `sync/issues/` notes that link submodule PRs, SHAs, and external ticket/wiki IDs

See `agents/rules/external-memory-systems.md` for strict operating rules.

## Repository Layout

```
├── AGENTS.md                          # Global rules for all agents
├── CLAUDE.md                          # Claude Code entry point (auto-loaded)
├── .github/copilot-instructions.md    # GitHub Copilot entry point
├── .cursorrules                       # Cursor entry point
├── agents/                            # Shared agent infrastructure
│   ├── rules/                         #   Modular rule files
│   ├── skills/                        #   Workflow definitions
│   └── profiles/                      #   Per-agent behavioral profiles
├── .claude/                           # Claude Code integration
│   ├── settings.json                  #   Permissions and hooks
│   ├── rules -> ../agents/rules       #   Symlink to shared rules
│   └── skills -> ../agents/skills     #   Symlink to shared skills
├── handoffs/                          # Cross-agent file handoff channel
│   ├── active/                        #   In-flight threads
│   ├── archive/                       #   Closed threads
│   └── templates/                     #   prompt/result templates
├── memory/                            # Long memory store
│   ├── current.md                     #   Active working state
│   ├── timeline.md                    #   Chronological index
│   ├── inbox/                         #   Raw entries
│   ├── compactions/                   #   Periodic summaries
│   └── archive/                       #   Processed entries
├── sync/                              # Cross-repo change notes
├── playbooks/                         # Operational checklists
├── scripts/                           # Memory and automation helpers
└── repos/                             # Git submodules
```

## Day-to-Day Workflow

1. **Work in submodules** — code changes happen inside `repos/<name>`
2. **Open PRs upstream** — each submodule has its own remote
3. **Bump pointers** — update submodule SHAs after merges
4. **Write sync notes** — capture what changed across repos
5. **Add memory entries** — record decisions and outcomes
6. **Compact periodically** — keep active memory small
7. **Keep external memory in sync** — update linked issues/tickets/wiki pages when state changes

## Cross-Agent Handoff Workflow

1. Open a thread in `handoffs/active/<YYYY-MM-DD-slug>/`
2. Dispatcher writes `round-NN-prompt.md`
3. Executor writes `round-NN-result.md`
4. Continue with additional rounds as needed
5. Move completed thread to `handoffs/archive/`

See `handoffs/README.md` and `agents/rules/handoffs.md`.

## Memory Commands

```bash
# Add a memory entry
./scripts/memory_add.sh "title" "summary" "tags"

# Compact inbox entries
./scripts/memory_compact.sh
```

## Commit Conventions

- `memory(add): <topic>` — new memory entry
- `memory(compact): <scope>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <sha>` — submodule pointer update
- `docs(agents): <description>` — agent infrastructure changes

## Extended Memory Storage (Jira, GitHub, Confluence)

This template supports using external systems as memory extensions:

- **GitHub Issues**: durable task lifecycle, acceptance criteria, blocker tracking
- **Jira**: program-level planning, sprint ownership, status and dependencies
- **GitHub Wiki**: engineering reference tied closely to repository surfaces
- **Confluence**: higher-level architecture and operational documentation

Recommended linking pattern for every substantive cross-repo task:

- One issue/ticket ID (`GH-123` or `PROJ-123`)
- One or more submodule PR links
- One memory entry in `memory/inbox/`
- One sync note in `sync/issues/`
- Zero or more wiki/confluence pages

## Adding Submodules

```bash
git submodule add {{REPO_PREFIX}}/<repo-name>.git repos/<repo-name>
git commit -m "chore(sync): add <repo-name> submodule"
```

## AI Agent Support

This repo supports multiple AI coding agents out of the box:

| Agent | Entry Point | Auto-loads |
|---|---|---|
| Claude Code | `CLAUDE.md` | Rules, skills, settings, hooks |
| GitHub Copilot | `.github/copilot-instructions.md` | Instructions |
| Cursor | `.cursorrules` | Instructions |
| Gemini | `GEMINI.md` (optional) | Profile + rules |
| Any other | `AGENTS.md` | Read manually |

---

*Generated from [ai-agent-template](https://github.com/noetl/ai-agent-template)*
