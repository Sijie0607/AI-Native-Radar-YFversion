import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES } from '../../constants';
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
      <div className="mb-6">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-500" size={20} />
          <input
            type="text"
            placeholder="搜索书名、作者或标签..."
            value={filters.searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-slate-700 border border-slate-600 rounded-lg text-slate-200 placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-[#4a5d4e] focus:border-transparent"
          />
        </div>
      </div>

      {/* 领域筛选 */}
      <div className="mb-6">
        <h4 className="text-sm font-medium text-slate-400 mb-3">领域</h4>
        <div className="flex flex-wrap gap-2">
          {DOMAINS.map((domain) => (
            <button
              key={domain.id}
              onClick={() => toggleDomain(domain.id)}
              className={`px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                filters.domains.includes(domain.id)
                  ? 'text-white shadow-lg'
                  : 'bg-slate-700 text-slate-400 hover:bg-slate-600 hover:text-slate-300'
              }`}
              style={{
                backgroundColor: filters.domains.includes(domain.id) ? domain.color : undefined,
              }}
            >
              {domain.name}
            </button>
          ))}
        </div>
      </div>

      {/* 难度筛选 */}
      <div className="mb-6">
        <h4 className="text-sm font-medium text-slate-400 mb-3">难度</h4>
        <div className="flex flex-wrap gap-2">
          {DIFFICULTIES.map((difficulty) => (
            <button
              key={difficulty.level}
              onClick={() => toggleDifficulty(difficulty.level)}
              className={`px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                filters.difficultyLevels.includes(difficulty.level)
                  ? 'bg-[#4a5d4e] text-white shadow-lg'
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
        <h4 className="text-sm font-medium text-slate-400 mb-3">最低推荐指数</h4>
        <div className="flex flex-wrap gap-2">
          {MIN_SCORE_OPTIONS.map((score) => (
            <button
              key={score}
              type="button"
              onClick={() => setMinScoreFilter(score)}
              className={`px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
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
