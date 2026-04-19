---
name: founder-synthetic-research
description: >-
  AI 合成用户调研。当用户需要进行用户需求调研、验证产品想法、了解目标用户痛点、
  或做合成用户访谈时使用。从 Reddit 真人画像构建合成用户，
  进行 Mom Test 式深度访谈，输出结构化调研报告。
  Use when: "用户调研", "用户访谈", "需求验证", "synthetic research",
  "合成用户", "虚拟用户", "/founder-synthetic-research".
metadata: {"openclaw":{"requires":{"bins":["node","python3","curl"]}}}
user-invokable: true
---

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

If output shows `UPGRADE_AVAILABLE`: tell user to upgrade before proceeding.

# Synthetic Research — AI 合成用户调研

## 这个 skill 做什么

帮助产品经理通过 AI 合成用户进行需求调研。合成用户基于 Reddit 真人画像构建，
在性别、年龄、城市、收入、MBTI、星座等维度随机分布，通过 Mom Test 方法论深度访谈。

## 触发条件

- 用户说"做用户调研"/"用户访谈"/"需求验证"/"synthetic research"
- 用户描述一个产品想法并想了解目标用户痛点
- 用户要求生成合成用户/虚拟用户

## 反讨好规则

合成用户调研的核心价值在于真实反馈，必须防止 AI 讨好 founder：

**合成用户层面：**
- 合成用户必须能说"不需要"、"不会用"、"太贵了"、"现有方案够用了"
- 不允许所有合成用户都表示支持——至少 30% 应该持保留或否定态度
- 合成用户的回答必须基于 Reddit 语料中的真实行为模式，不能为了让 founder 高兴而编造正面反馈

**分析报告层面：**
- 不美化调研结论（"用户普遍感兴趣" → 如实报告多少人正面、多少人负面、多少人无感）
- 不隐藏负面信号（如果多数合成用户表示不需要，这就是最重要的发现）
- 不把"没有反对"当成"支持"——沉默不是验证
- 方法论声明必须明确标注"这是 AI 合成调研，不能替代真实用户访谈"

## 四阶段流程

### Phase 1: 画像构建（自动 + 用户审批）

#### Step 1.1: 产品分析

分析用户输入的产品描述，输出：
1. 目标用户群关键词（英文，用于 Reddit 搜索）
2. 相关 subreddit 列表 — 先查 `config/subreddit-map.json`，再用 AI 补充
3. 5-8 个产品相关属性维度（例如：时区/团队规模/远程年限）
4. 建议合成用户数量 N（根据产品复杂度，通常 6-10）

→ **展示给用户确认**（可修改 subreddit 列表、属性维度、用户数量）

#### Step 1.2: Reddit 语料采集

对每个确认的 subreddit 执行：

```bash
bash scripts/reddit-profile.sh <subreddit> "<query>" --limit 15 --time month
```

收集帖子和评论，重点关注：吐槽、求助、经验分享、替代方案对比。
同时加载 `config/persona-pool.json` 作为补充语料。

#### Step 1.3: 合成用户生成

为 N 个用户分别执行：

1. **随机分配基础属性**（确保整体均衡分布）：
   - 性别：男/女 按约均衡比例
   - 年龄：18-55 岁分散分布
   - 城市：一线/二线/海外 混合
   - 收入：低/中/中高/高 分散
   - 教育：高中/本科/硕士/博士 分散
   - 职业：与产品领域相关但有差异

2. **随机分配心理属性**：
   - MBTI：从 16 型中随机抽取（不重复优先），参考 `config/mbti-profiles.json`
   - 星座：从 12 宫中随机抽取
   - 表达风格：基于 MBTI + Reddit 语料推断

3. **动态分配产品相关属性**：
   - 使用 Step 1.1 确定的维度
   - 在合理范围内随机赋值

4. **绑定 Reddit 语料**：
   - 从 Step 1.2 的语料中匹配最相关的帖子/评论
   - 提取 2-3 条原文引述

5. **生成人设卡**：
   - 读取 `references/persona-builder-prompt.md` 获取构建指南
   - 输出完整人设卡

→ **展示所有人设卡给用户审批**（可替换/调整某个用户）

### Phase 2: 批量自动访谈（全自动）

对每个合成用户执行深度访谈：

1. 读取 `references/interviewer-prompt.md` 获取访谈方法论
2. 读取 `config/interview-questions.json` 获取问题模板
3. 读取 `config/mbti-profiles.json` 获取该用户的 MBTI 行为模式
4. 将 `<PERSONA_CARD>` 替换为该用户的人设卡
5. 将 `<DOMAIN>` `<PAIN_AREA>` `<VALUE_PROP>` 等占位符替换为实际内容
6. 执行 8-12 轮对话
7. 生成访谈要点摘要

**关键**：每个访谈独立进行，合成用户之间不共享信息。

### Phase 3: 综合报告（自动）

1. 读取 `references/analyst-prompt.md` 获取分析框架
2. 将所有人设卡 + 访谈记录 + 要点摘要作为输入
3. 生成结构化报告（格式见 analyst-prompt.md）
4. 报告用中文撰写，关键引述保留英文原文
5. **报告必须包含所有访谈原文记录作为附录**（不可省略，详见 analyst-prompt.md 附录部分）

→ **展示完整报告给用户**

### 附录要求

最终报告必须包含以下附录（不可省略）：

**附录 A：合成用户人设卡**
- 所有用户的完整人设卡（基础属性 + 心理属性 + 产品属性）
- 每个用户绑定的 Reddit 语料来源

**附录 B：完整访谈记录**
- 每个合成用户的 8-12 轮完整对话记录（原文，不可删减）
- 每轮对话的要点标注

**附录 C：Reddit 语料采集记录**
- 使用的 subreddit 列表和搜索关键词
- 采集到的帖子/评论数量
- 关键引用原文及链接

**附录 D：分析方法说明**
- 合成用户的属性分配逻辑
- 访谈问题设计依据
- 结论推导过程

### Phase 4: 深入追问（用户主导，可选）

报告展示后，告知用户可以选择任意合成用户继续对话：
- 合成用户保持人设一致性
- 保持之前访谈的上下文
- 用户可自由追问任何细节
- 新发现可追加到报告中

## 重要原则

1. **所有结论标注为假设** — 报告末尾必须包含方法论声明
2. **反讨好** — 合成用户必须能说"不"和"没用"
3. **数据驱动** — 不编造 Reddit 语料中没有的经历
4. **多样性** — 三层属性体系确保用户间有真实差异
5. **Mom Test** — 只问过去行为事实，不问未来意愿

## 下一步建议

报告完成后，根据调研发现推荐：
- 如果调研验证了需求 → "建议使用 `/founder-competitive-analysis` 了解竞争格局，找到差异化切入点"
- 如果准备融资 → "建议使用 `/founder-pitch-deck` 生成 pitch deck，调研数据可直接用于 Problem 和 Market slide"
- 如果方向仍不清晰 → "建议使用 `/founder-requirements-clarification` 重新梳理需求，缩小范围后再做调研"

## 文件参考

- `references/persona-builder-prompt.md` — 人设构建指南
- `references/interviewer-prompt.md` — 访谈方法论和反讨好机制
- `references/analyst-prompt.md` — 分析框架和报告格式
- `config/subreddit-map.json` — 领域→subreddit 映射
- `config/mbti-profiles.json` — 16 型 MBTI 行为描述
- `config/interview-questions.json` — Mom Test 问题模板
- `config/persona-pool.json` — 预置画像补充库
- `scripts/reddit-profile.sh` — Reddit 语料采集脚本
