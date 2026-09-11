# Allowed Content

Only the following may be committed to this repo:

- AI instruction files (CLAUDE.md, AGENTS.md, .claude/rules/, .claude/agents/, .claude/skills/)
- Orchestration docs and checklists (playbooks/, sync/)
- Pointer updates, repository-link updates, or source changes when this repo intentionally owns that source
- AI memory entries and compactions (memory/)
- Cross-agent handoff threads and templates (handoffs/)
- Specs and spec templates (specs/) — problem statements, acceptance
  criteria, and plans, not implementation code
- Versioned prompts and prompt templates (prompts/) — prompt text, eval
  notes, and changelogs, never secrets or credentials
- Loop definitions and templates (loops/) — goals, stop conditions,
  iteration checkpoints, and outcomes
- Regression scenarios and templates (evals/) — protected behaviors and
  their append-only run logs, not automated test code

Project-specific implementation memory belongs in the owning source tree when
this repository is only coordinating the work. Record only shared decisions,
pointer state, deployment state, and cross-repo coordination here.
