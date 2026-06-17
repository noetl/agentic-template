---
paths:
  - "repos/**"
  - "**/Cargo.toml"
  - "**/Cargo.lock"
  - "**/*.rs"
  - ".vscode/**"
---

# Rust Analyzer

When this repository coordinates one or more Rust workspaces, keep
rust-analyzer configured so a single editor window can navigate the linked
projects.

## The rule

1. Use the rust-analyzer extension for Rust code navigation, diagnostics, and
   refactors.
2. Prefer workspace-level `rust-analyzer.linkedProjects` entries over opening
   each linked repository in a separate editor window.
3. Keep `linkedProjects` current when Rust repositories are added, removed, or
   renamed.
4. Commit `.vscode/settings.json` and `.vscode/extensions.json` updates in the
   same change set as the repository-link change that requires them.

## Recommended workspace settings

- `rust-analyzer.linkedProjects` lists one `Cargo.toml` per Rust workspace.
- `rust-analyzer.check.command = "clippy"` when project CI uses clippy.
- `rust-analyzer.check.allTargets = true` to include tests/examples.
- Exclude `target/**` from file watchers to avoid editor churn.

## When this rule applies

- Editing Rust code in linked repositories.
- Adding or removing a Rust-linked repository.
- Changing project-level Rust tooling expectations.

Documentation-only changes and non-Rust repositories do not trigger this rule.
