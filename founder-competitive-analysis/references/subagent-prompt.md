# Subagent Prompt Template

Standardized prompt sent to each parallel Agent in Step 3 (Deep Research). The main process fills in the `{{PLACEHOLDER}}` tokens before dispatching.

---

## Prompt Template

~~~
You are researching a competitor product for a startup founder's competitive analysis.

## Context

**Core Problem Being Solved:** {{CORE_PROBLEM}}
**Target Users:** {{TARGET_USERS}}
**Key Needs:** {{KEY_NEEDS}}

## Your Assignment

Research **{{COMPETITOR_NAME}}** ({{COMPETITOR_DESCRIPTION}}).

Competitor tier: {{COMPETITOR_TIER}} (direct / indirect / potential)

## Research Tasks

Complete all three modules below using WebSearch and WebFetch. Be thorough but factual — never fabricate data. If you cannot find information for a field, write "No public data found."

### Module A: Product Basics

Research and document:
1. **Launch/release date** — When was the product first available? Check Product Hunt, Crunchbase, company About page.
2. **Core features** — What does the product do today? List the main capabilities.
3. **Feature evolution** — Key milestones in product development (major feature launches, pivots, redesigns). Check company blog, changelog, press releases.
4. **Team** — Founders, key hires, team size. Check company About page, LinkedIn search results.
5. **Product story** — Why was it built? Founder's background and motivation. Check founder interviews, podcasts, blog posts.
6. **Funding** — Investment rounds, amounts, investors. Check Crunchbase, news articles.

### Module B: Growth & Business

Research and document:
1. **User count / traffic** — Downloads, MAU, registered users, or website traffic. Check SimilarWeb, company announcements, news articles.
2. **Revenue model** — How does the product make money? (subscription, freemium, transaction fee, etc.)
3. **Pricing** — Specific plan names and prices. Fetch the pricing page directly.
4. **Marketing channels** — How do they acquire users? Check for ads, content marketing, partnerships.
5. **Recent moves** — Major announcements, partnerships, acquisitions, pivots in the last 6 months.

### Module C: User Feedback

Search for user reviews and discussions. Prioritize these sources in order:
1. G2 / Capterra / Trustpilot reviews (WebFetch review pages)
2. Reddit discussions (WebSearch site:reddit.com → WebFetch threads)
3. Product Hunt comments (WebFetch product page)
4. App Store / Google Play reviews (WebSearch indirect)

From the collected feedback, distill:
1. **What they got right** — Features or qualities users repeatedly praise
2. **User sentiment** — Overall satisfaction level, main complaint themes
3. **Unmet needs** — Features users wish existed, pain points not addressed

## Output Format

Return your findings in EXACTLY this format:

# {{COMPETITOR_NAME}} Competitive Research

## Basic Info
- **Launch Date:** [date or "No public data found"]
- **HQ / Team Size:** [location, size]
- **Founders:** [names and backgrounds]
- **Funding Stage:** [seed/A/B/C/etc]
- **Total Funding:** [amount]
- **Core Features:** [bullet list]
- **Key Feature Evolution:**
  - [date]: [milestone]
  - [date]: [milestone]
- **Product Story:** [1-2 paragraphs]

## Growth & Business
- **Estimated Users / Traffic:** [numbers with source]
- **Revenue Model:** [description]
- **Pricing:**
  - [Plan name]: [price] — [what's included]
- **Marketing Channels:** [observed channels]
- **Recent Moves:** [bullet list of last 6 months]

## User Feedback
- **Data Sources:** [list platforms where you found reviews]
- **Overall Rating:** [aggregate if available, e.g. "4.2/5 on G2 (150 reviews)"]
- **What They Got Right:**
  - [praised aspect 1 — with example quote if found]
  - [praised aspect 2]
- **User Sentiment:** [1 paragraph summary of overall mood]
- **Unmet Needs:**
  - [unmet need 1 — with user quote if found]
  - [unmet need 2]

## Key References
- [URL] — [what this source provided]
- [URL] — [what this source provided]
(include all URLs you actually retrieved data from)
~~~

---

## Dispatch Instructions

When dispatching subagents from the main SKILL.md workflow:

1. **Construct the prompt** by replacing all `{{PLACEHOLDER}}` tokens with actual values from Step 1 (problem definition) and Step 2 (confirmed competitor list).

2. **Launch all Agents in parallel** using a single message with multiple Agent tool calls:

```
Agent(
  description="Research [CompetitorName]",
  prompt=<filled template above>,
  subagent_type="general-purpose"
)
```

3. **Collect results** — each Agent returns a structured markdown document. The main process assembles these into the final report.

4. **Quality check** — after all Agents complete, scan each result for:
   - Fields marked "No public data found" — if critical fields (core features, pricing) are empty, consider a targeted supplementary search
   - Consistency — if Agent A says "founded 2020" but Agent B references the same product as "launched 2019", flag for review
   - Reference count — a result with fewer than 3 references may need supplementary research

5. **Supplementary research** — if a competitor's result is severely incomplete (3+ critical fields empty), dispatch one more Agent with narrower queries targeting the missing data.
