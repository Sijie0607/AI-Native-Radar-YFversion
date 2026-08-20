import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { BookOpen, ChevronDown, Clock3, MessageSquare, Star, TrendingUp, X } from 'lucide-react';
import { DIFFICULTIES, DOMAIN_COLORS, DOMAIN_LABELS, DOMAINS } from '../../constants';
import { Book, DifficultyLevel, Domain, Recommendation } from '../../types';
import { useResourceStore } from '../../store/useResourceStore';

interface ListRecommendationShelfProps {
  books: Book[];
}

interface RankedBook {
  book: Book;
  count: number;
}

interface WeeklyNewBook {
  book: Book;
  date: string;
  source: 'created' | 'recommended';
}

interface LearningPath {
  domain: Domain;
  booksCount: number;
  averageScore: number;
  steps: {
    level: DifficultyLevel;
    book: Book | null;
  }[];
}

const TOP_LIMIT = 5;
const NEW_LIMIT = 6;

const getValidDate = (value?: string): Date | null => {
  if (!value) {
    return null;
  }

  const date = new Date(value);
  return Number.isNaN(date.getTime()) ? null : date;
};

const getWeekStart = (): Date => {
  const date = new Date();
  const day = date.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  date.setDate(date.getDate() + diff);
  date.setHours(0, 0, 0, 0);
  return date;
};

const isThisWeek = (value: string | undefined, weekStart: Date): boolean => {
  const date = getValidDate(value);
  if (!date) {
    return false;
  }

  const nextWeek = new Date(weekStart);
  nextWeek.setDate(nextWeek.getDate() + 7);
  return date >= weekStart && date < nextWeek;
};

const formatDate = (value?: string): string => {
  const date = getValidDate(value);
  if (!date) {
    return '待同步';
  }

  return new Intl.DateTimeFormat('zh-CN', {
    month: 'numeric',
    day: 'numeric',
  }).format(date);
};

const getDifficultyName = (level: DifficultyLevel): string =>
  DIFFICULTIES.find((item) => item.level === level)?.name ?? `难度 ${level}`;

const getTotalRecommendationCount = (book: Book): number => {
  if (typeof book.recommendationCount === 'number') {
    return book.recommendationCount;
  }

  return book.recommendations.length || book.votesCount;
};

const getLatestRecommendationAt = (book: Book): string | undefined =>
  book.recommendations.reduce<string | undefined>((latest, recommendation) => {
    const latestDate = getValidDate(latest);
    const currentDate = getValidDate(recommendation.recommendedAt);

    if (!currentDate) {
      return latest;
    }

    return !latestDate || currentDate > latestDate ? recommendation.recommendedAt : latest;
  }, book.lastRecommendedAt);

const getWeeklyRecommendationCount = (book: Book, weekStart: Date): number => {
  const weeklyRecords = book.recommendations.filter((recommendation) =>
    isThisWeek(recommendation.recommendedAt, weekStart),
  );

  if (weeklyRecords.length > 0) {
    return weeklyRecords.length;
  }

  if (isThisWeek(book.lastRecommendedAt, weekStart)) {
    return getTotalRecommendationCount(book);
  }

  return 0;
};

const compareByScore = (a: Book, b: Book): number => {
  const scoreDiff = b.recommendationScore - a.recommendationScore;
  if (scoreDiff !== 0) {
    return scoreDiff;
  }

  const voteDiff = b.votesCount - a.votesCount;
  if (voteDiff !== 0) {
    return voteDiff;
  }

  return a.title.localeCompare(b.title, 'zh-CN');
};

const compareByRank = (a: RankedBook, b: RankedBook): number => {
  const countDiff = b.count - a.count;
  if (countDiff !== 0) {
    return countDiff;
  }

  return compareByScore(a.book, b.book);
};

const getPathStrength = (path: LearningPath): number =>
  path.steps.reduce((total, step) => total + (step.book ? step.book.recommendationScore : 0), 0);

