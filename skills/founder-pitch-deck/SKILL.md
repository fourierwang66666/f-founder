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

# founder-pitch-deck: Startup Pitch Deck Generator

Generate a single-file HTML pitch deck that looks like it was designed by a top-tier agency. The workflow walks the founder through 8 steps: design extraction, content input, copy confirmation, narrative review, slide structure design, HTML generation, visual QA, and deployment.

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

### Input Path A: Brand Website URL (preferred)

**Two-phase extraction: visual analysis first, then code parsing.**

#### Phase 1: Visual Analysis (REQUIRED)

**DO THIS NOW:** Call the Skill tool with skill="browse" and navigate to the brand website.

Take these screenshots and visually analyze each one:

1. **Full homepage screenshot** (1280×800) — analyze:
   - Overall visual density: spacious or packed?
   - Color temperature: warm, cool, or neutral?
   - Visual rhythm: how do sections flow? Is there tension or calm?
   - Typography weight: are headings heavy/bold or light/thin?
   - Dark vs light: what is the dominant background treatment?

2. **Header/nav close-up screenshot** — analyze:
   - **Logo**: what does it look like? Is it a wordmark, icon, or combination mark? What colors does it use?
   - Navigation style: minimal or rich?
   - Overall brand tone conveyed by the top-of-page impression

3. **Logo extraction** (while still in browse session) — execute JavaScript in the browser to extract the actual logo asset:
   ```javascript
   // Try multiple common selectors — logos live in many places
   const selectors = [
     'header svg', 'nav svg', '[class*=logo] svg', '[id*=logo] svg',
     'a[href="/"] svg', '.navbar svg', '.brand svg',
     'header img', 'nav img', '[class*=logo] img', '[id*=logo] img',
     'a[href="/"] img', '.navbar img', '.brand img'
   ];
   for (const sel of selectors) {
     const el = document.querySelector(sel);
     if (el) {
       if (el.tagName === 'svg') console.log('SVG:', el.outerHTML);
       else console.log('IMG:', el.src, el.naturalWidth, el.naturalHeight);
     }
   }
   ```
   - **If SVG found**: extract the full `outerHTML` — this is the best case, the logo can be embedded directly in the deck with no external dependency
   - **If `<img>` found**: get the `src` URL. Then download it:
     ```bash
     curl -sL "<logo-url>" -o /tmp/logo-extracted.png  # or .svg
     ```
   - **If nothing found via selectors**: look at the screenshot you took in step 2, describe the logo visually, and ask the founder to provide the logo file directly
   - **Verify**: compare the extracted asset against your header screenshot — does it match what you saw?

4. **Hero section screenshot** — analyze:
   - Hero treatment: image-based, gradient, solid color, or illustration?
   - CTA button styling: color, roundness, shadow
   - Heading size and weight relative to body text
   - Whitespace above and below

5. **One additional page** (e.g., About, Product, or Pricing) — analyze:
   - Is the visual language consistent with the homepage?
   - Any secondary patterns: cards, grids, testimonial blocks?

For each screenshot, write down your visual observations in natural language. These observations are the primary input for design tokens — not CSS parsing.

#### Phase 2: Code Extraction (supplementary)

Use `WebFetch` to grab the homepage HTML and extract **exact values** that support your visual observations:

- **Colors** — hex/RGB values from CSS variables, buttons, backgrounds. Cross-reference with what you SAW in the screenshots.
- **Fonts** — follow the font identification flow below
- **Logo** — already extracted in Phase 1 step 3 via browse JS. If that failed, search the HTML for `<img>` tags with "logo" in src/alt/class, or `<svg>` elements in the `<header>`. WebFetch is a fallback — browse JS extraction is more reliable because it sees the rendered DOM including dynamically loaded elements.

**Font extraction flow** (goal: use the EXACT same fonts as the brand, not substitutes):

**Step 1: Extract font declarations via browse JS** (while still in the browse session from Phase 1):

