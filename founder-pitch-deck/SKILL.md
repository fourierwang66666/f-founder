---
name: founder-pitch-deck
description: |
  Generate a high-quality HTML pitch deck for startups. Guides founders through
  brand extraction, content input, narrative review, HTML generation, visual QA,
  and deployment. Outputs a single-file HTML presentation with password protection,
  bilingual switching (ZH/EN), PDF export with watermark, and responsive scaling.
  Use when: "make a pitch deck", "create investor presentation", "build a deck",
  "seed round deck", "series A slides", "demo day presentation", "/founder-pitch-deck".
user-invokable: true
args:
  - name: source
    description: Path to content file (markdown, pptx, pdf, txt) or URL to brand website
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

# founder-pitch-deck: Startup Pitch Deck Generator

Generate a single-file HTML pitch deck that looks like it was designed by a top-tier agency. The workflow walks the founder through 7 steps: design extraction, content input, copy & layout confirmation, narrative review, HTML generation, visual QA, and deployment.

## Overview

**What it produces:** A single `index.html` file containing an entire pitch deck -- no external dependencies, no build step, no framework. Just open it in a browser.

**Key features:**
- **Auth gate** -- password-protected entry screen; investors type a code to view
- **Bilingual ZH/EN** -- every text element has both languages; toggle with a single click
- **PDF export with watermark** -- Ctrl+P or export button; watermark auto-applies on print
- **Responsive scaling** -- looks correct on 13" laptop, 27" monitor, iPad, or phone
- **Keyboard + touch navigation** -- arrow keys, swipe, spacebar, click-to-advance
- **Self-contained** -- all CSS and JS inline; Google Fonts loaded via `<link>`; images base64 or external URL

**Example result:** A 14-slide Series A deck with animated stat counters, staggered reveal items, dark/light slide alternation, brand-consistent color palette, and a bilingual ZH/EN toggle in the corner.

---

## Installation (Bundle)

One-command setup that checks and links all dependencies:

```bash
bash ~/.claude/skills/founder-pitch-deck/scripts/setup.sh
```

The setup script will:
1. Verify founder-pitch-deck skill is installed
2. Check for **Gstack** (browse, office-hours) — link if present
3. Check for **Impeccable** skills (animate, delight, frontend-design) — link from `~/.agents/skills/` if present
4. Report missing optional skills (pptx, pdf)

### Manual install

If you prefer to install dependencies individually:

```bash
# Gstack (provides browse + office-hours)
# See: https://gstack.dev

# Impeccable skills (provides animate, delight, frontend-design)
# See: https://impeccable.dev
```

---

## 反讨好规则

Pitch deck 的价值在于帮 founder 赢得投资，不是讨好 founder。禁止：

- 接受没有数据来源的数字（"市场很大" → 要求给出具体 TAM/SAM/SOM + 数据来源）
- 接受虚荣指标（"10000 注册用户" → 追问 MAU、留存率、付费转化率）
- 美化竞争格局（如果竞品在各维度都领先，不要画一个 founder 占右上角的矩阵）
- 跳过弱点（如果没有 traction，不要假装有——直接说"你的 traction slide 需要更多真实数据"）
- 给空洞的愿景配华丽的视觉效果来掩盖内容不足

必须：
- Traction slide 的每个数字都要有来源
- Competition slide 必须诚实——如果竞品确实更强，在 narrative 中解释你的差异化
- 问题描述必须来自真实用户痛点，不是 founder 的想象
- 如果 founder 提供的内容不足以做一个有说服力的 deck，直接说，建议先做需求澄清或竞品分析

<HARD-RULE>
## MANDATORY: Sub-Skill Invocation Policy

You MUST call the Skill tool for each sub-skill listed below BEFORE using any fallback.
Do NOT skip sub-skill calls. Do NOT assume they are unavailable without trying.
The ONLY acceptable reason to use a fallback is if the Skill tool returns an actual error.
"I can handle this myself" is NOT a valid reason to skip.
</HARD-RULE>

## Sub-Skills

This skill chain-orchestrates several other skills. **You MUST attempt to invoke each one via the Skill tool.** Fallbacks are ONLY for when the Skill tool returns an error (skill not installed).

