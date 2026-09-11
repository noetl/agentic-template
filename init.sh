#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────
# ai-agent-template init script
#
# Replaces template placeholders in all text files, creates
# symlinks, initializes git, and prepares the repo for use.
# Self-deletes when done.
# ──────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         ai-agent-template — Project Setup               ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Collect inputs ────────────────────────────────────────────

read -rp "Project name (human-readable, e.g. 'Acme Platform'): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project name is required."
  exit 1
fi

# Generate default slug from project name
default_slug="$(printf '%s' "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
read -rp "Project slug (lowercase, e.g. '${default_slug}'): [${default_slug}] " PROJECT_SLUG
PROJECT_SLUG="${PROJECT_SLUG:-$default_slug}"

read -rp "GitHub organization or owner (e.g. 'acme-corp'): " ORG_NAME
if [ -z "$ORG_NAME" ]; then
  echo "Error: organization name is required."
  exit 1
fi

read -rp "Git remote prefix (e.g. 'git@github.com:${ORG_NAME}'): [git@github.com:${ORG_NAME}] " REPO_PREFIX
REPO_PREFIX="${REPO_PREFIX:-git@github.com:${ORG_NAME}}"

echo ""
echo "── Configuration ──────────────────────────────────────────"
echo "  Project name:  ${PROJECT_NAME}"
echo "  Project slug:  ${PROJECT_SLUG}"
echo "  Organization:  ${ORG_NAME}"
echo "  Remote prefix: ${REPO_PREFIX}"
echo "──────────────────────────────────────────────────────────"
echo ""

read -rp "Proceed? [Y/n] " confirm
if [[ "${confirm:-Y}" =~ ^[Nn] ]]; then
  echo "Aborted."
  exit 0
fi

# ── Replace placeholders ─────────────────────────────────────

echo ""
echo "→ Replacing template placeholders..."

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[\\&|]/\\&/g'
}

PROJECT_NAME_REPL="$(escape_sed_replacement "$PROJECT_NAME")"
PROJECT_SLUG_REPL="$(escape_sed_replacement "$PROJECT_SLUG")"
ORG_NAME_REPL="$(escape_sed_replacement "$ORG_NAME")"
REPO_PREFIX_REPL="$(escape_sed_replacement "$REPO_PREFIX")"

# Find all text files (skip .git, binary files, and this script)
find . -type f \
  -not -path './.git/*' \
  -not -path './init.sh' \
  -not -name '*.gitkeep' \
  | while IFS= read -r file; do
    if file "$file" | grep -q 'text'; then
      tmp_file="$(mktemp)"
      sed \
        -e "s|{{PROJECT_NAME}}|${PROJECT_NAME_REPL}|g" \
        -e "s|{{PROJECT_SLUG}}|${PROJECT_SLUG_REPL}|g" \
        -e "s|{{ORG_NAME}}|${ORG_NAME_REPL}|g" \
        -e "s|{{REPO_PREFIX}}|${REPO_PREFIX_REPL}|g" \
        "$file" > "$tmp_file"
      cp "$tmp_file" "$file"
      rm -f "$tmp_file"
    fi
  done

echo "  ✓ Placeholders replaced"
echo "  ✓ Includes README, AGENTS.md, CLAUDE.md, GEMINI.md, and other text files"

# ── Create symlinks ──────────────────────────────────────────

echo "→ Creating .claude/ symlinks..."

# Remove placeholder directories if they exist (from git clone)
rm -rf .claude/rules .claude/skills 2>/dev/null || true

cd .claude
ln -sf ../agents/rules rules
ln -sf ../agents/skills skills
cd ..

echo "  ✓ .claude/rules -> ../agents/rules"
echo "  ✓ .claude/skills -> ../agents/skills"

# ── Make scripts executable ──────────────────────────────────

echo "→ Making scripts executable..."
chmod +x scripts/memory_add.sh scripts/memory_compact.sh
echo "  ✓ scripts/memory_add.sh"
echo "  ✓ scripts/memory_compact.sh"

# ── Initialize git ───────────────────────────────────────────

if [ ! -d .git ]; then
  echo "→ Initializing git repository..."
  git init -b main
  echo "  ✓ Git initialized (branch: main)"
else
  echo "→ Git already initialized, skipping."
fi

# ── Remove this script ───────────────────────────────────────

echo "→ Removing init.sh (no longer needed)..."
rm -f init.sh
echo "  ✓ init.sh removed"

# ── Initial commit ───────────────────────────────────────────

echo "→ Creating initial commit..."
git add -A
git commit -m "docs(agents): initialize ${PROJECT_NAME} project from ai-agent-template"
echo "  ✓ Initial commit created"

# ── Optional remote setup ────────────────────────────────────

echo ""
read -rp "Set up a git remote? [Y/n] " setup_remote
if [[ ! "${setup_remote:-Y}" =~ ^[Nn] ]]; then
  default_remote="${REPO_PREFIX}/${PROJECT_SLUG}-meta.git"
  read -rp "Remote URL: [${default_remote}] " remote_url
  remote_url="${remote_url:-$default_remote}"
  git remote add origin "$remote_url"
  echo "  ✓ Remote 'origin' set to: ${remote_url}"
  echo ""
  echo "  To push: git push -u origin main"
fi

# ── Visibility reminder ──────────────────────────────────────
# This template repo is public; a project instance created from it should
# default to private (see agents/rules/safety.md). If the gh CLI is
# available and a remote is set, check and warn rather than assume.
if command -v gh >/dev/null 2>&1 && git remote get-url origin >/dev/null 2>&1; then
  origin_slug="$(git remote get-url origin | sed -E 's#^.*[:/]([^/]+/[^/]+)(\.git)?$#\1#; s#\.git$##')"
  visibility="$(gh repo view "$origin_slug" --json visibility --jq .visibility 2>/dev/null || true)"
  if [ "$visibility" = "PUBLIC" ]; then
    echo ""
    echo "  ⚠ ${origin_slug} is PUBLIC. Project repos created from this template"
    echo "    should default to private — confirm this is intentional, or fix it:"
    echo "      gh repo edit ${origin_slug} --visibility private"
  fi
fi

# ── Done ─────────────────────────────────────────────────────

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                    Setup complete!                       ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add linked repositories or project dependencies as needed:"
echo "     git submodule add ${REPO_PREFIX}/<repo>.git repos/<repo>"
echo ""
echo "  2. Create your first memory entry:"
echo "     ./scripts/memory_add.sh \"Project initialized\" \"Set up project workspace\" \"setup\""
echo ""
echo "  3. Open in your AI coding agent:"
echo "     - Claude Code: auto-loads CLAUDE.md, rules, skills, and settings"
echo "     - Copilot: auto-loads .github/copilot-instructions.md"
echo "     - Cursor: auto-loads .cursorrules"
echo "     - Gemini: use GEMINI.md as the entrypoint"
echo ""
echo "  4. Register durable task state in GitHub Issues and/or Jira for anything that may span sessions."
echo ""
echo "  5. Add GitHub Wiki and/or Confluence pages for stable reference material and runbooks."
echo ""
echo "  6. Read the playbooks in playbooks/ for operational guides."
echo ""
echo "  7. Use handoffs/ for long-running cross-agent collaboration."
echo ""