```javascript
// Extract all @font-face declarations and their source URLs
const fonts = [];
for (const sheet of document.styleSheets) {
  try {
    for (const rule of sheet.cssRules) {
      if (rule instanceof CSSFontFaceRule) {
        fonts.push({
          family: rule.style.getPropertyValue('font-family').replace(/['"]/g, ''),
          src: rule.style.getPropertyValue('src'),
          weight: rule.style.getPropertyValue('font-weight'),
          style: rule.style.getPropertyValue('font-style')
        });
      }
    }
  } catch(e) {} // CORS-blocked sheets will throw
}
// Also get computed fonts on key elements
const heading = document.querySelector('h1, h2, .hero-title, [class*=heading]');
const body = document.querySelector('p, .body-text, article');
console.log('FONTS:', JSON.stringify(fonts));
if (heading) console.log('HEADING_FONT:', getComputedStyle(heading).fontFamily, getComputedStyle(heading).fontWeight);
if (body) console.log('BODY_FONT:', getComputedStyle(body).fontFamily, getComputedStyle(body).fontWeight);
```

**Step 2: Determine font source and extract** (in priority order):

1. **Google Fonts `<link>` tag** — parse the URL for family names and weights. Best case: directly reusable via the same `<link>` tag in the deck. No download needed.

2. **`@font-face` with downloadable URLs** — if the JS extraction found `@font-face` rules with `url(...)` sources (WOFF2/WOFF/TTF files):
   ```bash
   # Download each font file
   curl -sL "https://example.com/fonts/brand-regular.woff2" -o /tmp/brand-regular.woff2
   curl -sL "https://example.com/fonts/brand-bold.woff2" -o /tmp/brand-bold.woff2
   # Base64 encode for embedding
   base64 -i /tmp/brand-regular.woff2 | tr -d '\n' > /tmp/brand-regular.b64
   ```
   Then embed in the deck's CSS as:
   ```css
   @font-face {
     font-family: 'BrandFont';
     src: url(data:font/woff2;base64,<base64-data>) format('woff2');
     font-weight: 400;
   }
   ```
   **This gives 100% identical fonts** — no substitution, no visual difference from the original site.

3. **Third-party font services** (Adobe Fonts, Monotype, fonts.com) — these often block direct download. If the `@font-face` URLs return 403/CORS errors:
   - Try downloading with the site's `Referer` header: `curl -sL -H "Referer: https://example.com" "<font-url>"`
   - If still blocked → fall through to step 4

4. **Google Fonts match** — search Google Fonts for the exact font name. Many commercial fonts have open-source versions or are available on Google Fonts.

5. **Substitution Table fallback** — ONLY if steps 1-4 all fail. Look up in `references/font-system.md` Section 4. Explain: "Your site uses '{BrandFont}' which I couldn't download or find on Google Fonts. '{Substitute}' has very similar proportions — shall I use that, or can you provide the font files directly?"

**Step 3: Extract typography details** (from the same browse JS results):

- **Weight** — heading weight (500? 600? 700?) and body weight (300? 400?) from `getComputedStyle`
- **Letter-spacing** — especially negative tracking on headings (-0.5px to -1px)
- **Line-height** — body text line-height (1.5-1.7 is standard)
- **Font-size ratio** — heading size vs body size (helps reproduce the visual hierarchy)

#### Phase 3: Present Visual Summary

Present to the founder:
1. The screenshots you took (so they can verify you saw the right thing)
2. Your visual observations in plain language: "Your brand feels X — Y colors, Z typography style, with a W overall mood"
3. The extracted design tokens for confirmation
4. The logo: show what you extracted — if SVG, show a snippet of the SVG code and confirm it's the right logo; if image, show the URL and file size. If extraction failed, show the header screenshot and ask the founder to provide the logo file directly.

**Wait for founder confirmation before proceeding.**

### Input Path A2: Reference Deck URL or File

