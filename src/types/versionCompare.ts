import { DifficultyLevel, Domain } from './index';

/** 版本快照中的一本书（radar_version_books 行） */
export interface VersionBookSnapshot {
  resourceId: string;
  title: string;
  author: string;
  domain: Domain;
  difficultyLevel: DifficultyLevel;
  sectorIndex: number;
  ringIndex: number;
  x: number;
  y: number;
  recommendationScore: number;
  votesCount: number;
  // 视觉权重字段：本轮仅随快照存储，不参与渲染
  pointRadius?: number;
  haloRadius?: number;
  haloOpacity?: number;
  strokeWidth?: number;
  fillOpacity?: number;
}

export interface VersionMetadata {
  versionNumber: number;
  generatedAt: string | null;
  weekStart?: string | null;
  weekEnd?: string | null;
}

/** get_version_diff RPC 返回（前端只读对比的数据源） */
export interface VersionDiff {
  currentVersion: VersionMetadata | null;
  previousVersion: VersionMetadata | null;
  previousBooks: VersionBookSnapshot[];
}

export type VersionChangeType = 'added' | 'score_up' | 'score_down' | 'unchanged';

/** 单本书在"当前 vs 上一版"中的变化信息 */
export interface BookChange {
  type: VersionChangeType;
  currentScore?: number;
  previousScore?: number;
  scoreDelta?: number;
  currentVotes?: number;
  previousVotes?: number;
  votesDelta?: number;
}

/**
 * 对比态渲染所需的全部数据（由 computeVersionCompareData 产出）。
 * 注：跌出雷达的书（上版有、本版无）数据仍随版本快照存在，但前端不单独展示——
 * 雷达成员按"每领域 Top 8 且指数 ≥3.0"每周变动，未在榜的书不标注。
 */
export interface VersionCompareData {
  changesByBookId: Record<string, BookChange>;
  /** 新增/指数升/指数降 的当前快照（含坐标），用于渲染"被筛选隐藏但有变化的书"的离屏标记 */
  changedBooks: VersionBookSnapshot[];
}
