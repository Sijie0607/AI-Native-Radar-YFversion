import { Book, Domain, FilterState } from '../types';
import { DOMAINS } from '../constants';

export const MAX_RADAR_POINTS_PER_DOMAIN = 8;

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
