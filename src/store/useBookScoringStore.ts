import { create } from 'zustand';
import {
  BookScoringDraft,
  BookScoringRecord,
  BookScoringScore,
  SessionBookScore,
} from '../types';

const BOOK_SCORING_RECORDS_STORAGE_KEY = 'ai-native-radar:book-scoring-records';
const BOOK_SCORING_SESSION_SCORES_STORAGE_KEY = 'ai-native-radar:book-scoring-session-scores';

const loadSessionValue = <T,>(storageKey: string, fallback: T): T => {
  if (typeof window === 'undefined') {
    return fallback;
  }

  try {
    const saved = window.sessionStorage.getItem(storageKey);
    return saved ? (JSON.parse(saved) as T) : fallback;
  } catch {
    return fallback;
  }
};

const persistSessionValue = <T,>(storageKey: string, value: T) => {
  if (typeof window === 'undefined') {
    return;
  }

  window.sessionStorage.setItem(storageKey, JSON.stringify(value));
};

export const EMPTY_BOOK_SCORING_DRAFT: BookScoringDraft = {
  bookId: '',
  score: null,
  reason: '',
  mode: 'create',
};

interface BookScoringStore {
  draft: BookScoringDraft;
  records: BookScoringRecord[];
  sessionScores: Record<string, SessionBookScore>;
  setDraft: (draft: BookScoringDraft) => void;
  setDraftField: <K extends keyof BookScoringDraft>(field: K, value: BookScoringDraft[K]) => void;
  resetDraft: () => void;
  setScore: (score: BookScoringScore | null) => void;
  setSessionBookScore: (score: SessionBookScore) => void;
  removeSessionBookScore: (bookId: string) => void;
  addRecord: (record: BookScoringRecord) => void;
  clearRecords: () => void;
}

export const useBookScoringStore = create<BookScoringStore>((set) => ({
  draft: EMPTY_BOOK_SCORING_DRAFT,
  records: loadSessionValue<BookScoringRecord[]>(BOOK_SCORING_RECORDS_STORAGE_KEY, []),
  sessionScores: loadSessionValue<Record<string, SessionBookScore>>(
    BOOK_SCORING_SESSION_SCORES_STORAGE_KEY,
    {},
  ),
  setDraft: (draft) => set({ draft }),
  setDraftField: (field, value) =>
    set((state) => ({
      draft: {
        ...state.draft,
        [field]: value,
      },
    })),
  resetDraft: () => set({ draft: EMPTY_BOOK_SCORING_DRAFT }),
  setScore: (score) =>
    set((state) => ({
      draft: {
        ...state.draft,
        score,
      },
    })),
  setSessionBookScore: (score) =>
    set((state) => {
      const sessionScores = {
        ...state.sessionScores,
        [score.bookId]: score,
      };
      persistSessionValue(BOOK_SCORING_SESSION_SCORES_STORAGE_KEY, sessionScores);
      return { sessionScores };
    }),
  removeSessionBookScore: (bookId) =>
    set((state) => {
      const sessionScores = { ...state.sessionScores };
      delete sessionScores[bookId];
      persistSessionValue(BOOK_SCORING_SESSION_SCORES_STORAGE_KEY, sessionScores);
      return { sessionScores };
    }),
  addRecord: (record) =>
    set((state) => {
      const records = [record, ...state.records];
      persistSessionValue(BOOK_SCORING_RECORDS_STORAGE_KEY, records);
      return { records };
    }),
  clearRecords: () => {
    persistSessionValue(BOOK_SCORING_RECORDS_STORAGE_KEY, []);
    set({ records: [] });
  },
}));
