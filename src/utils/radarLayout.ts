import { Book, Domain, FilterState } from '../types';
import { DOMAINS } from '../constants';

export const MAX_RADAR_POINTS_PER_DOMAIN = 8;

// 全局编号的领域遍历顺序：与主页九宫格一致，从左上角按逆时针方向。
// 格位映射 [0][1][2] / [3]雷达[4] / [5][6][7] → 逆时针 0,1,2,4,7,6,5,3
const NUMBER_DOMAIN_ORDER = [0, 1, 2, 4, 7, 6, 5, 3] as const;

export interface RadarBookItem {
  book: Book;
  displayNumber: number;
  isOnRadar: boolean;
  x: number;
  y: number;
}

const SECTOR_ANGLE = (Math.PI * 2) / 8;

// 每个扇形内 8 个预计算位置，按从中心到边缘、均匀分布。
// angleOffset 和 radius 都是相对于扇形中心的单位值。
const SECTOR_POSITIONS: { angleOffset: number; radius: number }[] = [
  { angleOffset: 0, radius: 0.32 },
  { angleOffset: -0.15, radius: 0.42 },
  { angleOffset: 0.15, radius: 0.42 },
  { angleOffset: -0.24, radius: 0.62 },
  { angleOffset: 0.24, radius: 0.62 },
  { angleOffset: 0, radius: 0.72 },
  { angleOffset: -0.15, radius: 0.85 },
  { angleOffset: 0.15, radius: 0.85 },
];

function getBaseAngle(sectorIndex: number): number {
  return (sectorIndex + 0.5) * SECTOR_ANGLE - Math.PI / 2;
}

function matchesFilters(book: Book, filters: FilterState): boolean {
  if (filters.domains.length > 0 && !filters.domains.includes(book.domain)) {
    return false;
  }
  if (
    filters.difficultyLevels.length > 0 &&
    !filters.difficultyLevels.includes(book.difficultyLevel)
  ) {
    return false;
  }
  if (book.recommendationScore < filters.minScore) {
    return false;
  }
  if (filters.searchQuery) {
    const query = filters.searchQuery.toLowerCase();
    return (
      book.title.toLowerCase().includes(query) ||
      book.author.toLowerCase().includes(query) ||
      book.tags.some((tag) => tag.toLowerCase().includes(query))
    );
  }
  return true;
}

function sortBooks(a: Book, b: Book): number {
  if (a.ringIndex !== b.ringIndex) return a.ringIndex - b.ringIndex;
  if (b.recommendationScore !== a.recommendationScore) {
    return b.recommendationScore - a.recommendationScore;
  }
  return a.displayNumber - b.displayNumber;
}

export function buildRadarData(
  books: Book[],
  filters: FilterState,
): {
  points: RadarBookItem[];
  domainGroups: Record<Domain, RadarBookItem[]>;
} {
  const visible = books.filter((book) => matchesFilters(book, filters));

  const domainGroups: Record<Domain, RadarBookItem[]> = {} as Record<Domain, RadarBookItem[]>;
  DOMAINS.forEach((domain) => {
    domainGroups[domain.id] = [];
  });

  visible.forEach((book) => {
    const item: RadarBookItem = {
      book,
      displayNumber: book.displayNumber,
      isOnRadar: false,
      x: 0,
      y: 0,
    };
    domainGroups[book.domain].push(item);
  });

  const points: RadarBookItem[] = [];

  DOMAINS.forEach((domain, sectorIndex) => {
    const group = domainGroups[domain.id];
    group.sort((a, b) => sortBooks(a.book, b.book));

    const radarGroup = group.slice(0, MAX_RADAR_POINTS_PER_DOMAIN);
    const baseAngle = getBaseAngle(sectorIndex);

    radarGroup.forEach((item, index) => {
      const offset = SECTOR_POSITIONS[index % SECTOR_POSITIONS.length];
      const angle = baseAngle + offset.angleOffset;
      const radius = offset.radius;
      item.x = Math.cos(angle) * radius;
      item.y = Math.sin(angle) * radius;
      item.isOnRadar = true;
      points.push(item);
    });
  });

  // 全局连续编号：按九宫格逆时针顺序遍历领域，每个领域内按推荐分降序（最高分在前）。
  // 编号跨领域连续递增、不重复；同一份 item 同时驱动雷达点标签与卡片列表。
  // 注意：仅重排卡片展示顺序并改写 displayNumber，雷达点的难度环位置不受影响。
  let sequence = 1;
  NUMBER_DOMAIN_ORDER.forEach((domainIndex) => {
    const items = domainGroups[DOMAINS[domainIndex].id];
    items.sort((a, b) => {
      if (b.book.recommendationScore !== a.book.recommendationScore) {
        return b.book.recommendationScore - a.book.recommendationScore;
      }
      return a.book.displayNumber - b.book.displayNumber;
    });
    items.forEach((item) => {
      item.displayNumber = sequence++;
    });
  });

  return { points, domainGroups };
}

export function getDomainRadarPosition(
  sectorIndex: number,
  itemIndex: number,
): { x: number; y: number } {
  const baseAngle = getBaseAngle(sectorIndex);
  const offset = SECTOR_POSITIONS[itemIndex % SECTOR_POSITIONS.length];
  const angle = baseAngle + offset.angleOffset;
  return {
    x: Math.cos(angle) * offset.radius,
    y: Math.sin(angle) * offset.radius,
  };
}
