import { ReactNode, useMemo, useState } from 'react';
import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES, getDomainConfig } from '../../constants';
import { Book, Domain } from '../../types';

const RadarChart = () => {
  const { loadingStatus, viewState, setHoveredBook, selectBook, filteredBooks } = useResourceStore();
  const [tooltip, setTooltip] = useState<{ visible: boolean; x: number; y: number; book: Book | null }>({
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

  const renderDomainLabel = (name: string, x: number, y: number, key: string) => {
    if (name === 'Agent 与智能体') {
      return (
        <text
          key={key}
          x={x}
          y={y}
          textAnchor="middle"
          fill="#94A3B8"
          fontSize={15}
          fontWeight="500"
        >
          <tspan x={x} dy="-0.35em">Agent</tspan>
          <tspan x={x} dy="1.2em">与智能体</tspan>
        </text>
      );
    }

    return (
      <text
        key={key}
        x={x}
        y={y}
        textAnchor="middle"
        dominantBaseline="middle"
        fill="#94A3B8"
        fontSize={15}
        fontWeight="500"
      >
        {name}
      </text>
    );
  };

  // 渲染扇形区域
  const renderSectors = () => {
    const sectors = [];

    for (let i = 0; i < 8; i++) {
      const startAngle = i * anglePerSector - Math.PI / 2;
      const endAngle = (i + 1) * anglePerSector - Math.PI / 2;
      const startX = centerX + Math.cos(startAngle) * maxRadius;
      const startY = centerY + Math.sin(startAngle) * maxRadius;
      const endX = centerX + Math.cos(endAngle) * maxRadius;
      const endY = centerY + Math.sin(endAngle) * maxRadius;

      const largeArcFlag = 0;
      const pathData = [
        `M ${centerX} ${centerY}`,
        `L ${startX} ${startY}`,
        `A ${maxRadius} ${maxRadius} 0 ${largeArcFlag} 1 ${endX} ${endY}`,
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
        />
      );

      // 添加领域标签
      const labelAngle = (i + 0.5) * anglePerSector - Math.PI / 2;
      const labelRadius = maxRadius + 24;
      const labelX = centerX + Math.cos(labelAngle) * labelRadius;
      const labelY = centerY + Math.sin(labelAngle) * labelRadius;

      sectors.push(renderDomainLabel(DOMAINS[i].name, labelX, labelY, `label-${i}`));
    }

    return sectors;
  };

  // 渲染难度圈
  const renderRings = () => {
    const rings = [];

    for (let i = 0; i < 3; i++) {
      const radius = DIFFICULTIES[i].radius * maxRadius;
      rings.push(
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
    }

    return rings;
  };

  // 渲染书籍点
  const renderBookPoints = () => {
    const points: ReactNode[] = [];

    filteredBooks().forEach((book) => {
      const x = centerX + book.x * maxRadius;
      const y = centerY + book.y * maxRadius;
      const size = 8 + (book.recommendationScore - 3) * 4;
      const domainConfig = getDomainConfig(book.domain);
      const isHovered = viewState.hoveredBookId === book.id;
      const isSelected = viewState.selectedBookId === book.id;
      const number = numberByBookId.get(book.id);
      const numberFontSize = Math.max(7, Math.round(size * 0.5));

      points.push(
        <g
          key={`book-${book.id}`}
          className="book-point"
          onMouseEnter={(e) => {
            setHoveredBook(book.id);
            setTooltip({
              visible: true,
              x: e.clientX + 15,
              y: e.clientY - 10,
              book,
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
          onClick={() => selectBook(book.id)}
        >
          {/* 光晕效果 */}
          <circle
            cx={x}
            cy={y}
            r={size * (isHovered || isSelected ? 2 : 1.5)}
            fill={domainConfig.color}
            opacity={0.2}
          />
          {/* 主要圆点 */}
          <circle
            cx={x}
            cy={y}
            r={size * (isHovered || isSelected ? 1.5 : 1)}
            fill={domainConfig.color}
            stroke="#F8FAFC"
            strokeWidth={isSelected ? 3 : 2}
            style={{
              transition: 'r 0.2s ease-out',
              cursor: 'pointer',
            }}
          />
          {/* 编号 */}
          {number && (
            <text
              x={x}
              y={y}
              textAnchor="middle"
              dominantBaseline="middle"
              fill="#F8FAFC"
              fontSize={numberFontSize}
              fontWeight="600"
              pointerEvents="none"
              style={{ userSelect: 'none' }}
            >
              {number}
            </text>
          )}
        </g>
      );
    });

    return points;
  };

  // 渲染书籍标签（分布在雷达外围）
  const renderBookLabels = () => {
    const labels: ReactNode[] = [];
    const maxLabelsPerDomain = 7;

    DOMAINS.forEach((domain, sectorIndex) => {
      const books = booksByDomain.get(domain.id as Domain) ?? [];
      if (books.length === 0) return;

      const midAngle = (sectorIndex + 0.5) * anglePerSector - Math.PI / 2;
      const startAngle = sectorIndex * anglePerSector - Math.PI / 2;
      const endAngle = (sectorIndex + 1) * anglePerSector - Math.PI / 2;
      const domainConfig = getDomainConfig(domain.id as Domain);

      const visibleBooks = books.slice(0, maxLabelsPerDomain);
      const moreCount = books.length - visibleBooks.length;
      const totalItems = visibleBooks.length + (moreCount > 0 ? 1 : 0);

      visibleBooks.forEach((book, index) => {
        const isHovered = viewState.hoveredBookId === book.id;
        const isSelected = viewState.selectedBookId === book.id;
        const number = numberByBookId.get(book.id) ?? String(index + 1);

        let angle: number;
        if (totalItems === 1) {
          angle = midAngle;
        } else {
          const spread = Math.min(anglePerSector * 0.7, Math.PI / 6);
          angle = midAngle - spread / 2 + (index / (totalItems - 1)) * spread;
        }

        // 限制在扇形范围内，避免侵入相邻领域
        angle = Math.max(startAngle + 0.04, Math.min(endAngle - 0.04, angle));

        const anchorX = centerX + Math.cos(angle) * bookLabelRadius;
        const anchorY = centerY + Math.sin(angle) * bookLabelRadius;
        const isRightHalf = Math.cos(angle) >= 0;
        const textX = anchorX + (isRightHalf ? 6 : -6);
        const textAnchor = isRightHalf ? 'start' : 'end';
        const titleColor = isHovered || isSelected ? '#F8FAFC' : '#CBD5E1';

        labels.push(
          <text
            key={`book-label-${book.id}`}
            x={textX}
            y={anchorY}
            textAnchor={textAnchor}
            dominantBaseline="middle"
            fontSize={11}
            fontWeight="500"
            pointerEvents="none"
            style={{ userSelect: 'none' }}
          >
            <tspan fill={domainConfig.color} fontWeight="700">
              {number}.
            </tspan>
            <tspan fill={titleColor}> {truncateTitle(book.title)}</tspan>
          </text>
        );
      });

      if (moreCount > 0) {
        let angle: number;
        if (totalItems === 1) {
          angle = midAngle;
        } else {
          const spread = Math.min(anglePerSector * 0.7, Math.PI / 6);
          angle = midAngle - spread / 2 + ((totalItems - 1) / (totalItems - 1)) * spread;
        }
        angle = Math.max(startAngle + 0.04, Math.min(endAngle - 0.04, angle));

        const anchorX = centerX + Math.cos(angle) * bookLabelRadius;
        const anchorY = centerY + Math.sin(angle) * bookLabelRadius;
        const isRightHalf = Math.cos(angle) >= 0;
        const textX = anchorX + (isRightHalf ? 6 : -6);
        const textAnchor = isRightHalf ? 'start' : 'end';

        labels.push(
          <text
            key={`book-label-more-${domain.id}`}
            x={textX}
            y={anchorY}
            textAnchor={textAnchor}
            dominantBaseline="middle"
            fontSize={11}
            fontWeight="500"
            fill="#94A3B8"
            pointerEvents="none"
            style={{ userSelect: 'none' }}
          >
            +{moreCount} 更多
          </text>
        );
      }
    });

    return labels;
  };

  // 渲染加载状态
  if (loadingStatus === 'loading') {
    return (
      <div className="flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-slate-700 border-t-blue-500 rounded-full animate-spin mx-auto mb-4" />
          <p className="text-slate-400 text-lg">加载中...</p>
        </div>
      </div>
    );
  }

  // 渲染空状态
  if (filteredBooks().length === 0) {
    return (
      <div className="flex aspect-square min-h-[320px] w-full items-center justify-center rounded-2xl bg-slate-900">
        <div className="text-center">
          <p className="text-slate-400 text-lg">无符合条件的书籍</p>
        </div>
      </div>
    );
  }

  return (
    <div className="relative aspect-square w-full overflow-hidden rounded-2xl bg-slate-900">
      <svg
        width="100%"
        height="100%"
        viewBox={`0 0 ${width} ${height}`}
        className="block h-full w-full"
      >
        {/* 背景 */}
        <rect x={0} y={0} width={width} height={height} fill="#0F172A" />

        {/* 扇形区域 */}
        {renderSectors()}

        {/* 难度圈 */}
        {renderRings()}

        {/* 书籍点 */}
        {renderBookPoints()}

        {/* 书籍标签 */}
        {renderBookLabels()}
      </svg>

      {/* Tooltip */}
      {tooltip.visible && tooltip.book && (
        <div
          className="fixed bg-slate-800 border border-slate-700 rounded-lg p-4 shadow-xl z-50 min-w-[250px]"
          style={{
            left: tooltip.x,
            top: tooltip.y,
            pointerEvents: 'none',
          }}
        >
          <h4 className="font-bold text-slate-50 mb-1">{tooltip.book.title}</h4>
          <p className="text-slate-400 text-sm mb-2">{tooltip.book.author}</p>
          <div className="flex items-center gap-2 mb-2">
            <span className="text-yellow-500 text-sm">★ {tooltip.book.recommendationScore.toFixed(1)}</span>
            <span className="text-slate-500 text-xs">• {getDomainConfig(tooltip.book.domain).name}</span>
          </div>
          <p className="text-slate-300 text-sm">{tooltip.book.reasonShort}</p>
        </div>
      )}
    </div>
  );
};

export default RadarChart;
