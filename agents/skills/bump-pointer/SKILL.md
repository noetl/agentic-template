---
name: bump-pointer
description: Update a submodule pointer after upstream merge
argument-hint: "<repo-name>"
allowed-tools:
  - Bash
  - Read
---

# Bump Submodule Pointer

Update a submodule to its latest remote commit and commit the pointer change.

## Steps

1. Pull latest first:
   ```
   git pull --ff-only
   ```
2. Update the target submodule:
   ```
   git submodule update --remote repos/$ARGUMENTS
   ```
3. Check what changed:
   ```
   git diff repos/$ARGUMENTS
   ```
4. Compare old/new SHAs and list merged commits in range.
5. Confirm related tracking and docs memory are updated when public surface changed:
   - GitHub issue and/or Jira ticket status
   - GitHub Wiki and/or Confluence updates
   - local sync note linkage under `sync/issues/`
6. Stage and commit:
   ```
   git add repos/$ARGUMENTS
   git commit -m "chore(sync): bump $ARGUMENTS to <short-sha>"
   ```
7. Ask if they want to push.
