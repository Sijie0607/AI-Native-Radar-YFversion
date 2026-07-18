import { AlertCircle, AlertTriangle, ArrowLeft, CheckCircle2 } from 'lucide-react';
import { DOMAINS } from '../../constants';
import {
  RecommendationExistingBookSnapshot,
  RecommendationSubmissionResult,
  RecommendationSubmissionStatus,
} from '../../types';

interface RecommendationResultProps {
  result: RecommendationSubmissionResult;
  isSubmitting: boolean;
  onBackToForm: () => void;
  onRetrySubmit: () => void;
  onContinueRecommend: () => void;
  onReturnBrowse: () => void;
}

const STATUS_META: Record<
  RecommendationSubmissionStatus,
  {
    title: string;
    icon: typeof CheckCircle2;
    colorClass: string;
    iconBgClass: string;
    panelBorderClass: string;
  }
> = {
  success: {
    title: '推荐已提交',
    icon: CheckCircle2,
    colorClass: 'text-emerald-300',
    iconBgClass: 'bg-emerald-500/15',
    panelBorderClass: 'border-emerald-500/20 bg-emerald-500/8',
  },
  duplicate: {
    title: '发现重复书籍',
    icon: AlertTriangle,
    colorClass: 'text-amber-300',
    iconBgClass: 'bg-amber-500/15',
    panelBorderClass: 'border-amber-500/20 bg-amber-500/8',
  },
  error: {
    title: '提交失败',
    icon: AlertCircle,
    colorClass: 'text-rose-300',
    iconBgClass: 'bg-rose-500/15',
    panelBorderClass: 'border-rose-500/20 bg-rose-500/8',
  },
};

const formatSubmittedTime = (submittedAt: string) =>
  new Intl.DateTimeFormat('zh-CN', {
    hour: '2-digit',
    minute: '2-digit',
    month: 'numeric',
    day: 'numeric',
  }).format(new Date(submittedAt));

const getDomainName = (domainId: RecommendationExistingBookSnapshot['domain']) =>
  DOMAINS.find((domain) => domain.id === domainId)?.name ?? '未分类';

const RecommendationResult = ({
  result,
  isSubmitting,
  onBackToForm,
  onRetrySubmit,
  onContinueRecommend,
  onReturnBrowse,
}: RecommendationResultProps) => {
  const meta = STATUS_META[result.status];
  const Icon = meta.icon;

  return (
    <section className="space-y-5 rounded-xl border border-slate-700 bg-slate-900/40 p-5">
      <div className={`rounded-xl border p-4 ${meta.panelBorderClass}`}>
        <div className="flex items-start gap-3">
          <div
            className={`inline-flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-xl ${meta.iconBgClass} ${meta.colorClass}`}
          >
            <Icon size={20} />
          </div>
          <div className="min-w-0 flex-1">
            <h3 className={`text-lg font-semibold ${meta.colorClass}`}>{meta.title}</h3>
            <p className="mt-2 text-sm leading-6 text-slate-200">{result.message}</p>
            <p className="mt-3 text-xs text-slate-400">处理时间：{formatSubmittedTime(result.submittedAt)}</p>
          </div>
        </div>
      </div>

      {result.existingBook && (
        <section className="rounded-xl border border-slate-700 bg-slate-800/70 p-4">
          <div className="mb-3 text-sm font-medium text-slate-200">已存在书籍信息</div>
          <div className="space-y-2 text-sm text-slate-300">
            <p>
              <span className="text-slate-400">书名：</span>
              {result.existingBook.title}
            </p>
            <p>
              <span className="text-slate-400">作者：</span>
              {result.existingBook.author}
            </p>
            <p>
              <span className="text-slate-400">所属领域：</span>
              {getDomainName(result.existingBook.domain)}
            </p>
            <p>
              <span className="text-slate-400">当前推荐指数：</span>
              {result.existingBook.recommendationScore.toFixed(1)} 星
            </p>
          </div>
        </section>
      )}

      {result.status === 'success' && (
        <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
          <button
            type="button"
            onClick={onContinueRecommend}
            className="rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:border-slate-500 hover:bg-slate-700"
          >
            继续推荐
          </button>
          <button
            type="button"
            onClick={onReturnBrowse}
            className="rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400"
          >
            返回浏览
          </button>
        </div>
      )}

      {result.status === 'duplicate' && (
        <div className="space-y-3">
          <p className="text-sm leading-6 text-slate-400">
            你可以回到表单补充更具体的推荐理由，再次提交为补充推荐。
          </p>
          <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
            <button
              type="button"
              onClick={onBackToForm}
              className="inline-flex items-center justify-center gap-2 rounded-xl bg-amber-500 px-4 py-3 text-sm font-medium text-slate-950 transition-colors hover:bg-amber-400"
            >
              <ArrowLeft size={16} />
              返回修改
            </button>
          </div>
        </div>
      )}

      {result.status === 'error' && (
        <div className="flex flex-col gap-3 sm:flex-row sm:justify-end">
          <button
            type="button"
            onClick={onBackToForm}
            className="rounded-xl border border-slate-600 px-4 py-3 text-sm font-medium text-slate-200 transition-colors hover:border-slate-500 hover:bg-slate-700"
          >
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

export default RecommendationResult;
