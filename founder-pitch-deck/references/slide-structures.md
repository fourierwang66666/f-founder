# Slide Structure Templates

Three deck templates with copy-pasteable HTML skeletons for every slide.
Each skeleton uses the utility classes defined in `html-engine.md`.

**CSS class reference:**
- `.slide` — light background (default)
- `.slide.dark` — dark background
- `.slide.red` — primary/brand color background
- `.eyebrow` — small uppercase section label
- `.stat-big` — hero number display
- `.stat-label` — caption below stat numbers
- `.beat-num` — animated count-up number
- `.reveal-item` — staggered entrance animation
- `.flex` / `.flex-3` / `.flex-4` — column layouts (2, 3, 4 cols)
- `.col` — equal-width column child
- `.tag` — label pill (variants: `.green`, `.orange`, `.red-tag`)
- `.quote` — testimonial blockquote
- `.mt-*` / `.mb-*` — margin spacing (1 = 0.5rem, 2 = 1rem, 3 = 1.5rem, 4 = 2rem)
- `span.zh` / `span.en` — bilingual text pair

---

## Template 1: Seed Round (12 slides)

### Slide 1 -- Cover `.red`

Eyebrow: round info. Hero h1: tagline. Subtitle: one-liner description. Footer: confidential + date.

```html
<div class="slide red">
  <div class="eyebrow">
    <span class="zh">种子轮融资</span><span class="en">SEED ROUND</span>
  </div>
  <h1>
    <span class="zh">让每一笔支付都准时到达</span>
    <span class="en">Making Every Payment Arrive on Time</span>
  </h1>
  <p class="subtitle">
    <span class="zh">为自由职业者打造的智能收款平台</span>
    <span class="en">The Smart Collections Platform for Freelancers</span>
  </p>
  <div class="slide-footer mt-4">
    <span class="zh">机密文件 &middot; 2026年3月</span>
    <span class="en">Confidential &middot; March 2026</span>
  </div>
</div>
```

---

### Slide 2 -- Market (default)

Eyebrow: THE MARKET. h2: market framing. Four stat cards in `.flex-4` with `.beat-num`. Data sources footer.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">市场规模</span><span class="en">THE MARKET</span>
  </div>
  <h2>
    <span class="zh">一个万亿级的全球市场</span>
    <span class="en">A Trillion-Dollar Global Market</span>
  </h2>
  <div class="flex-4 mt-3">
    <div class="col reveal-item">
      <div class="beat-num" data-target="1.4" data-suffix="T">
        <span class="stat-big">$1.4T</span>
      </div>
      <div class="stat-label">
        <span class="zh">全球自由职业经济规模</span>
        <span class="en">Global Freelance Economy</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="78" data-suffix="M">
        <span class="stat-big">78M</span>
      </div>
      <div class="stat-label">
        <span class="zh">活跃自由职业者</span>
        <span class="en">Active Freelancers</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="23" data-suffix="%">
        <span class="stat-big">23%</span>
      </div>
      <div class="stat-label">
        <span class="zh">年增长率</span>
        <span class="en">YoY Growth</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="4.35" data-prefix="$" data-suffix="B">
        <span class="stat-big">$4.35B</span>
      </div>
      <div class="stat-label">
        <span class="zh">可服务市场 (SAM)</span>
        <span class="en">Serviceable Market (SAM)</span>
      </div>
    </div>
  </div>
  <p class="data-source mt-3">
    <span class="zh">数据来源：Payoneer 2025, Statista, World Bank</span>
    <span class="en">Sources: Payoneer 2025, Statista, World Bank</span>
  </p>
</div>
```

---

### Slide 3 -- Problem (default)

Eyebrow: THE PROBLEM. h2: problem headline. 3-4 pain points with emoji icons, each as `.reveal-item`.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">痛点</span><span class="en">THE PROBLEM</span>
  </div>
  <h2>
    <span class="zh">自由职业者被付款拖延困扰</span>
    <span class="en">Freelancers Are Drowning in Late Payments</span>
  </h2>
  <div class="pain-points mt-3">
    <div class="reveal-item pain-point">
      <span class="pain-icon">&#x23F3;</span>
      <div>
        <strong>
          <span class="zh">67% 遭遇超30天延迟付款</span>
          <span class="en">67% face payment delays over 30 days</span>
        </strong>
        <p>
          <span class="zh">现金流断裂是自由职业者放弃的首要原因</span>
          <span class="en">Cash flow gaps are the #1 reason freelancers quit</span>
        </p>
      </div>
    </div>
    <div class="reveal-item pain-point">
      <span class="pain-icon">&#x1F4B8;</span>
      <div>
        <strong>
          <span class="zh">平均每月花8小时催款</span>
          <span class="en">8 hours/month spent chasing invoices</span>
        </strong>
        <p>
          <span class="zh">本该用于创造价值的时间被浪费在收款上</span>
          <span class="en">Time that should be spent on billable work, wasted</span>
        </p>
      </div>
    </div>
    <div class="reveal-item pain-point">
      <span class="pain-icon">&#x1F6AB;</span>
      <div>
        <strong>
          <span class="zh">现有工具碎片化，缺乏整合</span>
          <span class="en">Existing tools are fragmented and disconnected</span>
        </strong>
        <p>
          <span class="zh">发票、催收、合同分散在3-5个不同平台</span>
          <span class="en">Invoicing, collections, contracts across 3-5 platforms</span>
        </p>
      </div>
    </div>
    <div class="reveal-item pain-point">
      <span class="pain-icon">&#x1F30D;</span>
      <div>
        <strong>
          <span class="zh">跨境支付手续费高达5-8%</span>
          <span class="en">Cross-border fees eat 5-8% of earnings</span>
        </strong>
        <p>
          <span class="zh">小额高频交易被手续费蚕食</span>
          <span class="en">Small, frequent payments eroded by fees</span>
        </p>
      </div>
    </div>
  </div>
</div>
```

