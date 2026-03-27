#!/usr/bin/env bash
# founder-pitch-deck skill bundle installer
# Installs founder-pitch-deck + all recommended dependencies (gstack, impeccable skills)
# Usage: bash setup.sh

set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
AGENTS_DIR="${HOME}/.agents/skills"

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; }

echo ""
echo "founder-pitch-deck skill bundle installer"
echo "================================="
echo ""

MISSING=0

# ── 1. Check founder-pitch-deck skill itself ──
if [ -f "${SKILLS_DIR}/founder-pitch-deck/SKILL.md" ]; then
  ok "founder-pitch-deck skill installed"
else
  fail "founder-pitch-deck skill not found"
  echo "  Install: git clone <repo> ${SKILLS_DIR}/founder-pitch-deck"
  MISSING=$((MISSING + 1))
fi

# ── 2. Check Gstack (browse + office-hours) ──
echo ""
echo "Gstack skills (browse, office-hours):"

if [ -d "${SKILLS_DIR}/gstack" ]; then
  ok "gstack installed at ${SKILLS_DIR}/gstack"

  # Check browse
  if [ -L "${SKILLS_DIR}/browse" ] || [ -f "${SKILLS_DIR}/browse/SKILL.md" ]; then
    ok "  browse skill linked"
  else
    warn "  browse skill not linked — creating symlink"
    ln -sf gstack/browse "${SKILLS_DIR}/browse"
    ok "  browse skill linked"
  fi

  # Check office-hours
  if [ -L "${SKILLS_DIR}/office-hours" ] || [ -f "${SKILLS_DIR}/office-hours/SKILL.md" ]; then
    ok "  office-hours skill linked"
  else
    warn "  office-hours skill not linked — creating symlink"
    ln -sf gstack/office-hours "${SKILLS_DIR}/office-hours"
    ok "  office-hours skill linked"
  fi
else
  fail "gstack not installed"
  echo "  Install gstack first, then re-run this script."
  echo "  See: https://gstack.dev"
  MISSING=$((MISSING + 1))
fi

# ── 3. Check Impeccable skills (animate, delight, frontend-design) ──
echo ""
echo "Impeccable skills (animate, delight, frontend-design):"

IMPECCABLE_SKILLS=("animate" "delight" "frontend-design")

for skill in "${IMPECCABLE_SKILLS[@]}"; do
  if [ -f "${SKILLS_DIR}/${skill}/SKILL.md" ] || [ -L "${SKILLS_DIR}/${skill}" ]; then
    ok "  ${skill} installed"
  elif [ -f "${AGENTS_DIR}/${skill}/SKILL.md" ]; then
    # Found in .agents/skills/ but not symlinked — create symlink
    warn "  ${skill} found in ${AGENTS_DIR}/${skill} but not linked"
    ln -sf "../../.agents/skills/${skill}" "${SKILLS_DIR}/${skill}"
    ok "  ${skill} linked"
  else
    fail "  ${skill} not found"
    MISSING=$((MISSING + 1))
  fi
done

# ── 4. Check optional skills (pptx, pdf) ──
echo ""
echo "Optional skills (pptx, pdf):"

for skill in pptx pdf; do
  if [ -f "${SKILLS_DIR}/${skill}/SKILL.md" ] || [ -L "${SKILLS_DIR}/${skill}" ]; then
    ok "  ${skill} installed"
  else
    warn "  ${skill} not installed (optional — fallback will be used)"
  fi
done

# ── Summary ──
echo ""
echo "================================="
if [ $MISSING -eq 0 ]; then
  ok "All dependencies satisfied! Run /founder-pitch-deck in Claude Code to get started."
else
  warn "${MISSING} missing dependency(ies). Install them and re-run this script."
  echo ""
  echo "The founder-pitch-deck skill will still work with graceful fallbacks for missing skills."
fi
echo ""
