import { History, PencilLine, Trash2 } from 'lucide-react';
import { BookScoringRecord } from '../../types';

interface BookScoringRecordsProps {
  records: BookScoringRecord[];
  onBackToForm: () => void;
  onReturnBrowse: () => void;
  onClearRecords: () => void;
  onEditRecord: (record: BookScoringRecord) => void;
}

const ACTION_LABELS: Record<BookScoringRecord['actionType'], string> = {
  create: '首次评分',
  update: '修改评分',
};

const ACTION_CLASSES: Record<BookScoringRecord['actionType'], string> = {
  create: 'border-emerald-500/20 bg-emerald-500/8 text-emerald-300',
  update: 'border-amber-500/20 bg-amber-500/8 text-amber-300',
};

const formatRecordTime = (submittedAt: string) =>
  new Intl.DateTimeFormat('zh-CN', {
    month: 'numeric',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  }).format(new Date(submittedAt));

const BookScoringRecords = ({
  records,
  onBackToForm,
  onReturnBrowse,
  onClearRecords,
  onEditRecord,
}: BookScoringRecordsProps) => {
  return (
    <section className="space-y-5 rounded-xl border border-slate-700 bg-slate-900/40 p-5">
      <div className="flex items-start justify-between gap-4">
        <div>
          <div className="flex items-center gap-2 text-slate-50">
            <History size={18} />
            <h3 className="text-lg font-semibold">我的评分记录</h3>
          </div>
          <p className="mt-2 text-sm leading-6 text-slate-400">
            当前会话内的评分记录按最近提交在前排序。你可以从记录中直接再次编辑对应书籍的评分。
          </p>
        </div>
        {records.length > 0 && (
          <button
            type="button"
            onClick={onClearRecords}
            className="inline-flex items-center gap-2 rounded-xl border border-slate-600 px-3 py-2 text-sm text-slate-300 transition-colors hover:border-slate-500 hover:bg-slate-800"
          >
            <Trash2 size={16} />
            清空记录
          </button>
        )}
      </div>

      {records.length === 0 ? (
        <div className="rounded-xl border border-dashed border-slate-700 bg-slate-800/40 px-4 py-8 text-center">
          <p className="text-sm text-slate-400">当前会话还没有评分记录。</p>
        </div>
      ) : (
        <div className="space-y-3">
          {records.map((record) => (
            <article key={record.id} className="rounded-xl border border-slate-700 bg-slate-800/70 p-4">
              <div className="flex items-start justify-between gap-3">
                <div className="min-w-0 flex-1">
                  <div className="flex flex-wrap items-center gap-2">
                    <h4 className="truncate text-base font-semibold text-slate-50">{record.title}</h4>
                    <span
                      className={`rounded-full border px-2.5 py-1 text-xs font-medium ${ACTION_CLASSES[record.actionType]}`}
                    >
                      {ACTION_LABELS[record.actionType]}
                    </span>
                  </div>
                  <p className="mt-1 text-sm text-slate-400">{record.author}</p>
                </div>
                <span className="text-xs text-slate-500">{formatRecordTime(record.submittedAt)}</span>
              </div>

              <div className="mt-3 flex flex-wrap gap-2 text-xs text-slate-300">
                <span className="rounded-full bg-slate-700 px-2.5 py-1">我的评分：{record.score} 星</span>
                <span className="rounded-full bg-slate-700 px-2.5 py-1">
                  最新推荐指数：{record.updatedRecommendationScore.toFixed(2)} 星
                </span>
                <span className="rounded-full bg-slate-700 px-2.5 py-1">
                  推荐人数：{record.updatedVotesCount} 人
                </span>
              </div>

              <p className="mt-3 text-sm leading-6 text-slate-300">{record.reason}</p>

              <div className="mt-4 flex justify-end">
                <button
                  type="button"
                  onClick={() => onEditRecord(record)}
                  className="inline-flex items-center gap-2 rounded-xl border border-amber-500/30 bg-amber-500/10 px-3 py-2 text-sm font-medium text-amber-200 transition-colors hover:border-amber-400/50 hover:bg-amber-500/15"
                >
                  <PencilLine size={16} />
                  再次编辑
                </button>
              </div>
            </article>
          ))}
        </div>
      )}

      <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
        <button
          type="button"
          onClick={onBackToForm}
          className="rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:border-slate-500 hover:bg-slate-700"
        >
          返回评分表单
        </button>
        <button
          type="button"
          onClick={onReturnBrowse}
          className="rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400"
        >
          返回浏览
        </button>
      </div>
    </section>
  );
};

export default BookScoringRecords;
