import { useMemo, useState } from 'react';
import { BookPlus, FileText, X } from 'lucide-react';
import DraftConfirmModal from '../DraftConfirmModal';
import RecommendationForm from '../RecommendationForm';
import RecommendationRecords from '../RecommendationRecords';
import RecommendationResult from '../RecommendationResult';
import { useRecommendationStore } from '../../store/useRecommendationStore';
import { useResourceStore } from '../../store/useResourceStore';
import {
  BookRecommendationDraft,
  RecommendationDraftErrors,
  RecommendationRecord,
  RecommendationSubmissionResult,
} from '../../types';
import { recommendationService } from '../../services/recommendationService';

type DrawerView = 'form' | 'result' | 'records';

interface RecommendationDrawerProps {
  isOpen: boolean;
  onClose: () => void;
}

const RecommendationDrawer = ({ isOpen, onClose }: RecommendationDrawerProps) => {
  const { books } = useResourceStore();
  const { draft, records, addRecord, clearRecords, setDraftField, resetDraft } = useRecommendationStore();
  const [showDraftConfirm, setShowDraftConfirm] = useState(false);
  const [touchedFields, setTouchedFields] = useState<Partial<Record<keyof BookRecommendationDraft, boolean>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submissionResult, setSubmissionResult] = useState<RecommendationSubmissionResult | null>(null);
  const [allowDuplicateSubmit, setAllowDuplicateSubmit] = useState(false);
  const [drawerView, setDrawerView] = useState<DrawerView>('form');

  const allValidationErrors = useMemo<RecommendationDraftErrors>(() => {
    const errors: RecommendationDraftErrors = {};

    if (!draft.title.trim()) errors.title = '请输入资料名称';
    if (!draft.author.trim()) errors.author = '请输入作者/来源';
    if (draft.url.trim() && !/^https?:\/\//i.test(draft.url.trim())) {
      errors.url = '请输入以 http:// 或 https:// 开头的链接';
    }
    if (!draft.domain) errors.domain = '请选择所属领域';
    if (!draft.reason.trim()) errors.reason = '请填写推荐理由';
    if (draft.score === null) errors.score = '请选择推荐指数';

    return errors;
  }, [draft]);

  const visibleValidationErrors = useMemo<RecommendationDraftErrors>(() => {
    const errors: RecommendationDraftErrors = {};

    (Object.keys(touchedFields) as Array<keyof BookRecommendationDraft>).forEach((field) => {
      if (touchedFields[field] && allValidationErrors[field]) {
        errors[field] = allValidationErrors[field];
      }
    });

    return errors;
  }, [allValidationErrors, touchedFields]);

  const hasDraftContent = useMemo(
    () =>
      Boolean(
        draft.title.trim() ||
          draft.author.trim() ||
          draft.url.trim() ||
          draft.recommenderName.trim() ||
          draft.domain ||
          draft.fitFor.length > 0 ||
          draft.prerequisites.length > 0 ||
          draft.reason.trim() ||
          draft.score !== null
      ),
    [draft]
  );

  const isFormComplete = useMemo(
    () =>
      Boolean(
        draft.title.trim() &&
          draft.author.trim() &&
          draft.domain &&
          draft.reason.trim() &&
          draft.score !== null &&
          !allValidationErrors.url
      ),
    [allValidationErrors.url, draft]
  );

  const handleFieldChange = <K extends keyof BookRecommendationDraft>(
    field: K,
    value: BookRecommendationDraft[K]
  ) => {
    setDraftField(field, value);
  };

  const handleFieldBlur = (field: keyof BookRecommendationDraft) => {
    setTouchedFields((prev) => ({
      ...prev,
      [field]: true,
    }));
  };

  const resetTransientState = () => {
    setShowDraftConfirm(false);
    setTouchedFields({});
    setSubmissionResult(null);
    setAllowDuplicateSubmit(false);
    setIsSubmitting(false);
    setDrawerView('form');
  };

  const closeDrawer = () => {
    resetTransientState();
    onClose();
  };

  const resetForNewRecommendation = () => {
    resetDraft();
    resetTransientState();
  };

  const markAllFieldsTouched = () => {
    setTouchedFields({
      title: true,
      author: true,
      url: true,
      domain: true,
      fitFor: true,
      prerequisites: true,
      reason: true,
      score: true,
    });
  };

  const createRecordFromResult = (result: RecommendationSubmissionResult): RecommendationRecord | null => {
    if (!draft.domain || draft.score === null) {
      return null;
    }

    return {
      id: `${result.submittedAt}-${result.status}-${draft.title}-${draft.author}`,
      resourceType: draft.resourceType,
      title: draft.title.trim(),
      author: draft.author.trim(),
      url: draft.url.trim() || undefined,
      recommenderName: draft.recommenderName.trim() || '当前会话用户',
      domain: draft.domain,
      fitFor: draft.fitFor,
      prerequisites: draft.prerequisites,
      score: draft.score,
      reason: draft.reason.trim(),
      status: result.status,
      message: result.message,
      submittedAt: result.submittedAt,
      existingBook: result.existingBook,
    };
  };

  const handleSubmit = async () => {
    markAllFieldsTouched();

    if (!isFormComplete || isSubmitting) {
      return;
    }

    setIsSubmitting(true);

    const result = await recommendationService.submitRecommendation({
      draft,
      books,
      allowDuplicateSubmit,
    });

    const record = createRecordFromResult(result);
    if (record) {
      addRecord(record);
    }

    setSubmissionResult(result);
    setAllowDuplicateSubmit(result.status === 'duplicate');
    setDrawerView('result');
    setIsSubmitting(false);
  };

  const handleRequestClose = () => {
    if (submissionResult?.status === 'success') {
      resetDraft();
      closeDrawer();
      return;
    }

    if (hasDraftContent) {
      setShowDraftConfirm(true);
      return;
    }

    closeDrawer();
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50">
      <button
        type="button"
        aria-label="关闭推荐抽屉"
        className="absolute inset-0 bg-slate-950/45"
        onClick={handleRequestClose}
      />

      <aside className="paper-drawer absolute inset-y-0 right-0 w-full border-l border-slate-700 bg-slate-800 shadow-2xl sm:w-[480px] lg:w-[38.2vw] lg:min-w-[500px] lg:max-w-[640px]">
        <div className="flex h-full flex-col">
          <div className="flex items-start justify-between border-b border-slate-700 p-4 sm:p-5">
            <div className="pr-4">
              <div className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-[#0E42D2]/15 text-[var(--paper-accent)]">
                <BookPlus size={22} />
              </div>
              <h2 className="text-2xl font-bold text-slate-50">资料推荐</h2>
              <p className="mt-2 text-sm leading-6 text-slate-400">
                分享一份你认为值得推荐的 AI 领域资料，帮助从业者快速找到适合自己的高质量学习参考。
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

          <div className="flex-1 space-y-4 overflow-y-auto p-4 sm:p-5">
            <section className="paper-card rounded-xl border border-[#0E42D2]/20 bg-[#0E42D2]/10 p-4">
              <div className="flex items-center gap-2 text-sm font-medium text-[var(--paper-accent)]">
                <FileText size={16} />
                推荐说明
              </div>
              <p className="mt-3 text-sm leading-6 text-slate-300">
                你可以在这里填写推荐信息，并查看本次推荐的后续结果。
                <br />
                支持提交书籍、在线课程、官方文档、文章或其他 AI 学习资料。
              </p>
            </section>

            {drawerView === 'records' ? (
              <RecommendationRecords
                records={records}
                onBackToForm={() => {
                  setSubmissionResult(null);
                  setDrawerView('form');
                }}
                onReturnBrowse={() => {
                  if (submissionResult?.status === 'success') {
                    resetDraft();
                  }
                  closeDrawer();
                }}
                onClearRecords={clearRecords}
              />
            ) : submissionResult ? (
              <RecommendationResult
                result={submissionResult}
                isSubmitting={isSubmitting}
                onBackToForm={() => {
                  setSubmissionResult(null);
                  setDrawerView('form');
                }}
                onRetrySubmit={handleSubmit}
                onContinueRecommend={() => {
                  resetForNewRecommendation();
                }}
                onReturnBrowse={() => {
                  resetDraft();
                  closeDrawer();
                }}
                onViewRecords={() => setDrawerView('records')}
              />
            ) : (
              <RecommendationForm
                draft={draft}
                errors={visibleValidationErrors}
                onFieldChange={handleFieldChange}
                onFieldBlur={handleFieldBlur}
                onSubmit={handleSubmit}
                isSubmitting={isSubmitting}
                submitLabel={allowDuplicateSubmit ? '提交补充推荐' : '提交推荐'}
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

export default RecommendationDrawer;
