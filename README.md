# f-founder

AI-powered skills for startup founders. Each skill is a Claude Code skill that automates a specific founder workflow — from pitch decks to financial models to investor outreach.

## Skills

| Skill | Description | Status |
|-------|-------------|--------|
| [founder-pitch-deck](skills/founder-pitch-deck/) | Generate a single-file HTML pitch deck with brand extraction, bilingual ZH/EN, password protection, PDF export, and responsive scaling | Stable |

## What is a Claude Code Skill?

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills are markdown instruction files that extend Claude's capabilities with domain-specific workflows, reference docs, templates, and scripts. When you install a skill and invoke it, Claude follows the skill's instructions to complete complex multi-step tasks.

## Install

```bash
# Clone to your Claude skills directory
git clone https://github.com/fourierwang66666/f-founder.git ~/.claude/skills/f-founder

# Or install a single skill
git clone https://github.com/fourierwang66666/f-founder.git /tmp/f-founder
cp -r /tmp/f-founder/skills/founder-pitch-deck ~/.claude/skills/founder-pitch-deck
```

### founder-pitch-deck

Generates a production-quality HTML pitch deck in a single file. The 8-step workflow:

1. **Design Extraction** — browse the brand website, screenshot and extract colors, fonts, logo
2. **Content Input** — parse markdown, .pptx, PDF, or interactive Q&A
3. **Copy Confirmation** — founder reviews all slide text before proceeding
4. **Narrative Review** — YC-style office hours critique (6 forcing questions)
5. **Slide Structure** — ASCII wireframes for layout confirmation
6. **HTML Generation** — single `index.html` with auth gate, bilingual toggle, PDF export
7. **Visual QA** — headless browser screenshot review of every slide
8. **Deployment** — local, GitHub Pages, Vercel, or Netlify

**Key features:**
- Password-protected auth gate for investor access
- Bilingual ZH/EN toggle on every text element
- PDF export with confidential watermark
- Responsive scaling (laptop, monitor, iPad, phone)
- Zero dependencies — just open `index.html`

```
/founder-pitch-deck source=https://your-brand.com
```

#### Optional dependencies

The skill works standalone but is enhanced by:
- [Gstack](https://gstack.dev) — browse (headless browser QA) + office-hours (narrative review)
- [Impeccable](https://impeccable.dev) — animate + delight + frontend-design

Run `bash skills/founder-pitch-deck/scripts/setup.sh` to check and link dependencies.

## Contributing

PRs welcome. Each skill lives in `skills/<skill-name>/` and follows the [Claude Code skill format](https://docs.anthropic.com/en/docs/claude-code/skills).

## License

MIT