| Skill | Source | Purpose | Fallback (ONLY if Skill tool errors) |
|-------|--------|---------|--------------------------------------|
| `office-hours` | Gstack | YC-style narrative review -- six forcing questions | Lightweight self-review + tell founder to install Gstack |
| `frontend-design` | Impeccable | Design quality guidance for slide layout | Use `references/html-engine.md` + tell founder to install Impeccable |
| `animate` | Impeccable | CSS animations -- entrance choreography, stat counters | Base CSS transitions + tell founder to install Impeccable |
| `delight` | Impeccable | Micro-interactions, hover states, personality | Base transitions + tell founder to install Impeccable |
| `browse` | Gstack | Headless browser for screenshot-based visual QA | Ask founder to open in browser and confirm |
| `pptx` | Built-in | Parse `.pptx` to extract slide text | Ask founder to paste as markdown |
| `pdf` | Built-in | Parse brand guideline PDFs | Use interactive Q&A instead |

---

## Quick Start

Minimal happy path:

```
User:   /founder-pitch-deck
Claude: What is your company's website URL? (I will extract brand colors, fonts, and mood.)
User:   https://example.com
Claude: [extracts design tokens] Now provide your deck content -- markdown file, .pptx, or just describe your startup.
User:   Here is our deck outline: [pastes markdown]
Claude: [generates slide outline, runs narrative review, confirms copy with founder, designs slide layouts, builds HTML, screenshots each slide for QA]
Result: index.html written to project directory, ready to open.
```

If the `source` arg is provided, skip the first question and detect the input type automatically:
- URL ending in `.pptx` --> download and parse with `pptx` skill
- URL ending in `.pdf` --> download and parse with `pdf` skill
- URL with no file extension --> treat as brand website, extract design tokens
- Local file path --> detect by extension (`.md`, `.pptx`, `.pdf`, `.txt`)

---

## Step 1 -- Design Specification

Extract or build a design token set that drives the entire deck's look and feel. **This step requires visually seeing the brand — not just reading code.**

Detect which input the founder provides and follow the corresponding path. For detailed extraction procedures (JS snippets, font identification flow, logo extraction), read `references/brand-extraction.md`.

### Input paths

**Path A: Brand Website URL** (preferred) — Use `browse` skill to screenshot the site, visually analyze colors/typography/mood, extract logo via JS, then parse CSS for exact values. Three phases: visual analysis → code extraction → present summary. See `references/brand-extraction.md` Sections 1-3.

**Path A2: Reference Deck** — Use `browse` to screenshot slides, analyze design language, extract tokens. See `references/brand-extraction.md` Section 2.

**Path B: Brand Guideline PDF** — Use `pdf` skill to parse colors, fonts, logo. See `references/brand-extraction.md` Section 3.

**Path C: Interactive Q&A** — If no source is available, ask five questions:
1. **Primary color** — hex code, or pick from logo
2. **Style mood** — `minimal` | `bold` | `elegant` | `tech`
3. **Font pairing** — present 3 curated options from `references/font-system.md` Section 2
4. **CJK requirement** — SC, TC, JP, or none
5. **Company name** — for cover slide and watermark

**Path D: Logo File** — Read visually, extract colors, infer mood. See `references/brand-extraction.md` Section 4.

### Output: Design Tokens

Produce a JSON object with these fields (see `references/brand-extraction.md` Section 5 for full schema):

```json
{
  "colors": { "primary": "#da3d3d", "accent": "#0f8e61", "bg": "#faf9f6", "text": "rgba(0,0,0,0.82)" },
  "fonts": { "heading": "Inter", "body": "Inter", "cjk": "Noto Sans SC", "source": "google" },
  "mood": "minimal",
  "visualSummary": "Clean, spacious design with warm off-white backgrounds...",
  "logo": "https://example.com/logo.svg",
  "companyName": "ExampleCo",
  "watermark": "ExampleCo Confidential"
}
```

**`visualSummary`** is the most important field — it captures what you SAW, not what you parsed. Trust the visual summary over hex values when they conflict.

Store these tokens in memory — they feed into Step 5.

**References:**
- `references/brand-extraction.md` for detailed extraction procedures, JS snippets, and font identification flow
- `references/font-system.md` for curated pairings, substitution table, and typography fine-tuning
- `references/html-engine.md` for the full token list and CSS variable mapping

---

## Step 2 -- Content Input + Outline

### Multi-Format Input

Detect and handle:

