# f-founder

[English](#english) | [中文](#中文)

---

## English

AI-powered [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills for startup founders.

Each skill automates a specific founder workflow — pitch decks, financial models, investor outreach — with the quality bar of a top-tier agency.

### Install

```bash
git clone https://github.com/fourierwang66666/f-founder.git ~/.claude/skills/f-founder
```

That's it. The skills are now available in Claude Code. Type `/founder-pitch-deck` or just describe what you need.

#### Auto-update

Every skill checks for updates on first use. When a new version is available, you'll see a prompt. To update manually:

```bash
cd ~/.claude/skills/f-founder && git pull
```

### Skills

#### founder-pitch-deck

Generate a single-file HTML pitch deck that looks like it was designed by a top-tier agency.

```
/founder-pitch-deck source=https://your-brand.com
```

**8-step workflow:**

| Step | What happens |
|------|-------------|
| 1. Design Extraction | Browse the brand website, screenshot and extract colors, fonts, logo |
| 2. Content Input | Parse markdown, .pptx, PDF, or interactive Q&A |
| 3. Copy Confirmation | Founder reviews all slide text before proceeding |
| 4. Narrative Review | YC-style office hours critique (6 forcing questions) |
| 5. Slide Structure | ASCII wireframes for layout confirmation |
| 6. HTML Generation | Single `index.html` with auth gate, bilingual toggle, PDF export |
| 7. Visual QA | Headless browser screenshot review of every slide |
| 8. Deployment | Local, GitHub Pages, Vercel, or Netlify |

**Output features:**
- Password-protected auth gate for investor access
- Bilingual ZH/EN toggle on every text element
- PDF export with confidential watermark
- Responsive scaling (laptop, monitor, iPad, phone)
- Zero external dependencies — just open `index.html`

**Optional dependencies** (skill works without them, with graceful fallbacks):
- [Gstack](https://gstack.dev) — `browse` (headless browser QA) + `office-hours` (narrative review)
- [Impeccable](https://impeccable.dev) — `animate` + `delight` + `frontend-design`

Run `bash ~/.claude/skills/f-founder/founder-pitch-deck/scripts/setup.sh` to check dependencies.

### Structure

```
f-founder/
├── SKILL.md                          # Root skill (umbrella)
├── VERSION                           # Central version
├── bin/
│   └── f-founder-update-check        # Auto-update checker
└── founder-pitch-deck/               # First skill
    ├── SKILL.md                      # Skill instructions (825 lines)
    ├── assets/
    │   └── base-template.html        # HTML engine (747 lines)
    ├── references/
    │   ├── font-system.md            # Font identification, pairing, substitution
    │   ├── html-engine.md            # CSS tokens, class reference
    │   ├── slide-structures.md       # 3 deck templates with HTML skeletons
    │   └── storytelling.md           # Narrative arc (7 beats)
    └── scripts/
        ├── setup.sh                  # Dependency checker/installer
        └── serve.sh                  # Local preview server
```

### Contributing

PRs welcome. Each skill lives in its own directory with a `SKILL.md` and optional bundled resources.

### License

MIT

---

## 中文

为创业者打造的 AI [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 技能合集。

每个技能自动化一个创始人的关键工作流 —— 从 pitch deck 到财务模型到投资人沟通 —— 以顶级咨询公司的质量标准交付。

### 安装

```bash
git clone https://github.com/fourierwang66666/f-founder.git ~/.claude/skills/f-founder
```

安装完成。在 Claude Code 中输入 `/founder-pitch-deck` 或直接描述你的需求即可使用。

#### 自动更新

每个技能在首次使用时会自动检查更新。有新版本时会提示你。手动更新：

```bash
cd ~/.claude/skills/f-founder && git pull
```

### 技能列表

#### founder-pitch-deck（融资 Pitch Deck 生成器）

一键生成高质量的单文件 HTML pitch deck，效果媲美顶级设计公司出品。

```
/founder-pitch-deck source=https://your-brand.com
```

**8 步工作流：**

| 步骤 | 说明 |
|------|------|
| 1. 设计提取 | 浏览品牌官网，截图并提取品牌色、字体、Logo |
| 2. 内容输入 | 解析 Markdown、.pptx、PDF，或交互式问答 |
| 3. 文案确认 | 创始人逐页审核所有 slide 文案 |
| 4. 叙事审查 | YC 式 Office Hours 深度点评（6 个核心问题） |
| 5. 结构设计 | ASCII 线框图确认每页布局 |
| 6. HTML 生成 | 单文件 `index.html`，含密码门、中英双语切换、PDF 导出 |
| 7. 视觉 QA | 无头浏览器逐页截图审查 |
| 8. 部署上线 | 本地、GitHub Pages、Vercel 或 Netlify |

**输出特性：**
- 密码保护的投资人访问门
- 所有文字元素支持中英双语一键切换
- PDF 导出自带保密水印
- 响应式缩放（笔记本、显示器、iPad、手机）
- 零外部依赖 —— 直接打开 `index.html` 即可

**可选依赖**（无需安装也可使用，缺失时自动降级）：
- [Gstack](https://gstack.dev) — `browse`（无头浏览器 QA）+ `office-hours`（叙事审查）
- [Impeccable](https://impeccable.dev) — `animate` + `delight` + `frontend-design`

运行 `bash ~/.claude/skills/f-founder/founder-pitch-deck/scripts/setup.sh` 检查依赖。

### 项目结构

```
f-founder/
├── SKILL.md                          # 根技能（总入口）
├── VERSION                           # 版本号
├── bin/
│   └── f-founder-update-check        # 自动更新检查器
└── founder-pitch-deck/               # 第一个技能
    ├── SKILL.md                      # 技能指令（825 行）
    ├── assets/
    │   └── base-template.html        # HTML 引擎（747 行）
    ├── references/
    │   ├── font-system.md            # 字体识别、配对、替换表
    │   ├── html-engine.md            # CSS Token、Class 参考
    │   ├── slide-structures.md       # 3 套 deck 模板（含 HTML 骨架）
    │   └── storytelling.md           # 叙事弧（7 个节拍）
    └── scripts/
        ├── setup.sh                  # 依赖检查/安装脚本
        └── serve.sh                  # 本地预览服务器
```

### 贡献

欢迎 PR。每个技能放在独立目录中，包含 `SKILL.md` 和可选的打包资源文件。

### 许可证

MIT
