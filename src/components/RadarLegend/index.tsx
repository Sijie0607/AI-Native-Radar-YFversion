import { DOMAINS } from '../../constants';
import { useResourceStore } from '../../store/useResourceStore';
import { Domain } from '../../types';
import { RadarBookItem } from '../../utils/radarLayout';

interface RadarLegendProps {
  domainGroups: Record<Domain, RadarBookItem[]>;
  className?: string;
}

const RadarLegend = ({ domainGroups, className }: RadarLegendProps) => {
  const { viewState, setHoveredBook, selectBook } = useResourceStore();

  const renderBookList = (items: RadarBookItem[], size: 'sm' | 'md') => {
    if (items.length === 0) {
      return (
        <li className={size === 'sm' ? 'text-[10px] text-slate-500' : 'text-xs text-slate-500'}>
          暂无 4 星及以上书籍
        </li>
      );
    }

    return items.map((item) => {
      const isHovered = viewState.hoveredBookId === item.book.id;
      return (
        <li
          key={item.book.id}
          title={item.book.title}
          className={`cursor-pointer truncate rounded px-1.5 py-1 transition-colors ${
            size === 'sm' ? 'text-[11px]' : 'text-xs'
          } ${
            isHovered
              ? 'bg-slate-700 text-slate-100'
              : 'text-slate-300 hover:bg-slate-700 hover:text-slate-100'
          }`}
          onMouseEnter={() => setHoveredBook(item.book.id)}
          onMouseLeave={() => setHoveredBook(null)}
          onClick={() => selectBook(item.book.id)}
        >
          {item.displayNumber}. {item.book.title}
        </li>
      );
    });
  };

  return (
    <>
      {/* Desktop: absolute positioned around the radar */}
      <div className={`pointer-events-none absolute inset-0 hidden xl:block ${className || ''}`}>
        {DOMAINS.map((domain, index) => {
          const items = domainGroups[domain.id] || [];
          const baseAngle = ((index + 0.5) * Math.PI * 2) / 8 - Math.PI / 2;
          const radius = 0.4; // 40% of wrapper width from center
          const left = 50 + Math.cos(baseAngle) * radius * 100;
          const top = 50 + Math.sin(baseAngle) * radius * 100;

          return (
            <div
              key={domain.id}
              className="pointer-events-auto absolute w-[16%]"
              style={{
                left: `${left}%`,
                top: `${top}%`,
                transform: 'translate(-50%, -50%)',
              }}
            >
              <div className="rounded-lg border border-slate-700 bg-slate-800/95 p-3 shadow-xl backdrop-blur-sm">
                <div className="mb-2 flex items-center gap-2">
                  <div className="h-4 w-1 rounded-full" style={{ backgroundColor: domain.color }} />
                  <span className="text-xs font-semibold text-slate-200">{domain.name}</span>
                </div>
                <ul className="max-h-[140px] overflow-y-auto space-y-1">
                  {renderBookList(items, 'sm')}
                </ul>
              </div>
            </div>
          );
        })}
      </div>

      {/* Mobile / tablet: grid below the radar */}
      <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:hidden">
        {DOMAINS.map((domain) => {
          const items = domainGroups[domain.id] || [];
          return (
            <div key={domain.id} className="rounded-lg border border-slate-700 bg-slate-800 p-4">
              <div className="mb-2 flex items-center gap-2">
                <div className="h-4 w-1 rounded-full" style={{ backgroundColor: domain.color }} />
                <span className="text-sm font-semibold text-slate-200">{domain.name}</span>
              </div>
              <ul className="max-h-[200px] overflow-y-auto space-y-1">
                {renderBookList(items, 'md')}
              </ul>
            </div>
          );
        })}
      </div>
    </>
  );
};

export default RadarLegend;
