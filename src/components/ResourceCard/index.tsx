import { useNavigate } from 'react-router-dom';
import { Book } from '../../types';
import { DOMAIN_LABELS, DOMAIN_COLORS, DIFFICULTIES } from '../../constants';
import { Star } from 'lucide-react';

interface ResourceCardProps {
  resource: Book;
}

const ResourceCard = ({ resource }: ResourceCardProps) => {
  const navigate = useNavigate();
  const difficultyConfig = DIFFICULTIES[resource.ringIndex];

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
    </div>
  );
};

export default ResourceCard;
