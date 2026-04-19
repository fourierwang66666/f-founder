---
name: founder-competitive-analysis
description: |
  Deep competitive analysis for startup founders. Identifies competitors,
  researches product details, growth metrics, and user feedback, then
  generates a structured report with market insights and opportunity analysis.
  Supports parallel subagent research for efficiency.
  Use when: "competitive analysis", "competitor research", "market research",
  "analyze competitors", "who are our competitors", "竞品分析", "竞争对手",
  "市场调研", "/founder-competitive-analysis".
user-invokable: true
args:
  - name: source
    description: Path to PRD file (markdown, pdf, txt, docx) or leave empty for interactive input
    required: false
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

# founder-competitive-analysis: Competitive Analysis for Founders

Generate a deep competitive analysis report that identifies competitors, researches their products, growth, and user feedback, then produces a structured Markdown + PDF report with opportunity insights.

## Overview

**What it produces:**
- `report.md` — comprehensive Markdown report with cross-competitor comparisons and insights
- `report.pdf` — professionally styled PDF (brand-matched if pitch-deck exists, default style otherwise)

**Key features:**
- **Problem-first approach** — starts from the user problem, not product categories
- **Three-tier competitor discovery** — direct, indirect, and potential competitors
- **Parallel deep research** — one subagent per competitor, all running simultaneously
- **Real user feedback** — sourced from G2, Capterra, Reddit, Product Hunt
- **Opportunity synthesis** — market gaps, differentiation angles, risk flags
- **Brand-consistent PDF** — reuses pitch-deck design tokens when available

**Workflow:** 4 steps with 3 founder confirmation gates.

---

## Tool Dependencies

| Tool | Required | Purpose |
|------|----------|---------|
| WebSearch | Yes | Discovery, product info, funding, news |
| WebFetch | Yes | Fetch pages (company sites, G2, Reddit posts) |
| Agent | Yes | Parallel subagent deep research |
| Browse | Optional | JS-heavy page scraping |
| pdf | Optional | Parse PRD PDF input + PDF report generation |

---

## 反讨好规则

竞品分析必须客观，禁止：
- 淡化竞争威胁（"虽然竞争激烈但仍有机会" → 说清楚具体哪里有机会、有多大）
- 给市场空白加乐观包装（"存在差异化空间" → 说清楚空白是什么、为什么没人做、是真空白还是伪需求）
- 隐瞒不利数据（竞品融了 $100M 就说 $100M，不要说"获得了可观的融资"）
- 编造或推测数据（找不到就写"未找到公开数据"）

必须：
- 竞品强就说强，附证据
- 市场拥挤就说拥挤，列出玩家数量和融资总额
- 用户反馈差就如实呈现差评，不要只挑好的
- 机会分析要有数据支撑，不要空谈

## Step 1 — Problem Definition

Understand what problem the founder is trying to solve. This frames ALL subsequent research.

### 复用已有输出

如果 founder 之前已经跑过 `/founder-requirements-clarification`，检测当前项目目录下是否有需求澄清的输出。如果有：
- 直接复用已确认的核心问题、目标用户、关键需求
- 跳过问题定义的对话，告知 founder "检测到你之前的需求澄清结果，直接使用"
- 仅确认是否需要调整

如果没有，按正常流程执行问题定义。

### Input Detection

If the `source` arg is provided:
- `.md` file → read directly, extract problem definition
- `.pdf` file → invoke `pdf` skill to parse, then extract
- `.txt` / `.docx` file → read directly
- No file extension → treat as free-text description

If no `source` arg, ask the founder:
> "What problem are you trying to solve? You can describe it in your own words, or point me to a PRD file."

### Processing

Extract and structure into:

```
## Problem Definition

**Core Problem:** One sentence — the user pain point
**Target Users:** Who has this problem (be specific)
**Use Cases:** When/where users encounter this problem
**Key Needs:** 3-5 core user needs (these become search keywords)
**Current Solutions:** How users solve this today (if mentioned)
```

If input is a PRD:
- Also extract: product name, positioning, target market
- Use product name to EXCLUDE from competitor search results

### Gate

Present the structured problem definition to the founder:
> "Here is my understanding of the problem. Is this accurate? Any adjustments?"

Wait for confirmation before proceeding.

---

## Step 2 — Competitor Discovery

Find products that address the same or similar user needs. Cast a wide net, then narrow.