const ListRecommendationShelf = ({ books }: ListRecommendationShelfProps) => {
  const navigate = useNavigate();
  const activePathDomain = useResourceStore((state) => state.viewState.activePathDomain);
  const setActivePathDomain = useResourceStore((state) => state.setActivePathDomain);
  const [expandedBookId, setExpandedBookId] = useState<string | null>(null);

  const weekStart = useMemo(() => getWeekStart(), []);

  const weeklyTopBooks = useMemo<RankedBook[]>(() => {
    const rankedBooks = books
      .map((book) => ({
        book,
        count: getWeeklyRecommendationCount(book, weekStart),
      }))
      .filter((item) => item.count > 0)
      .sort(compareByRank)
      .slice(0, TOP_LIMIT);

    if (rankedBooks.length > 0) {
      return rankedBooks;
    }

    return [...books]
      .sort((a, b) => getTotalRecommendationCount(b) - getTotalRecommendationCount(a) || compareByScore(a, b))
      .slice(0, TOP_LIMIT)
      .map((book) => ({
        book,
        count: getTotalRecommendationCount(book),
      }));
  }, [books, weekStart]);

  const hasWeeklyRecommendation = useMemo(
    () => books.some((book) => getWeeklyRecommendationCount(book, weekStart) > 0),
    [books, weekStart],
  );

  const weeklyNewBooks = useMemo<WeeklyNewBook[]>(() =>
    books
      .map((book) => {
        const fallbackDate = getLatestRecommendationAt(book);
        return {
          book,
          date: book.createdAt ?? fallbackDate ?? '',
          source: book.createdAt ? ('created' as const) : ('recommended' as const),
        };
      })
      .filter((item) => isThisWeek(item.date, weekStart))
      .sort((a, b) => {
        const dateA = getValidDate(a.date)?.getTime() ?? 0;
        const dateB = getValidDate(b.date)?.getTime() ?? 0;
        return dateB - dateA || compareByScore(a.book, b.book);
      })
      .slice(0, NEW_LIMIT),
  [books, weekStart]);

  const learningPaths = useMemo<LearningPath[]>(() =>
    DOMAINS.map((domainConfig) => {
      const domainBooks = books
        .filter((book) => book.domain === domainConfig.id)
        .sort(compareByScore);

      const steps = DIFFICULTIES.map((difficulty) => ({
        level: difficulty.level,
        book: domainBooks.find((book) => book.difficultyLevel === difficulty.level) ?? null,
      }));

      const averageScore = domainBooks.length
        ? domainBooks.reduce((total, book) => total + book.recommendationScore, 0) / domainBooks.length
        : 0;

      return {
        domain: domainConfig.id,
        booksCount: domainBooks.length,
        averageScore,
        steps,
      };
    }).sort((a, b) => getPathStrength(b) - getPathStrength(a) || b.booksCount - a.booksCount),
  [books]);

  const activePath = activePathDomain
    ? learningPaths.find((path) => path.domain === activePathDomain) ?? null
    : null;

  if (books.length === 0) {
    return null;
  }

  const renderComment = (recommendation: Recommendation) => (
    <div key={recommendation.id} className="paper-card rounded-lg border border-slate-700/70 bg-slate-950/35 p-3">
      <div className="mb-2 flex items-center justify-between gap-3">
        <span className="text-sm font-medium text-slate-200">
          {recommendation.isAnonymous ? '匿名推荐' : recommendation.recommender}
        </span>
        <span className="flex items-center gap-1 text-xs text-amber-800">
          <Star size={12} className="fill-current" />
          {recommendation.score.toFixed(1)}
        </span>
      </div>
      <p className="text-sm leading-6 text-slate-300">{recommendation.reason}</p>
      <p className="mt-2 text-xs text-slate-500">{formatDate(recommendation.recommendedAt)}</p>
    </div>
  );

  const renderFallbackComment = (book: Book) => (
    <div className="paper-card rounded-lg border border-slate-700/70 bg-slate-950/35 p-3">
      <div className="mb-2 flex items-center justify-between gap-3">
        <span className="text-sm font-medium text-slate-200">资料推荐摘要</span>
        <span className="flex items-center gap-1 text-xs text-amber-800">
          <Star size={12} className="fill-current" />
          {book.recommendationScore.toFixed(1)}
        </span>
      </div>
      <p className="text-sm leading-6 text-slate-300">{book.reasonFull || book.reasonShort}</p>
    </div>
  );

  return (
    <section className="mb-8 space-y-6">
      <div className="grid grid-cols-1 gap-6 xl:grid-cols-[1.1fr_0.9fr]">
        <div className="paper-panel rounded-xl border border-slate-700 bg-slate-800 p-5 sm:p-6">
          <div className="mb-5 flex items-center justify-between gap-4">
            <div>
              <p className="text-sm font-medium text-[#7a5f33]">本周热度</p>
              <h2 className="mt-1 text-2xl font-bold text-slate-50">推荐量最多书籍榜</h2>
            </div>
            <div className="rounded-full border border-[#7a5f33]/30 bg-[#7a5f33]/10 p-3 text-[#7a5f33]">
              <TrendingUp size={20} />
            </div>
          </div>

          {!hasWeeklyRecommendation && (
            <div className="mb-4 rounded-lg border border-amber-400/20 bg-amber-500/10 px-3 py-2 text-sm text-amber-800">
              本周暂无新的推荐记录，当前展示累计推荐量最高的书籍。
            </div>
          )}

          <div className="space-y-3">
            {weeklyTopBooks.map(({ book, count }, index) => {
              const isExpanded = expandedBookId === book.id;
              const comments = book.recommendations.slice(0, 4);

              return (
                <div key={book.id} className="paper-card overflow-hidden rounded-xl border border-slate-700 bg-slate-900/45">
                  <button
                    type="button"
                    onClick={() => setExpandedBookId(isExpanded ? null : book.id)}
                    className="flex w-full items-center gap-4 p-4 text-left transition-colors hover:bg-slate-800"
                  >
                    <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-slate-950 text-lg font-bold text-slate-200">
                      {index + 1}
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="block truncate text-base font-semibold text-slate-50">{book.title}</span>
                      <span className="mt-1 block truncate text-sm text-slate-400">{book.author}</span>
                    </span>
                    <span className="hidden items-center gap-2 rounded-full border border-slate-600 px-3 py-1 text-sm text-slate-300 sm:flex">
                      <MessageSquare size={14} />
                      {count}
                    </span>
                    <ChevronDown
                      size={18}
                      className={`shrink-0 text-slate-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`}
                    />
                  </button>

                  {isExpanded && (
                    <div className="border-t border-slate-700 p-4">
                      <div className="mb-3 flex flex-wrap items-center gap-2">
                        <span
                          className="rounded-full px-2.5 py-1 text-xs font-medium text-white"
                          style={{ backgroundColor: DOMAIN_COLORS[book.domain] }}
                        >
                          {DOMAIN_LABELS[book.domain]}
                        </span>
                        <span className="rounded-full border border-slate-600 px-2.5 py-1 text-xs text-slate-300">
                          {getDifficultyName(book.difficultyLevel)}
                        </span>
                        <span className="flex items-center gap-1 rounded-full border border-amber-400/30 px-2.5 py-1 text-xs text-amber-800">
                          <Star size={12} className="fill-current" />
                          {book.recommendationScore.toFixed(1)}
                        </span>
                      </div>
                      <div className="grid gap-3">
                        {comments.length > 0 ? comments.map(renderComment) : renderFallbackComment(book)}
                      </div>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        <div className="paper-panel rounded-xl border border-slate-700 bg-slate-800 p-5 sm:p-6">
          <div className="mb-5 flex items-center justify-between gap-4">
            <div>
              <p className="text-sm font-medium text-[#3f6b6b]">新增资料</p>
              <h2 className="mt-1 text-2xl font-bold text-slate-50">本周上新推荐书籍</h2>
            </div>
            <div className="rounded-full border border-[#3f6b6b]/30 bg-[#3f6b6b]/10 p-3 text-[#3f6b6b]">
              <Clock3 size={20} />
            </div>
          </div>

          {weeklyNewBooks.length > 0 ? (
            <div className="space-y-3">
              {weeklyNewBooks.map(({ book, date, source }) => (
                <div key={book.id} className="paper-card rounded-xl border border-slate-700 bg-slate-900/45 p-4">
                  <div className="mb-3 flex items-start justify-between gap-3">
                    <div className="min-w-0">
                      <h3 className="truncate text-base font-semibold text-slate-50">{book.title}</h3>
                      <p className="mt-1 truncate text-sm text-slate-400">{book.author}</p>
                    </div>
                    <span className="shrink-0 rounded-full bg-[#3f6b6b]/10 px-2.5 py-1 text-xs font-medium text-[#3f6b6b]">
                      {formatDate(date)}
                    </span>
                  </div>
                  <div className="flex flex-wrap items-center gap-2">
                    <span
                      className="rounded-full px-2.5 py-1 text-xs font-medium text-white"
                      style={{ backgroundColor: DOMAIN_COLORS[book.domain] }}
                    >
                      {DOMAIN_LABELS[book.domain]}
                    </span>
                    <span className="rounded-full border border-slate-600 px-2.5 py-1 text-xs text-slate-300">
                      {source === 'created' ? '新入库' : '新推荐'}
                    </span>
                    <span className="flex items-center gap-1 text-xs text-amber-800">
                      <Star size={12} className="fill-current" />
                      {book.recommendationScore.toFixed(1)}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="paper-card rounded-xl border border-slate-700 bg-slate-900/45 p-6 text-sm leading-6 text-slate-400">
              本周暂无新入库书籍。
            </div>
          )}
        </div>
      </div>

      <div className="paper-panel rounded-xl border border-slate-700 bg-slate-800 p-5 sm:p-6">
        <div className="mb-5 flex items-center justify-between gap-4">
          <div>
            <p className="text-sm font-medium text-[#74586a]">长期高分</p>
            <h2 className="mt-1 text-2xl font-bold text-slate-50">领域学习路径</h2>
          </div>
          <div className="rounded-full border border-[#74586a]/30 bg-[#74586a]/10 p-3 text-[#74586a]">
            <BookOpen size={20} />
          </div>
        </div>

        <div className="grid grid-cols-1 gap-3 md:grid-cols-2 xl:grid-cols-4">
          {learningPaths.map((path) => {
            const completeSteps = path.steps.filter((step) => Boolean(step.book)).length;

            return (
              <button
                key={path.domain}
                type="button"
                onClick={() => setActivePathDomain(path.domain)}
                className="paper-card rounded-xl border border-slate-700 bg-slate-900/45 p-4 text-left transition-all hover:-translate-y-0.5 hover:border-[#74586a]/60 hover:bg-slate-900"
              >
                <div className="mb-4 flex items-center justify-between gap-3">
                  <span
                    className="rounded-full px-2.5 py-1 text-xs font-medium text-white"
                    style={{ backgroundColor: DOMAIN_COLORS[path.domain] }}
                  >
                    {DOMAIN_LABELS[path.domain]}
                  </span>
                  <span className="text-xs text-slate-400">{completeSteps}/3</span>
                </div>
                <div className="space-y-2">
                  {path.steps.map((step) => (
                    <div key={step.level} className="flex items-center gap-2">
                      <span className="h-2 w-2 rounded-full bg-[#74586a]" />
                      <span className="min-w-0 flex-1 truncate text-sm text-slate-300">
                        {step.book?.title ?? `${getDifficultyName(step.level)} 待补充`}
                      </span>
                    </div>
                  ))}
                </div>
                <div className="mt-4 flex items-center justify-between text-xs text-slate-500">
                  <span>{path.booksCount} 本资料</span>
                  <span>{path.averageScore ? path.averageScore.toFixed(1) : '暂无评分'}</span>
                </div>
              </button>
            );
          })}
        </div>
      </div>

      {activePath && (
        <div className="fixed inset-0 z-50 flex justify-end bg-slate-950/40">
          <div className="paper-drawer flex h-full w-full max-w-2xl flex-col border-l border-slate-700 bg-slate-900 shadow-2xl">
            <div className="flex items-start justify-between gap-4 border-b border-slate-700 p-6">
              <div>
                <p className="text-sm font-medium text-[#74586a]">领域学习路径</p>
                <h2 className="mt-1 text-2xl font-bold text-slate-50">{DOMAIN_LABELS[activePath.domain]}</h2>
              </div>
              <button
                type="button"
                aria-label="关闭学习路径"
                onClick={() => setActivePathDomain(null)}
                className="rounded-lg border border-slate-700 p-2 text-slate-300 transition-colors hover:border-slate-500 hover:bg-slate-800"
              >
                <X size={18} />
              </button>
            </div>

            <div className="flex-1 overflow-y-auto p-6">
              <div className="space-y-4">
                {activePath.steps.map((step, index) => {
                  const book = step.book;

                  return (
                    <div key={step.level} className="paper-card rounded-xl border border-slate-700 bg-slate-800 p-5">
                      <div className="mb-4 flex items-center justify-between gap-3">
                        <div>
                          <p className="text-sm font-medium text-slate-400">阶段 {index + 1}</p>
                          <h3 className="text-lg font-semibold text-slate-50">{getDifficultyName(step.level)}</h3>
                        </div>
                        {book && (
                          <span className="flex items-center gap-1 rounded-full border border-amber-400/30 px-2.5 py-1 text-xs text-amber-800">
                            <Star size={12} className="fill-current" />
                            {book.recommendationScore.toFixed(1)}
                          </span>
                        )}
                      </div>

                      {book ? (
                        <button
                          type="button"
                          onClick={() => navigate(`/detail/${book.id}`)}
                          className="group block w-full rounded-lg text-left transition-colors"
                        >
                          <div className="flex items-baseline justify-between gap-3">
                            <h4 className="text-xl font-bold text-slate-50 transition-colors group-hover:text-[#74586a]">
                              {book.title}
                            </h4>
                            <span className="shrink-0 text-xs text-slate-500 transition-colors group-hover:text-[#74586a]">
                              查看详情 →
                            </span>
                          </div>
                          <p className="mt-1 text-sm text-slate-400">{book.author}</p>
                          <p className="mt-4 text-sm leading-6 text-slate-300">
                            {book.reasonShort || book.reasonFull}
                          </p>
                          <div className="mt-4 flex flex-wrap gap-2">
                            {book.tags.slice(0, 4).map((tag) => (
                              <span key={tag} className="rounded-full bg-slate-700 px-2.5 py-1 text-xs text-slate-300">
                                {tag}
                              </span>
                            ))}
                          </div>
                        </button>
                      ) : (
                        <div className="rounded-lg border border-dashed border-slate-600 p-4 text-sm text-slate-400">
                          当前领域还没有该难度的长期高分书籍。
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        </div>
      )}
    </section>
  );
};

export default ListRecommendationShelf;
