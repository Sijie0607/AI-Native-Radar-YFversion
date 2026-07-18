import {
  Book,
  BookScoringDraft,
  BookScoringSubmissionResult,
  BookScoringActionType,
  Recommendation,
  SessionBookScore,
} from '../types';

interface SubmitBookScoreParams {
  book: Book;
  draft: BookScoringDraft;
  existingSessionScore?: SessionBookScore;
}

interface SubmitBookScoreResponse {
  result: BookScoringSubmissionResult;
  updatedBook?: Book;
  sessionScore?: SessionBookScore;
}

const SESSION_RECOMMENDER_PREFIX = 'session-score';

const delay = (ms: number) =>
  new Promise<void>((resolve) => {
    setTimeout(resolve, ms);
  });

const normalizeText = (value: string) => value.trim().toLowerCase();

const roundScore = (value: number) => Math.round(value * 100) / 100;

const buildSessionRecommendationId = (bookId: string) => `${SESSION_RECOMMENDER_PREFIX}:${bookId}`;

const shouldSimulateFailure = (draft: BookScoringDraft) =>
  normalizeText(draft.reason).includes('失败测试');

const buildSessionRecommendation = (
  bookId: string,
  score: number,
  reason: string,
  submittedAt: string,
): Recommendation => ({
  id: buildSessionRecommendationId(bookId),
  recommender: '当前会话评分',
  isAnonymous: false,
  reason,
  score,
  recommendedAt: submittedAt,
});

const replaceSessionRecommendation = (
  recommendations: Recommendation[],
  nextRecommendation: Recommendation,
) => {
  const nextId = nextRecommendation.id;
  const withoutCurrentSession = recommendations.filter((item) => item.id !== nextId);
  return [nextRecommendation, ...withoutCurrentSession];
};

const calculateNextAggregate = ({
  currentAverage,
  currentVotesCount,
  nextScore,
  previousScore,
}: {
  currentAverage: number;
  currentVotesCount: number;
  nextScore: number;
  previousScore?: number;
}) => {
  const normalizedVotesCount = Math.max(currentVotesCount, 0);
  const currentTotal = currentAverage * normalizedVotesCount;

  if (typeof previousScore === 'number' && normalizedVotesCount > 0) {
    const nextTotal = currentTotal - previousScore + nextScore;
    return {
      recommendationScore: roundScore(nextTotal / normalizedVotesCount),
      votesCount: normalizedVotesCount,
      actionType: 'update' as BookScoringActionType,
    };
  }

  const nextVotesCount = normalizedVotesCount + 1;
  const nextTotal = currentTotal + nextScore;

  return {
    recommendationScore: roundScore(nextTotal / nextVotesCount),
    votesCount: nextVotesCount,
    actionType: 'create' as BookScoringActionType,
  };
};

export const bookScoringService = {
  async submitBookScore({
    book,
    draft,
    existingSessionScore,
  }: SubmitBookScoreParams): Promise<SubmitBookScoreResponse> {
    await delay(450);

    if (shouldSimulateFailure(draft)) {
      return {
        result: {
          status: 'error',
          actionType: existingSessionScore ? 'update' : 'create',
          message: '评分提交失败，请检查内容后重试。',
          submittedAt: new Date().toISOString(),
          bookId: book.id,
        },
      };
    }

    if (!draft.bookId || draft.bookId !== book.id || draft.score === null) {
      return {
        result: {
          status: 'error',
          actionType: existingSessionScore ? 'update' : 'create',
          message: '评分信息不完整，暂时无法提交。',
          submittedAt: new Date().toISOString(),
          bookId: book.id,
        },
      };
    }

    const submittedAt = new Date().toISOString();
    const aggregate = calculateNextAggregate({
      currentAverage: book.recommendationScore,
      currentVotesCount: book.votesCount,
      nextScore: draft.score,
      previousScore: existingSessionScore?.score,
    });

    const sessionScore: SessionBookScore = {
      bookId: book.id,
      score: draft.score,
      reason: draft.reason.trim(),
      submittedAt,
    };

    const nextRecommendation = buildSessionRecommendation(
      book.id,
      draft.score,
      draft.reason.trim(),
      submittedAt,
    );

    const updatedBook: Book = {
      ...book,
      recommendationScore: aggregate.recommendationScore,
      votesCount: aggregate.votesCount,
      recommendations: replaceSessionRecommendation(book.recommendations, nextRecommendation),
    };

    return {
      result: {
        status: 'success',
        actionType: aggregate.actionType,
        message:
          aggregate.actionType === 'update'
            ? '你的评分已更新，推荐指数已同步刷新。'
            : '你的评分已生效，推荐指数已同步刷新。',
        submittedAt,
        bookId: book.id,
        updatedRecommendationScore: aggregate.recommendationScore,
        updatedVotesCount: aggregate.votesCount,
      },
      updatedBook,
      sessionScore,
    };
  },
};
