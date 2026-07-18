import { useEffect, useMemo, useState } from 'react';
import { FileText, Star, X } from 'lucide-react';
import DraftConfirmModal from '../DraftConfirmModal';
import BookScoringForm from '../BookScoringForm';
import BookScoringRecords from '../BookScoringRecords';
import BookScoringResult from '../BookScoringResult';
import { useBookScoringStore } from '../../store/useBookScoringStore';
import { useResourceStore } from '../../store/useResourceStore';
import { bookScoringService } from '../../services/bookScoringService';
import {
  Book,
  BookScoringDraft,
  BookScoringDraftErrors,
  BookScoringRecord,
  BookScoringSubmissionResult,
  SessionBookScore,
} from '../../types';

type DrawerView = 'form' | 'result' | 'records';

interface BookScoringDrawerProps {
  isOpen: boolean;
  book: Book | null;
  onClose: () => void;
}

const createDraftFromBook = (book: Book, existingSessionScore?: SessionBookScore): BookScoringDraft => ({
  bookId: book.id,
  score: existingSessionScore?.score ?? null,
  reason: existingSessionScore?.reason ?? '',
  mode: existingSessionScore ? 'edit' : 'create',
  originalScore: existingSessionScore?.score,
  originalReason: existingSessionScore?.reason,
});

