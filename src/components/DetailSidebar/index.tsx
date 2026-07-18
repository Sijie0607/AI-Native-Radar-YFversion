import { X, BookOpen, User, Star, Target, BookMarked, Tag, CheckCircle, MessageSquare } from 'lucide-react';
import { useResourceStore } from '../../store/useResourceStore';
import { getDomainConfig, DIFFICULTIES } from '../../constants';

const DetailSidebar = () => {
  const { books, viewState, selectBook, toggleDetailPanel } = useResourceStore();
  const selectedBook = books.find(b => b.id === viewState.selectedBookId);

  if (!selectedBook) return null;

  const domainConfig = getDomainConfig(selectedBook.domain);
  const difficultyConfig = DIFFICULTIES[selectedBook.ringIndex];

  return (
    <div className="fixed inset-y-0 right-0 w-[450px] bg-slate-800 border-l border-slate-700 shadow-2xl z-50 transform transition-transform duration-300 ease-in-out translate-x-0">
      {/* 头部 */}
      <div className="p-6 border-b border-slate-700">
        <div className="flex items-start justify-between">
          <div className="flex-1 pr-4">
            <h2 className="text-2xl font-bold text-slate-50 mb-2">{selectedBook.title}</h2>
            {selectedBook.subtitle && (
              <p className="text-slate-400 text-sm mb-3">{selectedBook.subtitle}</p>
            )}
            <div className="flex items-center gap-2">
              <User size={16} className="text-slate-400" />
              <span className="text-slate-300 text-sm">{selectedBook.author}</span>
            </div>
          </div>
          <button
            onClick={() => {
              selectBook(null);
              toggleDetailPanel(false);
            }}
            className="p-2 hover:bg-slate-700 rounded-lg transition-colors"
          >
            <X size={20} className="text-slate-400" />
          </button>
        </div>
      </div>

      {/* 内容 */}
      <div className="overflow-y-auto h-[calc(100vh-80px)] p-6">
        {/* 封面 */}
        {selectedBook.cover && (
          <div className="mb-6 flex justify-center">
            <img
              src={selectedBook.cover}
              alt={selectedBook.title}
              className="w-48 h-72 object-cover rounded-lg shadow-lg"
            />
          </div>
        )}

        {/* 基本信息 */}
        <div className="space-y-4 mb-6">
          {/* 推荐指数 */}
          <div className="flex items-center gap-3 p-4 bg-slate-700/50 rounded-lg">
            <div className="flex items-center gap-1">
              {[...Array(5)].map((_, i) => (
                <Star
                  key={i}
                  size={20}
                  fill={i < Math.floor(selectedBook.recommendationScore) ? '#F59E0B' : 'none'}
                  className={i < Math.floor(selectedBook.recommendationScore) ? 'text-yellow-500' : 'text-slate-600'}
                />
              ))}
            </div>
            <div>
              <div className="text-2xl font-bold text-yellow-500">{selectedBook.recommendationScore.toFixed(1)}</div>
              <div className="text-xs text-slate-400">{selectedBook.votesCount} 人推荐</div>
            </div>
          </div>

          {/* 领域和难度 */}
          <div className="grid grid-cols-2 gap-4">
            <div className="p-4 bg-slate-700/50 rounded-lg">
              <div className="flex items-center gap-2 mb-1">
                <BookOpen size={16} className="text-slate-400" />
                <span className="text-slate-400 text-sm">领域</span>
              </div>
              <div className="font-medium" style={{ color: domainConfig.color }}>
                {domainConfig.name}
              </div>
            </div>
            <div className="p-4 bg-slate-700/50 rounded-lg">
              <div className="flex items-center gap-2 mb-1">
                <BookMarked size={16} className="text-slate-400" />
                <span className="text-slate-400 text-sm">难度</span>
              </div>
              <div className="font-medium text-slate-200">{difficultyConfig.name}</div>
            </div>
          </div>
        </div>

        {/* 推荐理由 */}
        <div className="mb-6">
          <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
            <MessageSquare size={20} className="text-blue-500" />
            推荐理由
          </h3>
          <div className="p-4 bg-slate-700/30 rounded-lg border-l-4 border-blue-500">
            <p className="text-slate-300 leading-relaxed">{selectedBook.reasonFull}</p>
          </div>
        </div>

        {/* 适合人群 */}
        <div className="mb-6">
          <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
            <User size={20} className="text-green-500" />
            适合人群
          </h3>
          <div className="flex flex-wrap gap-2">
            {selectedBook.fitFor.map((person, idx) => (
              <span
                key={idx}
                className="px-3 py-1 bg-green-500/20 text-green-400 rounded-full text-sm"
              >
                {person}
              </span>
            ))}
          </div>
        </div>

        {/* 核心收获 */}
        <div className="mb-6">
          <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
            <CheckCircle size={20} className="text-purple-500" />
            核心收获
          </h3>
          <ul className="space-y-2">
            {selectedBook.takeaways.map((takeaway, idx) => (
              <li key={idx} className="flex items-start gap-2 text-slate-300">
                <CheckCircle size={16} className="text-purple-500 mt-0.5 flex-shrink-0" />
                <span>{takeaway}</span>
              </li>
            ))}
          </ul>
        </div>

        {/* 标签 */}
        <div className="mb-6">
          <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
            <Tag size={20} className="text-cyan-500" />
            标签
          </h3>
          <div className="flex flex-wrap gap-2">
            {selectedBook.tags.map((tag, idx) => (
              <span
                key={idx}
                className="px-3 py-1 bg-slate-700 text-slate-300 rounded-full text-sm"
              >
                {tag}
              </span>
            ))}
          </div>
        </div>

        {/* 能力主题 */}
        {selectedBook.competenceThemes.length > 0 && (
          <div className="mb-6">
            <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
              <Target size={20} className="text-orange-500" />
              能力主题
            </h3>
            <div className="flex flex-wrap gap-2">
              {selectedBook.competenceThemes.map((theme, idx) => (
                <span
                  key={idx}
                  className="px-3 py-1 bg-orange-500/20 text-orange-400 rounded-full text-sm"
                >
                  {theme}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* 推荐人 */}
        {selectedBook.recommendations.length > 0 && (
          <div className="mb-6">
            <h3 className="text-lg font-semibold text-slate-50 mb-3 flex items-center gap-2">
              <User size={20} className="text-pink-500" />
              推荐人
            </h3>
            <div className="space-y-4">
              {selectedBook.recommendations.map((rec) => (
                <div key={rec.id} className="p-4 bg-slate-700/30 rounded-lg">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-slate-200">
                      {rec.isAnonymous ? '匿名用户' : rec.recommender}
                    </span>
                    <div className="flex items-center gap-1">
                      {[...Array(5)].map((_, i) => (
                        <Star
                          key={i}
                          size={14}
                          fill={i < rec.score ? '#F59E0B' : 'none'}
                          className={i < rec.score ? 'text-yellow-500' : 'text-slate-600'}
                        />
                      ))}
                    </div>
                  </div>
                  <p className="text-slate-400 text-sm">{rec.reason}</p>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default DetailSidebar;
