# f-founder

[English](README.md)

为创业者打造的 AI [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 技能合集。

每个技能自动化一个创始人的关键工作流——从融资路演到财务模型到投资人沟通——以顶级咨询公司的质量标准交付。

## 安装

```bash
git clone https://github.com/fourierwang66666/f-founder.git ~/.claude/skills/f-founder
```

安装完成。在 Claude Code 中输入 `/founder-pitch-deck` 或直接描述你的需求即可使用。

### 自动更新

每个技能在首次使用时会自动检查更新。有新版本时会提示你。手动更新：

```bash
cd ~/.claude/skills/f-founder && git pull
```

## 效果演示

查看实际输出：**[Harvey Series A 融资演示](examples/harvey-series-a/)** — 一套 19 页的融资演示文稿，由 `founder-pitch-deck` 生成，风格参考 Harvey AI（估值 110 亿美元的法律 AI 公司）。下载 `index.html` 用浏览器打开即可（密码：`harvey`）。

## 技能列表

### founder-pitch-deck（融资演示文稿生成器）

一键生成高质量的单文件 HTML 融资演示文稿，效果媲美顶级设计公司出品。

```
/founder-pitch-deck source=https://your-brand.com
```

**8 步工作流：**

| 步骤 | 说明 |
|------|------|
| 1. 设计提取 | 浏览品牌官网，截图并提取品牌色、字体、Logo |
| 2. 内容输入 | 解析 Markdown、.pptx、PDF，或交互式问答 |
| 3. 文案确认 | 创始人逐页审核所有页面文案 |
| 4. 叙事审查 | YC 式深度点评（6 个核心问题） |
| 5. 结构设计 | ASCII 线框图确认每页布局 |
| 6. 生成页面 | 单文件 `index.html`，含密码门、中英双语切换、PDF 导出 |
| 7. 视觉检查 | 无头浏览器逐页截图审查 |
| 8. 部署上线 | 本地预览、GitHub Pages、Vercel 或 Netlify |

**输出特性：**
- 密码保护的投资人访问门
- 所有文字元素支持中英双语一键切换
- PDF 导出自带保密水印
- 响应式缩放（笔记本、显示器、iPad、手机）
- 零外部依赖——直接打开 `index.html` 即可

**可选依赖**（无需安装也可使用，缺失时自动降级）：
- [Gstack](https://gstack.dev) — `browse`（无头浏览器视觉检查）+ `office-hours`（叙事审查）
- [Impeccable](https://impeccable.dev) — `animate` + `delight` + `frontend-design`

运行 `bash ~/.claude/skills/f-founder/founder-pitch-deck/scripts/setup.sh` 检查依赖。

## 项目结构

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
    │   ├── slide-structures.md       # 3 套模板（含 HTML 骨架）
    │   └── storytelling.md           # 叙事弧（7 个节拍）
    └── scripts/
        ├── setup.sh                  # 依赖检查/安装脚本
        └── serve.sh                  # 本地预览服务器
```

## 贡献

欢迎提交 PR。每个技能放在独立目录中，包含 `SKILL.md` 和可选的打包资源文件。

## 许可证

MIT
