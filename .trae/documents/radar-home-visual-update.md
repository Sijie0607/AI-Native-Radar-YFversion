# 读书雷达 · 首页视觉改版与功能更新说明

> 本轮为一次综合性前端更新：以「雷达为主体」重构首页布局（纸感主题 + 8 领域书名框环绕雷达），
> 并同步落地历史版本对比（前端部分）与雷达默认显示阈值调整。
> 版本对比完整产品 Brief 见 [radar-version-compare.md](./radar-version-compare.md)。

## 1. 更新背景

- 原首页雷达在图内堆叠书名，视觉上「书名与雷达主次颠倒」：雷达反而被挤压变小。
- 期望主次关系：**雷达是主体**（大、明显），书名框是次要的（紧凑、环绕雷达摆放）。
- 用户连续迭代反馈：雷达要大 → 布局要环绕 → 书名要显示全 → 书名尽量一行放下。
- 同时存在两条待落地的功能线：历史版本对比（前端实现）+ 雷达默认显示阈值（4.0 → 3.0）。

## 2. 改动清单（按模块）

### 2.1 纸感主题雷达视觉改版

**布局（src/pages/Home/index.tsx）**
- 雷达为主体：右侧区域 `max-w-[1000px]`、`aspect-square`，`RadarChart` 撑满整个雷达区，恢复「调整书名框布局之前」的大小。
- 8 个领域书名框**环绕雷达**（lg 及以上）：按上/右上/右/右下/下/左下/左/左上 8 个罗盘点位摆放，各自贴近对应领域扇形方位。
  - 对应关系来自扇区几何：sector i 中心角 = `(i+0.5)*45° - 90°`（SVG y 向下坐标）→ 0=右上、1=右、2=右下、3=下、4=左下、5=左、6=左上、7=上。
- 窄屏（<lg）降级为雷达下方「两行四列」网格，与雷达零重叠。
- 版本对比浮层面板（左上角）叠加在雷达区之上，不参与环绕。

**纸感主题（src/index.css + src/components/RadarChart/index.tsx）**
- 米黄纸纹背景：`--paper-*` CSS 变量、`.paper-app / .paper-panel / .paper-card / .paper-drawer` 纸面类，`slate` 系列颜色经 `.paper-app` 覆写映射到纸感色板。
- SVG 雷达：径向渐变纸底 + `feTurbulence` grain 纸纹滤镜；纸纹经 `clipPath#radar-circle-clip` **只作用于圆内**，圆外四角保持透明，露出下方书名框。
- 8 领域使用莫兰迪低饱和色板（`getMorandiDomainColor`）。
- 雷达内部结构沿用：8 扇区（扇形花瓣按领域书量缩放半径）、8 条罗盘线、3 层难度虚线环（带慢速旋转动画）、中心准星、领域斜体标签。

**全局编号（src/utils/radarLayout.ts）**
- 新增 `NUMBER_DOMAIN_ORDER`（逆时针 `[0,1,2,4,7,6,5,3]`），为每本书分配**跨领域连续的 displayNumber**：按九宫格逆时针顺序遍历领域、领域内按推荐分降序。
- 同一份 `RadarBookItem` 同时驱动雷达点标签与书名框列表，编号一致对应（书 1、书 2…）。
- 仅重排卡片展示顺序并改写 `displayNumber`，雷达点的难度环位置不受影响。

### 2.2 书名显示优化（环绕布局收尾）

- 左右框（AI 产品设计 / AI 商业落地）加宽：`13% → 18%`（约 130px → 180px），书名字号 11px → 10px。
- 左右框书名**去掉开头的 `【产品】/【FDE】` 分类标签**（框头已标明领域，属冗余信息；悬停仍显示完整书名），使多数书名一行放下。
  - 实现：`DomainBookCard` 新增 `itemTextClass`（书名行字号）与 `stripTagPrefix`（去前缀）两个可选 props。
- 雷达纸纹圆 `maxRadius 320 → 280`，让出左右通道（1000px 框内圆约 711px → 622px，仍大于改版前参考的 544px）。
- 四角框加宽 `22% → 24%`、列表高度 150px → 170px。
- **几何取舍（已知限制）**：左右槽位宽度受圆的外沿卡死（圆 280 时约 180px 上限）。带长括号的书名（如「业务流程建模与重构（价值流/业务本体/知识管理等)」≈ 25 字）一行物理放不下，会折成 2 行、完整显示；强制一行只能省略号截断，本轮不采用。

### 2.3 历史版本对比（本周更新，前端落地）

**后端（supabase/migrations/003_radar_versions.sql）**
- 新增表：`radar_versions`（版本元数据）、`radar_version_books`（版本内每本书快照，`resource_id` 故意不加外键以支持幽灵书）。
- 新增 RPC：`generate_weekly_version()`（当前雷达全量快照生成新版本）、`get_version_diff()`（返回最近两版的元数据 + 上一版书目快照）。
- 含可删除的演示数据：构造「上周 vs 本周」假差异，使首次调用即有 新增/升/降/删除残影 4 种状态。

**前端（src/types/versionCompare.ts、utils/versionCompare.ts、services/versionCompareService.ts）**
- `computeVersionCompareData()`：以 resourceId 匹配，产出 `changesByBookId`（added / score_up / score_down / unchanged）、`removedBooks`、`changedBooks`。
- `versionCompareService.fetchVersionDiff()`：后端未配置 / RPC 失败时回退本地演示数据；后端可用但「确无上一版」时不兜底（真实无对比）。
- `RadarChart` 对比态渲染：删除书渲染虚线残影（「删」字、不占点位）、被筛选隐藏但有变化的书渲染离屏迷你标记、雷达点位上叠加「新 / ↑ / ↓」徽标（selected > hover > 对比态 > 默认）。
- `Home`：左侧「本周更新」入口按钮 + 左上角浮层面板（新增 / 删除 / 指数升 / 指数降 计数），diff 拉取一次后本地缓存复用。

### 2.4 雷达默认显示阈值 4.0 → 3.0

- `src/store/useResourceStore.ts`：初始 `filters` 与 `clearFilters` 重置处 `minScore: 4 → 3`。
- `src/pages/Home/index.tsx`：`activeFilterCount` 的「分数非默认值」判断同步改为 `!== 3`。
- 对齐产品文档 §5.3「每领域 Top 8 且推荐指数 ≥ 3.0」：默认视角雷达不再出现空领域（mock 数据下从 10 个点增至 25 个点，全部 8 领域有书）。
- 默认值改回 4.0 只需改回这 3 处字面量。

## 3. 验证

- `npx tsc --noEmit` 通过。
- `npm run build` 通过。
- 本地 dev server（:5173）HTTP 200。
- 回归点：hover / 点击选中 / 筛选 / 详情侧栏 / 版本对比（新增、删除残影、指数升降标记）均不受影响。

## 4. 相关文档

- 版本对比产品 Brief：[radar-version-compare.md](./radar-version-compare.md)
- 首页设计规范：[homepage-design-spec.md](./homepage-design-spec.md)

## 5. 后续可选事项

- 书名更宽松：继续缩小雷达圆换更宽框、把「去前缀」扩展到全部 8 框统一、或对超长书名采用省略号 + 悬停看全名。
- 版本保留周期 / AI 自动审核落地 / 周更定时触发：见 radar-version-compare.md §9 待确认假设。
