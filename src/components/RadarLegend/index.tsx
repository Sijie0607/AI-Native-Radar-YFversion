import { useResourceStore } from '../../store/useResourceStore';
import { getDomainColorToken } from '../../constants';
import { DomainConfig } from '../../types';
import { RadarBookItem } from '../../utils/radarLayout';

interface DomainBookCardProps {
  domain: DomainConfig;
  items: RadarBookItem[];
  listMaxHeight?: string;
  /** 书名行字号（默认 11px；左右窄框可用 10px 让更多文字一行放下） */
  itemTextClass?: string;
  /** 去掉书名开头的【分类】标签前缀（如【产品】【FDE】），框头已标明领域，省宽度让书名一行放下；悬停提示仍显示完整书名 */
  stripTagPrefix?: boolean;
  /** 首页外圈书名模块使用：轻微浮动，移动端网格不启用 */
  floating?: boolean;
  /** 错开浮动节奏，避免 8 个模块同步运动 */
  floatingDelay?: string;
}

/**
 * 单个领域的书名卡：彩色领域头 + 书籍编号列表。
 * 由主页浮动/网格布局放置；卡片有独立宽度与滚动区，
 * 书名再长也只在本卡内滚动/换行，不会与雷达产生重叠。
 */
const DomainBookCard = ({
  domain,
  items,
  listMaxHeight = 'max-h-[150px]',
  itemTextClass = 'text-[11px]',
  stripTagPrefix = false,
  floating = false,
  floatingDelay = '0s',
}: DomainBookCardProps) => {
  const { viewState, setHoveredBook, selectBook } = useResourceStore();
  const colorToken = getDomainColorToken(domain.id);

  return (
    <div
      className={`paper-card rounded-lg border border-slate-700 bg-slate-800/95 p-2 shadow-[0_18px_42px_rgba(70,52,28,0.2)] backdrop-blur-sm transition-shadow duration-200 hover:shadow-[0_22px_52px_rgba(70,52,28,0.26)] ${
        floating ? 'floating-domain-card' : ''
      }`}
      style={floating ? { animationDelay: floatingDelay } : undefined}
    >
      <div className="mb-1.5 flex items-center gap-1.5">
        <span
          className="inline-flex items-center gap-1 rounded-full border px-2 py-0.5 text-[11px] font-semibold"
          style={{
            backgroundColor: colorToken.tagBg,
            borderColor: colorToken.tagBorder,
            color: colorToken.text,
          }}
        >
          <span className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: colorToken.base }} />
          {domain.name}
        </span>
      </div>
      {items.length === 0 ? (
        <p className="text-[11px] text-slate-500">暂无符合条件的资料</p>
      ) : (
        <ul className={`${listMaxHeight} space-y-0.5 overflow-y-auto`}>
          {items.map((item) => {
            const isHovered = viewState.hoveredBookId === item.book.id;
            return (
              <li
                key={item.book.id}
                title={item.book.title}
                className={`cursor-pointer break-words rounded px-1.5 py-0.5 ${itemTextClass} leading-snug transition-colors ${
                  isHovered
                    ? 'bg-slate-700 text-slate-100'
                    : 'text-slate-300 hover:bg-slate-700 hover:text-slate-100'
                }`}
                onMouseEnter={() => setHoveredBook(item.book.id)}
                onMouseLeave={() => setHoveredBook(null)}
                onClick={() => selectBook(item.book.id)}
              >
                {item.displayNumber}.{' '}
                {stripTagPrefix
                  ? item.book.title.replace(/^【[^】]*】\s*/, '')
                  : item.book.title}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
};

export default DomainBookCard;
