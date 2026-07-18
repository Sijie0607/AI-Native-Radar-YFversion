import { useMemo, useState } from 'react';
import { BookPlus, FileText, X } from 'lucide-react';
import DraftConfirmModal from '../DraftConfirmModal';
import RecommendationForm from '../RecommendationForm';
import { useRecommendationStore } from '../../store/useRecommendationStore';
import { BookRecommendationDraft, RecommendationDraftErrors } from '../../types';

interface RecommendationDrawerProps {
  isOpen: boolean;
  onClose: () => void;
}

const RecommendationDrawer = ({ isOpen, onClose }: RecommendationDrawerProps) => {
  const { draft, setDraftField, resetDraft } = useRecommendationStore();
  const [showDraftConfirm, setShowDraftConfirm] = useState(false);
  const [touchedFields, setTouchedFields] = useState<Partial<Record<keyof BookRecommendationDraft, boolean>>>({});

  const allValidationErrors = useMemo<RecommendationDraftErrors>(() => {
    const errors: RecommendationDraftErrors = {};

    if (!draft.title.trim()) errors.title = '请输入书名';
    if (!draft.author.trim()) errors.author = '请输入作者';
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
          draft.domain ||
          draft.reason.trim() ||
          draft.score !== null
      ),
    [draft]
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

  const handleRequestClose = () => {
    if (hasDraftContent) {
      setShowDraftConfirm(true);
      return;
    }

    onClose();
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

      <aside className="absolute inset-y-0 right-0 w-full max-w-[440px] border-l border-slate-700 bg-slate-800 shadow-2xl">
        <div className="flex h-full flex-col">
          <div className="flex items-start justify-between border-b border-slate-700 p-6">
            <div className="pr-4">
              <div className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-blue-500/15 text-blue-400">
                <BookPlus size={22} />
              </div>
              <h2 className="text-2xl font-bold text-slate-50">书籍推荐</h2>
              <p className="mt-2 text-sm leading-6 text-slate-400">
                分享一本你认为值得推荐的 AI 领域书籍，帮助从业者快速找到适合自己的高质量学习参考用书。
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

          <div className="flex-1 space-y-6 overflow-y-auto p-6">
            <section className="rounded-xl border border-blue-500/20 bg-blue-500/8 p-4">
              <div className="flex items-center gap-2 text-sm font-medium text-blue-300">
                <FileText size={16} />
                推荐说明
              </div>
              <p className="mt-3 text-sm leading-6 text-slate-300">
                你可以在这里填写推荐信息，并查看本次推荐的后续结果。
                <br />
                目前仅支持提交书籍，暂不支持课程、博客或视频。
              </p>
            </section>

            <RecommendationForm
              draft={draft}
              errors={visibleValidationErrors}
              onFieldChange={handleFieldChange}
              onFieldBlur={handleFieldBlur}
            />
          </div>
        </div>

        <DraftConfirmModal
          isOpen={showDraftConfirm}
          onKeepDraft={() => {
            setShowDraftConfirm(false);
            onClose();
          }}
          onDiscardDraft={() => {
            resetDraft();
            setTouchedFields({});
            setShowDraftConfirm(false);
            onClose();
          }}
          onContinueEditing={() => setShowDraftConfirm(false)}
        />
      </aside>
    </div>
  );
};

export default RecommendationDrawer;