**Reference:** Read `references/search-strategies.md` Section 1 for complete query templates.

### 2a. Construct Search Queries

From Step 1's Key Needs and Core Problem, construct queries for three search paths:

**Path 1 — General Web Search (WebSearch):**
- "best [need keywords] tools/apps [current year]"
- "[need keywords] alternatives"
- "[core problem] solution/software"

**Path 2 — Reddit (WebSearch with site: filter):**
- "site:reddit.com [need keywords] recommendation"
- "site:reddit.com best [product type]"
- WebFetch top threads to extract product names and sentiment

**Path 3 — App Market / SaaS Reviews (adaptive):**
- If mobile-relevant: search App Store / Google Play via WebSearch
- If SaaS/Web: search G2 / Capterra via WebSearch
- If unclear: search both

### 2b. Supplementary Sources

After initial results, check:
- **AlternativeTo** — search by keyword or discovered competitor name
- **Product Hunt** — search related products
- **G2 / Capterra** — search by category

### 2c. Process Results

1. **Deduplicate** — merge same product found across multiple sources
2. **Score relevance** — how directly does this product address the founder's core problem?
3. **Classify into three tiers:**

| Tier | Definition |
|------|-----------|
| **Direct** | Solves the same problem with a similar approach |
| **Indirect** | Satisfies the same need through a different method |
| **Potential** | Adjacent product that could expand into this space |

4. **Present to founder as a table:**

```
## Competitor Discovery Results

### Direct Competitors
| # | Product | Description | Relevance | Sources |
|---|---------|-------------|-----------|---------|

### Indirect Competitors
| # | Product | Description | Relevance | Sources |
|---|---------|-------------|-----------|---------|

### Potential Competitors
| # | Product | Description | Relevance | Sources |
|---|---------|-------------|-----------|---------|
```

### Gate

> "Here are the competitors I found. Do you want to add, remove, or adjust any before I start deep research? Once confirmed, I will research each one in depth."

Wait for confirmation. Apply any changes the founder requests.

---

## Step 3 — Deep Research (Parallel Subagents)

Research each confirmed competitor in depth using parallel Agents.

**Reference:** Read `references/subagent-prompt.md` for the complete prompt template.
**Reference:** Read `references/search-strategies.md` Section 2 for per-module query templates.

### 3a. Dispatch Agents

For each competitor in the confirmed list, launch one Agent in parallel:

```
Agent(
  description="Research [CompetitorName]",
  prompt=<filled subagent prompt template>,
  subagent_type="general-purpose"
)
```

**All Agents launch in a single message** for maximum parallelism.

Each Agent prompt includes:
- Competitor name and one-line description
- Core problem definition (from Step 1)
- Competitor tier (direct/indirect/potential)
- Standardized research task list (Module A: Basics, Module B: Growth, Module C: Feedback)
- Required output format

### 3b. Collect and Quality-Check Results

After all Agents complete:

1. **Scan for completeness** — check each result for critical fields:
   - Core Features (Module A) — MUST have data
   - Pricing (Module B) — MUST have data
   - User Feedback (Module C) — SHOULD have data from at least one source

2. **Flag data gaps** — if a competitor has 3+ critical fields marked "No public data found", run a supplementary Agent with narrower queries.

3. **Cross-check consistency** — if two Agents reference the same product differently (e.g., conflicting founding dates), flag for the final report.

### 3c. Progress Update

After all Agents complete:
> "Deep research complete. Researched [n] competitors. [Brief summary of data quality — e.g., 'Strong data for 5, limited public info for 2.'] Generating report now."

---

## Step 4 — Report Generation

Assemble findings into a structured Markdown report, then generate PDF.

**Reference:** Read `references/report-structure.md` for complete report template and PDF generation instructions.

### 4a. Assemble Markdown Report

Follow the template in `references/report-structure.md` Section 1:

1. **Executive Summary** — write LAST, after all other sections. Synthesize the 3-5 most important findings and the overall opportunity signal.

2. **Cross-Competitor Overview** — build comparison tables from Agent outputs:
   - Basic Info table (launch, funding, team, pricing)
   - Feature Matrix (use Key Needs from Step 1 as rows)
   - Growth Comparison table

3. **Detailed Competitor Analysis** — paste each Agent's full output, grouped by tier (Direct → Indirect → Potential)

