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
  "市场调研", "/founder-competitive-analysis",
  "requirements clarification", "I want to build", "I have an idea", "需求澄清",
  "我想做一个", "我有个想法", "/founder-requirements-clarification",
  "用户调研", "用户访谈", "需求验证", "synthetic research", "合成用户",
  "/founder-synthetic-research".
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
| `/founder-requirements-clarification` | requirements clarification, I want to build, I have an idea, 需求澄清, 我想做一个, 我有个想法 | From vague idea to focused MVP direction through dialogue + real community data |
| `/founder-synthetic-research` | 用户调研, 用户访谈, 需求验证, synthetic research, 合成用户 | AI synthetic user research — Reddit-based personas, Mom Test interviews, structured report |

When the user's request matches a skill above, invoke it via the Skill tool.
If the request is ambiguous, briefly list the relevant skills and ask which one to use.

---

## Recommended Workflow

Founder 旅程的推荐顺序（不强制，任何 skill 都可以独立使用）：

```
想法阶段
  └─ /founder-requirements-clarification ─── 从模糊想法到聚焦的 MVP 方向
       ↓
验证阶段
  ├─ /founder-synthetic-research ─────────── 合成用户访谈验证假设（可选）
  └─ /founder-competitive-analysis ──────── 深度竞品分析了解格局
       ↓
融资阶段
  └─ /founder-pitch-deck ─────────────────── 生成投资人 pitch deck
```

**衔接机制**：每个 skill 完成后会推荐下一步可以使用的 skill。如果 founder 已经在某个 skill 中完成了问题定义，后续 skill 会自动检测并复用，不重复提问。

---

## Shared Principles

以下原则适用于所有 f-founder skill：

### 反讨好

所有 skill 在与 founder 交互时必须诚实直接。禁止：
- 给模糊的结论加乐观包装
- 用"有潜力"、"值得探索"等回避判断的措辞
- 隐瞒不利数据或淡化竞争威胁
- 编造或夸大数据来支撑 founder 的想法

必须：
- 数据不够就说"数据不足，无法判断"
- 竞争激烈就说"这个市场已经很拥挤"
- 想法有问题就指出问题

### 中间材料保留

所有 skill 的最终输出必须包含中间材料作为附录，确保过程可追溯：
- 搜索查询和原始结果
- 结构化的中间分析
- 决策点和 founder 的确认记录
- 数据来源完整链接

### 启动检查

所有 skill 启动时必须运行版本检查（见 Preamble），确保使用最新版本。

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
