import { create } from 'zustand';
import { BookRecommendationDraft, RecommendationScore } from '../types';

export const EMPTY_RECOMMENDATION_DRAFT: BookRecommendationDraft = {
  title: '',
  author: '',
  domain: '',
  reason: '',
  score: null,
};

interface RecommendationStore {
  draft: BookRecommendationDraft;
  setDraftField: <K extends keyof BookRecommendationDraft>(field: K, value: BookRecommendationDraft[K]) => void;
  setDraft: (draft: BookRecommendationDraft) => void;
  resetDraft: () => void;
  setScore: (score: RecommendationScore) => void;
}

export const useRecommendationStore = create<RecommendationStore>((set) => ({
  draft: EMPTY_RECOMMENDATION_DRAFT,
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
}));