---

### Slide 4 -- Solution `.dark`

Eyebrow: THE SOLUTION. h1: product tagline (bold, memorable). 3 value props in `.flex-3` columns.

```html
<div class="slide dark">
  <div class="eyebrow">
    <span class="zh">解决方案</span><span class="en">THE SOLUTION</span>
  </div>
  <h1>
    <span class="zh">一键搞定，从发票到到账</span>
    <span class="en">From Invoice to Income, in One Click</span>
  </h1>
  <div class="flex-3 mt-4">
    <div class="col reveal-item">
      <div class="feature-icon">&#x26A1;</div>
      <h3>
        <span class="zh">智能催收</span>
        <span class="en">Smart Collections</span>
      </h3>
      <p>
        <span class="zh">AI驱动的自动催收引擎，根据客户画像选择最佳催收策略和时间</span>
        <span class="en">AI-powered auto-collection engine picks the best strategy and timing per client profile</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="feature-icon">&#x1F310;</div>
      <h3>
        <span class="zh">全球即时到账</span>
        <span class="en">Global Instant Settlement</span>
      </h3>
      <p>
        <span class="zh">支持50+国家本地支付通道，手续费低至1.5%，T+0到账</span>
        <span class="en">Local payment rails in 50+ countries, fees as low as 1.5%, same-day settlement</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="feature-icon">&#x1F4CA;</div>
      <h3>
        <span class="zh">现金流仪表盘</span>
        <span class="en">Cash Flow Dashboard</span>
      </h3>
      <p>
        <span class="zh">实时可视化应收款状态，预测未来30天现金流</span>
        <span class="en">Real-time receivables visibility with 30-day cash flow forecasting</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 5 -- Product (default)

Eyebrow: THE PRODUCT. h2: product name. Screenshot area (placeholder div). Feature bullets below.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">产品</span><span class="en">THE PRODUCT</span>
  </div>
  <h2>
    <span class="zh">产品概览</span>
    <span class="en">Product Overview</span>
  </h2>
  <div class="flex mt-3">
    <div class="col" style="flex:1.6">
      <div class="product-screenshot reveal-item">
        <!-- Replace with actual screenshot: <img src="screenshot.png" alt="Product UI"> -->
        <div class="placeholder-screen">
          <span class="zh">产品截图</span><span class="en">Product Screenshot</span>
        </div>
      </div>
    </div>
    <div class="col" style="flex:1">
      <ul class="feature-list">
        <li class="reveal-item">
          <span class="zh">三步完成发票创建和发送</span>
          <span class="en">Create and send invoices in 3 steps</span>
        </li>
        <li class="reveal-item">
          <span class="zh">自动匹配最优支付通道</span>
          <span class="en">Auto-match the optimal payment rail</span>
        </li>
        <li class="reveal-item">
          <span class="zh">智能合同模板与电子签名</span>
          <span class="en">Smart contract templates with e-signatures</span>
        </li>
        <li class="reveal-item">
          <span class="zh">多币种钱包与即时兑换</span>
          <span class="en">Multi-currency wallet with instant conversion</span>
        </li>
        <li class="reveal-item">
          <span class="zh">移动端完整功能支持</span>
          <span class="en">Full-featured mobile experience</span>
        </li>
      </ul>
    </div>
  </div>
</div>
```

---

### Slide 6 -- How it Works (default)

Eyebrow: HOW IT WORKS. h2: process title. 3-step numbered flow with cards.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">工作原理</span><span class="en">HOW IT WORKS</span>
  </div>
  <h2>
    <span class="zh">三步开始</span>
    <span class="en">Three Steps to Get Paid</span>
  </h2>
  <div class="flex-3 mt-4">
    <div class="col reveal-item step-card">
      <div class="step-number">1</div>
      <h3>
        <span class="zh">创建发票</span>
        <span class="en">Create Invoice</span>
      </h3>
      <p>
        <span class="zh">输入金额和客户信息，AI自动生成专业发票并推荐付款条款</span>
        <span class="en">Enter amount and client info -- AI generates a professional invoice with recommended terms</span>
      </p>
    </div>
    <div class="col reveal-item step-card">
      <div class="step-number">2</div>
      <h3>
        <span class="zh">一键发送</span>
        <span class="en">Send with One Click</span>
      </h3>
      <p>
        <span class="zh">通过邮件、链接或即时通讯发送，客户打开即可用本地支付方式付款</span>
        <span class="en">Send via email, link, or chat -- client pays with their local payment method</span>
      </p>
    </div>
    <div class="col reveal-item step-card">
      <div class="step-number">3</div>
      <h3>
        <span class="zh">即时到账</span>
        <span class="en">Instant Settlement</span>
      </h3>
      <p>
        <span class="zh">资金实时到达你的钱包，支持50+币种提现到本地银行</span>
        <span class="en">Funds land in your wallet instantly -- withdraw in 50+ currencies to your local bank</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 7 -- Traction (default)

