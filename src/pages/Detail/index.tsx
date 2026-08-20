import { useParams, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useResourceStore } from '../../store/useResourceStore';
import BookScoringDrawer from '../../components/BookScoringDrawer';
import { DIFFICULTIES, DOMAINS } from '../../constants';
import { ArrowLeft, Star, User, Target, BookMarked, MessageSquare, CheckCircle, Tag } from 'lucide-react';
import { useBookScoringStore } from '../../store/useBookScoringStore';

const Detail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [isScoringOpen, setIsScoringOpen] = useState(false);
  const { books } = useResourceStore();
  const { sessionScores } = useBookScoringStore();
  const book = books.find((b) => b.id === id);

  if (!book) {
    return (
      <main className="pt-16">
        <div className="container mx-auto px-4 py-8 text-center">
          <h1 className="text-2xl font-bold text-slate-50">书籍未找到</h1>
          <button
            onClick={() => navigate('/')}
            className="mt-4 text-[#4a5d4e] hover:underline"
          >
            返回首页
          </button>
        </div>
      </main>
    );
  }

  const domainConfig = DOMAINS.find((d) => d.id === book.domain) || DOMAINS[0];
  const difficultyConfig = DIFFICULTIES[book.ringIndex];
  const hasSessionScore = Boolean(sessionScores[book.id]);

  return (
    <main className="pt-16">
      <div className="container mx-auto px-4 py-8">
        <button
          onClick={() => (window.history.length > 1 ? navigate(-1) : navigate('/list'))}
          className="flex items-center gap-2 text-slate-400 hover:text-slate-50 mb-6"
        >
          <ArrowLeft size={20} />
          返回
        </button>

        <div className="paper-panel bg-slate-800 rounded-2xl border border-slate-700 p-8">
          <div className="flex flex-col lg:flex-row items-start gap-8">
            {book.cover && (
              <div className="flex-shrink-0">
                <img
                  src={book.cover}
                  alt={book.title}
                  className="w-48 h-72 object-cover rounded-xl shadow-lg"
                />
              </div>
            )}
            <div className="flex-1">
              <h1 className="text-3xl font-bold text-slate-50 mb-2">
                {book.title}
              </h1>
              {book.subtitle && (
                <p className="text-lg text-slate-400 mb-4">
                  {book.subtitle}
                </p>
              )}
              <div className="flex items-center gap-2 text-slate-300 mb-6">
                <User size={18} className="text-slate-500" />
                <span>{book.author}</span>
              </div>

              <div className="flex flex-wrap items-center gap-4 mb-6">
                <span
                  className="px-4 py-2 rounded-full text-sm font-medium text-white"
                  style={{ backgroundColor: domainConfig.color }}
                >
                  {domainConfig.name}
                </span>
                <div className="flex items-center gap-2 px-4 py-2 bg-amber-500/20 rounded-full">
                  <Star size={18} className="text-amber-800 fill-current" />
                  <span className="font-semibold text-amber-800">{book.recommendationScore.toFixed(1)}</span>
                  <span className="text-slate-400 text-sm">({book.votesCount} 人推荐)</span>
                </div>
                <span className="px-4 py-2 bg-slate-700 text-slate-300 rounded-full">
                  <BookMarked size={16} className="inline mr-1" />
                  {difficultyConfig.name}
                </span>
              </div>

              <div className="mb-8 flex flex-wrap gap-3">
                <button
                  type="button"
                  onClick={() => setIsScoringOpen(true)}
                  className="rounded-xl border border-[#4a5d4e]/40 bg-[#4a5d4e]/10 px-4 py-3 text-sm font-medium text-[#4a5d4e] transition-colors hover:border-[#4a5d4e]/60 hover:bg-[#4a5d4e]/20"
                >
                  {hasSessionScore ? '修改我的评分' : '评分投票'}
                </button>
                <p className="self-center text-sm text-slate-400">
                  提交后会实时刷新推荐指数，但本轮不会影响雷达展示。
                </p>
              </div>

              {/* 推荐理由 */}
              <div className="mb-8">
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <MessageSquare size={20} className="text-[#4a5d4e]" />
                  推荐理由
                </h3>
                <div className="paper-card p-6 bg-slate-700/50 rounded-xl border-l-4 border-[#4a5d4e]">
                  <p className="text-slate-300 leading-relaxed">{book.reasonFull}</p>
                </div>
              </div>

              {/* 适合人群 */}
              <div className="mb-8">
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <User size={20} className="text-green-800" />
                  适合人群
                </h3>
                <div className="flex flex-wrap gap-2">
                  {book.fitFor.map((person, index) => (
                    <span
                      key={index}
                      className="px-4 py-2 bg-green-500/20 text-green-800 rounded-full"
                    >
                      {person}
                    </span>
                  ))}
                </div>
              </div>

              {/* 核心收获 */}
              <div className="mb-8">
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <CheckCircle size={20} className="text-purple-500" />
                  核心收获
                </h3>
                <ul className="space-y-3">
                  {book.takeaways.map((takeaway, index) => (
                    <li key={index} className="flex items-start gap-3 text-slate-300">
                      <CheckCircle size={18} className="text-purple-500 mt-0.5 flex-shrink-0" />
                      <span>{takeaway}</span>
                    </li>
                  ))}
                </ul>
              </div>

              {/* 能力主题 */}
              <div className="mb-8">
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <Target size={20} className="text-orange-800" />
                  能力主题
                </h3>
                <div className="flex flex-wrap gap-2">
                  {book.competenceThemes.map((theme, index) => (
                    <span
                      key={index}
                      className="px-3 py-1 bg-orange-500/20 text-orange-800 rounded-full text-sm"
                    >
                      {theme}
                    </span>
                  ))}
                </div>
              </div>

              {/* 标签 */}
              <div className="mb-8">
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <Tag size={20} className="text-cyan-500" />
                  标签
                </h3>
                <div className="flex flex-wrap gap-2">
                  {book.tags.map((tag, index) => (
                    <span
                      key={index}
                      className="px-3 py-1 bg-slate-700 text-slate-300 rounded-full text-sm"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </div>

              {/* 推荐人 */}
              <div>
                <h3 className="text-lg font-semibold text-slate-50 mb-4 flex items-center gap-2">
                  <User size={20} className="text-pink-500" />
                  推荐人
                </h3>
                <div className="space-y-4">
                  {book.recommendations.map((rec) => (
                    <div
                      key={rec.id}
                      className="paper-card p-4 bg-slate-700/50 rounded-xl border-l-4 border-pink-500"
                    >
                      <div className="flex items-center justify-between mb-2">
                        <span className="font-medium text-slate-200">
                          {rec.isAnonymous ? '匿名用户' : rec.recommender}
                        </span>
                        <div className="flex items-center gap-1">
                          {[...Array(5)].map((_, i) => (
                            <Star
                              key={i}
                              size={14}
                              fill={i < rec.score ? '#92400e' : 'none'}
                              className={i < rec.score ? 'text-amber-800' : 'text-slate-600'}
                            />
                          ))}
                          <span className="text-sm text-slate-400 ml-1">{rec.score}</span>
                        </div>
                      </div>
                      <p className="text-slate-300">{rec.reason}</p>
                      <p className="text-xs text-slate-500 mt-2">
                        {rec.recommendedAt}
                      </p>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <BookScoringDrawer
        isOpen={isScoringOpen}
        book={book}
        onClose={() => setIsScoringOpen(false)}
      />
    </main>
  );
};

export default Detail;
