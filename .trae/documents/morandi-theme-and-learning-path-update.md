# 读书雷达 · 莫兰迪配色统一与学习路径更新说明

> 本轮为一次综合性前端更新，围绕两个目标：
> 1. **配色协调统一** —— 清除全站荧光色（`green-400/500`、`orange-400/500`、`blue-500`、`yellow-400/500`、`cyan/emerald` 高亮），统一为纸感主题下的莫兰迪低饱和色；领域色收敛到 `constants` 单一定义（`DOMAIN_COLORS`）。
> 2. **领域学习路径体验** —— 抽屉里每本书可点击跳转整页详情；「当前打开的领域」持久化到全局 store，从详情页返回列表时自动恢复原抽屉。
>
> 附带：版本对比去掉「删除 / 残影」类别、推荐指数筛选从滑杆改为分段按钮、雷达对比标记改为独立渲染层、列表页布局调整。

## 1. 更新背景

- 用户反馈：详情页 / 详情侧栏的「适合人群」绿色、「能力主题」橙色过于荧光（`*-400 / *-500` 直接压在米黄纸面上），与纸感主题不协调，要求与背景及其它部分颜色协调统一。
- 顺带清理全站残留的亮蓝（科技蓝 `blue-500`）与荧光强调色，统一到纸感主题的强调色 `#4a5d4e`（`--paper-accent`）及其变体。
- 用户反馈：领域学习路径抽屉里展示的每本书都应能点击查看书籍详情；跳转详情后返回列表时希望自动回到之前打开的领域（明确不接受「再叠一层书籍详情」的嵌套抽屉方案）。
- 版本对比的「删除残影」在「每领域 Top 8 且推荐指数 ≥3.0」的周更规则下容易让用户误以为书被删除，改为在对比面板以一行全局提示交代成员变动规则。

## 2. 改动清单（按模块）

### 2.1 领域色单一来源（`src/constants/index.ts`）

- `DOMAINS` 各领域的 `color` 从 Tailwind 亮色（`#3B82F6` 等）改为莫兰迪低饱和色板（墨绿 / 赭红 / 靛蓝 / 棕褐 / 蓝灰 / 绛紫 / 炭灰 / 褐橙）。
- 新增导出 `DOMAIN_COLORS: Record<Domain, string>`（由 `DOMAINS` 派生），作为**全站领域色唯一来源**。
- `RadarChart` 删除自持的 `MORANDI_DOMAIN_COLORS` 本地副本，改从 `constants` 读取，消除两处漂移风险。

### 2.2 全站荧光色清理（配色统一）

统一规则：文字 / 图标从 `*-400 / *-500` 荧光色 → `*-800` 深色；按钮 / 选中态 / 强调从亮蓝 → 纸感强调色 `#4a5d4e`（hover `#55685a`）；评分 / 推荐指数相关黄色 → `amber-800`（`#92400e`）。

- **`Detail` 页**：适合人群 `green-400/500 → green-800`、能力主题 `orange-400/500 → orange-800`、推荐指数 `yellow → amber-800`、推荐理由 `blue → #4a5d4e`、评分投票按钮从实心 amber 改为 `#4a5d4e` 描边样式。
- **`DetailSidebar`**：同步上述配色（星级、推荐理由、适合人群、能力主题、推荐人星级）。
- **评分 / 推荐全套抽屉**：`BookScoringDrawer / Form / Result / Records`、`RecommendationDrawer / Form / Result / Records`、`DraftConfirmModal` —— 提交按钮 / 返回浏览 / 输入框聚焦边框 `blue → #4a5d4e`；评分说明 / 记录芯片 `amber-200/300 → amber-800`；评分选项选中态改为 `border-amber-800 bg-amber-800 text-white`。
- **`Navbar`**：logo 与「书籍推荐」按钮 `blue → #4a5d4e`；激活态导航高亮 → `#8fb09e`（纸感浅绿）。
- **`Home` / `SearchFilter` / `ResourceCard` / `RadarChart`（tooltip 与 loading 转圈）**：图例圆点、筛选角标、统计数字、卡片 hover 描边、评分按钮、加载动画统一到 `#4a5d4e` 系。
- **`ListRecommendationShelf`**：三大面板强调色荧光 → 莫兰迪变体（本周热度 `blue → #7a5f33`、新增资料 `cyan → #3f6b6b`、长期高分 `emerald → #74586a`）；各处 `amber-200 → amber-800`；抽屉遮罩 `bg-slate-950/70 backdrop-blur-sm → bg-slate-950/40`。

