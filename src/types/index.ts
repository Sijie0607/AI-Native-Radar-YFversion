// 八大领域枚举
export type Domain =
  | 'ai-engineering'
  | 'ai-product-design'
  | 'agent-and-intelligent-systems'
  | 'ai-organizational-transformation'
  | 'data-intelligence-and-knowledge'
  | 'ai-business-implementation'
  | 'ai-ethics-and-governance'
  | 'ai-frontier-trends';

// 难度层级
export type DifficultyLevel = 1 | 2 | 3;

// 推荐人信息
export interface Recommendation {
  id: string;
  recommender: string;
  isAnonymous: boolean;
  reason: string;
  score: number; // 3-5
  recommendedAt: string;
}

// 书籍数据
export interface Book {
  id: string;
  title: string;
  subtitle?: string;
  author: string;
  cover?: string;
  domain: Domain;
  difficultyLevel: DifficultyLevel;
  sectorIndex: number; // 0-7, 对应领域索引
  ringIndex: number; // 0-2, 对应难度圈索引
  x: number; // 雷达图坐标
  y: number;
  recommendationScore: number; // 3-5
  reasonShort: string;
  reasonFull: string;
  fitFor: string[];
  takeaways: string[];
  contentType: string;
  tags: string[];
  votesCount: number;
  sourceNote?: string;
  competenceThemes: string[];
  recommendations: Recommendation[];
}

// 筛选状态
export interface FilterState {
  domains: Domain[];
  difficultyLevels: DifficultyLevel[];
  minScore: number;
  searchQuery: string;
}

// 视图状态
export interface ViewState {
  hoveredBookId: string | null;
  selectedBookId: string | null;
  isDetailPanelOpen: boolean;
}

// 页面加载状态
export type LoadingStatus = 'idle' | 'loading' | 'success' | 'error';

// 领域配置
export interface DomainConfig {
  id: Domain;
  name: string;
  color: string;
  description: string;
}

// 难度配置
export interface DifficultyConfig {
  level: DifficultyLevel;
  name: string;
  description: string;
  radius: number;
}

export type RecommendationScore = 3 | 4 | 5;

export interface BookRecommendationDraft {
  title: string;
  author: string;
  domain: Domain | '';
  reason: string;
  score: RecommendationScore | null;
}

export type RecommendationDraftErrors = Partial<Record<keyof BookRecommendationDraft, string>>;

export interface RecommendationExistingBookSnapshot {
  id: string;
  title: string;
  author: string;
  domain: Domain;
  recommendationScore: number;
}

export type RecommendationSubmissionStatus = 'success' | 'duplicate' | 'error';

export interface RecommendationSubmissionResult {
  status: RecommendationSubmissionStatus;
  message: string;
  submittedAt: string;
  existingBook?: RecommendationExistingBookSnapshot;
}

export interface RecommendationRecord {
  id: string;
  title: string;
  author: string;
  domain: Domain;
  score: RecommendationScore;
  reason: string;
  status: RecommendationSubmissionStatus;
  message: string;
  submittedAt: string;
  existingBook?: RecommendationExistingBookSnapshot;
}

export type BookScoringScore = 3 | 3.5 | 4 | 4.5 | 5;

export type BookScoringMode = 'create' | 'edit';

export interface BookScoringDraft {
  bookId: string;
  score: BookScoringScore | null;
  reason: string;
  mode: BookScoringMode;
  originalScore?: BookScoringScore;
  originalReason?: string;
}

export type BookScoringDraftErrors = Partial<Record<'score' | 'reason', string>>;

export interface SessionBookScore {
  bookId: string;
  score: BookScoringScore;
  reason: string;
  submittedAt: string;
}

export type BookScoringActionType = 'create' | 'update';

export interface BookScoringRecord {
  id: string;
  bookId: string;
  title: string;
  author: string;
  score: BookScoringScore;
  reason: string;
  actionType: BookScoringActionType;
  submittedAt: string;
  updatedRecommendationScore: number;
  updatedVotesCount: number;
}

export interface BookScoringSubmissionResult {
  status: 'success' | 'error';
  actionType: BookScoringActionType;
  message: string;
  submittedAt: string;
  bookId: string;
  updatedRecommendationScore?: number;
  updatedVotesCount?: number;
}

// 兼容性类型 - 为了让旧代码继续工作
export type Resource = Book & {
  difficulty: string;
};
