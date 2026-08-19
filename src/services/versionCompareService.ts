import { Book, DifficultyLevel, Domain } from '../types';
import { callBackendRpc, isBackendConfigured } from './backendClient';
import {
  VersionBookSnapshot,
  VersionDiff,
  VersionMetadata,
} from '../types/versionCompare';

const round = (value: number) => Math.round(value * 100) / 100;

const mapSnapshot = (row: any): VersionBookSnapshot => ({
  resourceId: row.resource_id,
  title: row.title,
  author: row.author ?? '',
  domain: row.domain as Domain,
  difficultyLevel: (row.difficulty_level ?? 2) as DifficultyLevel,
  sectorIndex: row.sector_index ?? 0,
  ringIndex: row.ring_index ?? 0,
  x: Number(row.x ?? 0),
  y: Number(row.y ?? 0),
  recommendationScore: Number(row.recommendation_score ?? 0),
  votesCount: Number(row.votes_count ?? 0),
  pointRadius: row.point_radius != null ? Number(row.point_radius) : undefined,
  haloRadius: row.halo_radius != null ? Number(row.halo_radius) : undefined,
  haloOpacity: row.halo_opacity != null ? Number(row.halo_opacity) : undefined,
  strokeWidth: row.stroke_width != null ? Number(row.stroke_width) : undefined,
  fillOpacity: row.fill_opacity != null ? Number(row.fill_opacity) : undefined,
});

const mapMeta = (row: any): VersionMetadata => ({
  versionNumber: row.version_number,
  generatedAt: row.generated_at ?? null,
  weekStart: row.week_start ?? null,
  weekEnd: row.week_end ?? null,
});

const mapDiff = (raw: any): VersionDiff => ({
  currentVersion: raw.current_version ? mapMeta(raw.current_version) : null,
  previousVersion: raw.previous_version ? mapMeta(raw.previous_version) : null,
  previousBooks: (raw.previous_books ?? []).map(mapSnapshot),
});

/**
 * 无后端/后端不可用时的本地演示数据：
 * 从当前书籍合成"上一版"，覆盖新增/升/降/删除残影 4 种状态。
 */
const buildMockDiff = (currentBooks: Book[]): VersionDiff => {
  const now = new Date();
  const lastWeek = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000).toISOString();
  const previous: VersionBookSnapshot[] = [];

  currentBooks.forEach((book, index) => {
    const base: VersionBookSnapshot = {
      resourceId: book.id,
      title: book.title,
      author: book.author,
      domain: book.domain,
      difficultyLevel: book.difficultyLevel,
      sectorIndex: book.sectorIndex,
      ringIndex: book.ringIndex,
      x: book.x,
      y: book.y,
      recommendationScore: book.recommendationScore,
      votesCount: book.votesCount,
    };

    if (index < 2) return; // 前 2 本上周不在 → 本周新增
    if (index < 5) {
      // 上周分数更低 → 本周指数升（不做下限钳制，避免 3.0 分书被夹成 0 差值而变 unchanged）
      previous.push({
        ...base,
        recommendationScore: round(book.recommendationScore - 0.5),
      });
    } else if (index < 7) {
      // 上周分数更高 → 本周指数降
      previous.push({
        ...base,
        recommendationScore: Math.min(5, round(book.recommendationScore + 0.5)),
      });
    } else {
      previous.push(base);
    }
  });

  // 上周有、本周无 → 删除残影（幽灵书）
  previous.push({
    resourceId: 'ghost-mock-1',
    title: '《Ghost Demo Book》',
    author: 'Ghost Author',
    domain: 'ai-frontier-trends',
    difficultyLevel: 2,
    sectorIndex: 7,
    ringIndex: 1,
    x: Math.cos(((7 + 0.5) * Math.PI * 2) / 8 - Math.PI / 2) * 0.5,
    y: Math.sin(((7 + 0.5) * Math.PI * 2) / 8 - Math.PI / 2) * 0.5,
    recommendationScore: 4.3,
    votesCount: 12,
  });

  return {
    currentVersion: { versionNumber: 2, generatedAt: now.toISOString() },
    previousVersion: { versionNumber: 1, generatedAt: lastWeek },
    previousBooks: previous,
  };
};

export const versionCompareService = {
  async fetchVersionDiff(currentBooks: Book[]): Promise<VersionDiff | null> {
    if (!isBackendConfigured) {
      return buildMockDiff(currentBooks);
    }

    try {
      const raw = await callBackendRpc<any>('get_version_diff', {});
      const diff = mapDiff(raw);
      // RPC 已部署但尚无上一版（0 或 1 个版本）→ 真实"无上一版"，不兜底 mock
      if (!diff.previousVersion || diff.previousBooks.length === 0) {
        return null;
      }
      return diff;
    } catch (error) {
      // RPC 未部署 / 权限 / 网络错误 → 回退本地演示数据（对齐 resourceService.fetchBooks 模式）
      console.warn('版本对比数据获取失败，回退到本地演示数据。', error);
      return buildMockDiff(currentBooks);
    }
  },
};
