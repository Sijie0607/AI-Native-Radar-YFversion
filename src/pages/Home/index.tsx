import { useEffect, useMemo, useState } from 'react';
import RadarChart from '../../components/RadarChart';
import DomainBookCard from '../../components/RadarLegend';
import { DOMAINS } from '../../constants';
import SearchFilter from '../../components/SearchFilter';
import DetailSidebar from '../../components/DetailSidebar';
import BookScoringDrawer from '../../components/BookScoringDrawer';
import { useResourceStore } from '../../store/useResourceStore';
import { resourceService } from '../../services/resourceService';
import { versionCompareService } from '../../services/versionCompareService';
import { computeVersionCompareData } from '../../utils/versionCompare';
import {
  BookPlus,
  Info,
  Filter,
  ChevronLeft,
  ChevronRight,
  History,
  X,
} from 'lucide-react';
import { Book } from '../../types';
import { VersionDiff } from '../../types/versionCompare';
import { buildRadarData } from '../../utils/radarLayout';

const Home = () => {
  const [isScoringOpen, setIsScoringOpen] = useState(false);
  const [activeScoringBook, setActiveScoringBook] = useState<Book | null>(null);
  // 历史版本对比（本地态，不进 store）：diff 拉取一次后缓存复用
  const [versionCompare, setVersionCompare] = useState<{
    active: boolean;
    loading: boolean;
    notice: string | null;
    diff: VersionDiff | null;
  }>({ active: false, loading: false, notice: null, diff: null });
  const {
    books,
    filters,
    setBooks,
    setLoadingStatus,
    viewState,
    filteredBooks,
    openRecommendation,
    toggleSidebarCollapsed,
  } = useResourceStore();

  const isSidebarCollapsed = viewState.isSidebarCollapsed;

  const radarData = useMemo(() => buildRadarData(books, filters), [books, filters]);

  const activeFilterCount =
    filters.domains.length +
    filters.difficultyLevels.length +
    (filters.minScore !== 3 ? 1 : 0) +
    (filters.searchQuery ? 1 : 0);

  const openScoring = (book: Book) => {
    setActiveScoringBook(book);
    setIsScoringOpen(true);
  };

  // 进入/退出"本周更新"对比；diff 已缓存则直接激活，否则拉取（null=真无上一版，不兜底 mock）
  const handleToggleCompare = async () => {
    if (versionCompare.active) {
      setVersionCompare((prev) => ({ ...prev, active: false, notice: null }));
      return;
    }
    if (versionCompare.diff) {
      setVersionCompare((prev) => ({ ...prev, active: true, notice: null }));
      return;
    }
    setVersionCompare((prev) => ({ ...prev, loading: true, notice: null }));
    try {
      const diff = await versionCompareService.fetchVersionDiff(books);
      if (!diff) {
        setVersionCompare((prev) => ({
          ...prev,
          loading: false,
          notice: '暂无上一版本可对比',
        }));
        return;
      }
      setVersionCompare((prev) => ({ ...prev, loading: false, active: true, diff }));
    } catch (error) {
      setVersionCompare((prev) => ({
        ...prev,
        loading: false,
        notice: '版本数据加载失败，请稍后重试',
      }));
    }
  };

  // 当前 vs 上一版 的变化数据（仅 active 且有上一版快照时计算）
  const versionCompareData = useMemo(() => {
    if (!versionCompare.active || !versionCompare.diff) return null;
    if (!versionCompare.diff.previousBooks.length) return null;
    return computeVersionCompareData(books, versionCompare.diff.previousBooks);
  }, [versionCompare.active, versionCompare.diff, books]);

  // 面板计数：基于全量 books（含被筛选隐藏的书），removed 来自上一版残影
  const compareCounts = useMemo(() => {
    if (!versionCompareData) {
      return { added: 0, scoreUp: 0, scoreDown: 0 };
    }
    let added = 0;
    let scoreUp = 0;
    let scoreDown = 0;
    Object.values(versionCompareData.changesByBookId).forEach((change) => {
      if (change.type === 'added') added += 1;
      else if (change.type === 'score_up') scoreUp += 1;
      else if (change.type === 'score_down') scoreDown += 1;
    });
    return {
      added,
      scoreUp,
      scoreDown,
    };
  }, [versionCompareData]);

  // 周次日期展示：'2026-08-13' → '8月13日'
  const fmtDate = (value?: string | null) => {
    if (!value) return '';
    const d = new Date(value);
    if (Number.isNaN(d.getTime())) return value.slice(0, 10);
    return `${d.getMonth() + 1}月${d.getDate()}日`;
  };

  // 加载数据
  useEffect(() => {
    const loadData = async () => {
      setLoadingStatus('loading');
      try {
        const books = await resourceService.fetchBooks();
        setBooks(books);
        setLoadingStatus('success');
      } catch (error) {
        setLoadingStatus('error');
      }
    };

    loadData();
  }, [setBooks, setLoadingStatus]);

  return (
    <main className="pt-14">
      <div className="mx-auto max-w-[1440px] px-4 py-4 lg:px-5">
        {/* 页面标题和介绍 */}
        <div className="mb-4 text-center">
          <h1 className="mb-2 text-2xl font-bold text-slate-50 sm:text-3xl">
            AI-Native 读书雷达
          </h1>
          <p className="mx-auto mb-3 max-w-xl text-sm leading-6 text-slate-400">
            探索 AI 领域的优质资料，发现最适合你的学习路径。
            通过雷达图直观地浏览不同领域和难度的资料推荐。
          </p>

          {/* 图例说明 */}
          <div className="paper-panel inline-flex flex-wrap items-center justify-center gap-3 rounded-2xl border border-slate-700 bg-slate-800/50 px-4 py-2 sm:rounded-full">
            <div className="flex items-center gap-2">
              <div className="h-4 w-4 rounded-full bg-slate-500 text-center text-[9px] font-semibold leading-4 text-white">
                1
              </div>
              <span className="text-xs text-slate-400">资料编号</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="h-3 w-3 rounded-full bg-[var(--paper-accent)]" />
              <span className="text-xs text-slate-400">领域</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="h-0.5 w-7 bg-slate-600" style={{ borderStyle: 'dashed', borderWidth: 1 }} />
              <span className="text-xs text-slate-400">难度圈</span>
            </div>
            <div className="flex items-center gap-2">
              <Info size={14} className="text-slate-500" />
              <span className="text-xs text-slate-400">悬停查看详情</span>
            </div>
          </div>

          {/* 历史版本对比入口 */}
          <div className="mt-3 flex flex-col items-center gap-2">
            <button
              type="button"
              onClick={handleToggleCompare}
              disabled={versionCompare.loading}
              className={`inline-flex items-center gap-2 rounded-full border border-[var(--paper-border)] bg-[var(--paper-panel)] px-4 py-1.5 text-xs font-medium text-[var(--paper-ink)] shadow-sm transition-all hover:bg-[var(--paper-card)] disabled:cursor-not-allowed disabled:opacity-60 ${
                versionCompare.active ? 'ring-2 ring-[var(--paper-accent)]' : ''
              }`}
            >
              <History size={14} />
              {versionCompare.loading
                ? '加载中...'
                : versionCompare.active
                  ? '退出对比'
                  : '本周更新'}
            </button>
          {versionCompare.notice && (
            <p className="text-sm text-[var(--paper-muted)]">{versionCompare.notice}</p>
          )}
        </div>

        {/* 版本对比说明面板：固定在导航下方，避免被雷达外圈书名纸片覆盖 */}
        {versionCompare.active && versionCompare.diff && (
          <div className="fixed right-4 top-20 z-[49] w-[min(calc(100vw-2rem),18rem)] rounded-xl border border-[var(--paper-border)] bg-[var(--paper-panel)] p-3 text-left text-[var(--paper-ink)] shadow-[0_18px_45px_rgba(70,52,28,0.18)] backdrop-blur-sm lg:right-6">
            <div className="mb-1 flex items-start justify-between gap-2">
              <div>
                <h3 className="text-sm font-bold">
                  第 {versionCompare.diff.currentVersion?.versionNumber ?? '?'} 期
                  vs 第 {versionCompare.diff.previousVersion?.versionNumber ?? '?'} 期
                </h3>
                <p className="text-xs text-[var(--paper-muted)]">
                  {versionCompare.diff.currentVersion
                    ? `${fmtDate(versionCompare.diff.currentVersion.weekStart)} 起`
                    : ''}
                </p>
              </div>
              <button
                type="button"
                onClick={handleToggleCompare}
                className="rounded-md p-1 text-[var(--paper-muted)] transition-colors hover:bg-[var(--paper-card)] hover:text-[var(--paper-ink)]"
                aria-label="退出对比"
              >
                <X size={16} />
              </button>
            </div>

            <div className="mt-2 space-y-1 text-xs">
              <div className="flex items-center justify-between">
                <span className="flex items-center gap-1.5">
                  <span className="inline-block h-2.5 w-2.5 rounded-full" style={{ backgroundColor: '#3f6b4f' }} />
                  <span className="text-[var(--paper-muted)]">新增</span>
                </span>
                <span className="font-semibold">{compareCounts.added}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="flex items-center gap-1.5">
                  <span className="font-bold text-[var(--paper-accent)]">↑</span>
                  <span className="text-[var(--paper-muted)]">指数升</span>
                </span>
                <span className="font-semibold">{compareCounts.scoreUp}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="flex items-center gap-1.5">
                  <span className="font-bold" style={{ color: '#9c5a30' }}>↓</span>
                  <span className="text-[var(--paper-muted)]">指数降</span>
                </span>
                <span className="font-semibold">{compareCounts.scoreDown}</span>
              </div>
            </div>

            {compareCounts.added + compareCounts.scoreUp + compareCounts.scoreDown === 0 && (
              <p className="mt-2 text-center text-xs text-[var(--paper-muted)]">
                本周无变化
              </p>
            )}

            <p className="mt-2 border-t border-[var(--paper-border)] pt-2 text-[11px] leading-4 text-[var(--paper-muted)]">
              雷达成员按每领域 Top 8 且指数 ≥3.0 每周变动，未在榜的书不单独标注。
            </p>
          </div>
        )}
        </div>

        <div className="flex flex-col gap-4 xl:flex-row xl:items-start xl:gap-6">
          {/* 左侧边栏 */}
          <aside
            className={`flex-shrink-0 transition-all duration-300 ${
              isSidebarCollapsed ? 'w-full xl:w-14' : 'w-full xl:w-72'
            }`}
          >
            {isSidebarCollapsed ? (
              <button
                type="button"
                onClick={toggleSidebarCollapsed}
                className="paper-card relative flex w-full items-center justify-between gap-3 rounded-xl border border-slate-700 bg-slate-800 px-4 py-3 text-slate-400 transition-colors hover:bg-slate-700 hover:text-slate-200 xl:justify-center xl:px-3"
                aria-label="展开筛选面板"
              >
                <span className="flex items-center gap-2 xl:hidden">
                  <Filter size={18} />
                  筛选面板
                </span>
                <Filter size={20} className="hidden xl:block" />
                <ChevronRight size={20} className="xl:hidden" />
                {activeFilterCount > 0 && (
                  <span className="rounded-full bg-[var(--paper-accent)] px-2 py-0.5 text-xs font-medium text-white xl:absolute xl:-right-2 xl:-top-2">
                    {activeFilterCount}
                  </span>
                )}
              </button>
            ) : (
              <div className="paper-panel rounded-xl border border-slate-700 bg-slate-800 p-4">
                <div className="mb-3 flex items-center justify-between">
                  <h3 className="flex items-center gap-2 text-base font-semibold text-slate-50">
                    <Filter size={18} className="text-[var(--paper-accent)]" />
                    筛选面板
                  </h3>
                  <button
                    type="button"
                    onClick={toggleSidebarCollapsed}
                    className="rounded-lg p-1.5 text-slate-400 transition-colors hover:bg-slate-700 hover:text-slate-200"
                    aria-label="收起筛选面板"
                  >
                    <ChevronLeft size={20} />
                  </button>
                </div>

                <SearchFilter />

                {/* 统计信息 */}
                <div className="paper-card mt-4 rounded-xl border border-slate-700 bg-slate-900/50 p-3">
                  <div className="text-center">
                    <div className="mb-1 text-2xl font-bold text-[var(--paper-accent)]">
                      {filteredBooks().length}
                    </div>
                    <div className="text-sm text-slate-400">符合条件的资料</div>
                  </div>
                </div>

                <button
                  type="button"
                  onClick={openRecommendation}
                  className="mt-3 flex w-full items-center justify-center gap-2 rounded-xl bg-[var(--paper-accent)] px-4 py-2.5 text-sm font-medium text-white transition-all hover:opacity-90 hover:shadow-lg hover:shadow-[#0E42D2]/20"
                >
                  <BookPlus size={18} />
                  资料推荐
                </button>
              </div>
            )}
          </aside>

          {/* 右侧：雷达 + 浮动书名纸片 */}
          <div className="min-w-0 flex-1">
            <div className="mx-auto w-full max-w-[1280px]">
              {/* 宽屏舞台：雷达居中，周围书名纸片用左右留白分散摆放 */}
              <div
                className="relative mx-auto w-full"
                style={{ height: 'min(1040px, calc(100vh - 160px))', minHeight: 620 }}
              >
                {/* 雷达为主体：同比例放大，仍按视口高度收敛，避免桌面首屏过度滚动 */}
                <div
                  className="absolute left-1/2 top-1/2 aspect-square w-full -translate-x-1/2 -translate-y-1/2"
                  style={{ maxWidth: 'min(1040px, calc(100vh - 160px))' }}
                >
                  <RadarChart
                    points={radarData.points}
                    domainGroups={radarData.domainGroups}
                    versionChanges={versionCompareData}
                    className="absolute inset-0"
                  />

                </div>

              {/* 8 个领域书名框：lg+ 收拢到雷达外圈，轻微浮动但不倾斜；<lg 隐藏 */}
              <div className="pointer-events-none absolute inset-0 z-10 hidden lg:block">
                {/* 上方：AI 前沿趋势 */}
                <div className="pointer-events-auto absolute left-1/2 top-[2%] w-[26%] -translate-x-1/2">
                  <DomainBookCard
                    domain={DOMAINS[7]}
                    items={radarData.domainGroups[DOMAINS[7].id] || []}
                    listMaxHeight="max-h-[84px]"
                    floating
                    floatingDelay="-1.6s"
                  />
                </div>
                {/* 右上：AI 工程 */}
                <div className="pointer-events-auto absolute right-[10%] top-[8%] w-[21%]">
                  <DomainBookCard
                    domain={DOMAINS[0]}
                    items={radarData.domainGroups[DOMAINS[0].id] || []}
                    listMaxHeight="max-h-[120px]"
                    floating
                    floatingDelay="-0.4s"
                  />
                </div>
                {/* 右侧：AI 产品设计 */}
                <div className="pointer-events-auto absolute right-[7%] top-1/2 w-[18%] -translate-y-1/2">
                  <DomainBookCard
                    domain={DOMAINS[1]}
                    items={radarData.domainGroups[DOMAINS[1].id] || []}
                    listMaxHeight="max-h-[150px]"
                    itemTextClass="text-[10px]"
                    stripTagPrefix
                    floating
                    floatingDelay="-2.2s"
                  />
                </div>
                {/* 右下：Agent 与智能体 */}
                <div className="pointer-events-auto absolute bottom-[8%] right-[10%] w-[21%]">
                  <DomainBookCard
                    domain={DOMAINS[2]}
                    items={radarData.domainGroups[DOMAINS[2].id] || []}
                    listMaxHeight="max-h-[120px]"
                    floating
                    floatingDelay="-3s"
                  />
                </div>
                {/* 下方：AI 组织变革 */}
                <div className="pointer-events-auto absolute bottom-[2%] left-1/2 w-[26%] -translate-x-1/2">
                  <DomainBookCard
                    domain={DOMAINS[3]}
                    items={radarData.domainGroups[DOMAINS[3].id] || []}
                    listMaxHeight="max-h-[84px]"
                    floating
                    floatingDelay="-0.9s"
                  />
                </div>
                {/* 左下：数据智能与知识 */}
                <div className="pointer-events-auto absolute bottom-[8%] left-[10%] w-[21%]">
                  <DomainBookCard
                    domain={DOMAINS[4]}
                    items={radarData.domainGroups[DOMAINS[4].id] || []}
                    listMaxHeight="max-h-[120px]"
                    floating
                    floatingDelay="-2.7s"
                  />
                </div>
                {/* 左侧：AI 商业落地 */}
                <div className="pointer-events-auto absolute left-[7%] top-1/2 w-[18%] -translate-y-1/2">
                  <DomainBookCard
                    domain={DOMAINS[5]}
                    items={radarData.domainGroups[DOMAINS[5].id] || []}
                    listMaxHeight="max-h-[150px]"
                    itemTextClass="text-[10px]"
                    stripTagPrefix
                    floating
                    floatingDelay="-1.2s"
                  />
                </div>
                {/* 左上：AI 伦理治理 */}
                <div className="pointer-events-auto absolute left-[10%] top-[8%] w-[21%]">
                  <DomainBookCard
                    domain={DOMAINS[6]}
                    items={radarData.domainGroups[DOMAINS[6].id] || []}
                    listMaxHeight="max-h-[120px]"
                    floating
                    floatingDelay="-3.4s"
                  />
                </div>
              </div>
              </div>

              {/* 8 个领域书名卡：次要、紧凑，两行四列排开，与雷达零重叠（仅 <lg 显示） */}
              <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-4 lg:hidden">
                <DomainBookCard domain={DOMAINS[0]} items={radarData.domainGroups[DOMAINS[0].id] || []} />
                <DomainBookCard domain={DOMAINS[1]} items={radarData.domainGroups[DOMAINS[1].id] || []} />
                <DomainBookCard domain={DOMAINS[2]} items={radarData.domainGroups[DOMAINS[2].id] || []} />
                <DomainBookCard domain={DOMAINS[3]} items={radarData.domainGroups[DOMAINS[3].id] || []} />
                <DomainBookCard domain={DOMAINS[4]} items={radarData.domainGroups[DOMAINS[4].id] || []} />
                <DomainBookCard domain={DOMAINS[5]} items={radarData.domainGroups[DOMAINS[5].id] || []} />
                <DomainBookCard domain={DOMAINS[6]} items={radarData.domainGroups[DOMAINS[6].id] || []} />
                <DomainBookCard domain={DOMAINS[7]} items={radarData.domainGroups[DOMAINS[7].id] || []} />
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* 详情侧边栏 */}
      {viewState.isDetailPanelOpen && (
        <DetailSidebar
          onScoreClick={() => {
            const targetBook = viewState.selectedBookId
              ? books.find((item) => item.id === viewState.selectedBookId) ?? null
              : null;
            if (!targetBook) {
              return;
            }

            openScoring(targetBook);
          }}
        />
      )}
      <BookScoringDrawer
        isOpen={isScoringOpen}
        book={activeScoringBook}
        onClose={() => {
          setIsScoringOpen(false);
          setActiveScoringBook(null);
        }}
      />
    </main>
  );
};

export default Home;
