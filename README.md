# {{PROJECT_NAME}} AI Project Template

Reusable starter repository for AI-assisted projects.

This template provides durable project memory in Git, shared agent instructions, and optional coordination patterns for multi-agent or multi-repo workflows.

It also includes a file-based handoff protocol for teams that want durable handoff threads between coding agents without losing context.

## Bootstrap a New Project Repo

Use this template, then run the included initializer once to replace all placeholders and set up the local workspace.

This template repo is public. **A project repo created from it should default to
private** unless there's a deliberate reason to make it public — set visibility at
creation time, either via GitHub's "Use this template" button (choose "Private") or:

```bash
gh repo create <org>/<slug>-meta --template noetl/agentic-template --private --clone
```

```bash
# 1) Or, if the repo already exists (created via "Use this template"), just clone it
git clone {{REPO_PREFIX}}/{{PROJECT_SLUG}}-meta.git
cd {{PROJECT_SLUG}}-meta

# 2) Run initializer (interactive)
bash ./init.sh
```

What `init.sh` does:

- Replaces the project-name, slug, organization, and remote-prefix placeholders across text files.
- Creates `.claude/rules` and `.claude/skills` symlinks to `agents/`.
- Marks memory scripts executable.
- Initializes git (if needed), creates an initial commit, and optionally sets `origin`.
- Removes `init.sh` after successful setup.

If your project uses linked repositories, initialize them after setup with the commands your workflow requires.

## What This Repo Contains

- **`repos/`** — optional linked repositories or subprojects
- **`memory/`** — Git-tracked long memory (inbox → compaction → current state)
- **`sync/`** — change notes that capture links, SHAs, and follow-ups
- **`agents/`** — shared AI agent rules, skills, and profiles
- **`playbooks/`** — repeatable checklists for common tasks
- **`handoffs/`** — durable cross-agent prompt/result threads
- **`specs/`** — spec-driven development: problem, acceptance criteria, and
  plan before code
- **`prompts/`** — a versioned library of reusable, testable prompts
- **`loops/`** — definitions for repeatable agent loops with explicit stop
  conditions and hard bounds
- **`evals/`** — regression scenarios protecting shared rule/skill/profile
  behavior
- **`scripts/`** — automation helpers (memory_add.sh, memory_compact.sh)

## Engineering Disciplines

Beyond memory and coordination, this template gives downstream projects
working disciplines for AI-assisted development:

- **Prompt engineering** — prompts are versioned artifacts in
  `prompts/library/`, not throwaway chat text. See
  `agents/rules/prompt-engineering.md`.
- **Loop engineering** — repeatable agent loops (retry, plan-execute-verify,
  self-correction, CI-fix) declare a goal, stop conditions, hard bounds, and
  an escalation path in `loops/active/` before they run. See
  `agents/rules/loop-engineering.md`.
- **Spec-driven development** — non-trivial changes get a spec in
  `specs/active/` with checkable acceptance criteria before implementation,
  and tracked issues are generated from the spec's plan. See
  `agents/rules/spec-driven-development.md`.
- **Context engineering** — memory, specs, prompts, loops, and handoffs all
  compete for the same context window; a defined load order and a
  pointers-over-reproduction default keep that budget sane. See
  `agents/rules/context-engineering.md`.
- **Agent regression testing** — changes to shared rules/skills/profiles get
  a scenario in `evals/scenarios/` with an append-only pass/fail run log,
  the same discipline a test suite gives code. See
  `agents/rules/agent-regression-testing.md`.
- **Tool and MCP governance** — new tools/MCP servers get a registry entry
  (scope, risk tier, owner) before any agent profile references them. See
  `agents/rules/tool-governance.md`.
- **Definition of Done (default, lightweight)** — small, same-session work
  gets a default completion checklist instead of full spec/issue overhead,
  with explicit escalation rules for when it outgrows that checklist. See
  `agents/rules/definition-of-done.md`.

## Memory Layers

This template uses layered memory, where Git remains the durable source of truth for agent operations:

1. **Local repository memory (required)**
	- `memory/current.md`, `memory/inbox/`, `memory/compactions/`, `memory/timeline.md`
2. **Work-item memory (recommended)**
	- GitHub Issues, Jira, or another tracker for durable task state, blockers, and acceptance criteria
3. **Knowledge memory (recommended)**
	- GitHub Wiki, Confluence, or another docs system for durable architecture, runbooks, and policy pages
4. **Coordination memory (recommended)**
	- `sync/` notes that link PRs, SHAs, and external tracker/docs IDs

See `agents/rules/external-memory-systems.md` for extension patterns.

## Agent Rule Families

The template includes shared rules for:

- execution-model boundaries and platform data access
- explicit credential/auth references
- observability, logging, and local validation
- linked-repository pointer hygiene
- issue/ticket, roadmap-board, and wiki synchronization
- file-based handoffs and agent-routing decisions
- writing style and public-repo safety

## Repository Layout

