import { useNavigate } from 'react-router-dom';
import { Book } from '../../types';
import { DOMAIN_LABELS, DIFFICULTIES, getDomainColorToken } from '../../constants';
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
  const colorToken = getDomainColorToken(resource.domain);

  return (
    <div
      onClick={() => navigate(`/detail/${resource.id}`)}
      className="paper-card bg-slate-800 rounded-xl border border-slate-700 p-4 cursor-pointer hover:border-[var(--paper-accent)] hover:-translate-y-0.5 transition-all"
    >
      <div className="mb-3 flex items-start justify-between">
        <div className="flex-1">
          <h3 className="mb-1 text-base font-semibold leading-6 text-slate-50">
            {resource.title}
          </h3>
          <p className="text-slate-400 text-sm">{resource.author}</p>
        </div>
      </div>

      <div className="mb-3 flex items-center gap-2">
        <span
          className="rounded-full border px-2 py-1 text-xs font-medium"
          style={{
            backgroundColor: colorToken.tagBg,
            borderColor: colorToken.tagBorder,
            color: colorToken.text,
          }}
        >
          {DOMAIN_LABELS[resource.domain]}
        </span>
        <span className="rounded-full bg-slate-700 px-2 py-1 text-xs font-medium text-slate-300">
          {resource.contentType}
        </span>
        <div className="flex items-center gap-1">
          <Star size={14} className="text-amber-800 fill-current" />
          <span className="text-sm font-medium text-amber-800">{resource.recommendationScore.toFixed(1)}</span>
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
        <div className="mt-4 flex justify-end">
          <button
            type="button"
            onClick={(event) => {
              event.stopPropagation();
              onScoreClick(resource);
            }}
            className="rounded-lg border border-[#0E42D2]/40 bg-[#0E42D2]/10 px-3 py-1.5 text-sm font-medium text-[var(--paper-accent)] transition-colors hover:border-[#0E42D2]/60 hover:bg-[#0E42D2]/20"
          >
            {hasSessionScore ? '修改评分' : '评分投票'}
          </button>
        </div>
      )}
    </div>
  );
};

export default ResourceCard;
