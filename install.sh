#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing UX skills to ${SKILLS_DIR}..."

installed=0
skipped=0

for file in "${REPO_DIR}"/*.md; do
  name="$(basename "$file" .md)"

  # README is documentation, not a skill.
  if [[ "$name" == "README" ]]; then
    continue
  fi

  dest="${SKILLS_DIR}/${name}"

  if [[ -d "$dest" && "${1:-}" != "--force" ]]; then
    echo "  skip  ${name} (already exists, use --force to overwrite)"
    skipped=$((skipped + 1))
    continue
  fi

  mkdir -p "$dest"
  cp "$file" "${dest}/SKILL.md"
  echo "  ✓     ${name}"
  installed=$((installed + 1))
done

echo ""
echo "Done. ${installed} installed, ${skipped} skipped."
echo "Restart Claude Code (or reload the window) to pick up new skills."
