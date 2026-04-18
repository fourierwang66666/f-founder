# Search Strategies Reference

Query templates and data source instructions for each phase of competitor discovery and deep research. Read this when executing Step 2 and Step 3 of the workflow.

---

## 1. Competitor Discovery Queries (Step 2)

### Path 1: General Web Search

Construct queries from the core problem and key needs extracted in Step 1. Run all queries via WebSearch.

**Discovery queries:**
- `best [need keywords] tools 2026`
- `best [need keywords] apps 2026`
- `[need keywords] alternatives`
- `[core problem] solution software`
- `top [product category] startups`
- `[need keywords] comparison review`

**Example:** If core problem is "freelancers struggle to track expenses":
- `best freelancer expense tracking tools 2026`
- `expense tracking app alternatives`
- `freelancer financial management software`

### Path 2: Reddit Search

Use WebSearch with `site:reddit.com` for stable access (more reliable than Reddit API).

**Queries:**
- `site:reddit.com [need keywords] recommendation`
- `site:reddit.com best [product type] reddit`
- `site:reddit.com [core problem] what do you use`
- `site:reddit.com [product category] vs`

After finding relevant threads via WebSearch, use WebFetch to load the full thread and extract:
- Product names mentioned
- User sentiment per product
- Reasons for recommendation/criticism

**Tip:** Reddit threads with 50+ upvotes on the post tend to have higher quality recommendations.

### Path 3: App Market Search (Adaptive)

**When to use:** Only if the problem domain is relevant to mobile apps. Skip for pure SaaS/Web/B2B products.

**App Store (indirect via WebSearch):**
- `site:apps.apple.com [need keywords]`
- `[product category] app review ios`
- `best [product type] iphone app`

**Google Play (indirect via WebSearch):**
- `site:play.google.com [need keywords]`
- `[product category] android app review`

**For SaaS/Web products, use these instead:**
- `site:g2.com [product category]`
- `site:capterra.com [product category]`
- `[product category] software comparison`

### Supplementary Sources

After initial discovery, search these for additional competitors and validation:

**AlternativeTo:**
- WebSearch: `site:alternativeto.net [discovered competitor name]`
- WebFetch: `https://alternativeto.net/software/[product-name]/` — extract listed alternatives

**Product Hunt:**
- WebSearch: `site:producthunt.com [need keywords]`
- WebFetch: product pages to get launch date, upvotes, comments

**G2 / Capterra:**
- WebSearch: `site:g2.com [product category] reviews`
- WebFetch: category pages to find ranked products
- These are particularly valuable for B2B/SaaS products

---

## 2. Deep Research Queries (Step 3)

Per-competitor query templates. Replace `[PRODUCT]` with the actual product name.

### Module A: Product Basics

**Launch / release date:**
- `[PRODUCT] launch date founded`
- `site:producthunt.com [PRODUCT]`
- `site:crunchbase.com [PRODUCT]`
- WebFetch: company About page / press page

**Core features and evolution:**
- `[PRODUCT] features changelog`
- `[PRODUCT] product updates 2025 2026`
- WebFetch: company blog, changelog page, or release notes page

**Team:**
- `[PRODUCT] team founders`
- `[PRODUCT] CEO founder interview`
- `site:linkedin.com [PRODUCT] company`
- WebFetch: company About/Team page

**Product story:**
- `[PRODUCT] founder story origin`
- `[PRODUCT] why we built`
- `[PRODUCT] founder interview podcast`

**Funding:**
- `[PRODUCT] funding round investment`
- `site:crunchbase.com [PRODUCT]`
- `[PRODUCT] series A B seed raise`
- WebFetch: Crunchbase profile page (some data is public)

### Module B: Growth & Business

**Users / traffic:**
- `[PRODUCT] users downloads growth`
- `[PRODUCT] monthly active users`
- WebFetch: `https://www.similarweb.com/website/[product-domain]/` (partial free data)
- WebSearch: `[PRODUCT] milestone announcement`

**Revenue and pricing:**
- WebFetch: `[product-domain]/pricing` page directly
- `[PRODUCT] pricing plans cost`
- `[PRODUCT] revenue ARR`

**Marketing / advertising:**
- `[PRODUCT] marketing strategy`
- `[PRODUCT] advertising campaign`
- `[PRODUCT] growth strategy`

**Recent moves (limit to 6 months):**
- `[PRODUCT] news 2026`
- `[PRODUCT] announcement launch update 2026`
- `[PRODUCT] partnership acquisition 2026`

### Module C: User Feedback

**G2 / Capterra / Trustpilot (primary — most stable):**
- WebSearch: `site:g2.com [PRODUCT] reviews`
- WebSearch: `site:capterra.com [PRODUCT] reviews`
- WebSearch: `site:trustpilot.com [PRODUCT]`
- WebFetch: review pages directly — extract ratings, pros, cons, common themes

**Reddit (high-quality organic feedback):**
- `site:reddit.com [PRODUCT] review`
- `site:reddit.com [PRODUCT] experience`
- `site:reddit.com [PRODUCT] alternative`
- WebFetch: top 3-5 most relevant threads

**Product Hunt:**
- WebSearch: `site:producthunt.com [PRODUCT]`
- WebFetch: product page to read comments

**App Store / Google Play (indirect):**
- `[PRODUCT] app store reviews`
- `[PRODUCT] google play reviews`
- `[PRODUCT] app rating`
- If Browse is available: navigate to actual store page for direct review scraping

**Twitter / X:**
- `[PRODUCT] site:twitter.com OR site:x.com feedback`
- Useful for real-time sentiment

---

## 3. Data Source Reliability Guide

| Source | Reliability | Best For | Notes |
|--------|------------|----------|-------|
| Company website | ⭐⭐⭐ | Features, pricing, team, story | Most authoritative |
| Product Hunt | ⭐⭐⭐ | Launch date, early feedback | Pages are WebFetch-friendly |
| G2 / Capterra | ⭐⭐⭐ | Structured user reviews | Pros/cons format, ratings |
| Reddit | ⭐⭐⭐ | Organic user opinions | Use WebSearch → WebFetch |
| Crunchbase | ⭐⭐ | Funding, team, timeline | Some data behind paywall |
| SimilarWeb | ⭐⭐ | Traffic estimates | Free tier has limited data |
| AlternativeTo | ⭐⭐⭐ | Finding alternatives | Lightweight, easy to scrape |
| Trustpilot | ⭐⭐⭐ | Consumer product reviews | Good for B2C |
| App Store direct | ⭐ | App reviews | JS-heavy, needs Browse |
| Google Play direct | ⭐ | App reviews | JS-heavy, needs Browse |
| LinkedIn | ⭐⭐ | Team size, hiring signals | Search summaries only |
| News articles | ⭐⭐⭐ | Funding, strategy, milestones | Via WebSearch |

---

## 4. Query Construction Tips

1. **Use current year:** Always append `2025` or `2026` to discovery queries for freshness
2. **Combine site: with keywords:** `site:reddit.com [product] vs` is more targeted than generic search
3. **Try product domain directly:** WebFetch `[domain]/about`, `[domain]/pricing`, `[domain]/blog` before searching
4. **Cross-reference:** If one source says "500K users" and another says "2M downloads", note both with sources
5. **Mark gaps honestly:** Write "No public data found" rather than guessing. The founder knows their domain better.
