---
name: founder-requirements-clarification
description: |
  Help founders clarify requirements from a vague idea to a focused MVP direction.
  Through structured dialogue and real community data, find the sharpest pain point
  and the smallest PMF path.
  Use when: "analyze requirements", "I want to build", "requirements clarification",
  "product direction", "help me sort out", "I have an idea", "需求澄清",
  "我想做一个", "帮我分析一下", "我有个想法", "/founder-requirements-clarification".
  Activate even for vague or half-formed ideas — the whole point is to help sharpen them.
user-invokable: true
---

# founder-requirements-clarification: 需求澄清

帮产品发起人从一个模糊的想法出发，通过对话引导和真实数据调研，找到最痛的切入点和最小的 PMF 路径。

## 流程概览

整个过程是 **对话式** 的——每一步都需要和用户充分讨论，确认后再往下走。不要一口气输出一大段分析然后等用户回复。

```
需求来源 → 需求本质 → 用户场景 → 痛点验证(Reddit) → PMF 建议
```

---

## Step 1：需求来源——这个想法从哪来的？

目标：理解想法的起源，判断它是一手痛点还是二手臆想。

通过对话引导用户回答：

- **触发事件**：是什么让你想到要做这个？是你自己遇到了问题，还是看到别人有这个问题，还是看到某个趋势觉得有机会？
- **频次与强度**：这个问题你/他们多久遇到一次？遇到的时候有多痛？是"有点不方便"还是"真的很烦"？
- **现在怎么解决的**：目前用什么方式凑合？花多少时间/钱？

关键判断：需求来源的质量直接决定了后面所有分析的地基。自己踩过的坑 > 身边人反复抱怨的问题 > 看报告/趋势推导出来的机会。如果来源太弱（比如"我觉得这个方向有前景"），要直说，帮用户意识到这一点。

**这一步结束时，你和用户应该对齐**：这个想法的出发点是什么，可信度如何。

---

## Step 2：需求本质——真正要解决的是什么？

目标：剥掉解决方案的外衣，找到底层问题。

用户通常带着一个"解决方案"来（"我想做一个 XX 工具"），你的工作是反复追问，直到找到底层的 **问题**：

- 用户说的"功能"背后，真正想解决的问题是什么？
- 这个问题能不能用更简单的方式解决？（一个 Excel 表、一个现成工具、一个流程调整？）
- 如果问题消失了，用户的生活/工作会有什么具体变化？

**不要客气**。如果你觉得用户描述的东西是伪需求或者解法过重，直接指出来。你的价值不是附和，是帮他想清楚。

**这一步结束时，你和用户应该对齐**：一句话描述这个产品要解决的核心问题（不是功能，是问题）。

---

## Step 3：用户场景——谁在什么情况下会用？

目标：把抽象的需求落地为具体的人和具体的场景。

引导用户想清楚：

- **谁**：最可能的第一批用户是谁？不是"所有人"，是具体到职业、身份、甚至生活习惯的那种具体。
- **什么时候**：他们在什么场景下会想到用这个东西？是工作中被某个任务卡住了，还是日常生活中某个时刻？
- **怎么用**：他们期望的使用方式是什么？打开一个 app？发一条消息？说一句话？
- **替代品**：他们现在用什么替代方案？为什么那些方案不够好？

最终要聚焦到 **一个最核心的场景**——如果只能服务一个场景，选哪个？

**这一步结束时，你和用户应该对齐**：一个具体的用户画像 + 一个最核心的使用场景。

---

## Step 4：痛点验证——真实用户怎么说？

目标：用真实社区数据验证前三步的假设，找到最痛和最聚焦的切入点。

**这一步必须联网搜索，不能凭空分析。**

### 工具与执行方式

通过 **并行 Agent** 同时执行以下搜索任务（至少 2 个 Agent：Reddit + 中文社区）：

**Agent 1：Reddit 深度痛点挖掘**（核心数据源）

使用 bundled 脚本 `scripts/reddit-readonly.mjs`（Node.js 18+，无需认证），它直接调用 Reddit 公开 JSON API，返回结构化数据（帖子标题、分数、评论数、评论原文及点赞数）。

```bash
# 第一步：搜索相关帖子（多组关键词，覆盖不同表达）
node <skill-path>/scripts/reddit-readonly.mjs search all "[问题关键词] frustrated" --sort relevance --limit 25
node <skill-path>/scripts/reddit-readonly.mjs search all "[场景] wish there was" --sort relevance --limit 25
node <skill-path>/scripts/reddit-readonly.mjs search all "[现有方案] sucks alternative" --sort relevance --limit 25

# 也可以限定 subreddit 搜索
node <skill-path>/scripts/reddit-readonly.mjs search <subreddit> "<query>" --sort top --time year --limit 25

# 或用 find 命令做多 subreddit + 关键词过滤搜索
node <skill-path>/scripts/reddit-readonly.mjs find \
  --subreddits "subreddit1,subreddit2,subreddit3" \
  --query "[需求关键词]" \
  --include "pain,frustrat,wish,hate,annoying" \
  --rank score --maxResults 20

# 第二步：对高分帖子读取完整评论树
node <skill-path>/scripts/reddit-readonly.mjs thread <post_id> --depth 5 --maxChars 2000

# thread 命令返回帖子详情 + 评论树，每条评论包含：
# - author, score, body_snippet, depth, created_iso
# 重点关注高分评论——score 高的评论代表社区共识
```

