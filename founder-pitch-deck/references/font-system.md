# Font System Reference

Fonts are the single biggest lever for perceived design quality. A wrong font
destroys brand consistency faster than a wrong color. This reference covers:
identification, pairing, loading, and typographic fine-tuning.

---

## 1. Font Identification (from brand website)

When extracting fonts from a URL via `WebFetch`, check these sources **in order**:

### 1a. Google Fonts `<link>` tag

```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">
```

Parse the URL to extract:
- Family names (`Inter`, `Noto Sans SC`)
- Weights (`400`, `500`, `700`)
- This is the best case — the font is already on Google Fonts and easy to replicate.

### 1b. `@font-face` in `<style>` or linked CSS

```css
@font-face {
  font-family: 'BrandSans';
  src: url('/fonts/BrandSans-Medium.woff2') format('woff2');
  font-weight: 500;
}
```

Extract: family name, weight, format. This tells you the **exact** font but it
may be a commercial/proprietary font not available on Google Fonts.

### 1c. CSS `font-family` stacks

```css
body { font-family: 'PingFang SC', 'Helvetica Neue', Arial, sans-serif; }
h1   { font-family: 'Playfair Display', 'Songti SC', Georgia, serif; }
```

The first name in the stack is the intended font. System fonts (PingFang,
SF Pro, Segoe UI) tell you the **mood** but can't be replicated via Google Fonts.

### 1d. Font detection decision tree

```
Found Google Fonts <link>?
  → YES: Extract families + weights. Done.
  → NO: Found @font-face?
    → YES: Note the font name. Search Google Fonts for exact match.
      → Found: Use it.
      → Not found: Look up in Substitution Table (Section 4).
    → NO: Found CSS font-family?
      → YES: Note first family. Search Google Fonts or Substitution Table.
      → NO: Fall back to Mood-Based Pairing (Section 3).
```

### What to extract (complete checklist)

| Property | Where to find | Example |
|----------|--------------|---------|
| Heading font | `h1, h2, h3` font-family | `'Playfair Display'` |
| Body font | `body, p` font-family | `'Inter'` |
| Heading weight | `h1` font-weight or Google Fonts URL `wght@` | `700` |
| Body weight | `body` font-weight | `400` |
| Letter-spacing | `h1` letter-spacing | `-0.5px` |
| Line-height | `body` or `p` line-height | `1.6` |
| CJK font | Look for SC/TC/JP/KR font in stack | `'Noto Sans SC'` |

---

## 2. Curated Font Pairings (Google Fonts guaranteed)

Every pairing below is confirmed available on Google Fonts with CJK support.
Format: `heading / body / CJK` with recommended weights.

### Minimal

Clean, modern, lots of whitespace. Restrained personality.

| # | Heading | Body | CJK | Weights | Google Fonts URL snippet |
|---|---------|------|-----|---------|--------------------------|
| M1 | Inter | Inter | Noto Sans SC | 400,500,700 | `Inter:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |
| M2 | DM Sans | DM Sans | Noto Sans SC | 400,500,700 | `DM+Sans:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |
| M3 | Plus Jakarta Sans | Plus Jakarta Sans | Noto Sans SC | 400,500,700 | `Plus+Jakarta+Sans:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |
| M4 | Outfit | Outfit | Noto Sans SC | 300,400,600 | `Outfit:wght@300;400;600&family=Noto+Sans+SC:wght@400;700` |

**Typographic settings:**
```css
h1 { font-weight: 600; letter-spacing: -0.5px; line-height: 1.2; }
h2 { font-weight: 600; letter-spacing: -0.3px; line-height: 1.25; }
p  { font-weight: 400; letter-spacing: 0; line-height: 1.65; }
```

### Bold

High-impact, saturated, unapologetic. Big type, strong contrast.

| # | Heading | Body | CJK | Weights | Google Fonts URL snippet |
|---|---------|------|-----|---------|--------------------------|
| B1 | Space Grotesk | Inter | Noto Sans SC | 400,500,700 | `Space+Grotesk:wght@500;700&family=Inter:wght@400;500&family=Noto+Sans+SC:wght@400;700` |
| B2 | Sora | DM Sans | Noto Sans SC | 400,600,700 | `Sora:wght@600;700&family=DM+Sans:wght@400;500&family=Noto+Sans+SC:wght@400;700` |
| B3 | Lexend | Lexend | Noto Sans SC | 400,500,700 | `Lexend:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |
| B4 | Urbanist | Inter | Noto Sans SC | 400,600,800 | `Urbanist:wght@600;800&family=Inter:wght@400;500&family=Noto+Sans+SC:wght@400;700` |

