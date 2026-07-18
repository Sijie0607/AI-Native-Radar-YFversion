import { create } from 'zustand';
import { BookRecommendationDraft, RecommendationRecord, RecommendationScore } from '../types';

const RECOMMENDATION_RECORDS_STORAGE_KEY = 'ai-native-radar:recommendation-records';

const loadRecommendationRecords = (): RecommendationRecord[] => {
  if (typeof window === 'undefined') {
    return [];
  }

  try {
    const saved = window.sessionStorage.getItem(RECOMMENDATION_RECORDS_STORAGE_KEY);
    return saved ? (JSON.parse(saved) as RecommendationRecord[]) : [];
  } catch {
    return [];
  }
};

const persistRecommendationRecords = (records: RecommendationRecord[]) => {
  if (typeof window === 'undefined') {
    return;
  }

  window.sessionStorage.setItem(RECOMMENDATION_RECORDS_STORAGE_KEY, JSON.stringify(records));
};

export const EMPTY_RECOMMENDATION_DRAFT: BookRecommendationDraft = {
  title: '',
  author: '',
  domain: '',
  reason: '',
  score: null,
};

interface RecommendationStore {
  draft: BookRecommendationDraft;
  records: RecommendationRecord[];
  setDraftField: <K extends keyof BookRecommendationDraft>(field: K, value: BookRecommendationDraft[K]) => void;
  setDraft: (draft: BookRecommendationDraft) => void;
  resetDraft: () => void;
  setScore: (score: RecommendationScore) => void;
  addRecord: (record: RecommendationRecord) => void;
  clearRecords: () => void;
}

export const useRecommendationStore = create<RecommendationStore>((set) => ({
  draft: EMPTY_RECOMMENDATION_DRAFT,
  records: loadRecommendationRecords(),
  setDraftField: (field, value) =>
    set((state) => ({
      draft: {
        ...state.draft,
        [field]: value,
      },
    })),
  setDraft: (draft) => set({ draft }),
  resetDraft: () => set({ draft: EMPTY_RECOMMENDATION_DRAFT }),
  setScore: (score) =>
    set((state) => ({
      draft: {
        ...state.draft,
        score,
      },
    })),
  addRecord: (record) =>
    set((state) => {
      const records = [record, ...state.records];
      persistRecommendationRecords(records);
      return { records };
    }),
  clearRecords: () => {
    persistRecommendationRecords([]);
    set({ records: [] });
  },
}));
