import { useState } from 'react';
import { useResourceStore } from '../../store/useResourceStore';
import { DOMAINS, DIFFICULTIES, getDomainConfig } from '../../constants';
import { Book } from '../../types';

const RadarChart = () => {
  const { loadingStatus, viewState, setHoveredBook, selectBook, filteredBooks } = useResourceStore();
  const [tooltip, setTooltip] = useState<{ visible: boolean; x: number; y: number; book: Book | null }>({
    visible: false,
    x: 0,
    y: 0,
    book: null,
  });

  const width = 800;
  const height = 800;
  const centerX = width / 2;
  const centerY = height / 2;
  const maxRadius = 350;

  const renderDomainLabel = (name: string, x: number, y: number, key: string) => {
    if (name === 'Agent 与智能体') {
      return (
        <text
          key={key}
          x={x}
          y={y}
          textAnchor="middle"
          fill="#94A3B8"
          fontSize={13}
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
        fontSize={13}
        fontWeight="500"
      >
        {name}
      </text>
    );
  };

  // 渲染扇形区域
  const renderSectors = () => {
    const sectors = [];
    const anglePerSector = (Math.PI * 2) / 8;

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
    const points = [];

    filteredBooks().forEach((book) => {
      const x = centerX + book.x * maxRadius;
      const y = centerY + book.y * maxRadius;
      const size = 8 + (book.recommendationScore - 3) * 4;
      const domainConfig = getDomainConfig(book.domain);
      const isHovered = viewState.hoveredBookId === book.id;
      const isSelected = viewState.selectedBookId === book.id;

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
        </g>
      );
    });

    return points;
  };

  // 渲染加载状态
  if (loadingStatus === 'loading') {
    return (
      <div className="w-full h-[800px] flex items-center justify-center">
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
      <div className="w-full h-[800px] flex items-center justify-center">
        <div className="text-center">
          <p className="text-slate-400 text-lg">无符合条件的书籍</p>
        </div>
      </div>
    );
  }

  return (
    <div className="relative w-full h-[800px] overflow-hidden bg-slate-900 rounded-2xl">
      <svg
        width={width}
        height={height}
        viewBox={`0 0 ${width} ${height}`}
      >
        {/* 背景 */}
        <rect x={0} y={0} width={width} height={height} fill="#0F172A" />

        {/* 扇形区域 */}
        {renderSectors()}

        {/* 难度圈 */}
        {renderRings()}

        {/* 书籍点 */}
        {renderBookPoints()}
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