Eyebrow: TRACTION. h2: traction headline. 3-4 key metrics in `.flex-4`. Growth narrative paragraph.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">增长数据</span><span class="en">TRACTION</span>
  </div>
  <h2>
    <span class="zh">上线6个月，增长势头强劲</span>
    <span class="en">6 Months Live, Strong Momentum</span>
  </h2>
  <div class="flex-4 mt-3">
    <div class="col reveal-item">
      <div class="beat-num" data-target="12500">
        <span class="stat-big">12,500</span>
      </div>
      <div class="stat-label">
        <span class="zh">注册用户</span>
        <span class="en">Registered Users</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="2.1" data-prefix="$" data-suffix="M">
        <span class="stat-big">$2.1M</span>
      </div>
      <div class="stat-label">
        <span class="zh">处理交易总额</span>
        <span class="en">Total Processed Volume</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="32" data-suffix="%">
        <span class="stat-big">32%</span>
      </div>
      <div class="stat-label">
        <span class="zh">月环比增长</span>
        <span class="en">MoM Growth</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="4.8">
        <span class="stat-big">4.8</span>
      </div>
      <div class="stat-label">
        <span class="zh">App Store 评分</span>
        <span class="en">App Store Rating</span>
      </div>
    </div>
  </div>
  <p class="mt-3 reveal-item">
    <span class="zh">用户获取主要来自口碑推荐（65%），付费获客成本持续下降。</span>
    <span class="en">65% of acquisition is organic referral; paid CAC is declining month over month.</span>
  </p>
</div>
```

---

### Slide 8 -- Business Model (default)

Eyebrow: BUSINESS MODEL. h2: revenue model title. Pricing/revenue structure. Unit economics hint.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">商业模式</span><span class="en">BUSINESS MODEL</span>
  </div>
  <h2>
    <span class="zh">交易驱动，多层收入</span>
    <span class="en">Transaction-Driven, Multi-Layer Revenue</span>
  </h2>
  <div class="flex-3 mt-3">
    <div class="col reveal-item">
      <div class="tag green">
        <span class="zh">核心收入</span><span class="en">Core Revenue</span>
      </div>
      <h3>
        <span class="zh">交易手续费</span>
        <span class="en">Transaction Fees</span>
      </h3>
      <p>
        <span class="zh">每笔交易收取1.5-2.5%手续费，随交易量阶梯递减</span>
        <span class="en">1.5-2.5% per transaction, tiered down with volume</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="tag orange">
        <span class="zh">增值服务</span><span class="en">Value-Add</span>
      </div>
      <h3>
        <span class="zh">Pro 订阅</span>
        <span class="en">Pro Subscription</span>
      </h3>
      <p>
        <span class="zh">$29/月，解锁高级催收、现金流预测和优先支付通道</span>
        <span class="en">$29/mo for advanced collections, forecasting, and priority rails</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="tag">
        <span class="zh">未来收入</span><span class="en">Future Revenue</span>
      </div>
      <h3>
        <span class="zh">金融产品</span>
        <span class="en">Financial Products</span>
      </h3>
      <p>
        <span class="zh">基于交易数据的预支工资、小额信贷服务</span>
        <span class="en">Invoice advances and micro-lending powered by transaction data</span>
      </p>
    </div>
  </div>
  <p class="mt-3 reveal-item">
    <span class="zh">单位经济：LTV $380 / CAC $45 = 8.4x 回报率</span>
    <span class="en">Unit economics: LTV $380 / CAC $45 = 8.4x payback ratio</span>
  </p>
</div>
```

---

### Slide 9 -- Competition (default)

