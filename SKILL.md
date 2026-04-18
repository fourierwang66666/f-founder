---
name: f-founder
description: |
  AI-powered skills for startup founders. Provides specialized Claude Code skills
  for pitch decks, financial models, investor outreach, and other founder workflows.
  Use this skill when the user needs help with any founder/startup task — pitch deck
  creation, fundraising materials, investor presentations, startup strategy, demo day
  prep, or any task where a founder-specific workflow exists.
  Triggers: "pitch deck", "investor deck", "fundraising", "demo day", "series A/B/seed",
  "BP", "融资", "路演", "/founder-pitch-deck", "/f-founder",
  "competitive analysis", "competitor research", "竞品分析", "竞争对手",
  "市场调研", "/founder-competitive-analysis".
user-invokable: true
---

# f-founder: AI Skills for Startup Founders

A collection of specialized Claude Code skills that help founders move faster on
high-stakes tasks — from pitch decks to financial models to investor communications.

## Preamble (run first)

```bash
_FF_DIR="${FFOUNDER_DIR:-$(find ~/.claude/skills -maxdepth 1 -name 'f-founder' -type d 2>/dev/null | head -1)}"
[ -z "$_FF_DIR" ] && _FF_DIR="$(find .claude/skills -maxdepth 1 -name 'f-founder' -type d 2>/dev/null | head -1)"
if [ -n "$_FF_DIR" ] && [ -f "$_FF_DIR/bin/f-founder-update-check" ]; then
  _UPD=$("$_FF_DIR/bin/f-founder-update-check" 2>/dev/null || true)
  [ -n "$_UPD" ] && echo "$_UPD" || true
fi
_FF_VER=$(cat "$_FF_DIR/VERSION" 2>/dev/null | tr -d '[:space:]' || echo "unknown")
echo "F-FOUNDER: v$_FF_VER"
```

If output shows `UPGRADE_AVAILABLE <old> <new>`: tell the user
"f-founder v{new} is available (you have v{old}). Run `cd ~/.claude/skills/f-founder && git pull` to upgrade."
If `JUST_UPGRADED <from> <to>`: tell the user "f-founder updated to v{to}!" and continue.

---

## Available Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| `/founder-pitch-deck` | pitch deck, investor deck, BP, 融资材料, demo day slides | Generate a single-file HTML pitch deck with brand extraction, bilingual ZH/EN, auth gate, PDF export |
| `/founder-competitive-analysis` | competitive analysis, competitor research, 竞品分析, 竞争对手, 市场调研 | Deep competitive analysis with parallel research, structured Markdown + PDF report |

When the user's request matches a skill above, invoke it via the Skill tool.
If the request is ambiguous, briefly list the relevant skills and ask which one to use.

---

## Upgrade

```bash
cd ~/.claude/skills/f-founder && git pull
```

Or reinstall:

```bash
rm -rf ~/.claude/skills/f-founder
git clone https://github.com/fourierwang66666/f-founder.git ~/.claude/skills/f-founder
```
