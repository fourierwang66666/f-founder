# HTML Engine Technical Reference

Reference for generating slide HTML in Step 4. All classes, tokens, and patterns
documented here match the base template engine exactly. Copy-paste ready.

---

## 1. Design Tokens (CSS Custom Properties)

Set in `:root`. Replace default values with design tokens extracted in Step 1.

| Token | Purpose | Default |
|-------|---------|---------|
| `--red` | Primary brand color. Cover bg, accent elements, active nav dots, `.num` circles | `#da3d3d` |
| `--red-dark` | Darker variant for hover/active states | `#b40003` |
| `--cream` | Light text on primary backgrounds (`.slide.red` text color) | `#fffee1` |
| `--green` | Positive indicator color (tags, growth metrics) | `#0f8e61` |
| `--orange` | Warning/neutral indicator color (tags) | `#cb4a00` |
| `--bg` | Default slide background | `#faf9f6` |
| `--bg-warm` | Warm background for cards | `#fffefc` |
| `--text` | Primary text -- headings, important copy | `rgba(0,0,0,0.82)` |
| `--text-mid` | Secondary text -- body paragraphs, descriptions | `rgba(0,0,0,0.65)` |
| `--text-light` | Tertiary text -- labels, captions, eyebrows, stat-labels | `rgba(0,0,0,0.45)` |
| `--border` | Subtle borders and dividers | `rgba(0,0,0,0.1)` |
| `--border-mid` | Stronger borders (architecture diagrams) | `rgba(0,0,0,0.25)` |
| `--shadow` | Flat shadow for emphasized elements | `3px 3px 0 0 rgba(0,0,0,0.8)` |
| `--font-main` | Heading + body font stack | `'Kiwi Maru','Noto Sans SC',system-ui,sans-serif` |
| `--font-cn` | Chinese serif for decorative/closing quotes | `'Songti SC','STSong','Noto Serif SC',serif` |
| `--font-serif` | Western serif for quotes and editorial text | `'Cormorant Garamond','Songti SC',serif` |
| `--slide-w` | Slide canvas width (do not change) | `1280px` |
| `--slide-h` | Slide canvas height (do not change) | `720px` |

---

## 2. Slide Types

Each slide is `<div class="slide" data-slide="N">`. First slide gets `.active`.
All slides: `padding: 60px 80px; display: flex; flex-direction: column`.

**Default (light)** -- `.slide`
- bg: `var(--bg)` | text: `var(--text)` | p: `var(--text-mid)` | eyebrow: `var(--text-light)`
- Use for: most content slides (Market, Problem, Product, Business Model, etc.)

**Dark** -- `.slide.dark`
- bg: `#1a1a1a` | text: `rgba(255,255,255,0.9)` | h2/h3: `#fff`
- p: `rgba(255,255,255,0.65)` | eyebrow: `rgba(255,255,255,0.4)`
- Use for: high-impact vision slides, opening/closing, dramatic data reveals

**Primary** -- `.slide.red`
- bg: `var(--red)` | text/h1/h2: `var(--cream)` (`#fffee1`)
- p: `rgba(255,255,255,0.65)` | eyebrow: `rgba(255,254,225,0.6)`
- Use for: cover slide, CTA, ask/fundraising slides

---

## 3. Typography Classes

| Element/Class | Size | Weight | Line-Height | Color | Purpose |
|---------------|------|--------|-------------|-------|---------|
| `h1` | 44px | 500 | 1.25 | inherit | Slide main title |
| `h2` | 32px | 500 | 1.3 | inherit | Section title (mb 8px) |
| `h3` | 20px | 500 | 1.4 | inherit | Sub-section heading (mb 6px) |
| `p` | 16px | normal | 1.65 | `--text-mid` | Body text |
| `.eyebrow` | 13px | 500 | default | `--text-light` | Section label. Uppercase, letter-spacing 2px, mb 16px |
| `.stat-big` | 56px | 500 | 1.1 | inherit | Hero numbers in stat cards |
| `.stat-label` | 14px | normal | default | `--text-light` | Caption below numbers (mt 4px) |
| `.quote` | 20px | normal | 1.6 | `--text` | Testimonials. `--font-serif`, italic |
| `.logo` | 22px | 500 | default | `--text-light` | Company logo text (letter-spacing 1px) |
| `.cover-tagline` | 64px | 500 | 1.15 | inherit | Cover headline (letter-spacing -1px) |
| `.cover-sub` | 20px | 300 | default | inherit | Cover subtitle (mt 12px) |

