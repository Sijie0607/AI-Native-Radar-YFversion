import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES, getDomainColorToken } from '../../constants';
import { Search } from 'lucide-react';
import { Domain, DifficultyLevel } from '../../types';

const MIN_SCORE_OPTIONS = [3, 3.5, 4, 4.5, 5];

const SearchFilter = () => {
  const {
    filters,
    setDomainFilter,
    setDifficultyFilter,
    setMinScoreFilter,
    setSearchQuery,
  } = useResourceStore();

  const toggleDomain = (domain: Domain) => {
    const newDomains = filters.domains.includes(domain)
      ? filters.domains.filter((d) => d !== domain)
      : [...filters.domains, domain];
    setDomainFilter(newDomains);
  };

  const toggleDifficulty = (level: DifficultyLevel) => {
    const newLevels = filters.difficultyLevels.includes(level)
      ? filters.difficultyLevels.filter((l) => l !== level)
      : [...filters.difficultyLevels, level];
    setDifficultyFilter(newLevels);
  };

  return (
    <div>
      {/* 搜索 */}
      <div className="mb-4">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-500" size={18} />
          <input
            type="text"
            placeholder="搜索书名、作者或标签..."
            value={filters.searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full rounded-lg border border-slate-600 bg-slate-700 py-2 pl-9 pr-3 text-sm text-slate-200 placeholder-slate-500 focus:border-transparent focus:outline-none focus:ring-2 focus:ring-[var(--paper-accent)]"
          />
        </div>
      </div>

      {/* 领域筛选 */}
      <div className="mb-4">
        <h4 className="mb-2 text-sm font-medium text-slate-400">领域</h4>
        <div className="flex flex-wrap gap-2">
          {DOMAINS.map((domain) => {
            const isSelected = filters.domains.includes(domain.id);
            const colorToken = getDomainColorToken(domain.id);

            return (
              <button
                key={domain.id}
                onClick={() => toggleDomain(domain.id)}
                className="rounded-full border px-2.5 py-1 text-xs font-medium transition-all hover:-translate-y-0.5"
                style={{
                  backgroundColor: isSelected ? colorToken.base : colorToken.tagBg,
                  borderColor: isSelected ? colorToken.base : colorToken.tagBorder,
                  color: isSelected ? '#fffaf0' : colorToken.text,
                  boxShadow: isSelected ? `0 8px 18px ${colorToken.sectorHover}` : undefined,
                }}
              >
                {domain.name}
              </button>
            );
          })}
        </div>
      </div>

      {/* 难度筛选 */}
      <div className="mb-4">
        <h4 className="mb-2 text-sm font-medium text-slate-400">难度</h4>
        <div className="flex flex-wrap gap-2">
          {DIFFICULTIES.map((difficulty) => (
            <button
              key={difficulty.level}
              onClick={() => toggleDifficulty(difficulty.level)}
              className={`rounded-full px-2.5 py-1 text-xs font-medium transition-all ${
                filters.difficultyLevels.includes(difficulty.level)
                  ? 'bg-[var(--paper-accent)] text-white shadow-lg'
                  : 'bg-slate-700 text-slate-400 hover:bg-slate-600 hover:text-slate-300'
              }`}
            >
              {difficulty.name}
            </button>
          ))}
        </div>
      </div>

      {/* 推荐指数筛选 */}
      <div>
        <h4 className="mb-2 text-sm font-medium text-slate-400">最低推荐指数</h4>
        <div className="flex flex-wrap gap-2">
          {MIN_SCORE_OPTIONS.map((score) => (
            <button
              key={score}
              type="button"
              onClick={() => setMinScoreFilter(score)}
              className={`rounded-full px-2.5 py-1 text-xs font-medium transition-all ${
                filters.minScore === score
                  ? 'bg-amber-800 text-white shadow-lg'
                  : 'bg-slate-700 text-slate-400 hover:bg-slate-600 hover:text-slate-300'
              }`}
            >
              {score.toFixed(1)}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

export default SearchFilter;
