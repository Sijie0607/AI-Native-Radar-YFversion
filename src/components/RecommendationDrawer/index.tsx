import { BookPlus, ChevronRight, FileText, X } from 'lucide-react';

interface RecommendationDrawerProps {
  isOpen: boolean;
  onClose: () => void;
}

const RecommendationDrawer = ({ isOpen, onClose }: RecommendationDrawerProps) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50">
      <button
        type="button"
        aria-label="关闭推荐抽屉"
        className="absolute inset-0 bg-slate-950/45"
        onClick={onClose}
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
                你可以在这里填写推荐信息，并查看本次推荐的后续结果。
                <br />
                目前仅支持提交书籍，暂不支持课程、博客或视频。
              </p>
            </div>
            <button
              type="button"
              onClick={onClose}
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
              <ul className="mt-3 space-y-2 text-sm leading-6 text-slate-300">
                <li>仅支持提交书籍，不支持课程、博客或视频。</li>
                <li>提交后会收到处理结果反馈，推荐内容不会自动进入正式雷达。</li>
                <li>你可以在这里填写推荐信息，并查看本次推荐的后续结果。</li>
              </ul>
            </section>

            <section className="rounded-xl border border-slate-700 bg-slate-900/40 p-5">
              <div className="flex items-center justify-between">
                <div>
                  <h3 className="text-lg font-semibold text-slate-50">推荐表单</h3>
                  <p className="mt-1 text-sm text-slate-400">
                    这里将填写书名、作者、领域、推荐理由和推荐指数。
                  </p>
                </div>
                <ChevronRight size={18} className="text-slate-500" />
              </div>
            </section>

            <section className="rounded-xl border border-slate-700 bg-slate-900/40 p-5">
              <div className="flex items-center justify-between">
                <div>
                  <h3 className="text-lg font-semibold text-slate-50">结果与记录</h3>
                  <p className="mt-1 text-sm text-slate-400">
                    提交后可查看处理结果，以及当前会话内的推荐记录。
                  </p>
                </div>
                <ChevronRight size={18} className="text-slate-500" />
              </div>
            </section>
          </div>

          <div className="border-t border-slate-700 p-6">
            <button
              type="button"
              disabled
              className="w-full cursor-not-allowed rounded-xl bg-slate-700 px-4 py-3 text-sm font-medium text-slate-400"
            >
              表单功能即将开放
            </button>
          </div>
        </div>
      </aside>
    </div>
  );
};

export default RecommendationDrawer;