### 2.3 推荐指数筛选：滑杆 → 分段按钮（`src/components/SearchFilter/index.tsx`）

- 移除 range 滑杆，改为 `3.0 / 3.5 / 4.0 / 4.5 / 5.0` 五个分段按钮（单选），选中态 `amber-800`。
- 默认值仍为 `3.0`，与雷达准入门槛一致。

### 2.4 版本对比：移除「删除 / 残影」类别

- `src/types/versionCompare.ts`：`VersionChangeType` 去掉 `'removed'`；`VersionCompareData` 去掉 `removedBooks` 字段。
- `src/utils/versionCompare.ts`：不再计算 `removedBooks`。
- `src/services/versionCompareService.ts`：演示数据去掉幽灵书（`ghost`），演示覆盖新增 / 升 / 降 3 种状态。
- `src/components/RadarChart/index.tsx`：删除 `renderRemovedGhosts` 与 removed 相关配色。
- `src/pages/Home/index.tsx`：「本周更新」面板去掉「删除」计数行，改为一行全局提示：**「雷达成员按每领域 Top 8 且指数 ≥3.0 每周变动，未在榜的书不单独标注。」**

### 2.5 雷达对比标记独立渲染层（`src/components/RadarChart/index.tsx`）

- 「新 / ↑ / ↓」徽标从圆点内部抽出为独立 `renderCompareMarkers()` 层，置于所有圆点之上，避免被相邻书籍圆点遮挡。
- 标记不拦截鼠标事件（`pointerEvents="none"`）；被 hover / 选中的圆点隐藏其标记，保证悬停 / 点击交互不变。

### 2.6 领域学习路径：书籍可点击 + 抽屉状态持久化

- **抽屉内书籍可点击**：每阶段书籍整块改为 `<button>`，点击 `navigate('/detail/{id}')` 跳转整页详情；hover 显示「查看详情 →」并以路径色（`#74586a`）高亮书名。
- **抽屉状态提升到全局 store**：`viewState.activePathDomain: Domain | null` + `setActivePathDomain()`（`src/types/index.ts`、`src/store/useResourceStore.ts`）。
  - 点领域卡片 → `setActivePathDomain(path.domain)`；点抽屉关闭按钮 → `setActivePathDomain(null)`。
  - 返回列表页时按 store 恢复**同一个领域**抽屉，跳转详情不打断路径浏览。
  - 注意：由于状态在全局 store，未关闭抽屉就离开列表页再回来时抽屉仍会打开（视为「记住看到哪」的有意设计）。
- **Detail 页返回兜底**：`onClick={() => (window.history.length > 1 ? navigate(-1) : navigate('/list'))}`，直接深链 / 刷新进入（无浏览历史）时不死链。

### 2.7 列表页布局调整

- `src/pages/List/index.tsx`：`ListRecommendationShelf` 移到书籍列表（`ResourceList`）**下方**。
- `src/components/ResourceList/index.tsx`：网格底部加 `mb-8`，避免与下方推荐书架贴太近。

## 3. 验证

- `npm run build` 通过（CSS 32.27 kB / JS 283.57 kB / 761ms）。
- 配色：`Detail`、`DetailSidebar` 两组件经 grep 确认无 `*-400 / *-500` 荧光文字残留。
- 学习路径流程：点领域 → 抽屉 → 点书 → 整页详情 → 返回 → 列表页自动恢复原领域抽屉；关闭抽屉后不残留。
- 回归：hover / 点击选中 / 筛选 / 详情侧栏 / 版本对比（新增、指数升降、离屏迷你标记）均不受影响。

## 4. 相关文档

- 配色与领域色规范：[ux-design-guidelines.md](./ux-design-guidelines.md)、[arch.md](./arch.md)
- 版本对比：radar-version-compare.md、[radar-home-visual-update.md](./radar-home-visual-update.md)
- 首页 / 列表结构：[homepage-design-spec.md](./homepage-design-spec.md)、[arch.md](./arch.md)
