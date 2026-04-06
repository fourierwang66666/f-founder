# Brand Extraction Reference

Detailed procedures for extracting design tokens from various sources. Read this when executing Step 1 of the workflow.

---

## 1. Brand Website URL (Path A)

Three-phase extraction: visual first, then code, then present.

### Phase 1: Visual Analysis (REQUIRED)

**Call the Skill tool** with skill="browse" and navigate to the brand website.

Take these screenshots and visually analyze each one:

1. **Full homepage** (1280×800) — visual density, color temperature, typography weight, dark vs light
2. **Header/nav close-up** — logo appearance (wordmark/icon/combo), nav style, brand tone
3. **Logo extraction** — execute JS in the browse session:
   ```javascript
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
   - **SVG found**: extract `outerHTML` for direct embedding
   - **`<img>` found**: download via `curl -sL "<url>" -o /tmp/logo.png`
   - **Nothing found**: describe from screenshot, ask founder for file
   - **Verify**: compare extracted asset against header screenshot
4. **Hero section** — hero treatment, CTA styling, heading weight, whitespace
5. **One additional page** — consistency check, secondary patterns

Write visual observations in natural language for each screenshot. These drive design tokens.

### Phase 2: Code Extraction (supplementary)

Use `WebFetch` to grab homepage HTML. Extract exact values supporting visual observations:

- **Colors** — hex/RGB from CSS variables, buttons, backgrounds
- **Logo** — fallback if Phase 1 JS extraction failed
- **Fonts** — follow the font identification flow below

#### Font Extraction Flow

Goal: use the EXACT same fonts as the brand, not substitutes.

**Step 1: Extract via browse JS:**
```javascript
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
  } catch(e) {}
}
const heading = document.querySelector('h1, h2, .hero-title, [class*=heading]');
const body = document.querySelector('p, .body-text, article');
console.log('FONTS:', JSON.stringify(fonts));
if (heading) console.log('HEADING_FONT:', getComputedStyle(heading).fontFamily, getComputedStyle(heading).fontWeight);
if (body) console.log('BODY_FONT:', getComputedStyle(body).fontFamily, getComputedStyle(body).fontWeight);
```

**Step 2: Determine font source** (in priority order):

1. **Google Fonts `<link>` tag** — parse URL for families and weights. Directly reusable.
2. **`@font-face` with downloadable URLs** — download WOFF2/WOFF files and base64-encode:
   ```bash
   curl -sL "https://example.com/fonts/brand-regular.woff2" -o /tmp/brand-regular.woff2
   base64 -i /tmp/brand-regular.woff2 | tr -d '\n' > /tmp/brand-regular.b64
   ```
   Embed as:
   ```css
   @font-face {
     font-family: 'BrandFont';
     src: url(data:font/woff2;base64,<base64-data>) format('woff2');
     font-weight: 400;
   }
   ```
3. **Third-party font services** (Adobe Fonts, Monotype) — try with Referer header: `curl -sL -H "Referer: https://example.com" "<font-url>"`
4. **Google Fonts match** — search for the exact font name on Google Fonts
5. **Substitution Table fallback** — ONLY if steps 1-4 fail. Use `references/font-system.md` Section 4. Explain the substitution to the founder.

**Step 3: Extract typography details:**
- Weight: heading (500-700) and body (300-400) from `getComputedStyle`
- Letter-spacing: especially negative tracking on headings
- Line-height: body 1.5-1.7 is standard
- Font-size ratio: heading vs body

### Phase 3: Present Visual Summary

Present to the founder:
1. Screenshots (so they can verify)
2. Visual observations: "Your brand feels X — Y colors, Z typography, W mood"
3. Extracted design tokens
4. Logo: SVG snippet or image URL

**Wait for confirmation before proceeding.**

---

## 2. Reference Deck (Path A2)

**Call the Skill tool** with skill="browse" and navigate to the reference deck.

1. Screenshot every slide (or 5-6 representative ones)
2. For each: color palette, typography, layout patterns, visual elements, dark/light alternation
3. Write a design language summary: "This deck uses a [mood] aesthetic — [colors], [typography], [layout], [techniques]"
4. Extract actionable design tokens

This captures the "feel" of a deck — by looking at it, not reading its source code.

---

## 3. Brand Guideline PDF (Path B)

Use the `pdf` skill to parse. Look for:
- Color palette section (hex, RGB, named swatches)
- Typography section (font names, weights, sizes) — cross-reference with Substitution Table
- Logo usage section

If the PDF has visual examples, use `Read` tool to view pages as images and analyze the design language.

---

## 4. Logo File Provided Directly (Path D)

1. **Read visually** using the `Read` tool
2. Extract colors — these are the most authoritative brand colors
3. Analyze logo style to inform mood: geometric → tech/minimal, handwritten → elegant, bold → bold
4. Store path or base64-encode for embedding

---

## 5. Design Token Output Schema

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
  "visualSummary": "Clean, spacious design with generous whitespace...",
  "logo": "https://example.com/logo.svg",
  "logoSvg": "<svg>...</svg>",
  "companyName": "ExampleCo",
  "watermark": "ExampleCo Confidential"
}
```

**Key fields:**

- **`visualSummary`** — most important. Captures what you SAW. If it conflicts with hex values, trust the visual summary.
- **`fonts.source`** — `"embedded"` (base64 in HTML), `"google"` (CDN link), or `"substituted"` (fallback)
- **`fonts.embeddedFonts`** — downloaded font files to base64-encode. Only when source is `"embedded"`.
- **`logoSvg`** — inline SVG for embedding. If raster, use `logo` URL instead.
