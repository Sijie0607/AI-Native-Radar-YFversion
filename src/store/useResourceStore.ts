import { create } from 'zustand';
import { Book, FilterState, ViewState, LoadingStatus, Domain, DifficultyLevel } from '../types';

interface RadarStore {
  // 数据 - 新接口
  books: Book[];
  loadingStatus: LoadingStatus;
  error: string | null;
  
  // 筛选状态 - 新接口
  filters: FilterState;
  
  // 视图状态 - 新接口
  viewState: ViewState;
  
  // Actions - 新接口
  setBooks: (books: Book[]) => void;
  setLoadingStatus: (status: LoadingStatus) => void;
  setError: (error: string | null) => void;
  
  setDomainFilter: (domains: Domain[]) => void;
  setDifficultyFilter: (levels: DifficultyLevel[]) => void;
  setMinScoreFilter: (score: number) => void;
  setSearchQuery: (query: string) => void;
  clearFilters: () => void;
  
  setHoveredBook: (bookId: string | null) => void;
  selectBook: (bookId: string | null) => void;
  toggleDetailPanel: (open: boolean) => void;
  
  filteredBooks: () => Book[];

  // 兼容旧接口 - 为了让现有代码继续工作
  resources: Book[];
  filteredResources: Book[];
  setFilters: (filters: Partial<FilterState>) => void;
  selectResource: (resource: Book | null) => void;
}

export const useResourceStore = create<RadarStore>((set, get) => ({
  // 数据
  books: [],
  loadingStatus: 'idle',
  error: null,
  
  // 筛选状态
  filters: {
    domains: [],
    difficultyLevels: [],
    minScore: 3,
    searchQuery: '',
  },
  
  // 视图状态
  viewState: {
    hoveredBookId: null,
    selectedBookId: null,
    isDetailPanelOpen: false,
  },
  
  // Actions
  setBooks: (books) => set({ books }),
  setLoadingStatus: (status) => set({ loadingStatus: status }),
  setError: (error) => set({ error }),
  
  setDomainFilter: (domains) => set(state => ({
    filters: { ...state.filters, domains },
  })),
  
  setDifficultyFilter: (levels) => set(state => ({
    filters: { ...state.filters, difficultyLevels: levels },
  })),
  
  setMinScoreFilter: (score) => set(state => ({
    filters: { ...state.filters, minScore: score },
  })),
  
  setSearchQuery: (query) => set(state => ({
    filters: { ...state.filters, searchQuery: query },
  })),
  
  clearFilters: () => set({
    filters: {
      domains: [],
      difficultyLevels: [],
      minScore: 3,
      searchQuery: '',
    },
  }),
  
  setHoveredBook: (bookId) => set(state => ({
    viewState: { ...state.viewState, hoveredBookId: bookId },
  })),
  
  selectBook: (bookId) => set(state => ({
    viewState: {
      ...state.viewState,
      selectedBookId: bookId,
      isDetailPanelOpen: bookId !== null,
    },
  })),
  
  toggleDetailPanel: (open) => set(state => ({
    viewState: {
      ...state.viewState,
      isDetailPanelOpen: open,
    },
  })),
  
  filteredBooks: () => {
    const { books, filters } = get();
    return books.filter(book => {
      // 领域筛选
      if (filters.domains.length > 0 && !filters.domains.includes(book.domain)) {
        return false;
      }
      // 难度筛选
      if (filters.difficultyLevels.length > 0 && 
          !filters.difficultyLevels.includes(book.difficultyLevel)) {
        return false;
      }
      // 推荐指数筛选
      if (book.recommendationScore < filters.minScore) {
        return false;
      }
      // 搜索筛选
      if (filters.searchQuery) {
        const query = filters.searchQuery.toLowerCase();
        const matchesTitle = book.title.toLowerCase().includes(query);
        const matchesAuthor = book.author.toLowerCase().includes(query);
        const matchesTags = book.tags.some(tag => tag.toLowerCase().includes(query));
        if (!matchesTitle && !matchesAuthor && !matchesTags) {
          return false;
        }
      }
      return true;
    });
  },

  // 兼容旧接口
  get resources() {
    return get().books;
  },
  get filteredResources() {
    return get().filteredBooks();
  },
  setFilters: (partialFilters) => set(state => ({
    filters: { ...state.filters, ...partialFilters },
  })),
  selectResource: (resource) => set(state => ({
    viewState: {
      ...state.viewState,
      selectedBookId: resource ? resource.id : null,
      isDetailPanelOpen: resource !== null,
    },
  })),
}));
