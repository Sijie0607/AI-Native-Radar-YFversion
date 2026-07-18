interface DraftConfirmModalProps {
  isOpen: boolean;
  onKeepDraft: () => void;
  onDiscardDraft: () => void;
  onContinueEditing: () => void;
}

const DraftConfirmModal = ({
  isOpen,
  onKeepDraft,
  onDiscardDraft,
  onContinueEditing,
}: DraftConfirmModalProps) => {
  if (!isOpen) return null;

  return (
    <div className="absolute inset-0 z-20 flex items-center justify-center bg-slate-950/60 p-6">
      <div className="w-full max-w-md rounded-2xl border border-slate-700 bg-slate-900 p-6 shadow-2xl">
        <h3 className="text-xl font-semibold text-slate-50">保留草稿吗？</h3>
        <p className="mt-3 text-sm leading-6 text-slate-400">
          你还有未提交的推荐内容。关闭前可以选择保留为草稿，稍后继续编辑。
        </p>

        <div className="mt-6 space-y-3">
          <button
            type="button"
            onClick={onKeepDraft}
            className="w-full rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-all hover:bg-blue-400"
          >
            保留草稿并关闭
          </button>
          <button
            type="button"
            onClick={onDiscardDraft}
            className="w-full rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:bg-slate-800"
          >
            不保留并关闭
          </button>
          <button
            type="button"
            onClick={onContinueEditing}
            className="w-full rounded-xl px-4 py-3 text-sm font-medium text-slate-400 transition-colors hover:bg-slate-800 hover:text-slate-200"
          >
            返回继续编辑
          </button>
        </div>
      </div>
    </div>
  );
};

export default DraftConfirmModal;
