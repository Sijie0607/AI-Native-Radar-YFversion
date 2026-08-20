import { useResourceStore } from '../../store/useResourceStore';
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
}

/**
 * 单个领域的书名卡：彩色领域头 + 书籍编号列表。
 * 由主页九宫格环绕雷达放置；卡片有独立宽度与滚动区，
 * 书名再长也只在本卡内滚动/换行，不会与雷达产生重叠。
 */
const DomainBookCard = ({
  domain,
  items,
  listMaxHeight = 'max-h-[150px]',
  itemTextClass = 'text-[11px]',
  stripTagPrefix = false,
}: DomainBookCardProps) => {
  const { viewState, setHoveredBook, selectBook } = useResourceStore();

  return (
    <div className="paper-card rounded-lg border border-slate-700 bg-slate-800/95 p-2 shadow-xl backdrop-blur-sm">
      <div className="mb-1.5 flex items-center gap-1.5">
        <div className="h-3 w-0.5 rounded-full" style={{ backgroundColor: domain.color }} />
        <span className="text-[11px] font-semibold text-slate-200">{domain.name}</span>
      </div>
      {items.length === 0 ? (
        <p className="text-[11px] text-slate-500">暂无符合条件的书籍</p>
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
