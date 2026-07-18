import { useNavigate } from 'react-router-dom';
import { Book } from '../../types';
import { DOMAIN_LABELS, DOMAIN_COLORS, DIFFICULTIES } from '../../constants';
import { Star } from 'lucide-react';
import { useBookScoringStore } from '../../store/useBookScoringStore';

interface ResourceCardProps {
  resource: Book;
  onScoreClick?: (book: Book) => void;
}

const ResourceCard = ({ resource, onScoreClick }: ResourceCardProps) => {
  const navigate = useNavigate();
  const difficultyConfig = DIFFICULTIES[resource.ringIndex];
  const { sessionScores } = useBookScoringStore();
  const hasSessionScore = Boolean(sessionScores[resource.id]);

  return (
    <div
      onClick={() => navigate(`/detail/${resource.id}`)}
      className="bg-slate-800 rounded-xl border border-slate-700 p-6 cursor-pointer hover:border-blue-500 hover:-translate-y-1 transition-all"
    >
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <h3 className="text-lg font-semibold text-slate-50 mb-1">
            {resource.title}
          </h3>
          <p className="text-slate-400 text-sm">{resource.author}</p>
        </div>
      </div>

      <div className="flex items-center gap-2 mb-4">
        <span
          className="px-2 py-1 rounded-full text-xs font-medium text-white"
          style={{ backgroundColor: DOMAIN_COLORS[resource.domain] }}
        >
          {DOMAIN_LABELS[resource.domain]}
        </span>
        <div className="flex items-center gap-1">
          <Star size={14} className="text-yellow-500 fill-current" />
          <span className="text-sm font-medium text-yellow-400">{resource.recommendationScore.toFixed(1)}</span>
        </div>
        <span className="text-xs text-slate-500">
          {difficultyConfig.name}
        </span>
      </div>

      <div className="flex flex-wrap gap-1">
        {resource.competenceThemes.slice(0, 3).map((theme, index) => (
          <span
            key={index}
            className="px-2 py-1 bg-slate-700 text-slate-300 rounded text-xs"
          >
            {theme}
          </span>
        ))}
        {resource.competenceThemes.length > 3 && (
          <span className="px-2 py-1 text-slate-500 text-xs">
            +{resource.competenceThemes.length - 3}
          </span>
        )}
      </div>

      {onScoreClick && (
        <div className="mt-5 flex justify-end">
          <button
            type="button"
            onClick={(event) => {
              event.stopPropagation();
              onScoreClick(resource);
            }}
            className="rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-2 text-sm font-medium text-amber-200 transition-colors hover:border-amber-400/50 hover:bg-amber-500/15"
          >
            {hasSessionScore ? '修改评分' : '评分投票'}
          </button>
        </div>
      )}
    </div>
  );
};

export default ResourceCard;