```
├── AGENTS.md                          # Global rules for all agents
├── CLAUDE.md                          # Claude Code entry point (auto-loaded)
├── .github/copilot-instructions.md    # GitHub Copilot entry point
├── .cursorrules                       # Cursor entry point
├── agents/                            # Shared agent infrastructure
│   ├── README.md                      #   Agent mapping and adapter explanation
│   ├── rules/                         #   Modular rule files
│   ├── skills/                        #   Workflow definitions
│   └── profiles/                      #   Per-agent behavioral profiles
├── .claude/                           # Claude Code integration
│   ├── settings.json                  #   Permissions and hooks
│   ├── rules -> ../agents/rules       #   Symlink to shared rules
│   └── skills -> ../agents/skills     #   Symlink to shared skills
├── handoffs/                          # Optional cross-agent file handoff channel
│   ├── active/                        #   In-flight threads
│   ├── archive/                       #   Closed threads
│   └── templates/                     #   prompt/result templates
├── memory/                            # Long memory store
│   ├── current.md                     #   Active working state
│   ├── timeline.md                    #   Chronological index
│   ├── inbox/                         #   Raw entries
│   ├── compactions/                   #   Periodic summaries
│   └── archive/                       #   Processed entries
├── specs/                             # Spec-driven development
│   ├── active/                        #   Specs being drafted or implemented
│   ├── archive/                       #   Shipped/closed specs
│   └── templates/                     #   spec.md scaffold
├── prompts/                           # Versioned prompt library
│   ├── library/                       #   One file per prompt
│   └── templates/                     #   prompt.md scaffold
├── loops/                             # Agent loop definitions
│   ├── active/                        #   Running/paused loops
│   ├── archive/                       #   Closed loops with recorded outcome
│   └── templates/                     #   loop.md scaffold
├── evals/                             # Agent regression scenarios
│   ├── scenarios/                     #   Protected behaviors + run logs
│   └── templates/                     #   scenario.md scaffold
├── sync/                              # Cross-repo change notes
├── playbooks/                         # Operational checklists
├── scripts/                           # Memory and automation helpers
└── repos/                             # Optional linked repositories
```

## Day-to-Day Workflow

1. **Spec non-trivial work first** — `/spec-new`, resolve Open Questions,
   then `/spec-to-tasks` to generate tracked issues
2. **Work in the project source** — keep product code out of the template repo unless you intentionally fork it into a working project
3. **Open PRs where your source lives** — whether that is this repo, a monorepo, or linked repositories
4. **Record coordination changes** — capture what changed across repos or project areas
5. **Add memory entries** — record decisions and outcomes
6. **Compact periodically** — keep active memory small
7. **Keep external memory in sync** — update linked issues/tickets/wiki pages when state changes
8. **Use loops for repeatable automation** — `/loop-new` with explicit stop
   conditions instead of ad hoc unbounded retries
9. **Version prompts, don't rewrite them silently** — `/prompt-new` /
   `/prompt-iterate` for anything reused across sessions
10. **Default to the lightweight checklist** in
    `agents/rules/definition-of-done.md` for small, same-session work;
    escalate to a spec or issue only when its own rules say to
11. **Protect shared agent behavior** — `/eval-new` before, `/eval-record`
    after, any change to a rule/skill/profile other agents depend on

## Cross-Agent Handoff Workflow

1. Open a thread in `handoffs/active/<YYYY-MM-DD-slug>/`
2. Dispatcher writes `round-NN-prompt.md`
3. Executor writes `round-NN-result.md`
4. Continue with additional rounds as needed
5. Move completed thread to `handoffs/archive/`

See `handoffs/README.md` and `agents/rules/handoffs.md` if you use handoffs.

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
- `chore(sync): bump <repo> to <sha>` — linked-repo pointer update
- `docs(agents): <description>` — agent infrastructure changes
- `spec(new): <slug>` / `spec(tasks): <slug>` — spec opened / converted to tasks
- `prompt(add): <name>` / `prompt(iterate): <name> vN` — prompt added / revised
- `loop(open): <slug>` / `loop(close): <slug>` — loop opened / closed
- `eval(new): <slug>` / `eval(record): <slug>` — scenario added / run recorded

## Extended Memory Storage (Jira, GitHub, Confluence)

This template supports using external systems as memory extensions when you need them:

- **GitHub Issues**: durable task lifecycle, acceptance criteria, blocker tracking
- **Jira**: program-level planning, sprint ownership, status and dependencies
- **GitHub Wiki**: engineering reference tied closely to repository surfaces
- **Confluence**: higher-level architecture and operational documentation

Recommended linking pattern for every substantive cross-repo task:

- One issue/ticket ID (`GH-123` or `PROJ-123`)
- One or more PR links
- One memory entry in `memory/inbox/`
- One sync note in `sync/issues/`
- Zero or more wiki/confluence pages

## Linking Repositories

```bash
git submodule add {{REPO_PREFIX}}/<repo-name>.git repos/<repo-name>
git commit -m "chore(sync): add <repo-name> submodule"
```

If you do not use linked repositories, replace this step with the repo-linking or dependency setup your project requires.

## AI Agent Support

This repo supports multiple AI coding agents out of the box:

| Agent | Entry Point | Auto-loads |
|---|---|---|
| Claude Code | `CLAUDE.md` | Rules, skills, settings, hooks |
| GitHub Copilot | `.github/copilot-instructions.md` | Instructions |
| Cursor | `.cursorrules` | Instructions |
| Gemini | `GEMINI.md` (optional) | Profile + rules |
| Any other | `AGENTS.md` | Read manually |

See `agents/README.md` for the current adapter/source-of-truth mapping.

---

*Generated from [ai-agent-template](https://github.com/noetl/ai-agent-template)*
