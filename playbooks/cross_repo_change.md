# Cross-Repo Change Playbook

Canonical checklist for changes spanning multiple submodules.

## Inputs

- Feature/bug description
- Impacted repositories
- Required release channels
- Linked issue/ticket IDs (GitHub and/or Jira)
- Linked docs memory targets (GitHub Wiki and/or Confluence)

## Steps

1. Confirm impacted submodules.
2. Create branches in impacted repos.
3. Implement + validate per repo.
4. Open PRs and merge.
5. Update issue/ticket status and docs memory links.
6. Update submodule pointers in this meta-repo.
7. Add a short sync note in `sync/`.

## Output

- List of merged PRs
- Final submodule SHAs
- Linked issue/ticket updates
- Linked wiki/confluence updates
- Any follow-up release actions
