#!/bin/bash
# Design consistency review — blocks commit if staged code conflicts with DESIGN.md
set -euo pipefail

cd "$CLAUDE_PROJECT_DIR"

DESIGN="DESIGN.md"
[ ! -f "$DESIGN" ] && exit 0

STAGED=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null | grep '\.dart$' || true)
[ -z "$STAGED" ] && exit 0

ERRORS=0

# Extract brand colors from DESIGN.md YAML
PRIMARY=$(awk '/^colors:/{found=1} found && /^  primary:/{print; exit}' "$DESIGN" | grep -oE '#[0-9A-Fa-f]{6}')
SECONDARY=$(awk '/^colors:/{found=1} found && /^  secondary:/{print; exit}' "$DESIGN" | grep -oE '#[0-9A-Fa-f]{6}')
TERTIARY=$(awk '/^colors:/{found=1} found && /^  tertiary:/{print; exit}' "$DESIGN" | grep -oE '#[0-9A-Fa-f]{6}')

[ -z "$PRIMARY" ] && echo "WARNING: Could not parse primary from DESIGN.md" && exit 0

# Known old brand colors that should not appear in new code
OLD_COLORS="0xFF004D99|0xFF1B6D24|0xFFA00312|0xFFF9F9F9"

for file in $STAGED; do
  [ ! -f "$file" ] && continue
  # Skip the token source files themselves
  echo "$file" | grep -qE "app_colors\.dart|DESIGN\.md" && continue

  MATCHES=$(grep -nE "$OLD_COLORS" "$file" 2>/dev/null || true)
  if [ -n "$MATCHES" ]; then
    echo "ERROR: $file has old brand colors (use AppColors tokens):"
    echo "$MATCHES"
    ERRORS=$((ERRORS + 1))
  fi
done

# If app_colors.dart is staged, verify brand seeds match DESIGN.md
if echo "$STAGED" | grep -q "app_colors.dart"; then
  COLORS_FILE=$(echo "$STAGED" | grep "app_colors.dart")
  to_ff() { echo "$1" | sed 's/#/0xFF/' | tr '[:lower:]' '[:upper:]'; }

  for pair in "primary:$PRIMARY" "secondary:$SECONDARY" "tertiary:$TERTIARY"; do
    NAME="${pair%%:*}"
    HEX="${pair##*:}"
    FF=$(to_ff "$HEX")
    if ! grep -q "$FF" "$COLORS_FILE" 2>/dev/null; then
      echo "ERROR: app_colors.dart $NAME doesn't match DESIGN.md ($HEX → $FF)"
      ERRORS=$((ERRORS + 1))
    fi
  done
fi

if [ $ERRORS -gt 0 ]; then
  echo ""
  echo "Design review FAILED: $ERRORS issue(s). DESIGN.md is the source of truth."
  exit 2
fi

echo "Design review: passed"
exit 0