4. **User Feedback Insights** — SYNTHESIZE across all competitors:
   - Cross-competitor patterns (what do users consistently praise/complain about?)
   - Sentiment ranking
   - Unmet needs table with frequency and quotes
   - Flag needs NO competitor addresses

5. **Opportunity Analysis** — connect dots between:
   - Unmet user needs × market gaps → differentiation angles
   - Competitor weaknesses × founder's strengths → strategic entry points
   - Big company moves × regulatory changes → risk flags

6. **Data Sources** — consolidate all reference URLs from all Agents

### 4b. Save Markdown Report

```bash
mkdir -p competitive-analysis
```

Write the report to `competitive-analysis/report.md`.

### 4c. Generate PDF

**Design token detection** (see `references/report-structure.md` Section 3):

1. Look for pitch-deck `index.html` in current project — extract CSS custom properties
2. Look for `design-tokens.json`
3. If neither found, use defaults:
   - Primary: `#1a1a2e`, Accent: `#e94560`, BG: `#ffffff`
   - Font: Inter + Noto Sans SC

**Generation:**
1. Read `assets/report-template.html`
2. Replace `{{PLACEHOLDER}}` tokens with design values:
   - `{{REPORT_TITLE}}` — "[Product/Project Name] Competitive Analysis Report"
   - `{{PRIMARY}}` — primary brand color
   - `{{ACCENT}}` — accent color
   - `{{BG}}` — background color
   - `{{BG_SECONDARY}}` — secondary background
   - `{{TEXT}}` — primary text color
   - `{{TEXT_SECONDARY}}` — secondary text color
   - `{{BORDER}}` — border color
   - `{{FONT_MAIN}}` — main font stack
   - `{{FONT_MONO}}` — monospace font stack
   - `{{GOOGLE_FONTS_LINK}}` — full `<link>` tag
   - `{{REPORT_CONTENT}}` — Markdown converted to HTML
3. Convert `report.md` to HTML: transform markdown headings, tables, lists, blockquotes, and inline formatting into corresponding HTML elements
4. Inject the HTML into the template's `{{REPORT_CONTENT}}` placeholder
5. Write to `competitive-analysis/report.html`

**PDF output:**
- If `browse` skill is available: use it to open `report.html` and print to PDF → `competitive-analysis/report.pdf`
- Otherwise: tell the founder to open `report.html` in browser and use Ctrl+P / Cmd+P to save as PDF

### 4d. 附录：中间材料

最终报告必须包含以下附录：

**附录 A：问题定义**
- 核心问题、目标用户、关键需求的结构化输出

**附录 B：竞品发现原始结果**
- 所有搜索查询（实际使用的 query）
- 每条 query 返回的原始结果摘要
- 去重和筛选前的完整列表

**附录 C：Subagent 原始输出**
- 每个竞品的 Agent 原始返回（未经编辑）
- 标注哪些字段是 Agent 原始输出，哪些是主进程补充的

**附录 D：Founder 确认记录**
- Step 1 问题定义确认
- Step 2 竞品列表确认（含 founder 的增删调整）

### Gate

> "Report generated: `competitive-analysis/report.md` and `competitive-analysis/report.html`.
> [If PDF generated:] PDF saved to `competitive-analysis/report.pdf`.
> [If no Browse:] Open `report.html` in your browser and print to PDF (Cmd+P).
>
> Would you like me to dig deeper into any specific competitor?"

If the founder requests deeper research on specific competitors, dispatch targeted Agents and update the report.

### 下一步建议

报告完成后，根据 founder 的情况推荐：
- 如果发现了明确的市场空白 → "建议使用 `/founder-synthetic-research` 对目标用户做合成访谈，验证这些机会是否真实"
- 如果已经验证了方向 → "建议使用 `/founder-pitch-deck` 生成 pitch deck，竞品分析数据可以直接用于 Competition slide"
- 如果问题定义还不够清晰 → "建议先使用 `/founder-requirements-clarification` 梳理需求"

---

## Quick Reference

**Trigger:** `/founder-competitive-analysis` or describe a competitive analysis need
**Input:** Free text, or `source` arg pointing to a PRD file
**Output:** `competitive-analysis/report.md` + `report.html` + `report.pdf`
**Duration:** Deep research mode — thorough analysis with parallel subagents
**Gates:** 3 confirmation points (problem → competitor list → final report)
