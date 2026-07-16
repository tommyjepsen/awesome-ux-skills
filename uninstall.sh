#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Uninstalling UX skills from ${SKILLS_DIR}..."

removed=0
skipped=0

for file in "${REPO_DIR}"/*.md; do
  name="$(basename "$file" .md)"

  # README is documentation, not a skill.
  if [[ "$name" == "README" ]]; then
    continue
  fi

  dest="${SKILLS_DIR}/${name}"

  if [[ ! -d "$dest" ]]; then
    echo "  skip  ${name} (not installed)"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ "${1:-}" == "--purge" ]]; then
    # Remove the whole skill directory, including any extra files.
    rm -rf "$dest"
    echo "  ✓     ${name} (purged)"
    removed=$((removed + 1))
    continue
  fi

  # Default: remove only the SKILL.md we installed, then drop the
  # directory if nothing else is left. Preserves anything you added.
  rm -f "${dest}/SKILL.md"
  if rmdir "$dest" 2>/dev/null; then
    echo "  ✓     ${name}"
  else
    echo "  ✓     ${name} (kept dir, contains other files)"
  fi
  removed=$((removed + 1))
done

echo ""
echo "Done. ${removed} removed, ${skipped} skipped."
echo "Restart Claude Code (or reload the window) to drop removed skills."
