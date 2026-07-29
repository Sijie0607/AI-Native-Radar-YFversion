import { Book, DifficultyLevel, Domain, Recommendation } from '../types';

export interface BackendRecommendationRow {
  id: string;
  recommender: string;
  isAnonymous: boolean;
  reason: string;
  score: number;
  recommendedAt: string;
}

export interface BackendRadarBookRow {
  id: string;
  display_number: number | null;
  title: string;
  subtitle: string | null;
  author: string | null;
  cover: string | null;
  domain: Domain;
  difficulty_level: DifficultyLevel;
  sector_index: number;
  ring_index: number;
  x: number;
  y: number;
  recommendation_score: number;
  reason_short: string | null;
  reason_full: string | null;
  fit_for: string[] | null;
  takeaways: string[] | null;
  content_type: string | null;
  tags: string[] | null;
  votes_count: number | null;
  source_note: string | null;
  competence_themes: string[] | null;
  recommendations: BackendRecommendationRow[] | null;
}

const mapRecommendation = (item: BackendRecommendationRow): Recommendation => ({
  id: item.id,
  recommender: item.recommender,
  isAnonymous: item.isAnonymous,
  reason: item.reason,
  score: item.score,
  recommendedAt: item.recommendedAt,
});

export const mapBackendBook = (row: BackendRadarBookRow, index: number): Book => ({
  id: row.id,
  displayNumber: row.display_number ?? index + 1,
  title: row.title,
  subtitle: row.subtitle ?? undefined,
  author: row.author ?? '作者待补充',
  cover: row.cover ?? undefined,
  domain: row.domain,
  difficultyLevel: row.difficulty_level,
  sectorIndex: row.sector_index,
  ringIndex: row.ring_index,
  x: row.x,
  y: row.y,
  recommendationScore: row.recommendation_score,
  reasonShort: row.reason_short ?? '',
  reasonFull: row.reason_full ?? row.reason_short ?? '',
  fitFor: row.fit_for ?? [],
  takeaways: row.takeaways ?? [],
  contentType: row.content_type ?? '书籍',
  tags: row.tags ?? [],
  votesCount: row.votes_count ?? 0,
  sourceNote: row.source_note ?? undefined,
  competenceThemes: row.competence_themes ?? [],
  recommendations: (row.recommendations ?? []).map(mapRecommendation),
});