Eyebrow: COMPETITIVE LANDSCAPE. h2: positioning statement. Comparison table or matrix.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">竞争格局</span><span class="en">COMPETITIVE LANDSCAPE</span>
  </div>
  <h2>
    <span class="zh">为自由职业者专属设计</span>
    <span class="en">Purpose-Built for Freelancers</span>
  </h2>
  <table class="comparison-table mt-3 reveal-item">
    <thead>
      <tr>
        <th></th>
        <th>
          <span class="zh">我们</span><span class="en">Us</span>
        </th>
        <th>PayPal</th>
        <th>Wise</th>
        <th>
          <span class="zh">传统银行</span><span class="en">Banks</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <span class="zh">自动催收</span><span class="en">Auto Collections</span>
        </td>
        <td class="tag green">&#x2713;</td>
        <td>&#x2717;</td>
        <td>&#x2717;</td>
        <td>&#x2717;</td>
      </tr>
      <tr>
        <td>
          <span class="zh">本地支付通道</span><span class="en">Local Rails</span>
        </td>
        <td class="tag green">50+</td>
        <td>
          <span class="zh">有限</span><span class="en">Limited</span>
        </td>
        <td class="tag green">40+</td>
        <td>
          <span class="zh">仅本国</span><span class="en">Domestic</span>
        </td>
      </tr>
      <tr>
        <td>
          <span class="zh">手续费</span><span class="en">Fees</span>
        </td>
        <td class="tag green">1.5%</td>
        <td class="tag red-tag">4.5%</td>
        <td class="tag orange">1.8%</td>
        <td class="tag red-tag">5-8%</td>
      </tr>
      <tr>
        <td>
          <span class="zh">到账速度</span><span class="en">Settlement</span>
        </td>
        <td class="tag green">T+0</td>
        <td class="tag orange">T+1</td>
        <td class="tag orange">T+1</td>
        <td class="tag red-tag">T+3</td>
      </tr>
      <tr>
        <td>
          <span class="zh">现金流预测</span><span class="en">Cash Forecasting</span>
        </td>
        <td class="tag green">&#x2713;</td>
        <td>&#x2717;</td>
        <td>&#x2717;</td>
        <td>&#x2717;</td>
      </tr>
    </tbody>
  </table>
</div>
```

---

### Slide 10 -- Team (default)

Eyebrow: THE TEAM. h2: team headline. Founder cards with photo placeholder, name, role, bio.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">团队</span><span class="en">THE TEAM</span>
  </div>
  <h2>
    <span class="zh">经验丰富的创始团队</span>
    <span class="en">A Team That Has Done This Before</span>
  </h2>
  <div class="flex-3 mt-3">
    <div class="col reveal-item team-member">
      <div class="avatar">
        <!-- Replace: <img src="founder1.jpg" alt="Name"> -->
        <div class="avatar-placeholder">CEO</div>
      </div>
      <h3>
        <span class="zh">张明</span><span class="en">Ming Zhang</span>
      </h3>
      <p class="role">
        <span class="zh">CEO &amp; 联合创始人</span>
        <span class="en">CEO &amp; Co-Founder</span>
      </p>
      <p class="bio">
        <span class="zh">前Stripe支付产品负责人，10年金融科技经验</span>
        <span class="en">Ex-Stripe Payments PM Lead, 10yr fintech veteran</span>
      </p>
    </div>
    <div class="col reveal-item team-member">
      <div class="avatar">
        <div class="avatar-placeholder">CTO</div>
      </div>
      <h3>
        <span class="zh">李华</span><span class="en">Hua Li</span>
      </h3>
      <p class="role">
        <span class="zh">CTO &amp; 联合创始人</span>
        <span class="en">CTO &amp; Co-Founder</span>
      </p>
      <p class="bio">
        <span class="zh">前蚂蚁金服高级架构师，分布式支付系统专家</span>
        <span class="en">Ex-Ant Financial Sr. Architect, distributed payments expert</span>
      </p>
    </div>
    <div class="col reveal-item team-member">
      <div class="avatar">
        <div class="avatar-placeholder">COO</div>
      </div>
      <h3>
        <span class="zh">王莉</span><span class="en">Li Wang</span>
      </h3>
      <p class="role">
        <span class="zh">COO &amp; 联合创始人</span>
        <span class="en">COO &amp; Co-Founder</span>
      </p>
      <p class="bio">
        <span class="zh">前Upwork东南亚总经理，自由职业者社区运营专家</span>
        <span class="en">Ex-Upwork SEA GM, freelancer community operations expert</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 11 -- Vision `.dark`

Eyebrow: THE VISION. h1: bold future statement. Roadmap bullets with timeline.

```html
<div class="slide dark">
  <div class="eyebrow">
    <span class="zh">愿景</span><span class="en">THE VISION</span>
  </div>
  <h1>
    <span class="zh">成为自由职业者的金融操作系统</span>
    <span class="en">The Financial OS for Freelancers</span>
  </h1>
  <div class="roadmap mt-4">
    <div class="reveal-item roadmap-item">
      <div class="tag green">2026</div>
      <p>
        <span class="zh">覆盖东南亚5国，月活跃用户突破10万</span>
        <span class="en">Live in 5 SEA markets, 100K MAU</span>
      </p>
    </div>
    <div class="reveal-item roadmap-item">
      <div class="tag orange">2027</div>
      <p>
        <span class="zh">推出预支工资和信用产品，进入拉美市场</span>
        <span class="en">Launch advance and credit products, enter LATAM</span>
      </p>
    </div>
    <div class="reveal-item roadmap-item">
      <div class="tag">2028</div>
      <p>
        <span class="zh">构建自由职业者金融生态：保险、税务、退休金</span>
        <span class="en">Build the freelancer financial ecosystem: insurance, tax, retirement</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 12 -- Ask `.red`

Eyebrow: THE ASK. h1: funding amount. Use of funds breakdown. Contact info.