If the founder provides a reference deck (another company's pitch deck, a PDF, or a URL to an existing deck):

**DO THIS NOW:** Call the Skill tool with skill="browse" and navigate to the reference deck.

1. Screenshot **every slide** (or at least 5-6 representative slides)
2. For each slide, analyze:
   - Color palette in use (backgrounds, text, accents)
   - Typography: heading vs body weight, size ratio, font style (geometric, humanist, serif)
   - Layout patterns: centered vs left-aligned, use of grids, whitespace ratio
   - Visual elements: charts, icons, photos, illustrations — what style?
   - Slide transitions: dark/light alternation pattern
3. Write a **design language summary**: "This deck uses a [mood] aesthetic — [description of colors], [typography feel], [layout approach], [notable visual techniques]"
4. Extract actionable design tokens from the visual analysis

This is how you capture the "feel" of a Harvey deck vs a HappyCappy deck — by actually looking at them, not reading their source code.

### Input Path B: Brand Guideline PDF

Use the `pdf` skill to parse. Look for:
- Color palette section (hex values, RGB, or named swatches)
- Typography section (font names, weights, sizes) -- cross-reference with Substitution Table if fonts are commercial
- Logo usage section (grab a logo asset URL or path)

If the PDF contains visual examples (mockups, slide samples), use the `Read` tool to view the PDF pages as images and visually analyze the design language — same as Path A Phase 1.

### Input Path C: Interactive Q&A

If no source is available, ask the founder five questions:

1. **Primary color** -- "What is your brand's primary color? (hex code, or I can pick from your logo)"
2. **Style mood** -- present options:
   - `minimal` -- lots of whitespace, restrained palette, clean lines
   - `bold` -- saturated colors, large type, high contrast
   - `elegant` -- serif fonts, muted tones, editorial feel
   - `tech` -- dark backgrounds, monospace accents, gradient highlights
3. **Font pairing** -- present 3 curated options from the **Mood-Based Pairing Library** (`references/font-system.md` Section 2), each with a description of feel and best-fit industry. Example:
   > Option 1 (Recommended): Inter + Noto Sans SC — clean, universally readable. Used by Linear, Vercel, Stripe.
   > Option 2: DM Sans + Noto Sans SC — slightly warmer, more personality.
   > Option 3: Plus Jakarta Sans + Noto Sans SC — geometric and friendly, modern startup feel.
   > Or name your own font and I'll find the closest Google Fonts match.
4. **CJK requirement** -- Simplified Chinese (SC), Traditional Chinese (TC), Japanese (JP), or none
5. **Company name** -- for cover slide and watermark text

### Input Path D: Logo File Provided Directly

If the founder provides a logo file (SVG, PNG, PDF):

1. **Read the file visually** using the `Read` tool (for images/PDFs) to see the actual logo
2. Extract colors from the logo — these are the most authoritative brand colors
3. Analyze the logo style to inform mood: geometric logo → tech/minimal mood, handwritten → elegant, bold shapes → bold
4. Store the logo path or base64-encode it for embedding in the deck

### Output: Design Tokens

```json
{
  "colors": {
    "primary": "#da3d3d",
    "accent": "#0f8e61",
    "bg": "#faf9f6",
    "text": "rgba(0,0,0,0.82)",
    "darkBg": "#1a1a2e",
    "darkText": "rgba(255,255,255,0.9)"
  },
  "fonts": {
    "heading": "BrandHeading",
    "body": "BrandBody",
    "cjk": "Noto Sans SC",
    "headingWeight": "600",
    "bodyWeight": "400",
    "letterSpacingHeading": "-0.5px",
    "lineHeightBody": "1.65",
    "source": "embedded",
    "embeddedFonts": [
      { "family": "BrandHeading", "weight": "600", "file": "/tmp/brand-heading-semibold.woff2" },
      { "family": "BrandBody", "weight": "400", "file": "/tmp/brand-body-regular.woff2" }
    ],
    "googleFontsUrl": "Noto+Sans+SC:wght@400;700"
  },
  "mood": "minimal",
  "visualSummary": "Clean, spacious design with generous whitespace. Warm off-white backgrounds (#faf9f6), dark text with slight transparency. Headlines use medium-weight Inter with tight tracking. Hero section uses a muted photo with text overlay. CTAs are rounded pills in brand red. Overall feel: confident restraint.",
  "logo": "https://example.com/logo.svg",
  "logoSvg": "<svg>...</svg>",
  "companyName": "ExampleCo",
  "watermark": "ExampleCo Confidential"
}
```

**`visualSummary`** is the most important field — it captures what you SAW, not what you parsed. This drives all downstream design decisions. If the visual summary doesn't match the hex values, trust the visual summary.

**`fonts.source`** — one of:
- `"embedded"` — font files downloaded and will be base64-embedded in the HTML (best: 100% identical fonts)
- `"google"` — using Google Fonts CDN link (good: exact match if the brand uses Google Fonts)
- `"substituted"` — using a substitute from the Substitution Table (fallback: close but not identical)

**`fonts.embeddedFonts`** — array of downloaded font files to base64-encode into the deck's `@font-face`. Only present when `source` is `"embedded"`.

**`logoSvg`** — if the logo is an inline SVG on the website, extract the full SVG code here. This allows embedding the actual logo in the deck without external dependencies. If the logo is a raster image (PNG/JPG), use the `logo` URL field instead.

Store these tokens in memory -- they feed into Step 6.

**References:**
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

## Step 3 -- Copy Confirmation

Compile all slide text into a clean document for the founder to review and approve. **Do NOT proceed to narrative review until the founder confirms the copy.**

### 3a. Generate copy document

Create a file `copy.md` in the project directory with:

```markdown
# [Company Name] Pitch Deck — Final Copy

## Slide 1: Cover
- Title: ...
- Subtitle: ...
- Tagline: ...

## Slide 2: Problem
- Eyebrow: PROBLEM
- Headline: ...
- Bullet 1: ...
- Bullet 2: ...
- Bullet 3: ...
- Supporting stat: ...
- Source: ...

## Slide 3: Solution
...

(continue for all slides)
```

For each slide, include:
- Every piece of visible text (headline, bullets, stats, sources, footnotes)
- Data points with their sources
- Any text that will appear in both ZH and EN (mark which is the primary language)
- Placeholders for visual elements: `[CHART: 2x2 competitive quadrant]`, `[DIAGRAM: user flow]`, `[PHOTO: team headshots]`

### 3b. Present to founder

Tell the founder:
> Here is the complete copy for all slides. Please review carefully:
> - Are all data points accurate and sourced?
> - Is the narrative flow correct?
> - Any text you want to change?
>
> You can edit `copy.md` directly and tell me when you are done, or tell me what to change.

Wait for the founder to confirm. Apply any edits they request. Re-present if changes are significant.

### 3c. Lock copy

Once confirmed, this copy becomes the source of truth for the rest of the workflow. Any later changes require coming back to this step.

---

## Step 4 -- Narrative Review

**IMPORTANT: You MUST attempt to invoke the `office-hours` skill before falling back to self-review. Do NOT skip this step.**

Run the narrative review on the **confirmed copy** (from Step 3's `copy.md`), not the raw outline.

### 4a. Invoke office-hours (REQUIRED first attempt)

**DO THIS NOW:** Call the Skill tool with skill="office-hours" and args="startup mode — review this pitch deck copy for investment readiness". Pass the full `copy.md` content in the args.

office-hours will stress-test six dimensions:

1. **Demand Reality** -- Is the market real? Are the data sources credible and recent?
2. **Status Quo** -- How do people solve this today? Why is the current way tolerable?
3. **Desperate Specificity** -- Is the target customer specific enough to find and sell to?
4. **Narrowest Wedge** -- Is the entry point focused enough to win against incumbents?
5. **Observation** -- What unique insight or unfair advantage backs this company?
6. **Future-fit** -- Does this hold in 5 years, or will a platform shift kill it?

After the review, present the critique to the founder. Iterate:
1. Founder revises specific slides or bullets in `copy.md`
2. Re-run the review on changed sections only
3. Confirm final copy

### 4b. Fallback (ONLY if office-hours skill is not installed)

If the Skill tool returns an error indicating office-hours is not available, THEN perform a self-review covering:
- **Data credibility** -- are stats sourced? Are sources recent (< 2 years old)?
- **Narrative flow** -- does the story build logically from problem to ask?
- **Specificity** -- are claims vague ("huge market") or precise ("$4.35B TAM in SEA freelancer payments")?
- **Missing slides** -- is there a clear ask? Is team slide present? Is competition addressed honestly?

Tell the founder: "The office-hours skill is not installed, so I performed a lightweight review. For a deeper YC-style critique, install Gstack and re-run Step 4."

---

## Step 5 -- Slide Structure Design

Before writing HTML, design the visual layout of each slide using markdown mockups. This step catches layout problems early — before they become expensive HTML rewrites.

### 5a. Design each slide layout

For each slide, create an ASCII/markdown wireframe showing element placement. Present them to the founder one by one or in batches.

**Example formats:**

Simple stat slide:
```
┌─────────────────────────────────┐
│  EYEBROW                        │
│                                 │
│  Big Headline Text              │
│                                 │
│  ┌────────┐ ┌────────┐ ┌─────┐ │
│  │ $4.35B │ │  120M  │ │ 47% │ │
│  │  TAM   │ │ users  │ │ CAGR│ │
│  └────────┘ └────────┘ └─────┘ │
│                                 │
│  Source: Grand View Research    │
└─────────────────────────────────┘
```

Competition quadrant chart:
```
┌─────────────────────────────────┐
│  COMPETITIVE LANDSCAPE          │
│                                 │
│  "Purpose-Built for X"          │
│                                 │
│        ▲ Full-stack             │
│        │                        │
│   ○D   │        ★ Us           │
│        │                        │
│  ──────┼──────────▶ Specialized │
│        │                        │
│   ○A   │   ○B      ○C          │
│        │                        │
│        ▼ Point solution         │
│                                 │
│  ○A=Competitor  ○B=Comp2  ...   │
└─────────────────────────────────┘
```

Team slide with photos:
```
┌─────────────────────────────────┐
│  TEAM                           │
│                                 │
│  ┌──────┐  ┌──────┐  ┌──────┐  │
│  │[photo]│  │[photo]│  │[photo]│ │
│  │ Name  │  │ Name  │  │ Name  │ │
│  │ Role  │  │ Role  │  │ Role  │ │
│  │ Bio   │  │ Bio   │  │ Bio   │ │
│  └──────┘  └──────┘  └──────┘  │
└─────────────────────────────────┘
```

### 5b. Handle visual elements

For slides that need charts, diagrams, or illustrations:

1. **Quadrant / positioning charts** — design as pure CSS (positioned dots + axis labels). Show the mockup and confirm axis labels + competitor placement with founder.
2. **Flow diagrams** — design as flexbox with arrow connectors (CSS `::after` triangles). Show the flow sequence for confirmation.
3. **Comparison tables** — design column structure, confirm which features/competitors to include.
4. **Timeline / milestones** — design as horizontal or vertical sequence. Confirm milestone items.
5. **Bar/pie charts** — design as CSS shapes (no JS charting library). Confirm data values.

For each visual element, present the mockup and ask:
> Does this layout capture what you want to show? Any changes to the positioning or labels?

### 5c. Confirm all structures

After all slide wireframes are reviewed, present a summary:
> All slide layouts confirmed. Proceeding to HTML generation.
> - X slides with standard text layout
> - Y slides with custom visual elements (charts, diagrams, etc.)

**Do NOT proceed to HTML until the founder approves all slide structures.**

---

## Step 6 -- HTML Generation

Three-layer build process. All output goes into a single `index.html` file.

### Layer 1: Engine Setup

1. Read `assets/base-template.html` -- the full HTML engine with auth gate, navigation, bilingual toggle, PDF export, and responsive scaling already built in.
2. Replace all `{{PLACEHOLDER}}` tokens with design values:
   - `{{DECK_PASSWORD}}` -- investor access code (ask founder, default: company name lowercase)
   - `{{DECK_TITLE}}` -- company name or deck title
   - `{{WATERMARK_TEXT}}` -- confidential watermark for PDF export
   - `{{PRIMARY_COLOR}}`, `{{ACCENT_COLOR}}`, `{{BG_COLOR}}`, `{{TEXT_COLOR}}` -- from design tokens
   - `{{HEADING_FONT}}`, `{{BODY_FONT}}` -- from design tokens
   - `{{GOOGLE_FONTS_URL}}` -- constructed from chosen fonts
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

## Step 7 -- Visual QA

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

## Step 8 -- Deployment

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

---

## Slide HTML Conventions (Cheat Sheet)

Quick reference for generating slide markup. Full details in `references/html-engine.md`.

### Slide Types

```html
<div class="slide">           <!-- light background (default) -->
<div class="slide dark">      <!-- dark background -->
<div class="slide red">       <!-- primary color background -->
```

### Bilingual Text

Every visible text element uses paired spans:
```html
<span class="zh">中文</span><span class="en">English</span>
```

The CSS hides one language based on `body.lang-zh` or `body.lang-en` class. The toggle button switches the class.

### Layout

```html
<div class="flex">
  <div class="col">Left column</div>
  <div class="col">Right column</div>
</div>
```

Three columns: add a third `.col`. Unequal widths: use inline `flex` values.

### Stat Card

```html
<div class="beat-num">
  <span class="zh"><span class="stat-big">4.35</span><span>亿</span></span>
  <span class="en"><span class="stat-big">435</span><span>M</span></span>
</div>
<div class="stat-label">
  <span class="zh">全球自由职业者</span>
  <span class="en">Global Freelancers</span>
</div>
```

`.beat-num` triggers the count-up animation. `.stat-big` uses the heading font at a large size.

### Eyebrow Label

```html
<div class="eyebrow">
  <span class="zh">市场规模</span>
  <span class="en">MARKET SIZE</span>
</div>
```

Small uppercase label above a section title.

### Staggered Reveal

```html
<div class="reveal-item">First (appears at 0.1s)</div>
<div class="reveal-item">Second (appears at 0.22s)</div>
<div class="reveal-item">Third (appears at 0.34s)</div>
```

Each `.reveal-item` gets a CSS custom property `--i` set automatically by JS. The stagger delay is `calc(0.1s + var(--i) * 0.12s)`.

### Common Slide Patterns

**Cover slide:** `.slide.dark` with `.logo` img, `<h1>` tagline, `.subtitle` paragraph.

**Team slide:** `.slide` with `.eyebrow` + `<h2>`, then `.flex` grid of `.team-member` items each containing `.avatar` img, name, title, and bio spans.

**Ask slide:** `.slide.red` with `<h2>` title, `.beat-num` for the funding amount, `.stat-label`, and a `.reveal-item` `<ul>` for fund allocation breakdown.

---

## Error Handling

- **Font loading failure** -- all `font-family` declarations include system font fallbacks
- **Image loading failure** -- use `onerror` to swap to a colored placeholder div
- **Auth bypass attempt** -- deck content is present in DOM but fully hidden via CSS until auth succeeds; no security-critical data should rely solely on client-side auth
- **Print issues** -- `@media print` stylesheet hides navigation, auth gate, and animations; forces all slides to page-break layout
- **Offline viewing** -- works fully offline except Google Fonts (falls back to system fonts)

---

## File Structure

After generation, the project directory contains:

```
project/
  index.html          # The complete pitch deck (single file)
  outline.md          # Slide outline used for generation (kept for reference)
```

No build step. No `node_modules`. No framework. Just open `index.html`.
