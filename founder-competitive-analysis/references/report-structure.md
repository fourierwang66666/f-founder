# Report Structure Reference

Complete specification for the final Markdown report and PDF generation. Read this when executing Step 4 of the workflow.

---

## 1. Markdown Report Template

The report follows a hybrid structure: horizontal comparison first, then per-competitor deep dives, then cross-cutting insights.

```markdown
# [Product/Project Name] Competitive Analysis Report

> Generated: YYYY-MM-DD
> Core Problem: [one-line recap from Step 1]
> Competitors Analyzed: [count] (Direct: [n] / Indirect: [n] / Potential: [n])

---

## 1. Executive Summary

[2-3 paragraphs covering:]
- Market landscape overview — how mature is this space, who dominates
- Key findings — the 3-5 most important insights from the research
- Opportunity signal — where the gaps are and what they mean for the founder

## 2. Cross-Competitor Overview

### 2.1 Basic Info Comparison

| Product | Type | Launch | Funding Stage | Total Funding | Team Size | Pricing Model |
|---------|------|--------|--------------|---------------|-----------|---------------|
| [name]  | Direct | [date] | [stage] | [amount] | [size] | [model] |

### 2.2 Feature Matrix

[Construct from core features across all competitors. Use the Key Needs from Step 1 as row headers when possible.]

| Capability | Comp A | Comp B | Comp C | Comp D |
|-----------|--------|--------|--------|--------|
| [need 1]  | ✅ Full | ⚠️ Partial | ❌ None | ✅ Full |
| [need 2]  | ✅ Full | ✅ Full | ✅ Full | ⚠️ Partial |

### 2.3 Growth & Traction Comparison

| Product | Est. Users/Traffic | Growth Trend | Revenue Model | Notable Recent Move |
|---------|-------------------|-------------|---------------|-------------------|

## 3. Detailed Competitor Analysis

### 3.1 [Competitor A] (Direct Competitor)

[Paste the complete subagent output for this competitor, formatted consistently.]

### 3.2 [Competitor B] (Direct Competitor)

[...]

### 3.3 [Competitor C] (Indirect Competitor)

[...]

(Continue for all competitors, grouped by tier: Direct first, then Indirect, then Potential.)

## 4. User Feedback Insights

### 4.1 What Competitors Got Right

**Cross-competitor patterns:**
- [Pattern 1] — seen in [Comp A, Comp C]: [description]
- [Pattern 2] — seen in [Comp B, Comp D]: [description]

**Unique strengths:**
- [Comp A]: [unique praise point]
- [Comp B]: [unique praise point]

### 4.2 User Sentiment

**Overall satisfaction ranking:**
1. [Comp B] — 4.5/5 (G2, 200 reviews) — users love [aspect]
2. [Comp A] — 4.1/5 (G2, 150 reviews) — generally positive but [concern]
3. [Comp C] — 3.2/5 (Capterra, 80 reviews) — mixed, main issue is [issue]

**Main dissatisfaction themes (by frequency):**
1. [Theme] — mentioned across [n] competitors
2. [Theme] — specific to [Comp X]
3. [Theme] — emerging concern

### 4.3 Unmet Needs

| Unmet Need | Frequency | Competitors Affected | User Quotes |
|-----------|-----------|---------------------|-------------|
| [need 1]  | High | Comp A, B, C | "I wish..." |
| [need 2]  | Medium | Comp B | "Why can't it..." |
| [need 3]  | Low but critical | All | "Dealbreaker..." |

**Needs no competitor is addressing:**
- [Need X] — [explanation of why this represents an opportunity]

## 5. Opportunity Analysis

### 5.1 Market Gaps
- [Gap 1]: [description + which competitors miss this + potential impact]
- [Gap 2]: [description]

### 5.2 Differentiation Angles
- [Angle 1]: [why this could work, evidence from user feedback]
- [Angle 2]: [why this could work]

### 5.3 Risk Flags
- [Risk 1]: [e.g., large company expanding into this space]
- [Risk 2]: [e.g., regulatory changes]

## 6. Data Sources

All references consolidated:
- [URL] — [what data was obtained]
- [URL] — [what data was obtained]
```

---

## 2. Report Assembly Instructions

When assembling the final report from subagent outputs:

1. **Executive Summary** — write AFTER all sections are assembled. Synthesize, don't summarize. The founder should be able to read only this section and understand the competitive landscape.

2. **Cross-competitor tables** — extract structured fields from each subagent output and normalize into comparable columns. If a field is missing for one competitor, mark as "—".

3. **Feature Matrix** — use the Key Needs from Step 1 as primary rows. Add additional feature rows discovered during research. Use ✅ (full support), ⚠️ (partial), ❌ (none).

4. **User Feedback Insights** — this section requires SYNTHESIS, not copy-paste. Look across all competitor feedback to find:
   - Patterns that repeat across 2+ competitors
   - Unique strengths only one competitor has
   - Unmet needs that represent real opportunity

5. **Opportunity Analysis** — connect the dots between unmet needs, market gaps, and the founder's core problem. Be specific and actionable, not generic.

---

## 3. PDF Generation

### Design Token Detection

Check for existing pitch-deck design tokens in this order:

1. **Pitch-deck output:** Look for `index.html` files in the current project directory and subdirectories. If found, extract CSS custom properties:
   ```
   grep for: --primary, --accent, --bg, --text, --font-main, --font-serif
   ```

2. **Design tokens JSON:** Look for a `design-tokens.json` file in the project directory.

3. **Default style (fallback):**
   ```css
   :root {
     --primary: #1a1a2e;
     --accent: #e94560;
     --bg: #ffffff;
     --bg-secondary: #f8f9fa;
     --text: #1a1a2e;
     --text-secondary: #6c757d;
     --border: #e9ecef;
     --font-main: 'Inter', 'Noto Sans SC', sans-serif;
     --font-mono: 'JetBrains Mono', monospace;
   }
   ```

### Generation Flow

1. Read `assets/report-template.html`
2. Replace `{{PLACEHOLDER}}` tokens with design values
3. Convert Markdown report content to HTML and inject into template
4. Write to `competitive-analysis/report.html`
5. Instruct founder to open in browser and print to PDF (Ctrl+P / Cmd+P), or use Browse skill to generate PDF programmatically

### Print CSS Requirements

The HTML template must include:
- `@page` rules with margins for header/footer space
- Page breaks: `page-break-before: always` on each `<h2>` (major sections)
- No page breaks inside tables or competitor detail sections
- Running header: report title + date
- Running footer: page numbers
- Tables: repeat header rows across pages
- Hide interactive elements (links styled as plain text)