```html
<div class="slide red">
  <div class="eyebrow">
    <span class="zh">融资需求</span><span class="en">THE ASK</span>
  </div>
  <h1>
    <span class="zh">种子轮融资</span>
    <span class="en">Seed Round</span>
  </h1>
  <div class="beat-num mt-2" data-target="3" data-prefix="$" data-suffix="M">
    <span class="stat-big">$3M</span>
  </div>
  <div class="stat-label mb-3">
    <span class="zh">目标融资额</span>
    <span class="en">Target Raise</span>
  </div>
  <ul class="fund-allocation reveal-item">
    <li>
      <span class="zh"><strong>40%</strong> 产品研发 — 支付通道接入、AI催收引擎</span>
      <span class="en"><strong>40%</strong> Product &amp; Engineering — payment rails, AI collections</span>
    </li>
    <li>
      <span class="zh"><strong>30%</strong> 市场拓展 — 东南亚3国启动</span>
      <span class="en"><strong>30%</strong> Go-to-Market — launch in 3 SEA countries</span>
    </li>
    <li>
      <span class="zh"><strong>20%</strong> 团队扩充 — 工程、合规、运营</span>
      <span class="en"><strong>20%</strong> Team — engineering, compliance, operations</span>
    </li>
    <li>
      <span class="zh"><strong>10%</strong> 运营储备</span>
      <span class="en"><strong>10%</strong> Operating Reserve</span>
    </li>
  </ul>
  <div class="contact mt-4 reveal-item">
    <p>
      <span class="zh">联系人：张明 &middot; ming@example.com &middot; +65 9123 4567</span>
      <span class="en">Contact: Ming Zhang &middot; ming@example.com &middot; +65 9123 4567</span>
    </p>
  </div>
</div>
```

---
---

## Template 2: Series A (extends Seed to 16 slides)

The Series A template uses all 12 Seed slides above plus 4 additional slides inserted at specific positions. Only the new slides are shown here.

**Final slide order (16 slides):**

