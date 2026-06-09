# How to Use This Meta-Repo Day-to-Day

This is the operational runbook for using this repo as the coordination layer across your ecosystem.

## 1) Start of day

From the repo root:

```bash
git pull --ff-only
git submodule sync --recursive
git submodule update --init --recursive
git submodule foreach --recursive 'git fetch --all --tags'
```

Then check baseline state:

```bash
git status
git submodule status --recursive
```

Expected: clean meta-repo and pinned submodule SHAs.

Then sync external memory view:

- Review open GitHub issues and/or Jira tickets for active work.
- Open linked GitHub Wiki and/or Confluence pages for touched surfaces.

## 2) Pick work and create a trace

Before code changes, create a memory entry:

```bash
./scripts/memory_add.sh "Start <topic>" "<what will be changed>" "<tags>"
```

If the work maps to an upstream issue, add/update a note under `sync/issues/`:

- `sync/issues/YYYY-MM-DD-<repo>-issue-<id>-<topic>.md`

Capture:

- issue link
- target repos
- planned branch names
- rollout/validation plan
- external tracker links (GitHub issue URL and/or Jira key)
- docs memory links (GitHub Wiki page and/or Confluence page)

## 3) Implement changes in submodules

Use only paths under `repos/` (not sibling folders outside this repo).

Typical flow per repo:

```bash
cd repos/<repo>
git checkout -b <branch>
# implement + test
git add .
git commit -m "<message>"
git push -u origin <branch>
```

Open and merge PRs in target repos.

## 4) Record merged state

After merges, update pointers from the repo root:

```bash
git submodule update --remote --merge repos/<repo1> repos/<repo2>
git add repos/<repo1> repos/<repo2>
git commit -m "chore(sync): bump <repo1>, <repo2> to merged SHAs"
git push
```

Then append a short sync note in `sync/` or `sync/issues/` with:

- merged PR links
- final submodule SHAs
- follow-up actions
- tracker status updates (GitHub/Jira)
- docs update links (Wiki/Confluence)

## 5) End of day

Capture outcome:

```bash
./scripts/memory_add.sh "End <topic>" "<result + blockers + next step>" "<tags>"
git add memory
git commit -m "memory(add): <topic> end-of-day"
git push
```

If inbox entries accumulate, compact memory:

```bash
./scripts/memory_compact.sh
git add memory
git commit -m "memory(compact): <scope>"
git push
```

## 6) Rules to enforce every day

- Do not commit secrets, tokens, or private credentials.
- Do not commit product source code directly to this meta-repo.
- Commit only instructions, playbooks, sync notes, memory, and submodule SHA bumps.
- Keep changes atomic: one coordination concern per commit when possible.
- Keep local memory, issues/tickets, and docs pages synchronized for substantive changes.