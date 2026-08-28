import { Book, DifficultyLevel, Domain, FilterState } from '../types';
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

// 难度决定三层同心半径带：入门在内圈，方法实践在中圈，深度进阶在外圈。
// 数值为相对于雷达最大半径的比例，保留环线之间的缓冲，避免点压在线上。
const DIFFICULTY_RADIUS_BANDS: Record<DifficultyLevel, { min: number; max: number }> = {
  1: { min: 0.18, max: 0.31 },
  2: { min: 0.42, max: 0.58 },
  3: { min: 0.72, max: 0.9 },
};

const RADIUS_LANES = [0.5, 0.18, 0.82, 0.34, 0.66, 0.08, 0.92, 0.58];

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

function getDifficultyLevel(book: Book): DifficultyLevel {
  return book.difficultyLevel ?? ((book.ringIndex + 1) as DifficultyLevel);
}

function getSectorPositionByDifficulty(
  sectorIndex: number,
  difficultyLevel: DifficultyLevel,
  rankInDifficulty: number,
  totalInDifficulty: number,
): { x: number; y: number } {
  const baseAngle = getBaseAngle(sectorIndex);
  const maxAngleOffset = SECTOR_ANGLE * 0.38;
  const angleOffset =
    totalInDifficulty <= 1
      ? 0
      : -maxAngleOffset + (rankInDifficulty / (totalInDifficulty - 1)) * maxAngleOffset * 2;
  const radiusBand = DIFFICULTY_RADIUS_BANDS[difficultyLevel];
  const radiusLane = RADIUS_LANES[rankInDifficulty % RADIUS_LANES.length];
  const radius = radiusBand.min + radiusLane * (radiusBand.max - radiusBand.min);
  const angle = baseAngle + angleOffset;

  return {
    x: Math.cos(angle) * radius,
    y: Math.sin(angle) * radius,
  };
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
    const totalsByDifficulty = radarGroup.reduce(
      (acc, item) => {
        acc[getDifficultyLevel(item.book)] += 1;
        return acc;
      },
      { 1: 0, 2: 0, 3: 0 } as Record<DifficultyLevel, number>,
    );
    const rankByDifficulty = { 1: 0, 2: 0, 3: 0 } as Record<DifficultyLevel, number>;

    radarGroup.forEach((item) => {
      const difficultyLevel = getDifficultyLevel(item.book);
      const rankInDifficulty = rankByDifficulty[difficultyLevel];
      const pos = getSectorPositionByDifficulty(
        sectorIndex,
        difficultyLevel,
        rankInDifficulty,
        totalsByDifficulty[difficultyLevel],
      );
      rankByDifficulty[difficultyLevel] += 1;
      item.x = pos.x;
      item.y = pos.y;
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
  ringIndex: number,
): { x: number; y: number } {
  const difficultyLevel = Math.min(Math.max(ringIndex + 1, 1), 3) as DifficultyLevel;
  return getSectorPositionByDifficulty(sectorIndex, difficultyLevel, 0, 1);
}
