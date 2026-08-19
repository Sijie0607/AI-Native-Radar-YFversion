import { useMemo, useState } from 'react';
import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES, getDomainConfig } from '../../constants';
import { Book, Domain } from '../../types';
import { RadarBookItem } from '../../utils/radarLayout';

interface RadarChartProps {
  points: RadarBookItem[];
  domainGroups?: Record<Domain, RadarBookItem[]>;
  className?: string;
}

const PAPER_BG = '#e8e2d5';
const PAPER_LIGHT = '#f4efe4';
const INK = '#1a1a1a';
const BORDER_FAINT = 'rgba(26, 26, 26, 0.14)';

const MORANDI_DOMAIN_COLORS: Record<Domain, string> = {
  'ai-engineering': '#4a5d4e',
  'ai-product-design': '#5d4a4a',
  'agent-and-intelligent-systems': '#4a4d5d',
  'ai-organizational-transformation': '#5d584a',
  'data-intelligence-and-knowledge': '#4a5d5d',
  'ai-business-implementation': '#5d4a56',
  'ai-ethics-and-governance': '#3d3d3d',
  'ai-frontier-trends': '#6b4f3b',
};

const getMorandiDomainColor = (domain: Domain) => MORANDI_DOMAIN_COLORS[domain];

const RadarChart = ({ points, domainGroups, className }: RadarChartProps) => {
  const { loadingStatus, viewState, setHoveredBook, selectBook } = useResourceStore();
  const [hoveredDomain, setHoveredDomain] = useState<Domain | null>(null);
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
    className || 'paper-radar-frame relative aspect-square w-full overflow-hidden rounded-2xl bg-slate-900';

  const domainCounts = useMemo(() => {
    const counts = {} as Record<Domain, number>;
    DOMAINS.forEach((domain) => {
      counts[domain.id] =
        domainGroups?.[domain.id]?.length ??
        points.filter((item) => item.book.domain === domain.id).length;
    });

    return counts;
  }, [domainGroups, points]);

  const activeBook = points.find(
    (item) =>
      item.book.id === viewState.hoveredBookId ||
      item.book.id === viewState.selectedBookId,
  )?.book;

  const activeDomain = hoveredDomain ?? activeBook?.domain ?? null;

  const getPetalRadius = (domain: Domain) => {
    const counts = DOMAINS.map((item) => domainCounts[item.id] ?? 0);
    const minCount = Math.min(...counts);
    const maxCount = Math.max(...counts, 1);
    const count = domainCounts[domain] ?? 0;
    const normalized =
      maxCount === minCount ? (count > 0 ? 0.64 : 0) : (count - minCount) / (maxCount - minCount);
    const minRadius = maxRadius * 0.46;
    const maxPetalRadius = maxRadius * 0.98;

    return minRadius + normalized * (maxPetalRadius - minRadius);
  };

  const renderCompassLines = () => {
    const lines = [];
    const anglePerSector = (Math.PI * 2) / 8;

    for (let i = 0; i < 8; i++) {
      const angle = i * anglePerSector - Math.PI / 2;
      const x = centerX + Math.cos(angle) * maxRadius;
      const y = centerY + Math.sin(angle) * maxRadius;

      lines.push(
        <line
          key={`compass-${i}`}
          x1={centerX}
          y1={centerY}
          x2={x}
          y2={y}
          stroke={INK}
          strokeWidth={0.8}
          strokeOpacity={0.26}
        />,
      );
    }

    return lines;
  };

  const renderSectors = () => {
    const sectors = [];

    for (let i = 0; i < 8; i++) {
      const domain = DOMAINS[i];
      const isActive = activeDomain === domain.id;
      const petalRadius = getPetalRadius(domain.id) + (isActive ? 18 : 0);
      const startAngle = i * anglePerSector - Math.PI / 2 + angleGap;
      const endAngle = (i + 1) * anglePerSector - Math.PI / 2 - angleGap;
      const startX = centerX + Math.cos(startAngle) * petalRadius;
      const startY = centerY + Math.sin(startAngle) * petalRadius;
      const endX = centerX + Math.cos(endAngle) * petalRadius;
      const endY = centerY + Math.sin(endAngle) * petalRadius;
      const domainColor = getMorandiDomainColor(domain.id);

      const pathData = [
        `M ${centerX} ${centerY}`,
        `L ${startX} ${startY}`,
        `A ${petalRadius} ${petalRadius} 0 0 1 ${endX} ${endY}`,
        'Z',
      ].join(' ');

      sectors.push(
        <path
          key={`sector-${domain.id}`}
          d={pathData}
          fill={domainColor}
          opacity={isActive ? 0.34 : 0.22}
          stroke={INK}
          strokeWidth={isActive ? 1.2 : 0.7}
          strokeOpacity={isActive ? 0.46 : 0.24}
          onMouseEnter={() => setHoveredDomain(domain.id)}
          onMouseLeave={() => setHoveredDomain(null)}
          style={{
            cursor: 'crosshair',
            transition: 'opacity 180ms ease, stroke-width 180ms ease',
          }}
        />,
      );
    }

    return sectors;
  };

  const renderRings = () => {
    return DIFFICULTIES.map((difficulty, i) => {
      const radius = ((i + 1) / 3) * maxRadius;
      const dashArray = ['2 5', '8 11', '15 18'][i];
      const duration = ['70s', '42s', '56s'][i];
      const direction = i === 1 ? `360 ${centerX} ${centerY}` : `0 ${centerX} ${centerY}`;
      const target = i === 1 ? `0 ${centerX} ${centerY}` : `360 ${centerX} ${centerY}`;

      return (
        <g key={`ring-${i}`}>
          <circle
            cx={centerX}
            cy={centerY}
            r={radius}
            fill="none"
            stroke={INK}
            strokeWidth={0.9 + i * 0.35}
            strokeDasharray={dashArray}
            strokeOpacity={0.34 + i * 0.1}
          >
            <animateTransform
              attributeName="transform"
              type="rotate"
              from={direction}
              to={target}
              dur={duration}
              repeatCount="indefinite"
            />
          </circle>
          <text
            x={centerX + radius - 10}
            y={centerY - 8}
            textAnchor="end"
            fill={INK}
            fontSize={11}
            fontWeight={500}
            opacity={0.46}
          >
            {difficulty.name}
          </text>
        </g>
      );
    });
  };

  const renderDomainLabels = () => {
    const anglePerSector = (Math.PI * 2) / 8;

    return DOMAINS.map((domain, i) => {
      const angle = (i + 0.5) * anglePerSector - Math.PI / 2;
      const isActive = activeDomain === domain.id;
      const petalRadius = getPetalRadius(domain.id);
      const labelRadius = Math.min(petalRadius + 30, maxRadius + 22);
      const x = centerX + Math.cos(angle) * labelRadius;
      const y = centerY + Math.sin(angle) * labelRadius;
      const rotate = (angle * 180) / Math.PI;
      const safeRotate = rotate > 90 || rotate < -90 ? rotate + 180 : rotate;

      return (
        <text
          key={`domain-label-${domain.id}`}
          x={x}
          y={y}
          textAnchor="middle"
          dominantBaseline="middle"
          fill={isActive ? getMorandiDomainColor(domain.id) : INK}
          fontSize={12}
          fontStyle="italic"
          fontWeight={isActive ? 700 : 500}
          opacity={isActive ? 1 : 0.72}
          transform={`rotate(${safeRotate}, ${x}, ${y})`}
          style={{ transition: 'opacity 180ms ease, fill 180ms ease' }}
        >
          {domain.name}
        </text>
      );
    });
  };

  const renderCenterTarget = () => (
    <g>
      <circle
        cx={centerX}
        cy={centerY}
        r={68}
        fill={PAPER_BG}
        stroke={BORDER_FAINT}
        strokeWidth={1}
      />
      <circle
        cx={centerX}
        cy={centerY}
        r={13}
        fill={PAPER_LIGHT}
        stroke={INK}
        strokeWidth={1.6}
      />
      <circle cx={centerX} cy={centerY} r={4.5} fill={INK} />
      <line x1={centerX - 26} y1={centerY} x2={centerX - 15} y2={centerY} stroke={INK} strokeWidth={1.5} />
      <line x1={centerX + 15} y1={centerY} x2={centerX + 26} y2={centerY} stroke={INK} strokeWidth={1.5} />
      <line x1={centerX} y1={centerY - 26} x2={centerX} y2={centerY - 15} stroke={INK} strokeWidth={1.5} />
      <line x1={centerX} y1={centerY + 15} x2={centerX} y2={centerY + 26} stroke={INK} strokeWidth={1.5} />
    </g>
  );

  const renderBookPoints = () => {
    return points.map((item) => {
      const x = centerX + item.x * maxRadius;
      const y = centerY + item.y * maxRadius;
      const domainColor = getMorandiDomainColor(item.book.domain);
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
            fill={domainColor}
            opacity={0.18}
          />
          <circle
            cx={x}
            cy={y}
            r={radius}
            fill={domainColor}
            stroke={PAPER_LIGHT}
            strokeWidth={isSelected ? 3 : 2}
            style={{ transition: 'r 0.2s ease-out' }}
          />
          <text
            x={x}
            y={y}
            textAnchor="middle"
            dominantBaseline="central"
            fill={PAPER_LIGHT}
            fontSize={fontSize}
            fontWeight={600}
            stroke={INK}
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
      <div className="paper-radar-frame relative flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
        <div className="text-center">
          <div className="mx-auto mb-4 h-16 w-16 animate-spin rounded-full border-4 border-slate-700 border-t-blue-500" />
          <p className="text-lg text-slate-400">加载中...</p>
        </div>
      </div>
    );
  }

  if (points.length === 0) {
    return (
      <div className="paper-radar-frame relative flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
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
        <defs>
          <radialGradient id="radar-paper-bg" cx="50%" cy="48%" r="62%">
            <stop offset="0%" stopColor={PAPER_LIGHT} />
            <stop offset="72%" stopColor={PAPER_BG} />
            <stop offset="100%" stopColor="#d8cfbd" />
          </radialGradient>
          <filter id="paper-grain">
            <feTurbulence type="fractalNoise" baseFrequency="0.95" numOctaves="2" seed="7" />
            <feColorMatrix type="saturate" values="0" />
            <feComponentTransfer>
              <feFuncA type="table" tableValues="0 0.08" />
            </feComponentTransfer>
          </filter>
        </defs>
        <rect x={0} y={0} width={width} height={height} fill={PAPER_BG} />
        <circle
          cx={centerX}
          cy={centerY}
          r={maxRadius}
          fill="url(#radar-paper-bg)"
          stroke={BORDER_FAINT}
          strokeWidth={1}
        />
        <rect x={0} y={0} width={width} height={height} filter="url(#paper-grain)" opacity={0.35} />
        {renderSectors()}
        {renderCompassLines()}
        {renderRings()}
        {renderCenterTarget()}
        {renderDomainLabels()}
        {renderBookPoints()}

        {/* 书籍标签 */}
        {renderBookLabels()}
      </svg>

      {tooltip.visible && tooltip.book && (
        <div
          className="paper-card fixed z-50 min-w-[250px] rounded-lg border border-slate-700 bg-slate-800 p-4 shadow-xl"
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