**关键**：搜索返回的每个帖子都有 `score`（点赞数）和 `num_comments`，优先读取高分高评论的帖子。评论里的 `score` 是该条评论的点赞数，用来判断哪些观点代表社区共识。

**Agent 2：中文社区搜索**

工具链：`WebSearch`（限定 zhihu.com / v2ex.com）→ `WebFetch`

```
步骤：
1. WebSearch 搜索知乎、V2EX
   - "[问题关键词] 痛点"
   - "[现有方案] 不好用 / 替代品"
   - "求推荐 [需求场景]"
2. WebFetch 读取高赞回答/帖子，提取用户原话
```

**可选 Agent 3：ProductHunt / App Store**（如果有对标产品）

```
WebSearch allowed_domains: ["producthunt.com"] 搜索同类产品评价
WebSearch 搜索 "[竞品名] app store reviews reddit"
```

### 输出格式

按痛点类别归类，每个类别下列出用户原声：

```
### 痛点归类

#### 类别 1：[痛点描述，如"现有工具配置太复杂"]
- 情绪强度：🔥🔥🔥（高）/ 🔥🔥（中）/ 🔥（低）
- 出现频次：X 条相关讨论

> "原话引用，保持用户的原始表达" — [来源](链接)，👍 XX

> "另一条原话引用" — [来源](链接)，👍 XX

#### 类别 2：[痛点描述]
- 情绪强度：🔥🔥
- 出现频次：X 条

> "原话引用" — [来源](链接)

### 未被满足的 Gap
- [用户明确提出但没人做的具体诉求]

### 需求温度判定
- ❄️ 冷门（几乎无讨论）
- 🌡️ 有热度（零散讨论，有人关注但不密集）
- 🔥 强需求（高频、高情绪强度、多平台出现）
```

> **情绪强度判定标准**：看用词激烈程度（frustrated/hate/terrible = 高，annoying/wish = 中，would be nice = 低）、点赞/回复数、以及是否有人表示"愿意付费解决"。

### 关键判断

如果社区数据显示需求很冷，要诚实告诉用户。"没人讨论"本身就是重要信号——可能是需求不成立，也可能是细分市场还没被发现，但不管哪种情况用户都需要知道。

**这一步结束时，你和用户应该对齐**：需求是否被真实用户验证，最痛的点在哪里。

---

## Step 5：PMF 建议——最小的切入点是什么？

目标：基于前 4 步的所有信息，给出最克制的 MVP 建议。

### 综合前面的发现，输出：

**1. 切入点定义**
- 一句话描述：为 [谁] 解决 [什么问题]，通过 [什么方式]
- 为什么选这个切入点（结合痛点数据）

**2. MVP 做什么、不做什么**
- P0（必须有，没有就不成立的功能）：最多 3 个
- 明确排除的功能 + 排除理由

**3. 验证策略**
- 第一批用户从哪找？（结合 Step 4 的社区数据）
- 怎么判断 PMF 达成？给 1-2 个关键指标
- 最快的验证方式是什么？（landing page、waitlist、手动服务、prototype？）

**4. 风险提示**
- 这个方向最大的风险是什么？
- 什么信号出现了说明应该 pivot？

**5. 下一步建议**
- 如果需要深入了解竞争格局，建议使用 `/founder-competitive-analysis` 进行系统的竞品分析
- 如果需要制作融资材料，建议使用 `/founder-pitch-deck` 生成 pitch deck

### 原则

- **做减法**，不是做加法。MVP 的目标是验证假设，不是做一个完整产品。
- **诚实**。如果你觉得这个方向不太行，直接说，附上理由。
- **具体**。"做一个 MVP" 不是建议，"用 Typeform 做一个 20 题的需求验证问卷，投放到 r/xxx 社区" 才是建议。

---

## 执行原则

- **对话优先**：前 3 步是跟用户对话，不是你自己分析。每一步都要等用户确认后再往下。
- **数据驱动**：Step 4 必须联网搜索真实数据，禁止编造。
- **并行采集**：Step 4 的数据搜索通过并行 Agent 执行，提高效率。
- **诚实直接**：发现问题直接说，不要为了不打击用户而回避真相。
- **来源标注**：所有引用的社区讨论、数据必须附链接。
- **串联 f-founder**：完成需求澄清后，自然引导 founder 使用 f-founder 的其他 skill（竞品分析、pitch deck）继续推进。
