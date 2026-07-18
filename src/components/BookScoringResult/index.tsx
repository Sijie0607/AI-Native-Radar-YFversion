import { AlertCircle, ArrowLeft, CheckCircle2 } from 'lucide-react';
import { BookScoringSubmissionResult } from '../../types';

interface BookScoringResultProps {
  result: BookScoringSubmissionResult;
  isSubmitting: boolean;
  onBackToForm: () => void;
  onRetrySubmit: () => void;
  onReturnBrowse: () => void;
}

const formatSubmittedTime = (submittedAt: string) =>
  new Intl.DateTimeFormat('zh-CN', {
    hour: '2-digit',
    minute: '2-digit',
    month: 'numeric',
    day: 'numeric',
  }).format(new Date(submittedAt));

const BookScoringResult = ({
  result,
  isSubmitting,
  onBackToForm,
  onRetrySubmit,
  onReturnBrowse,
}: BookScoringResultProps) => {
  const isSuccess = result.status === 'success';
  const title = isSuccess
    ? result.actionType === 'update'
      ? '评分已更新'
      : '评分已提交'
    : '提交失败';
  const Icon = isSuccess ? CheckCircle2 : AlertCircle;
  const colorClass = isSuccess ? 'text-emerald-300' : 'text-rose-300';
  const iconBgClass = isSuccess ? 'bg-emerald-500/15' : 'bg-rose-500/15';
  const panelClass = isSuccess
    ? 'border-emerald-500/20 bg-emerald-500/8'
    : 'border-rose-500/20 bg-rose-500/8';

  return (
    <section className="space-y-5 rounded-xl border border-slate-700 bg-slate-900/40 p-5">
      <div className={`rounded-xl border p-4 ${panelClass}`}>
        <div className="flex items-start gap-3">
          <div
            className={`inline-flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-xl ${iconBgClass} ${colorClass}`}
          >
            <Icon size={20} />
          </div>
          <div className="min-w-0 flex-1">
            <h3 className={`text-lg font-semibold ${colorClass}`}>{title}</h3>
            <p className="mt-2 text-sm leading-6 text-slate-200">{result.message}</p>
            <p className="mt-3 text-xs text-slate-400">处理时间：{formatSubmittedTime(result.submittedAt)}</p>
          </div>
        </div>
      </div>

      {isSuccess && (
        <section className="rounded-xl border border-slate-700 bg-slate-800/70 p-4 text-sm leading-6 text-slate-300">
          <p>
            最新推荐指数：
            <span className="ml-1 font-semibold text-amber-300">
              {result.updatedRecommendationScore?.toFixed(2) ?? '--'} 星
            </span>
          </p>
          <p className="mt-2">
            当前推荐人数：
            <span className="ml-1 font-semibold text-slate-100">{result.updatedVotesCount ?? '--'} 人</span>
          </p>
          <p className="mt-3 text-slate-400">本轮只更新推荐指数，不改变雷达中的点位展示。</p>
        </section>
      )}

      {isSuccess ? (
        <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
          <button
            type="button"
            onClick={onBackToForm}
            className="rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:border-slate-500 hover:bg-slate-700"
          >
            继续调整
          </button>
          <button
            type="button"
            onClick={onReturnBrowse}
            className="rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400"
          >
            返回浏览
          </button>
        </div>
      ) : (
        <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
          <button
            type="button"
            onClick={onBackToForm}
            className="inline-flex items-center justify-center gap-2 rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:border-slate-500 hover:bg-slate-700"
          >
            <ArrowLeft size={16} />
            返回编辑
          </button>
          <button
            type="button"
            onClick={onRetrySubmit}
            disabled={isSubmitting}
            className="rounded-xl bg-rose-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-rose-400 disabled:cursor-not-allowed disabled:opacity-70"
          >
            {isSubmitting ? '重试中...' : '重试提交'}
          </button>
        </div>
      )}
    </section>
  );
};

export default BookScoringResult;
