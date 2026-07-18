import { useEffect, useState } from 'react';
import Navbar from '../../components/Navbar';
import RadarChart from '../../components/RadarChart';
import SearchFilter from '../../components/SearchFilter';
import DetailSidebar from '../../components/DetailSidebar';
import RecommendationDrawer from '../../components/RecommendationDrawer';
import { useResourceStore } from '../../store/useResourceStore';
import { mockService } from '../../mocks/mockData';
import { BookPlus, Info } from 'lucide-react';

const Home = () => {
  const [isRecommendationOpen, setIsRecommendationOpen] = useState(false);
  const { setBooks, setLoadingStatus, viewState, filteredBooks, selectBook, toggleDetailPanel } = useResourceStore();

  const openRecommendation = () => {
    if (viewState.isDetailPanelOpen) {
      selectBook(null);
      toggleDetailPanel(false);
    }
    setIsRecommendationOpen(true);
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
    <div className="min-h-screen bg-slate-900">
      <Navbar onRecommendClick={openRecommendation} />
      <main className="pt-16">
        <div className="container mx-auto px-4 py-8">
          {/* 页面标题和介绍 */}
          <div className="text-center mb-8">
            <h1 className="text-4xl font-bold text-slate-50 mb-4">
              AI-Native 读书雷达
            </h1>
            <p className="text-slate-400 max-w-2xl mx-auto mb-6">
              探索 AI 领域的优质书籍，发现最适合你的学习路径。
              通过雷达图直观地浏览不同领域和难度的书籍推荐。
            </p>
            
            {/* 图例说明 */}
            <div className="inline-flex items-center gap-6 bg-slate-800/50 px-6 py-3 rounded-full border border-slate-700">
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

          <div className="flex gap-8">
            {/* 左侧：筛选面板 */}
            <div className="w-80 flex-shrink-0">
              <SearchFilter />
              
              {/* 统计信息 */}
              <div className="mt-6 bg-slate-800 rounded-xl p-4 border border-slate-700">
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
                推荐一本书
              </button>
            </div>

            {/* 右侧：雷达图 */}
            <div className="flex-1">
              <RadarChart />
            </div>
          </div>
        </div>
      </main>

      {/* 详情侧边栏 */}
      {viewState.isDetailPanelOpen && <DetailSidebar />}
      <RecommendationDrawer
        isOpen={isRecommendationOpen}
        onClose={() => setIsRecommendationOpen(false)}
      />
    </div>
  );
};

export default Home;
