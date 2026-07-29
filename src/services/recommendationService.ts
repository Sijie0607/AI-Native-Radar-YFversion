import {
  Book,
  BookRecommendationDraft,
  RecommendationExistingBookSnapshot,
  RecommendationSubmissionResult,
} from '../types';
import { callBackendRpc, isBackendConfigured } from './backendClient';

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

interface BackendRecommendationResult {
  status: RecommendationSubmissionResult['status'];
  message: string;
  submittedAt: string;
  existingBook?: RecommendationExistingBookSnapshot;
}

export const recommendationService = {
  async submitRecommendation({
    draft,
    books,
    allowDuplicateSubmit = false,
  }: SubmitRecommendationParams): Promise<RecommendationSubmissionResult> {
    if (isBackendConfigured) {
      try {
        return await callBackendRpc<BackendRecommendationResult>('submit_recommendation', {
          p_title: draft.title.trim(),
          p_author: draft.author.trim(),
          p_domain: draft.domain,
          p_reason: draft.reason.trim(),
          p_score: draft.score,
          p_resource_type: '书籍',
          p_url: null,
          p_recommender_name: '当前会话用户',
          p_is_anonymous: false,
          p_allow_duplicate_submit: allowDuplicateSubmit,
        });
      } catch (error) {
        return {
          status: 'error',
          message: '提交失败，后台暂时无法写入，请稍后重试。',
          submittedAt: new Date().toISOString(),
        };
      }
    }

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