- **Markdown (`.md`)** -- parse `## headings` as slide breaks; bullets become slide content
- **Old `.pptx`** -- invoke `pptx` skill to extract text via markitdown; map slides 1:1
- **PDF (`.pdf`)** -- invoke `pdf` skill to extract text; founder confirms slide mapping
- **Plain text or conversation** -- Claude asks structured questions per template below

### Template Selection

Present three options and let the founder choose:

**Seed Round (12-16 slides)**
Cover --> Market --> Problem --> Solution --> Product --> How it Works --> Traction --> Business Model --> Competition --> Team --> Vision --> Ask

**Series A (14-18 slides)**
Cover --> Market --> Problem --> Solution --> Product --> How it Works --> Traction --> Unit Economics --> Growth Strategy --> Business Model --> Competition --> Financials --> Case Studies --> Team --> Vision --> Ask

**Demo Day (8-10 slides)**
Cover --> Problem --> Solution --> Demo --> Traction --> Business Model --> Team --> Ask

**Reference:** `references/slide-structures.md` for full templates with per-slide guidance and example bullets.

### Outline Generation

Produce `outline.md` with this structure per slide:

```markdown
## Slide 3: Problem
**Title ZH:** 问题
**Title EN:** The Problem
**Visual:** Full-bleed photo of frustrated freelancer at laptop
**Layout:** dark slide, centered text
**Bullets:**
- 67% of freelancers report payment delays > 30 days
- Average chasing time: 8 hours/month per freelancer
- $1.4T annual freelancer economy with broken payment rails
**Data source:** Payoneer 2025 Freelancer Survey
**Speaker notes:** Pause here. Let the number sink in.
```

Present the complete outline to the founder. Allow:
- Add / remove / reorder slides
- Edit any bullet or title
- Change slide type (light / dark / accent)

Confirm the outline before moving to Step 3.

---

## Step 3 -- Copy & Layout Confirmation

Compile all slide content into a single document for the founder to review. This combines text copy and visual layout into one confirmation step — the founder sees exactly what each slide will contain and how it will be arranged.

### 3a. Generate copy-layout document

Create `copy.md` in the project directory. For each slide, include both the text content and a simple ASCII wireframe showing layout:

```markdown
# [Company Name] Pitch Deck — Copy & Layout

## Slide 1: Cover (.slide.red)
- Logo: [BRAND LOGO]
- Eyebrow: SEED ROUND · $1M
- Tagline: "One line that captures the company"
- Subtitle: 一句话中文描述 / One-line English description
- Footer: Confidential · April 2026

## Slide 2: Problem (.slide.dark)
- Eyebrow: PROBLEM
- Headline: The Problem Statement
- Layout: 3 pain points, left-aligned with icons
  ┌──────────────────────────────┐
  │  🔍 Pain 1 title + desc     │
  │  💸 Pain 2 title + desc     │
  │  ⏱ Pain 3 title + desc     │
  │  [callout: key stat]        │
  └──────────────────────────────┘
- Supporting stat: 67% of freelancers report payment delays
- Source: Payoneer 2025 Freelancer Survey

(continue for all slides)
```

For each slide, include:
- Every piece of visible text (headline, bullets, stats, sources, footnotes)
- **Layout type** in parentheses: `.slide`, `.slide.dark`, or `.slide.red`
- **Visual elements** as ASCII wireframes or bracketed placeholders: `[CHART: 2x2 quadrant]`, `[DIAGRAM: flow]`, `[PHOTO: team]`
- Data points with their sources
- Which language is primary (ZH or EN); the other will be translated

For complex visual slides (competition quadrants, timelines, flow diagrams), sketch the layout and confirm element placement — these will be built as pure CSS (no charting libraries). Reference `references/slide-structures.md` for standard layout patterns.

### 3b. Present to founder

Tell the founder:
> Here is the complete copy and layout for all slides. Please review:
> - Are all data points accurate and sourced?
> - Does each slide layout capture what you want to show?
> - Any text or layout changes?
>
> Edit `copy.md` directly or tell me what to change.

Wait for confirmation. Apply edits and re-present if changes are significant. Once confirmed, this document becomes the source of truth for all downstream steps.

---

## Step 4 -- Narrative Review

**IMPORTANT: You MUST attempt to invoke the `office-hours` skill before falling back to self-review.**