**Typographic settings:**
```css
h1 { font-weight: 700; letter-spacing: -1px; line-height: 1.1; }
h2 { font-weight: 700; letter-spacing: -0.5px; line-height: 1.15; }
p  { font-weight: 400; letter-spacing: 0; line-height: 1.6; }
```

### Elegant

Editorial feel. Serif headings, refined spacing. Muted sophistication.

| # | Heading | Body | CJK | Weights | Google Fonts URL snippet |
|---|---------|------|-----|---------|--------------------------|
| E1 | Cormorant Garamond | Inter | Noto Serif SC | 400,500,600 | `Cormorant+Garamond:wght@500;600&family=Inter:wght@400;500&family=Noto+Serif+SC:wght@400;700` |
| E2 | Playfair Display | DM Sans | Noto Serif SC | 400,500,700 | `Playfair+Display:wght@500;700&family=DM+Sans:wght@400;500&family=Noto+Serif+SC:wght@400;700` |
| E3 | Lora | Lora | Noto Serif SC | 400,500,600 | `Lora:wght@400;500;600&family=Noto+Serif+SC:wght@400;700` |
| E4 | EB Garamond | Inter | Noto Serif SC | 400,500,700 | `EB+Garamond:wght@500;700&family=Inter:wght@400;500&family=Noto+Serif+SC:wght@400;700` |

**Typographic settings:**
```css
h1 { font-weight: 500; letter-spacing: -0.3px; line-height: 1.2; }
h2 { font-weight: 500; letter-spacing: 0; line-height: 1.3; }
p  { font-weight: 400; letter-spacing: 0.2px; line-height: 1.7; }
```

### Tech

Dark-first, monospace accents, gradient-friendly. Developer/AI/SaaS vibe.

