# Harvey — Series A 融资演示 Demo

[English](README.md)

一套 19 页的 Series A 融资演示文稿，由 `founder-pitch-deck` 技能生成，风格参考 [Harvey AI](https://harvey.ai)（估值 110 亿美元的法律 AI 公司）。

## 生成方式

```
/founder-pitch-deck source=https://harvey.ai
```

技能通过截图参考文稿（17 页）提取了 Harvey 的暗色编辑风格，然后：

1. **设计提取** — Cormorant Garamond 衬线 + Inter 无衬线，深色 `#0F0E0D` / 浅色 `#FAFAF9` 交替，金色强调 `#B8956A`
2. **内容** — 基于公开数据（TechCrunch、公司博客、SEC 文件）
3. **叙事审查** — YC 式深度点评，覆盖全部 19 页
4. **页面生成** — 单文件 `index.html`，零外部依赖

## 查看

```bash
open index.html
# 密码: harvey
```

## 看点

- **密码门** — 输入 `harvey` 进入
- **中英切换** — 点击角落的 ZH/EN 按钮
- **明暗交替** — 页面在深色 `#0F0E0D` 和浅色 `#FAFAF9` 之间交替
- **排版** — Cormorant Garamond 标题、Inter 正文、标题字重 500（不用粗体）
- **数字动画** — 数据页的数字自动计数
- **渐次出现** — 列表项和卡片以 120ms 间隔依次出现
- **PDF 导出** — Ctrl+P 或点击 PDF 按钮（自动加保密水印）
- **响应式** — 缩放窗口，内容等比缩放

## 文件

| 文件 | 说明 |
|------|------|
| `index.html` | 完整融资演示（单文件，浏览器打开即可） |
| `outline.md` | 生成时使用的页面大纲 |
| `copy.md` | 最终确认的文案（所有页面文字，中英双语） |