const BookScoringDrawer = ({ isOpen, book, onClose }: BookScoringDrawerProps) => {
  const { books, updateBook } = useResourceStore();
  const {
    draft,
    records,
    sessionScores,
    setDraft,
    setDraftField,
    resetDraft,
    addRecord,
    clearRecords,
    setSessionBookScore,
  } = useBookScoringStore();
  const [activeBook, setActiveBook] = useState<Book | null>(book);
  const [showDraftConfirm, setShowDraftConfirm] = useState(false);
  const [touchedFields, setTouchedFields] = useState<Partial<Record<'score' | 'reason', boolean>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submissionResult, setSubmissionResult] = useState<BookScoringSubmissionResult | null>(null);
  const [drawerView, setDrawerView] = useState<DrawerView>('form');

  const existingSessionScore = activeBook ? sessionScores[activeBook.id] : undefined;

  const initialDraft = useMemo(
    () => (activeBook ? createDraftFromBook(activeBook, existingSessionScore) : null),
    [activeBook, existingSessionScore],
  );

  useEffect(() => {
    if (!isOpen || !book) {
      return;
    }

    setActiveBook(book);
  }, [book, isOpen]);

  useEffect(() => {
    if (!isOpen || !activeBook || !initialDraft) {
      return;
    }

    setDraft(initialDraft);
    setTouchedFields({});
    setSubmissionResult(null);
    setIsSubmitting(false);
    setShowDraftConfirm(false);
    setDrawerView('form');
  }, [activeBook, initialDraft, isOpen, setDraft]);

  const allValidationErrors = useMemo<BookScoringDraftErrors>(() => {
    const errors: BookScoringDraftErrors = {};

    if (draft.score === null) errors.score = '请选择评分';
    if (!draft.reason.trim()) errors.reason = '请填写评分理由';

    return errors;
  }, [draft.reason, draft.score]);

  const visibleValidationErrors = useMemo<BookScoringDraftErrors>(() => {
    const errors: BookScoringDraftErrors = {};

    (Object.keys(touchedFields) as Array<'score' | 'reason'>).forEach((field) => {
      if (touchedFields[field] && allValidationErrors[field]) {
        errors[field] = allValidationErrors[field];
      }
    });

    return errors;
  }, [allValidationErrors, touchedFields]);

  const hasUnsavedChanges = useMemo(() => {
    if (!initialDraft) {
      return false;
    }

    return draft.score !== initialDraft.score || draft.reason.trim() !== initialDraft.reason.trim();
  }, [draft.reason, draft.score, initialDraft]);

  const isFormComplete = useMemo(
    () => Boolean(draft.score !== null && draft.reason.trim()),
    [draft.reason, draft.score],
  );

  const resetTransientState = () => {
    setTouchedFields({});
    setShowDraftConfirm(false);
    setSubmissionResult(null);
    setIsSubmitting(false);
    setDrawerView('form');
  };

  const closeDrawer = () => {
    resetTransientState();
    setActiveBook(null);
    onClose();
  };

  const markAllFieldsTouched = () => {
    setTouchedFields({
      score: true,
      reason: true,
    });
  };

  const createRecordFromResult = (
    result: BookScoringSubmissionResult,
    currentBook: Book,
  ): BookScoringRecord | null => {
    if (draft.score === null) {
      return null;
    }

    return {
      id: `${result.submittedAt}-${result.actionType}-${currentBook.id}`,
      bookId: currentBook.id,
      title: currentBook.title,
      author: currentBook.author,
      score: draft.score,
      reason: draft.reason.trim(),
      actionType: result.actionType,
      submittedAt: result.submittedAt,
      updatedRecommendationScore: result.updatedRecommendationScore ?? currentBook.recommendationScore,
      updatedVotesCount: result.updatedVotesCount ?? currentBook.votesCount,
    };
  };

  const handleFieldChange = <K extends keyof BookScoringDraft>(field: K, value: BookScoringDraft[K]) => {
    setDraftField(field, value);
  };

  const handleFieldBlur = (field: keyof BookScoringDraft) => {
    if (field === 'score' || field === 'reason') {
      setTouchedFields((prev) => ({
        ...prev,
        [field]: true,
      }));
    }
  };

  const handleSubmit = async () => {
    if (!activeBook) {
      return;
    }

    markAllFieldsTouched();

    if (!isFormComplete || isSubmitting) {
      return;
    }

    setIsSubmitting(true);

    const response = await bookScoringService.submitBookScore({
      book: activeBook,
      draft,
      existingSessionScore,
    });

    if (response.updatedBook) {
      updateBook(activeBook.id, response.updatedBook);
    }

    if (response.sessionScore) {
      setSessionBookScore(response.sessionScore);
    }

    const record = createRecordFromResult(response.result, activeBook);
    if (record && response.result.status === 'success') {
      addRecord(record);
    }

    setSubmissionResult(response.result);
    setDrawerView('result');
    setIsSubmitting(false);
  };

  const handleRequestClose = () => {
    if (submissionResult?.status === 'success') {
      closeDrawer();
      return;
    }

    if (hasUnsavedChanges) {
      setShowDraftConfirm(true);
      return;
    }

    resetDraft();
    closeDrawer();
  };

  const handleEditRecord = (record: BookScoringRecord) => {
    const targetBook = books.find((item) => item.id === record.bookId);
    if (!targetBook) {
      return;
    }

    const targetSessionScore = sessionScores[targetBook.id];
    setActiveBook(targetBook);
    setDraft(createDraftFromBook(targetBook, targetSessionScore));
    setTouchedFields({});
    setSubmissionResult(null);
    setDrawerView('form');
  };

  if (!isOpen || !activeBook) return null;

  return (
    <div className="fixed inset-0 z-50">
      <button
        type="button"
        aria-label="关闭评分抽屉"
        className="absolute inset-0 bg-slate-950/45"
        onClick={handleRequestClose}
      />

      <aside className="absolute inset-y-0 right-0 w-full max-w-[440px] border-l border-slate-700 bg-slate-800 shadow-2xl">
        <div className="flex h-full flex-col">
          <div className="flex items-start justify-between border-b border-slate-700 p-4 sm:p-6">
            <div className="pr-4">
              <div className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-amber-500/15 text-amber-300">
                <Star size={22} />
              </div>
              <h2 className="text-2xl font-bold text-slate-50">
                {draft.mode === 'edit' ? '修改评分' : '评分投票'}
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-400">
                为《{activeBook.title}》填写你的评分和判断理由。提交后，推荐指数会实时更新，但本轮不会影响雷达展示。
              </p>
            </div>
            <button
              type="button"
              onClick={handleRequestClose}
              className="rounded-lg p-2 text-slate-400 transition-colors hover:bg-slate-700 hover:text-slate-200"
            >
              <X size={20} />
            </button>
          </div>

          <div className="flex-1 space-y-6 overflow-y-auto p-4 sm:p-6">
            <section className="rounded-xl border border-amber-500/20 bg-amber-500/8 p-4">
              <div className="flex items-center gap-2 text-sm font-medium text-amber-200">
                <FileText size={16} />
                评分说明
              </div>
              <p className="mt-3 text-sm leading-6 text-slate-300">
                当前会话内，同一本书只保留你的一条有效评分。再次提交会覆盖旧评分，并同步刷新推荐指数与推荐人数。
              </p>
            </section>

            {drawerView === 'records' ? (
              <BookScoringRecords
                records={records}
                onBackToForm={() => {
                  setSubmissionResult(null);
                  setDrawerView('form');
                }}
                onReturnBrowse={() => {
                  closeDrawer();
                }}
                onClearRecords={clearRecords}
                onEditRecord={handleEditRecord}
              />
            ) : submissionResult ? (
              <BookScoringResult
                result={submissionResult}
                isSubmitting={isSubmitting}
                onBackToForm={() => {
                  setSubmissionResult(null);
                  setDrawerView('form');
                }}
                onRetrySubmit={handleSubmit}
                onViewRecords={() => setDrawerView('records')}
                onReturnBrowse={() => {
                  closeDrawer();
                }}
              />
            ) : (
              <BookScoringForm
                draft={draft}
                errors={visibleValidationErrors}
                bookTitle={activeBook.title}
                onFieldChange={handleFieldChange}
                onFieldBlur={handleFieldBlur}
                onSubmit={handleSubmit}
                isSubmitting={isSubmitting}
              />
            )}
          </div>
        </div>

        <DraftConfirmModal
          isOpen={showDraftConfirm}
          onKeepDraft={() => {
            closeDrawer();
          }}
          onDiscardDraft={() => {
            resetDraft();
            closeDrawer();
          }}
          onContinueEditing={() => setShowDraftConfirm(false)}
        />
      </aside>
    </div>
  );
};

export default BookScoringDrawer;
