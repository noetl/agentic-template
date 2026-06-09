---
name: issue-open
description: Open a tracked issue for long-running or cross-session work.
argument-hint: "\"<title>\" <repo>"
allowed-tools:
  - Bash
  - Read
  - Write
---

# Open Tracked Issue

1. Validate title and target repository label.
2. Check for duplicate open issues.
3. Draft body with `Context`, `Goal`, `Pointers`, `Blocked on`, `Links`.
4. Add optional external references:
  - Jira ticket key/URL
  - GitHub Wiki page URL
  - Confluence page URL
5. Create issue via `gh issue create`.
6. Return created URL.