`.beat-num`: 72px, weight 500, `color: var(--red)` on light slides. On dark: `rgba(255,255,255,0.9)`.

---

## 4. Layout Classes

| Class | Behavior |
|-------|----------|
| `.flex` | `display:flex; gap:32px` -- 2-column default |
| `.flex-3` | `display:flex; gap:24px` -- 3-column |
| `.flex-4` | `display:flex; gap:20px` -- 4-column |
| `.col` | `flex:1` -- equal-width column |
| `.center` | `text-align:center; align-items:center; justify-content:center` |
| `.space-between` | `justify-content:space-between` |
| `.grow` | `flex:1` -- fills remaining vertical space |
| `.mt-auto` | `margin-top:auto` -- push to bottom of flex parent |

Spacing: `.mt-8` `.mt-16` `.mt-24` `.mt-32` `.mt-40` `.mb-8` `.mb-16` (values match suffix in px).

---

## 5. Cards and Tags

**Cards:** `.card` / `.cap-card` -- bg-warm, 0.5px border, 2px radius, 24px padding, flex:1. Hover lifts 2px.
`.card-dark` -- same shape, `rgba(255,255,255,0.06)` bg for dark slides.

**Tags:** `.tag` -- inline pill, 13px, 500, `padding:4px 12px`, `border-radius:1px`.
- `.tag.green` -- green bg/text (positive metrics)
- `.tag.orange` -- orange bg/text (warnings, neutral)
- `.tag.red-tag` -- red bg/text (negative, urgent)

---

## 6. Animation Classes

**`.reveal-item`** -- staggered entrance. Starts `opacity:0; translateY(14px)`.
When `.slide.active`: fades in + slides up. Delays: 0.1s, 0.22s, 0.34s, 0.46s, 0.56s (nth-child 1-5).

**`.beat-num`** -- hidden when inactive; fades in on `.active`. JS count-up runs 0 to target.
Wrap numeric content directly; counter script reads `textContent`.

**`.cover-tagline`** -- delayed entrance: 0.2s delay, 0.8s fade + slide-up.
**`.cover-sub`** -- delayed entrance: 0.5s delay, 0.7s fade + slide-up.

---

## 7. Bilingual Pattern

Every visible text element uses paired `<span>` tags:

```html
<h2><span class="zh">标题</span><span class="en">Title</span></h2>
<p><span class="zh">中文段落</span><span class="en">English paragraph</span></p>

<!-- Number with locale-specific units -->
<div class="beat-num">
  <span class="zh">4.35<span style="font-size:28px">亿</span></span>
  <span class="en">435<span style="font-size:28px">M</span></span>
</div>
```

**CSS:** Default: `span.en { display:none }` (Chinese visible).
`body.lang-en`: Chinese hidden, English visible.

**Rules:**
- DO NOT translate: brand names, proper nouns, common English tech terms
- Numbers: locale adaptation needed (亿 -> M/B, 万 -> K/M)
- Both languages should have similar visual weight
- Eyebrows: English UPPERCASE, Chinese natural case

---

## 8. Common Slide Patterns

### Cover Slide

```html
<div class="slide red active" data-slide="0">
  <div class="logo">BRAND</div>
  <div class="grow" style="display:flex;flex-direction:column;justify-content:center">
    <div class="eyebrow">SEED ROUND · $1M</div>
    <h1 class="cover-tagline">Tagline Here</h1>
    <p class="cover-sub" style="color:rgba(255,254,225,0.7)">
      <span class="zh">一句话中文描述</span><span class="en">One-line English description</span>
    </p>
  </div>
  <p style="font-size:13px;color:rgba(255,254,225,0.35);margin-top:auto">
    <span class="zh">机密 · 2026年3月</span><span class="en">Confidential · March 2026</span>
  </p>
</div>
```