1. Cover (Seed #1)
2. Market (Seed #2)
3. **Why Now** -- NEW, insert after Market
4. Problem (Seed #3)
5. Solution (Seed #4)
6. Product (Seed #5)
7. How it Works (Seed #6)
8. Traction (Seed #7)
9. **Case Studies** -- NEW, insert after Traction
10. Business Model (Seed #8)
11. **Unit Economics** -- NEW, insert after Business Model
12. **Growth Strategy** -- NEW, insert after Unit Economics
13. Competition (Seed #9)
14. Team (Seed #10)
15. Vision (Seed #11)
16. Ask (Seed #12)

---

### NEW Slide -- Why Now (default) -- insert after Market (position 3)

Market timing, tailwinds, and macro catalysts that make this the right moment.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">为什么是现在</span><span class="en">WHY NOW</span>
  </div>
  <h2>
    <span class="zh">三大趋势交汇，窗口正在打开</span>
    <span class="en">Three Tailwinds Converging Right Now</span>
  </h2>
  <div class="flex-3 mt-3">
    <div class="col reveal-item">
      <div class="tag green">
        <span class="zh">监管利好</span><span class="en">Regulatory</span>
      </div>
      <h3>
        <span class="zh">实时支付基础设施全球铺开</span>
        <span class="en">Real-Time Payment Rails Going Global</span>
      </h3>
      <p>
        <span class="zh">新加坡PayNow、印度UPI、巴西Pix等即时支付系统在2024-2025年实现跨境互联</span>
        <span class="en">PayNow, UPI, Pix -- instant payment systems achieved cross-border interop in 2024-25</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="tag orange">
        <span class="zh">行为转变</span><span class="en">Behavioral</span>
      </div>
      <h3>
        <span class="zh">自由职业成为主流工作方式</span>
        <span class="en">Freelancing Has Gone Mainstream</span>
      </h3>
      <p>
        <span class="zh">后疫情时代远程工作常态化，Z世代选择自由职业比例达47%</span>
        <span class="en">Post-pandemic remote normalization; 47% of Gen Z choose freelancing</span>
      </p>
    </div>
    <div class="col reveal-item">
      <div class="tag">
        <span class="zh">技术成熟</span><span class="en">Technology</span>
      </div>
      <h3>
        <span class="zh">AI让智能催收成为可能</span>
        <span class="en">AI Makes Smart Collections Possible</span>
      </h3>
      <p>
        <span class="zh">LLM和预测模型将催收成功率从35%提升到78%</span>
        <span class="en">LLMs and predictive models lift collection rates from 35% to 78%</span>
      </p>
    </div>
  </div>
</div>
```

---

### NEW Slide -- Case Studies (default) -- insert after Traction (position 9)

2-3 customer stories with real quotes and measurable outcomes.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">客户案例</span><span class="en">CASE STUDIES</span>
  </div>
  <h2>
    <span class="zh">客户的真实反馈</span>
    <span class="en">What Our Users Say</span>
  </h2>
  <div class="flex-3 mt-3">
    <div class="col reveal-item">
      <div class="quote">
        <p>
          <span class="zh">"以前每月花10小时催款，现在全自动。上线两周回款率提升了60%。"</span>
          <span class="en">"I used to spend 10hrs/month chasing payments. Now it is fully automated. Collection rate up 60% in two weeks."</span>
        </p>
      </div>
      <div class="case-meta mt-2">
        <strong>Sarah K.</strong>
        <p>
          <span class="zh">品牌设计师 &middot; 新加坡</span>
          <span class="en">Brand Designer &middot; Singapore</span>
        </p>
        <div class="tag green">
          <span class="zh">回款率 +60%</span><span class="en">+60% Collection Rate</span>
        </div>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="quote">
        <p>
          <span class="zh">"跨境收款手续费从5%降到1.5%，一个月省了将近$800。"</span>
          <span class="en">"Cross-border fees dropped from 5% to 1.5%. Saving nearly $800/month."</span>
        </p>
      </div>
      <div class="case-meta mt-2">
        <strong>Rizky A.</strong>
        <p>
          <span class="zh">全栈开发者 &middot; 雅加达</span>
          <span class="en">Full-Stack Developer &middot; Jakarta</span>
        </p>
        <div class="tag green">
          <span class="zh">费用 -70%</span><span class="en">-70% Fees</span>
        </div>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="quote">
        <p>
          <span class="zh">"现金流仪表盘让我终于能做财务规划了。这是我用过最好的工具。"</span>
          <span class="en">"The cash flow dashboard finally lets me plan ahead. Best tool I have ever used."</span>
        </p>
      </div>
      <div class="case-meta mt-2">
        <strong>Mei L.</strong>
        <p>
          <span class="zh">市场顾问 &middot; 曼谷</span>
          <span class="en">Marketing Consultant &middot; Bangkok</span>
        </p>
        <div class="tag green">
          <span class="zh">NPS 92</span><span class="en">NPS 92</span>
        </div>
      </div>
    </div>
  </div>
</div>
```

---

### NEW Slide -- Unit Economics (default) -- insert after Business Model (position 11)

CAC, LTV, payback period, gross margins. Hard numbers for Series A investors.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">单位经济</span><span class="en">UNIT ECONOMICS</span>
  </div>
  <h2>
    <span class="zh">健康的单位经济模型</span>
    <span class="en">Healthy Unit Economics at Scale</span>
  </h2>
  <div class="flex-4 mt-3">
    <div class="col reveal-item">
      <div class="beat-num" data-target="45" data-prefix="$">
        <span class="stat-big">$45</span>
      </div>
      <div class="stat-label">
        <span class="zh">获客成本 (CAC)</span>
        <span class="en">CAC</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="380" data-prefix="$">
        <span class="stat-big">$380</span>
      </div>
      <div class="stat-label">
        <span class="zh">生命周期价值 (LTV)</span>
        <span class="en">LTV</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="8.4" data-suffix="x">
        <span class="stat-big">8.4x</span>
      </div>
      <div class="stat-label">
        <span class="zh">LTV / CAC</span>
        <span class="en">LTV / CAC</span>
      </div>
    </div>
    <div class="col reveal-item">
      <div class="beat-num" data-target="4.2" data-suffix="">
        <span class="stat-big">4.2</span>
      </div>
      <div class="stat-label">
        <span class="zh">回收期（月）</span>
        <span class="en">Payback (months)</span>
      </div>
    </div>
  </div>
  <div class="flex mt-4">
    <div class="col reveal-item">
      <h3>
        <span class="zh">毛利率趋势</span>
        <span class="en">Gross Margin Trend</span>
      </h3>
      <div class="margin-bar">
        <div class="margin-fill" style="width:72%">
          <span>72%</span>
        </div>
      </div>
      <p class="data-source">
        <span class="zh">当前毛利率 72%，随规模效应预计提升至 80%+</span>
        <span class="en">Current 72% gross margin, projected 80%+ at scale</span>
      </p>
    </div>
    <div class="col reveal-item">
      <h3>
        <span class="zh">收入构成</span>
        <span class="en">Revenue Mix</span>
      </h3>
      <ul>
        <li>
          <span class="zh">交易手续费 65%</span>
          <span class="en">Transaction fees 65%</span>
        </li>
        <li>
          <span class="zh">Pro 订阅 25%</span>
          <span class="en">Pro subscriptions 25%</span>
        </li>
        <li>
          <span class="zh">金融产品 10%</span>
          <span class="en">Financial products 10%</span>
        </li>
      </ul>
    </div>
  </div>
</div>
```

---

### NEW Slide -- Growth Strategy (default) -- insert after Unit Economics (position 12)

Channels, GTM motion, and expansion plan.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">增长策略</span><span class="en">GROWTH STRATEGY</span>
  </div>
  <h2>
    <span class="zh">三阶段市场拓展计划</span>
    <span class="en">Three-Phase Go-to-Market Plan</span>
  </h2>
  <div class="flex-3 mt-3">
    <div class="col reveal-item">
      <div class="tag green">
        <span class="zh">阶段一：深耕</span><span class="en">Phase 1: Deepen</span>
      </div>
      <h3>
        <span class="zh">社区驱动增长</span>
        <span class="en">Community-Led Growth</span>
      </h3>
      <ul>
        <li>
          <span class="zh">自由职业者社区合作（Upwork、Fiverr论坛）</span>
          <span class="en">Freelancer community partnerships (Upwork, Fiverr forums)</span>
        </li>
        <li>
          <span class="zh">推荐奖励计划：邀请1人得1个月Pro</span>
          <span class="en">Referral program: invite 1, get 1 month Pro free</span>
        </li>
        <li>
          <span class="zh">内容营销：跨境收款指南系列</span>
          <span class="en">Content marketing: cross-border payment guide series</span>
        </li>
      </ul>
    </div>
    <div class="col reveal-item">
      <div class="tag orange">
        <span class="zh">阶段二：扩展</span><span class="en">Phase 2: Expand</span>
      </div>
      <h3>
        <span class="zh">平台合作</span>
        <span class="en">Platform Partnerships</span>
      </h3>
      <ul>
        <li>
          <span class="zh">接入自由职业平台API（支付插件）</span>
          <span class="en">Integrate with freelance platform APIs (payment plugin)</span>
        </li>
        <li>
          <span class="zh">与记账软件集成（QuickBooks、Xero）</span>
          <span class="en">Accounting integrations (QuickBooks, Xero)</span>
        </li>
        <li>
          <span class="zh">B2B渠道：企业端应付账款解决方案</span>
          <span class="en">B2B channel: enterprise accounts payable solution</span>
        </li>
      </ul>
    </div>
    <div class="col reveal-item">
      <div class="tag">
        <span class="zh">阶段三：生态</span><span class="en">Phase 3: Ecosystem</span>
      </div>
      <h3>
        <span class="zh">金融平台化</span>
        <span class="en">Financial Platform</span>
      </h3>
      <ul>
        <li>
          <span class="zh">嵌入式金融服务（保险、税务）</span>
          <span class="en">Embedded finance (insurance, tax filing)</span>
        </li>
        <li>
          <span class="zh">开发者API：第三方接入支付能力</span>
          <span class="en">Developer API: third-party payment integration</span>
        </li>
        <li>
          <span class="zh">新市场：LATAM、非洲</span>
          <span class="en">New markets: LATAM, Africa</span>
        </li>
      </ul>
    </div>
  </div>
</div>
```

---
---

## Template 3: Demo Day (8 slides, compressed)

Designed for 3-5 minute presentations. Every slide is punchy and minimal. No filler text.

---

### Slide 1 -- Cover `.red`

Brand, one-liner, round info. Nothing else.

```html
<div class="slide red">
  <div class="eyebrow">
    <span class="zh">YC W26 Demo Day</span><span class="en">YC W26 Demo Day</span>
  </div>
  <h1>
    <span class="zh">CompanyName</span>
    <span class="en">CompanyName</span>
  </h1>
  <p class="subtitle">
    <span class="zh">一句话描述你的公司</span>
    <span class="en">One sentence that explains what you do</span>
  </p>
</div>
```

---

### Slide 2 -- Problem (default)

3 bullets maximum. Large text. No paragraphs, no fluff.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">痛点</span><span class="en">THE PROBLEM</span>
  </div>
  <div class="big-bullets mt-3">
    <div class="reveal-item big-bullet">
      <span class="zh">67% 的自由职业者遭遇超30天延迟付款</span>
      <span class="en">67% of freelancers face payment delays over 30 days</span>
    </div>
    <div class="reveal-item big-bullet">
      <span class="zh">每月平均8小时浪费在催款上</span>
      <span class="en">8 hours/month wasted chasing invoices</span>
    </div>
    <div class="reveal-item big-bullet">
      <span class="zh">跨境手续费吃掉 5-8% 的收入</span>
      <span class="en">Cross-border fees eat 5-8% of earnings</span>
    </div>
  </div>
</div>
```

---

### Slide 3 -- Solution + Demo `.dark`

Product screenshot dominates. One sentence explanation. Let the product speak.

```html
<div class="slide dark">
  <div class="eyebrow">
    <span class="zh">解决方案</span><span class="en">THE SOLUTION</span>
  </div>
  <h2>
    <span class="zh">一键搞定，从发票到到账</span>
    <span class="en">From Invoice to Income, in One Click</span>
  </h2>
  <div class="product-screenshot mt-3 reveal-item">
    <!-- Replace with actual screenshot: <img src="demo.png" alt="Product Demo"> -->
    <div class="placeholder-screen large">
      <span class="zh">产品演示截图</span><span class="en">Product Demo Screenshot</span>
    </div>
  </div>
</div>
```

---

### Slide 4 -- Traction (default)

One hero metric dominates. Growth rate beside it. Nothing else competes for attention.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">增长数据</span><span class="en">TRACTION</span>
  </div>
  <div class="traction-hero mt-3">
    <div class="beat-num" data-target="2.1" data-prefix="$" data-suffix="M">
      <span class="stat-big">$2.1M</span>
    </div>
    <div class="stat-label">
      <span class="zh">月处理交易额</span>
      <span class="en">Monthly Processed Volume</span>
    </div>
  </div>
  <div class="flex mt-4">
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="32" data-suffix="%">
        <span class="stat-big">32%</span>
      </div>
      <div class="stat-label">
        <span class="zh">月环比增长</span>
        <span class="en">MoM Growth</span>
      </div>
    </div>
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="12500">
        <span class="stat-big">12,500</span>
      </div>
      <div class="stat-label">
        <span class="zh">活跃用户</span>
        <span class="en">Active Users</span>
      </div>
    </div>
  </div>
</div>
```

---

### Slide 5 -- Business Model (default)

One sentence describing the model. One key number proving it works.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">商业模式</span><span class="en">BUSINESS MODEL</span>
  </div>
  <h2>
    <span class="zh">每笔交易收取 1.5-2.5% 手续费</span>
    <span class="en">1.5-2.5% Fee on Every Transaction</span>
  </h2>
  <div class="flex mt-4">
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="8.4" data-suffix="x">
        <span class="stat-big">8.4x</span>
      </div>
      <div class="stat-label">
        <span class="zh">LTV / CAC</span>
        <span class="en">LTV / CAC</span>
      </div>
    </div>
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="72" data-suffix="%">
        <span class="stat-big">72%</span>
      </div>
      <div class="stat-label">
        <span class="zh">毛利率</span>
        <span class="en">Gross Margin</span>
      </div>
    </div>
  </div>
</div>
```

---

### Slide 6 -- Market Size (default)

TAM / SAM / SOM as 3 stat cards. No narrative text needed.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">市场规模</span><span class="en">MARKET SIZE</span>
  </div>
  <div class="flex-3 mt-4">
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="1.4" data-prefix="$" data-suffix="T">
        <span class="stat-big">$1.4T</span>
      </div>
      <div class="stat-label">
        <span class="zh">TAM</span><span class="en">TAM</span>
      </div>
      <p class="mt-1">
        <span class="zh">全球自由职业经济</span>
        <span class="en">Global Freelance Economy</span>
      </p>
    </div>
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="4.35" data-prefix="$" data-suffix="B">
        <span class="stat-big">$4.35B</span>
      </div>
      <div class="stat-label">
        <span class="zh">SAM</span><span class="en">SAM</span>
      </div>
      <p class="mt-1">
        <span class="zh">东南亚跨境支付</span>
        <span class="en">SEA Cross-Border Payments</span>
      </p>
    </div>
    <div class="col reveal-item" style="text-align:center">
      <div class="beat-num" data-target="180" data-prefix="$" data-suffix="M">
        <span class="stat-big">$180M</span>
      </div>
      <div class="stat-label">
        <span class="zh">SOM</span><span class="en">SOM</span>
      </div>
      <p class="mt-1">
        <span class="zh">3年可触达市场</span>
        <span class="en">3-Year Addressable</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 7 -- Team (default)

Photos only, no bios. Names and roles in minimal text. `.flex-3` or `.flex-4` layout.

```html
<div class="slide">
  <div class="eyebrow">
    <span class="zh">团队</span><span class="en">THE TEAM</span>
  </div>
  <div class="flex-3 mt-4">
    <div class="col reveal-item team-member compact">
      <div class="avatar">
        <!-- Replace: <img src="founder1.jpg" alt="Name"> -->
        <div class="avatar-placeholder">CEO</div>
      </div>
      <h3>
        <span class="zh">张明</span><span class="en">Ming Zhang</span>
      </h3>
      <p class="role">
        <span class="zh">CEO &middot; 前Stripe</span>
        <span class="en">CEO &middot; Ex-Stripe</span>
      </p>
    </div>
    <div class="col reveal-item team-member compact">
      <div class="avatar">
        <div class="avatar-placeholder">CTO</div>
      </div>
      <h3>
        <span class="zh">李华</span><span class="en">Hua Li</span>
      </h3>
      <p class="role">
        <span class="zh">CTO &middot; 前蚂蚁金服</span>
        <span class="en">CTO &middot; Ex-Ant Financial</span>
      </p>
    </div>
    <div class="col reveal-item team-member compact">
      <div class="avatar">
        <div class="avatar-placeholder">COO</div>
      </div>
      <h3>
        <span class="zh">王莉</span><span class="en">Li Wang</span>
      </h3>
      <p class="role">
        <span class="zh">COO &middot; 前Upwork</span>
        <span class="en">COO &middot; Ex-Upwork</span>
      </p>
    </div>
  </div>
</div>
```

---

### Slide 8 -- Ask `.red`

Funding amount and one sentence. That is all.

```html
<div class="slide red">
  <div class="eyebrow">
    <span class="zh">融资需求</span><span class="en">THE ASK</span>
  </div>
  <div class="beat-num mt-3" data-target="3" data-prefix="$" data-suffix="M">
    <span class="stat-big">$3M</span>
  </div>
  <div class="stat-label mb-3">
    <span class="zh">种子轮</span>
    <span class="en">Seed Round</span>
  </div>
  <p class="subtitle reveal-item">
    <span class="zh">18个月跑道 &middot; 10万月活 &middot; 5国市场</span>
    <span class="en">18-month runway &middot; 100K MAU &middot; 5 markets</span>
  </p>
  <div class="contact mt-4 reveal-item">
    <p>ming@example.com</p>
  </div>
</div>
```