Run the narrative review on the **confirmed copy** (from Step 3's `copy.md`), not the raw outline.

**Reference:** `references/storytelling.md` provides the 7-beat narrative arc, YC/a16z frameworks, data presentation rules, and common mistakes. Use it to evaluate narrative structure and identify weak spots.

### 4a. Invoke office-hours (REQUIRED first attempt)

**DO THIS NOW:** Call the Skill tool with skill="office-hours" and args="startup mode — review this pitch deck copy for investment readiness". Pass the full `copy.md` content.

office-hours will stress-test six dimensions: Demand Reality, Status Quo, Desperate Specificity, Narrowest Wedge, Observation, Future-fit.

After the review, present the critique. Iterate: founder revises `copy.md` → re-run on changed sections → confirm final copy.

### 4b. Fallback (ONLY if office-hours skill is not installed)

If the Skill tool returns an error, perform a self-review using `references/storytelling.md` as your framework:
- **Data credibility** -- are stats sourced and recent (< 2 years)?
- **Narrative arc** -- does the story follow the 7-beat structure (hook → problem → insight → solution → proof → vision → ask)?
- **Specificity** -- precise claims ("$4.35B TAM in SEA freelancer payments") vs vague ("huge market")?
- **Missing elements** -- clear ask? Team slide? Honest competition? Data sources?

Tell the founder: "The office-hours skill is not installed. I used the storytelling framework for a lightweight review. Install Gstack for a deeper YC-style critique."

---

## Step 5 -- HTML Generation

Three-layer build process. All output goes into a single `index.html` file.

### Layer 1: Engine Setup

1. Read `assets/base-template.html` -- the full HTML engine with auth gate, navigation, bilingual toggle, PDF export, and responsive scaling already built in.
2. Replace all `{{PLACEHOLDER}}` tokens with design values (see `references/html-engine.md` Section 1 for the full mapping):
   - `{{PASSWORD}}` -- investor access code (ask founder, default: company name lowercase)
   - `{{DECK_TITLE}}` -- company name or deck title
   - `{{WATERMARK}}` -- confidential watermark for PDF export
   - `{{BRAND_LOGO_TEXT}}` -- brand name shown on auth gate
   - `{{PRIMARY}}`, `{{PRIMARY_DARK}}`, `{{ACCENT}}` -- brand colors from design tokens
   - `{{BG}}`, `{{BG_WARM}}`, `{{TEXT}}`, `{{TEXT_MID}}`, `{{TEXT_LIGHT}}`, `{{BORDER}}` -- surface/text colors
   - `{{FONT_MAIN}}`, `{{FONT_SERIF}}` -- font stacks from design tokens
   - `{{GOOGLE_FONTS_LINK}}` -- full `<link>` tag for Google Fonts
3. Write the result to `index.html` in the project directory.

### Layer 2: Slide Content

**DO THIS NOW:** Call the Skill tool with skill="frontend-design" and args containing the design tokens JSON + slide outline. Follow its guidance for layout, spacing, and visual hierarchy.

If the Skill tool returns an error (skill not installed), use `references/html-engine.md` for layout conventions. Tell the founder: "frontend-design skill is not installed. Install Impeccable for better design quality."

For each slide in the confirmed outline:
- Generate semantic HTML following `references/html-engine.md` conventions
- Insert into `<div class="deck" id="deck">` container
- Apply bilingual spans on all visible text:
  ```html
  <span class="zh">中文内容</span><span class="en">English content</span>
  ```
- Use utility classes: `.eyebrow`, `.stat-big`, `.flex`, `.col`, `.reveal-item`, `.beat-num`
- Match slide type to CSS class: `.slide` (light), `.slide.dark`, `.slide.red`
- Inline any SVG icons or illustrations; reference external images by URL

### Layer 3: Animation + Delight

**DO THIS NOW — two sequential Skill tool calls:**

**Step 3a — Call the Skill tool** with skill="animate" and args="Review and enhance the pitch deck at index.html with purposeful animations. Focus on: count-up animation on .beat-num elements, staggered .reveal-item entrance (100ms offset, fade + translateY), smooth slide transitions (opacity crossfade 400ms), scroll-progress indicator."

**Step 3b — Call the Skill tool** with skill="delight" and args="Add micro-interactions and personality to the pitch deck at index.html. Focus on: auth gate background animation + input focus glow, hover micro-interactions on team photos / stat cards / CTA buttons, progress bar gradient with brand colors, language toggle smooth text crossfade."

**Fallback (ONLY if the Skill tool returns an error for animate/delight):**

If the Skill tool returns an error indicating the skill is not installed, use base CSS transitions. Tell the founder: "animate/delight skills are not installed. Install Impeccable for richer animations."
```css
.reveal-item { opacity: 0; transform: translateY(20px); transition: all 0.5s ease-out; }
.reveal-item.visible { opacity: 1; transform: translateY(0); }
```

Tell the founder: "The animate/delight skills are not installed. The deck uses basic transitions. Install Impeccable for richer animations."

---

## Step 6 -- Visual QA

**DO THIS NOW:** Call the Skill tool with skill="browse" to start a headless browser QA session.

### With `browse` Skill

1. Start a local server:
   ```bash
   cd <project-dir> && python3 -m http.server 8080 &
   ```
2. Navigate to `http://localhost:8080` -- enter the password on the auth gate.
3. For each slide, screenshot at 1280x720. Claude reviews:
   - **Alignment** -- are elements properly centered or grid-aligned?
   - **Text overflow** -- does any text clip or wrap unexpectedly?
   - **Color contrast** -- does text meet WCAG AA (4.5:1 for body, 3:1 for large text)?
   - **Bilingual layout** -- switch to EN, re-screenshot, check nothing breaks
   - **Data visualization** -- are stat numbers readable? Are charts/icons clear?
4. Auto-fix any issues found (adjust font-size, padding, color).
5. Re-screenshot fixed slides to verify.
6. Kill the local server.

### Fallback (ONLY if browse skill returns error)

Tell the founder:
> I have generated `index.html`. Please open it in your browser and check each slide.
> Things to verify: text readability, color contrast, bilingual toggle works, PDF export works (Ctrl+P), password gate works.

---

## Step 7 -- Deployment

Present four deployment options:

### Option 1: Local (simplest)
```bash
open index.html
```
Works offline. Good for email attachments or USB delivery.

### Option 2: GitHub Pages
```bash
git init && git add index.html && git commit -m "pitch deck"
gh repo create <company>-deck --private --source=. --push
gh api repos/{owner}/{repo}/pages -f source.branch=main -f source.path=/
```
Provides a URL like `https://username.github.io/company-deck/`. Set repo to private for confidentiality.

### Option 3: Vercel
```bash
npx vercel --prod
```
One command. Free tier. Custom domain possible.

### Option 4: Netlify
```bash
npx netlify deploy --prod --dir .
```
Similar to Vercel. Founder's preference.

After deployment, provide the final URL and remind the founder to test the auth gate from an incognito window.

### 下一步建议

Deck 完成后，根据 founder 的情况推荐：
- 如果还没做过竞品分析 → "建议使用 `/founder-competitive-analysis` 做深度竞品研究，可以加强你的 Competition slide"
- 如果 deck 内容薄弱 → "建议先使用 `/founder-requirements-clarification` 梳理需求，再回来完善 deck 内容"
- 如果需要用户数据支撑 → "建议使用 `/founder-synthetic-research` 做合成用户访谈，获取 Problem slide 的真实用户引述"

---

## 中间材料保留

在最终 `index.html` 之外，以下中间材料必须保留在项目目录中：

- `design-tokens.json` — 提取的设计 tokens（颜色、字体、mood、logo）
- `outline.md` — Step 2 生成的 slide outline
- `copy.md` — Step 3 确认的文案和布局
- `narrative-review.md` — Step 4 的 narrative review 反馈和修改记录

这些文件确保过程可追溯，也方便后续迭代时不用从零开始。

---

## Quick Reference

Slide markup essentials. Full details in `references/html-engine.md`, slide templates in `references/slide-structures.md`.

**Slide types:** `.slide` (light) | `.slide.dark` | `.slide.red` (primary color)

**Bilingual:** `<span class="zh">中文</span><span class="en">English</span>` on every text element. CSS toggles via `body.lang-en`.

**Layout:** `.flex` + `.col` (2-col), `.flex-3` (3-col), `.flex-4` (4-col). Spacing: `.mt-8` `.mt-16` `.mt-24` `.mt-32`.

**Stats:** `.beat-num` triggers count-up animation. Supports `data-target`/`data-prefix`/`data-suffix` attributes or inline bilingual spans.

**Animation:** `.reveal-item` for staggered entrance. `.eyebrow` for section labels. `.card` / `.cap-card` for content cards.

**Output:** Single `index.html` file. No build step, no dependencies. Just open in browser.