| # | Heading | Body | CJK | Weights | Google Fonts URL snippet |
|---|---------|------|-----|---------|--------------------------|
| T1 | JetBrains Mono | Inter | Noto Sans SC | 400,500,700 | `JetBrains+Mono:wght@500;700&family=Inter:wght@400;500&family=Noto+Sans+SC:wght@400;700` |
| T2 | Space Grotesk | Space Grotesk | Noto Sans SC | 400,500,700 | `Space+Grotesk:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |
| T3 | IBM Plex Sans | IBM Plex Mono | Noto Sans SC | 400,500,600 | `IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&family=Noto+Sans+SC:wght@400;700` |
| T4 | Geist Mono | Inter | Noto Sans SC | 400,500,700 | `Inter:wght@400;500;700&family=Noto+Sans+SC:wght@400;700` |

> Note: Geist Mono is not on Google Fonts. T4 uses Inter as fallback; if the
> founder wants a mono heading font, recommend T1 (JetBrains Mono) instead.

**Typographic settings:**
```css
h1 { font-weight: 500; letter-spacing: -0.5px; line-height: 1.15; }
h2 { font-weight: 500; letter-spacing: -0.3px; line-height: 1.2; }
p  { font-weight: 400; letter-spacing: 0; line-height: 1.6; }
.eyebrow { font-family: 'JetBrains Mono', 'IBM Plex Mono', monospace; font-size: 11px; letter-spacing: 2px; }
```

### Japanese-Friendly

For decks targeting JP investors or bilingual ZH/JP/EN.

| # | Heading | Body | CJK | Weights | Google Fonts URL snippet |
|---|---------|------|-----|---------|--------------------------|
| J1 | Kiwi Maru | Noto Sans JP | Noto Sans JP | 400,500 | `Kiwi+Maru:wght@400;500&family=Noto+Sans+JP:wght@400;700` |
| J2 | Zen Maru Gothic | Noto Sans JP | Noto Sans JP | 400,500,700 | `Zen+Maru+Gothic:wght@400;500;700&family=Noto+Sans+JP:wght@400;700` |

---

## 3. Mood → Default Pairing Map

When the founder picks a mood but has no font preference, use these defaults:

| Mood | Default Pairing | Why |
|------|----------------|-----|
| `minimal` | M1 (Inter + Noto Sans SC) | Universally clean, excellent CJK support, no personality friction |
| `bold` | B1 (Space Grotesk + Inter + Noto Sans SC) | Geometric with character, reads well at large sizes |
| `elegant` | E1 (Cormorant Garamond + Inter + Noto Serif SC) | Classic editorial quality, excellent contrast with sans body |
| `tech` | T1 (JetBrains Mono + Inter + Noto Sans SC) | Immediately signals developer/tech without being gimmicky |

---

## 4. Font Substitution Table

When the brand uses a commercial/proprietary font, find the closest Google Fonts match.

### Sans-Serif

| Commercial Font | Google Fonts Substitute | Notes |
|----------------|------------------------|-------|
| Helvetica / Helvetica Neue | Inter | Closest in metrics and feel |
| San Francisco (SF Pro) | Inter | Apple system font → Inter is the standard sub |
| Avenir / Avenir Next | Nunito Sans | Similar geometric humanist proportions |
| Futura | Outfit | Geometric sans, similar x-height |
| Proxima Nova | Montserrat | Very close metrics and weight range |
| Gotham | Plus Jakarta Sans | Similar proportions, slightly warmer |
| Circular | DM Sans | Geometric with similar roundness |
| Graphik | Inter | Neutral grotesque, Inter is the safe match |
| Gilroy | Lexend | Similar weight range and geometric feel |
| Aktiv Grotesk | Inter | Neutral grotesque family |
| Brandon Grotesque | Josefin Sans | Similar geometric with low x-height |
| Calibri | Source Sans 3 | System font replacement |
| Segoe UI | Noto Sans | Microsoft system font → Noto is closest |
| PingFang SC | Noto Sans SC | Apple CJK system font |
| Microsoft YaHei | Noto Sans SC | Windows CJK system font |

### Serif

| Commercial Font | Google Fonts Substitute | Notes |
|----------------|------------------------|-------|
| Times New Roman | Lora | Warmer and more modern than TNR |
| Georgia | Merriweather | Designed for screen, similar warmth |
| Garamond (any) | EB Garamond | Direct open-source Garamond |
| Baskerville | Libre Baskerville | High-quality screen Baskerville |
| Didot / Bodoni | Playfair Display | High-contrast didone style |
| Minion Pro | Crimson Pro | Similar old-style proportions |
| Caslon | Libre Caslon Text | Direct open-source Caslon |
| Sabon | Cormorant Garamond | Elegant Garamond variant |
| Songti SC | Noto Serif SC | Apple CJK serif → Google equivalent |
| SimSun / NSimSun | Noto Serif SC | Windows CJK serif |

### Monospace

| Commercial Font | Google Fonts Substitute | Notes |
|----------------|------------------------|-------|
| SF Mono | JetBrains Mono | Similar proportions and readability |
| Menlo / Monaco | JetBrains Mono | macOS mono → JetBrains is closest modern match |
| Consolas | IBM Plex Mono | Windows mono, similar metrics |
| Fira Code | Fira Code | Same font, available on Google Fonts |
| Source Code Pro | Source Code Pro | Same font, available on Google Fonts |

---

## 5. CJK Font Selection

### Chinese (Simplified)

| Style | Font | Google Fonts | Notes |
|-------|------|-------------|-------|
| Sans | Noto Sans SC | Yes | Default for all CJK. Clean, complete coverage |
| Serif | Noto Serif SC | Yes | For elegant mood or editorial decks |
| Rounded | ZCOOL XiaoWei | Yes | Friendly, consumer-facing brands |

### Chinese (Traditional)

| Style | Font | Google Fonts | Notes |
|-------|------|-------------|-------|
| Sans | Noto Sans TC | Yes | For TW/HK audiences |
| Serif | Noto Serif TC | Yes | For formal/elegant TW/HK decks |

### Japanese

| Style | Font | Google Fonts | Notes |
|-------|------|-------------|-------|
| Sans | Noto Sans JP | Yes | Standard clean JP sans |
| Rounded | Zen Maru Gothic | Yes | Friendly, startup-friendly |
| Handwritten feel | Kiwi Maru | Yes | Warm, distinctive personality |

**Rule:** Always load the CJK font alongside the Latin font. CJK fonts are
large (2-5MB), so only load the weights you actually use (typically 400 + 700).

---

## 6. Google Fonts URL Construction

Build the `<link>` tag from selected fonts:

```
https://fonts.googleapis.com/css2?family={HEADING}:wght@{WEIGHTS}&family={BODY}:wght@{WEIGHTS}&family={CJK}:wght@{WEIGHTS}&display=swap
```

**Example** (Minimal M1):
```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">
```

**Rules:**
- Always add `&display=swap` for FOUT prevention
- Replace spaces with `+` in font names
- Only include weights you actually use (smaller payload)
- For CJK: limit to `400;700` unless the design specifically needs 300 or 500

### Font stack construction for `--font-main`

```
'{Heading}', '{CJK}', system-ui, sans-serif
```

For mixed heading/body:
```css
--font-heading: '{Heading}', '{CJK}', system-ui, sans-serif;
--font-body: '{Body}', '{CJK}', system-ui, sans-serif;
```

---

## 7. Typography Fine-Tuning Checklist

After selecting fonts, verify these details for the design tokens:

| Property | What to check | Common pitfall |
|----------|--------------|----------------|
| `font-weight` heading | Should match brand (500 vs 600 vs 700) | Using 700 when brand uses 500 makes it feel heavy |
| `font-weight` body | 400 is standard; 300 only for elegant mood | 300 on screen at small sizes is hard to read |
| `letter-spacing` heading | Negative for large sans (-0.5px to -1px) | Forgetting negative tracking makes headings feel loose |
| `letter-spacing` body | 0 to 0.2px for sans; 0.3px for serif | Over-tracking body text feels clinical |
| `line-height` body | 1.5-1.7 for readability | Less than 1.4 makes paragraphs feel cramped |
| CJK line-height | +0.1 vs Latin (CJK glyphs are taller) | CJK text in a Latin line-height clips descenders |
| CJK spacing | `letter-spacing: 0` for CJK | Any letter-spacing on CJK text looks broken |

---

## 8. Presenting Font Choices to Founders

When the font can't be auto-detected, present choices like this:

```
I'll set up fonts for your deck. Based on your [minimal] style, here are 3 options:

Option 1 (Recommended): Inter + Noto Sans SC
  → Clean, universally readable, excellent CJK. Used by Linear, Vercel, Stripe.
  → Best for: SaaS, fintech, developer tools

Option 2: DM Sans + Noto Sans SC
  → Slightly warmer than Inter, more personality without being loud.
  → Best for: Consumer, marketplace, health-tech

Option 3: Plus Jakarta Sans + Noto Sans SC
  → Geometric and friendly, modern startup feel.
  → Best for: EdTech, social, creator economy

All three are free (Google Fonts), load fast, and have full CJK support.
Which one, or do you have a specific font in mind?
```

If the founder names a commercial font, look it up in the Substitution Table
and explain: "'{CommercialFont}' isn't available as a web font, but
'{Substitute}' has very similar proportions and feel. Shall I use that?"
