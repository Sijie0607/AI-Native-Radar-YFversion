import {
  Book,
  BookRecommendationDraft,
  RecommendationExistingBookSnapshot,
  RecommendationSubmissionResult,
} from '../types';

interface SubmitRecommendationParams {
  draft: BookRecommendationDraft;
  books: Book[];
  allowDuplicateSubmit?: boolean;
}

const delay = (ms: number) =>
  new Promise<void>((resolve) => {
    setTimeout(resolve, ms);
  });

const normalizeText = (value: string) => value.trim().toLowerCase();

const toExistingBookSnapshot = (book: Book): RecommendationExistingBookSnapshot => ({
  id: book.id,
  title: book.title,
  author: book.author,
  domain: book.domain,
  recommendationScore: book.recommendationScore,
});

const shouldSimulateFailure = (draft: BookRecommendationDraft) =>
  normalizeText(draft.title).includes('失败测试') || normalizeText(draft.author).includes('失败测试');

export const recommendationService = {
  async submitRecommendation({
    draft,
    books,
    allowDuplicateSubmit = false,
  }: SubmitRecommendationParams): Promise<RecommendationSubmissionResult> {
    await delay(650);

    if (shouldSimulateFailure(draft)) {
      return {
        status: 'error',
        message: '提交失败，请检查信息后重试。',
        submittedAt: new Date().toISOString(),
      };
    }

    const duplicateBook = books.find(
      (book) =>
        normalizeText(book.title) === normalizeText(draft.title) &&
        normalizeText(book.author) === normalizeText(draft.author)
    );

    if (duplicateBook && !allowDuplicateSubmit) {
      return {
        status: 'duplicate',
        message: '该书已存在，你可以补充推荐理由后再次提交。',
        submittedAt: new Date().toISOString(),
        existingBook: toExistingBookSnapshot(duplicateBook),
      };
    }

    return {
      status: 'success',
      message: duplicateBook
        ? '已接收你的补充推荐理由，但不会自动进入正式雷达。'
        : '已接收你的书籍推荐，但不会自动进入正式雷达。',
      submittedAt: new Date().toISOString(),
      existingBook: duplicateBook ? toExistingBookSnapshot(duplicateBook) : undefined,
    };
  },
};
