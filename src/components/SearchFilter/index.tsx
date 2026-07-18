import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES } from '../../constants';
import { Search, Filter, X } from 'lucide-react';
import { Domain, DifficultyLevel } from '../../types';

const SearchFilter = () => {
  const { filters, setDomainFilter, setDifficultyFilter, setMinScoreFilter, setSearchQuery, clearFilters } = useResourceStore();

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

  const hasActiveFilters = filters.domains.length > 0 || filters.difficultyLevels.length > 0 || filters.minScore > 3 || filters.searchQuery;

  return (
    <div className="bg-slate-800 rounded-xl p-6 border border-slate-700">
      <div className="flex items-center justify-between mb-6">
        <h3 className="text-lg font-semibold text-slate-50 flex items-center gap-2">
          <Filter size={20} className="text-blue-500" />
          筛选
        </h3>
        {hasActiveFilters && (
          <button
            onClick={clearFilters}
            className="flex items-center gap-1 text-sm text-slate-400 hover:text-slate-300 transition-colors"
          >
            <X size={16} />
            清除
          </button>
        )}
      </div>

      {/* 搜索 */}
      <div className="mb-6">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-500" size={20} />
          <input
            type="text"
            placeholder="搜索书名、作者或标签..."
            value={filters.searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-slate-700 border border-slate-600 rounded-lg text-slate-200 placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
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
                  ? 'bg-blue-500 text-white shadow-lg'
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
        <h4 className="text-sm font-medium text-slate-400 mb-3">
          最低推荐指数：<span className="text-yellow-500 font-bold">{filters.minScore.toFixed(1)}</span>
        </h4>
        <input
          type="range"
          min="3"
          max="5"
          step="0.5"
          value={filters.minScore}
          onChange={(e) => setMinScoreFilter(parseFloat(e.target.value))}
          className="w-full h-2 bg-slate-700 rounded-lg appearance-none cursor-pointer accent-yellow-500"
        />
        <div className="flex justify-between text-xs text-slate-500 mt-2">
          <span>3.0</span>
          <span>3.5</span>
          <span>4.0</span>
          <span>4.5</span>
          <span>5.0</span>
        </div>
      </div>
    </div>
  );
};

export default SearchFilter;