### Stat Card Grid (4 columns)

```html
<div class="flex-4 mt-32">
  <div class="beat reveal-item">
    <div style="font-size:11px;color:var(--text-light);letter-spacing:1px;margin-bottom:8px">
      <span class="zh">① 标签</span><span class="en">① Label</span></div>
    <div class="beat-num"><span class="zh">4.35<span style="font-size:28px">亿</span></span><span class="en">435<span style="font-size:28px">M</span></span></div>
    <h3><span class="zh">指标名称</span><span class="en">Metric Name</span></h3>
    <p><span class="zh">解释说明</span><span class="en">Explanation</span></p>
  </div>
  <!-- repeat for each stat -->
</div>
```

### Pain Point List

```html
<div class="pain-row reveal-item">
  <div class="pain-icon">🔍</div>
  <div>
    <div class="pain-title"><span class="zh">痛点标题</span><span class="en">Pain Title</span></div>
    <div class="pain-desc"><span class="zh">描述</span><span class="en">Description</span></div>
  </div>
</div>
```

Pain rows: flex row, 16px gap, bottom border 0.5px. Wrap in `.grow` for vertical fill.

### Capability Cards (4 columns)

```html
<div class="flex-4 mt-32 grow">
  <div class="cap-card reveal-item">
    <div class="num mb-8">1</div>
    <h3><span class="zh">能力标题</span><span class="en">Capability Title</span></h3>
    <ul class="cap-items">
      <li><span class="zh">要点</span><span class="en">Point</span></li>
    </ul>
  </div>
</div>
```

`.num`: 32px circle, `var(--red)` bg, `var(--cream)` text. `.cap-items li::before`: red dot prefix.

### Team Cards (3 columns)

```html
<div class="flex-3 mt-32">
  <div class="col center reveal-item">
    <img src="img/name.jpg" style="width:100px;height:100px;border-radius:50%;object-fit:cover" alt="Name">
    <h3 class="mt-16">Name</h3>
    <p style="color:var(--text-light)"><span class="zh">角色</span><span class="en">Role</span></p>
    <p class="mt-8"><span class="zh">简介</span><span class="en">Bio</span></p>
  </div>
</div>
```

### Callout Box

```html
<div style="background:rgba(218,61,61,0.06);padding:16px 24px;border-radius:2px;margin-top:auto">
  <p style="font-size:14px;color:var(--text);font-weight:500;text-align:center">
    <span class="zh">关键洞察</span><span class="en">Key insight</span></p>
</div>
```

Neutral variant: use `background:rgba(0,0,0,0.04)` instead.

### Competition Diff

```html
<div class="diff-row">
  <div class="diff-col them"><h4>Them</h4><p>...</p></div>
  <div class="diff-col us"><h4>Us</h4><p>...</p></div>
</div>
```

`.them`: neutral gray bg. `.us`: primary-tinted bg with red border.

---

## 9. Decorative Elements

**`.gold-line`** -- 48px x 2px gradient (`var(--red)` to `#e8a04c`) with shimmer animation. Section divider.

**`.num`** -- 32px circle, primary bg, cream text. For capability cards and process steps.

**Quadrant chart** -- `.quadrant` (480x360, centered), `.q-axis-x`/`.q-axis-y` crosshairs,
`.q-dot.alter` (primary) / `.q-dot.other` (gray), `.q-label` for axis labels.

**Timeline** -- `.timeline` flex with gradient `::before` line. `.phase` + `.phase-dot` circles
(red/gold/green for phases 1/2/3).

---

## 10. PDF Export Notes

- Slides MUST render at explicit 1280x720 during capture
- Disable CSS transitions (`transition: none !important`) before capture
- Canvas scale: 2x for retina quality
- Watermark: `WATERMARK_TEXT` config, `80px sans-serif`, `rgba(0,0,0,0.04)`, -35deg rotation, tiled 800x360px
- JPEG quality: 0.92
- External images MUST have `crossorigin="anonymous"` for canvas export
- Force all `.reveal-item` visible and `.beat-num` to final values before capture
- Hide auth gate; capture all slides sequentially
