import { Book } from '../types';
import {
  BookChange,
  VersionBookSnapshot,
  VersionChangeType,
  VersionCompareData,
} from '../types/versionCompare';

const roundDelta = (value: number) => Math.round(value * 100) / 100;

/**
 * 计算"当前 vs 上一版"的变化信息。
 * 以 resourceId（== Book.id，即 resources.id）匹配：
 * - 当前有、上版无 → added
 * - 两版都有 → 按 recommendationScore 差值定 score_up / score_down / unchanged
 * - 上版有、当前无 → 进入 removedBooks（用于渲染残影，不占点位）
 */
export function computeVersionCompareData(
  currentBooks: Book[],
  previousBooks: VersionBookSnapshot[],
): VersionCompareData {
  const previousById = new Map<string, VersionBookSnapshot>();
  previousBooks.forEach((snapshot) => previousById.set(snapshot.resourceId, snapshot));

  const currentById = new Set<string>(currentBooks.map((book) => book.id));
  const changesByBookId: Record<string, BookChange> = {};

  currentBooks.forEach((book) => {
    const previous = previousById.get(book.id);
    if (!previous) {
      changesByBookId[book.id] = { type: 'added' };
      return;
    }

    const scoreDelta = roundDelta(book.recommendationScore - previous.recommendationScore);
    const type: VersionChangeType =
      scoreDelta > 0 ? 'score_up' : scoreDelta < 0 ? 'score_down' : 'unchanged';

    changesByBookId[book.id] = {
      type,
      currentScore: book.recommendationScore,
      previousScore: previous.recommendationScore,
      scoreDelta,
      currentVotes: book.votesCount,
      previousVotes: previous.votesCount,
      votesDelta: book.votesCount - previous.votesCount,
    };
  });

  const removedBooks = previousBooks.filter((snapshot) => !currentById.has(snapshot.resourceId));

  // 有变化（非 unchanged）的当前书快照，含坐标，供离屏标记渲染
  const changedBooks: VersionBookSnapshot[] = [];
  currentBooks.forEach((book) => {
    const change = changesByBookId[book.id];
    if (change && change.type !== 'unchanged') {
      changedBooks.push({
        resourceId: book.id,
        title: book.title,
        author: book.author,
        domain: book.domain,
        difficultyLevel: book.difficultyLevel,
        sectorIndex: book.sectorIndex,
        ringIndex: book.ringIndex,
        x: book.x,
        y: book.y,
        recommendationScore: book.recommendationScore,
        votesCount: book.votesCount,
      });
    }
  });

  return { changesByBookId, removedBooks, changedBooks };
}
