#!/usr/bin/env bash
# founder-competitive-analysis skill dependency checker
# Usage: bash setup.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; }

echo ""
echo "founder-competitive-analysis dependency checker"
echo "================================================"
echo ""

MISSING=0

# ── 1. Check skill itself ──
SKILLS_DIR="${HOME}/.claude/skills"
if [ -f "${SKILLS_DIR}/founder-competitive-analysis/SKILL.md" ] || \
   [ -f "${SKILLS_DIR}/f-founder/founder-competitive-analysis/SKILL.md" ]; then
  ok "founder-competitive-analysis skill installed"
else
  fail "founder-competitive-analysis skill not found"
  MISSING=$((MISSING + 1))
fi

# ── 2. Check core tool availability ──
echo ""
echo "Core tools (WebSearch, WebFetch, Agent):"
ok "  WebSearch — built-in Claude Code tool"
ok "  WebFetch — built-in Claude Code tool"
ok "  Agent — built-in Claude Code tool"

# ── 3. Check optional skills ──
echo ""
echo "Optional skills:"

# pdf skill (for PRD parsing + PDF generation)
if [ -f "${SKILLS_DIR}/pdf/SKILL.md" ] || [ -L "${SKILLS_DIR}/pdf" ]; then
  ok "  pdf skill installed (PRD parsing + PDF generation)"
else
  warn "  pdf skill not installed (optional — manual input + HTML-only fallback)"
fi

# browse skill (for JS-heavy page scraping)
if [ -f "${SKILLS_DIR}/browse/SKILL.md" ] || [ -L "${SKILLS_DIR}/browse" ]; then
  ok "  browse skill installed (enhanced page scraping)"
else
  warn "  browse skill not installed (optional — WebFetch fallback)"
fi

# ── 4. Check for pitch-deck design tokens ──
echo ""
echo "Pitch deck integration:"
if ls */index.html pitch-deck/index.html 2>/dev/null | head -1 | grep -q '.'; then
  ok "  Pitch deck output found — PDF will use matching brand style"
else
  warn "  No pitch deck output found — PDF will use default style"
fi

# ── Summary ──
echo ""
echo "================================================"
if [ $MISSING -eq 0 ]; then
  ok "Ready! Run /founder-competitive-analysis in Claude Code to get started."
else
  warn "${MISSING} issue(s) found. The skill will still work with fallbacks."
fi
echo ""
