import { useEffect, useState } from 'react';
import RadarChart from '../../components/RadarChart';
import SearchFilter from '../../components/SearchFilter';
import DetailSidebar from '../../components/DetailSidebar';
import BookScoringDrawer from '../../components/BookScoringDrawer';
import { useResourceStore } from '../../store/useResourceStore';
import { mockService } from '../../mocks/mockData';
import { BookPlus, Info, Filter, ChevronLeft, ChevronRight } from 'lucide-react';
import { Book } from '../../types';

const Home = () => {
  const [isScoringOpen, setIsScoringOpen] = useState(false);
  const [activeScoringBook, setActiveScoringBook] = useState<Book | null>(null);
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

  const activeFilterCount =
    filters.domains.length +
    filters.difficultyLevels.length +
    (filters.minScore > 3 ? 1 : 0) +
    (filters.searchQuery ? 1 : 0);

  const openScoring = (book: Book) => {
    setActiveScoringBook(book);
    setIsScoringOpen(true);
  };

  // 加载数据
  useEffect(() => {
    const loadData = async () => {
      setLoadingStatus('loading');
      try {
        const books = await mockService.fetchBooks();
        setBooks(books);
        setLoadingStatus('success');
      } catch (error) {
        setLoadingStatus('error');
      }
    };

    loadData();
  }, [setBooks, setLoadingStatus]);

  return (
    <main className="pt-16">
      <div className="container mx-auto px-4 py-8">
        {/* 页面标题和介绍 */}
        <div className="mb-8 text-center">
          <h1 className="mb-4 text-3xl font-bold text-slate-50 sm:text-4xl">
            AI-Native 读书雷达
          </h1>
          <p className="mx-auto mb-6 max-w-2xl text-sm leading-7 text-slate-400 sm:text-base">
            探索 AI 领域的优质书籍，发现最适合你的学习路径。
            通过雷达图直观地浏览不同领域和难度的书籍推荐。
          </p>

          {/* 图例说明 */}
          <div className="inline-flex flex-wrap items-center justify-center gap-4 rounded-2xl border border-slate-700 bg-slate-800/50 px-5 py-3 sm:gap-6 sm:rounded-full sm:px-6">
            <div className="flex items-center gap-2">
              <div className="w-3 h-3 rounded-full bg-blue-500" />
              <span className="text-slate-400 text-sm">领域</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-8 h-0.5 bg-slate-600" style={{ borderStyle: 'dashed', borderWidth: 1 }} />
              <span className="text-slate-400 text-sm">难度圈</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 rounded-full bg-slate-500" />
              <span className="text-slate-400 text-sm">书籍</span>
            </div>
            <div className="flex items-center gap-2">
              <Info size={16} className="text-slate-500" />
              <span className="text-slate-400 text-sm">悬停查看详情</span>
            </div>
          </div>
        </div>

        <div className="flex flex-col gap-6 xl:flex-row xl:gap-8">
          {/* 左侧边栏 */}
          <aside
            className={`flex-shrink-0 transition-all duration-300 ${
              isSidebarCollapsed ? 'w-full xl:w-16' : 'w-full xl:w-80'
            }`}
          >
            {isSidebarCollapsed ? (
              <button
                type="button"
                onClick={toggleSidebarCollapsed}
                className="relative flex w-full items-center justify-between gap-3 rounded-xl border border-slate-700 bg-slate-800 px-4 py-3 text-slate-400 transition-colors hover:bg-slate-700 hover:text-slate-200 xl:justify-center xl:px-3"
                aria-label="展开筛选面板"
              >
                <span className="flex items-center gap-2 xl:hidden">
                  <Filter size={18} />
                  筛选面板
                </span>
                <Filter size={20} className="hidden xl:block" />
                <ChevronRight size={20} className="xl:hidden" />
                {activeFilterCount > 0 && (
                  <span className="rounded-full bg-blue-500 px-2 py-0.5 text-xs font-medium text-white xl:absolute xl:-right-2 xl:-top-2">
                    {activeFilterCount}
                  </span>
                )}
              </button>
            ) : (
              <div className="rounded-xl border border-slate-700 bg-slate-800 p-4 sm:p-6">
                <div className="mb-4 flex items-center justify-between">
                  <h3 className="text-lg font-semibold text-slate-50 flex items-center gap-2">
                    <Filter size={20} className="text-blue-500" />
                    筛选面板
                  </h3>
                  <button
                    type="button"
                    onClick={toggleSidebarCollapsed}
                    className="rounded-lg p-1.5 text-slate-400 hover:bg-slate-700 hover:text-slate-200 transition-colors"
                    aria-label="收起筛选面板"
                  >
                    <ChevronLeft size={20} />
                  </button>
                </div>

                <SearchFilter />

                {/* 统计信息 */}
                <div className="mt-6 bg-slate-900/50 rounded-xl p-4 border border-slate-700">
                  <div className="text-center">
                    <div className="text-3xl font-bold text-blue-500 mb-1">
                      {filteredBooks().length}
                    </div>
                    <div className="text-slate-400 text-sm">
                      符合条件的书籍
                    </div>
                  </div>
                </div>

                <button
                  type="button"
                  onClick={openRecommendation}
                  className="mt-4 flex w-full items-center justify-center gap-2 rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-all hover:bg-blue-400 hover:shadow-lg hover:shadow-blue-500/20"
                >
                  <BookPlus size={18} />
                  书籍推荐
                </button>
              </div>
            )}
          </aside>

          {/* 右侧：雷达图 */}
          <div className="min-w-0 flex-1">
            <div className="mx-auto w-full max-w-[720px] xl:max-w-[760px]">
              <RadarChart />
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
