import { useState } from 'react';
import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES, getDomainConfig } from '../../constants';
import { Book } from '../../types';
import { RadarBookItem } from '../../utils/radarLayout';

interface RadarChartProps {
  points: RadarBookItem[];
  className?: string;
}

const RadarChart = ({ points, className }: RadarChartProps) => {
  const { loadingStatus, viewState, setHoveredBook, selectBook } = useResourceStore();
  const [tooltip, setTooltip] = useState<{
    visible: boolean;
    x: number;
    y: number;
    book: Book | null;
  }>({
    visible: false,
    x: 0,
    y: 0,
    book: null,
  });

  const width = 900;
  const height = 900;
  const centerX = width / 2;
  const centerY = height / 2;
  const maxRadius = 350;
  const bookLabelRadius = maxRadius + 55;
  const anglePerSector = (Math.PI * 2) / 8;

  // 按领域分组并编号
  const { booksByDomain, numberByBookId } = useMemo(() => {
    const visible = filteredBooks();
    const grouped = new Map<Domain, Book[]>();
    const numbers = new Map<string, string>();

    visible.forEach((book) => {
      const list = grouped.get(book.domain) ?? [];
      list.push(book);
      grouped.set(book.domain, list);
    });

    grouped.forEach((list) => {
      list.sort((a, b) => {
        if (a.ringIndex !== b.ringIndex) {
          return a.ringIndex - b.ringIndex;
        }
        return a.title.localeCompare(b.title, 'zh-CN');
      });
      list.forEach((book, index) => {
        numbers.set(book.id, String(index + 1));
      });
    });

    return { booksByDomain: grouped, numberByBookId: numbers };
  }, [filteredBooks]);

  const truncateTitle = (title: string, maxLength = 18) => {
    if (title.length <= maxLength) return title;
    return `${title.slice(0, maxLength)}…`;
  };

  const outerClassName =
    className || 'relative aspect-square w-full overflow-hidden rounded-2xl bg-slate-900';

  const renderSectors = () => {
    const sectors = [];

    for (let i = 0; i < 8; i++) {
      const startAngle = i * anglePerSector - Math.PI / 2;
      const endAngle = (i + 1) * anglePerSector - Math.PI / 2;
      const startX = centerX + Math.cos(startAngle) * maxRadius;
      const startY = centerY + Math.sin(startAngle) * maxRadius;
      const endX = centerX + Math.cos(endAngle) * maxRadius;
      const endY = centerY + Math.sin(endAngle) * maxRadius;

      const pathData = [
        `M ${centerX} ${centerY}`,
        `L ${startX} ${startY}`,
        `A ${maxRadius} ${maxRadius} 0 0 1 ${endX} ${endY}`,
        'Z',
      ].join(' ');

      sectors.push(
        <path
          key={`sector-${i}`}
          d={pathData}
          fill={DOMAINS[i].color}
          opacity={0.1}
          stroke={DOMAINS[i].color}
          strokeWidth={1}
          strokeOpacity={0.3}
        />,
      );
    }

    return sectors;
  };

  const renderRings = () => {
    return DIFFICULTIES.map((difficulty, i) => {
      const radius = difficulty.radius * maxRadius;
      return (
        <circle
          key={`ring-${i}`}
          cx={centerX}
          cy={centerY}
          r={radius}
          fill="none"
          stroke="#475569"
          strokeWidth={1}
          strokeDasharray="5,5"
          opacity={0.5}
        />
      );
    });
  };

  const renderBookPoints = () => {
    return points.map((item) => {
      const x = centerX + item.x * maxRadius;
      const y = centerY + item.y * maxRadius;
      const domainConfig = getDomainConfig(item.book.domain);
      const isHovered = viewState.hoveredBookId === item.book.id;
      const isSelected = viewState.selectedBookId === item.book.id;
      const baseRadius = 18;
      const radius = baseRadius * (isHovered || isSelected ? 1.4 : 1);
      const label = String(item.displayNumber);
      const fontSize = label.length > 2 ? 10 : 12;

      return (
        <g
          key={`book-${item.book.id}`}
          className="book-point"
          onMouseEnter={(e) => {
            setHoveredBook(item.book.id);
            setTooltip({
              visible: true,
              x: e.clientX + 15,
              y: e.clientY - 10,
              book: item.book,
            });
          }}
          onMouseMove={(e) => {
            if (tooltip.visible) {
              setTooltip((prev) => ({
                ...prev,
                x: e.clientX + 15,
                y: e.clientY - 10,
              }));
            }
          }}
          onMouseLeave={() => {
            setHoveredBook(null);
            setTooltip({ visible: false, x: 0, y: 0, book: null });
          }}
          onClick={() => selectBook(item.book.id)}
          style={{ cursor: 'pointer' }}
        >
          <circle
            cx={x}
            cy={y}
            r={radius * 1.5}
            fill={domainConfig.color}
            opacity={0.2}
          />
          <circle
            cx={x}
            cy={y}
            r={radius}
            fill={domainConfig.color}
            stroke="#F8FAFC"
            strokeWidth={isSelected ? 3 : 2}
            style={{ transition: 'r 0.2s ease-out' }}
          />
          <text
            x={x}
            y={y}
            textAnchor="middle"
            dominantBaseline="central"
            fill="#F8FAFC"
            fontSize={fontSize}
            fontWeight={600}
            stroke="#0F172A"
            strokeWidth={3}
            paintOrder="stroke"
          >
            {label}
          </text>
        </g>
      );
    });
  };

  if (loadingStatus === 'loading') {
    return (
      <div className="flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
        <div className="text-center">
          <div className="mx-auto mb-4 h-16 w-16 animate-spin rounded-full border-4 border-slate-700 border-t-blue-500" />
          <p className="text-lg text-slate-400">加载中...</p>
        </div>
      </div>
    );
  }

  if (points.length === 0) {
    return (
      <div className="flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
        <div className="text-center">
          <p className="text-lg text-slate-400">无符合条件的书籍</p>
        </div>
      </div>
    );
  }

  return (
    <div className={outerClassName}>
      <svg
        width="100%"
        height="100%"
        viewBox={`0 0 ${width} ${height}`}
        className="block h-full w-full"
      >
        <rect x={0} y={0} width={width} height={height} fill="#0F172A" />
        {renderSectors()}
        {renderRings()}
        {renderBookPoints()}

        {/* 书籍标签 */}
        {renderBookLabels()}
      </svg>

      {tooltip.visible && tooltip.book && (
        <div
          className="fixed z-50 min-w-[250px] rounded-lg border border-slate-700 bg-slate-800 p-4 shadow-xl"
          style={{
            left: tooltip.x,
            top: tooltip.y,
            pointerEvents: 'none',
          }}
        >
          <h4 className="mb-1 font-bold text-slate-50">{tooltip.book.title}</h4>
          <p className="mb-2 text-sm text-slate-400">{tooltip.book.author}</p>
          <div className="mb-2 flex items-center gap-2">
            <span className="text-sm text-yellow-500">
              ★ {tooltip.book.recommendationScore.toFixed(1)}
            </span>
            <span className="text-xs text-slate-500">
              • {getDomainConfig(tooltip.book.domain).name}
            </span>
            <span className="text-xs text-slate-500">
              • {DIFFICULTIES[tooltip.book.ringIndex].name}
            </span>
          </div>
          <p className="text-sm text-slate-300">{tooltip.book.reasonShort}</p>
        </div>
      )}
    </div>
  );
};

export default RadarChart;
