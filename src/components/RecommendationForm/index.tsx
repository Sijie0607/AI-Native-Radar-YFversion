import { useMemo } from 'react';
import { BookRecommendationDraft, RecommendationDraftErrors, RecommendationScore } from '../../types';
import { DOMAINS } from '../../constants';

interface RecommendationFormProps {
  draft: BookRecommendationDraft;
  errors: RecommendationDraftErrors;
  onFieldChange: <K extends keyof BookRecommendationDraft>(field: K, value: BookRecommendationDraft[K]) => void;
  onFieldBlur: (field: keyof BookRecommendationDraft) => void;
  onSubmit: () => void;
  isSubmitting: boolean;
  submitLabel?: string;
}

const SCORE_OPTIONS: RecommendationScore[] = [3, 4, 5];

const RecommendationForm = ({
  draft,
  errors,
  onFieldChange,
  onFieldBlur,
  onSubmit,
  isSubmitting,
  submitLabel = '提交推荐',
}: RecommendationFormProps) => {
  const isComplete = useMemo(
    () =>
      Boolean(
        draft.title.trim() &&
          draft.author.trim() &&
          draft.domain &&
          draft.reason.trim() &&
          draft.score !== null
      ),
    [draft]
  );

  return (
    <section className="rounded-xl border border-slate-700 bg-slate-900/40 p-5">
      <div className="mb-5">
        <h3 className="text-lg font-semibold text-slate-50">推荐表单</h3>
        <p className="mt-1 text-sm text-slate-400">
          请填写书名、作者、所属领域、推荐理由和推荐指数。所有字段均为必填。
        </p>
      </div>

      <div className="space-y-5">
        <div>
          <label htmlFor="recommend-title" className="mb-2 block text-sm font-medium text-slate-200">
            书名
          </label>
          <input
            id="recommend-title"
            type="text"
            value={draft.title}
            onChange={(e) => onFieldChange('title', e.target.value)}
            onBlur={() => onFieldBlur('title')}
            placeholder="例如：深度学习入门"
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-blue-500 focus:outline-none"
          />
          {errors.title && <p className="mt-2 text-sm text-rose-400">{errors.title}</p>}
        </div>

        <div>
          <label htmlFor="recommend-author" className="mb-2 block text-sm font-medium text-slate-200">
            作者
          </label>
          <input
            id="recommend-author"
            type="text"
            value={draft.author}
            onChange={(e) => onFieldChange('author', e.target.value)}
            onBlur={() => onFieldBlur('author')}
            placeholder="例如：斋藤康毅"
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-blue-500 focus:outline-none"
          />
          {errors.author && <p className="mt-2 text-sm text-rose-400">{errors.author}</p>}
        </div>

        <div>
          <p className="mb-2 block text-sm font-medium text-slate-200">所属领域</p>
          <div className="flex flex-wrap gap-2">
            {DOMAINS.map((domain) => {
              const isSelected = draft.domain === domain.id;
              return (
                <button
                  key={domain.id}
                  type="button"
                  onClick={() => {
                    onFieldChange('domain', domain.id);
                    onFieldBlur('domain');
                  }}
                  className={`rounded-full px-3 py-2 text-sm font-medium transition-all ${
                    isSelected
                      ? 'text-white shadow-lg'
                      : 'bg-slate-800 text-slate-400 hover:bg-slate-700 hover:text-slate-200'
                  }`}
                  style={{
                    backgroundColor: isSelected ? domain.color : undefined,
                  }}
                >
                  {domain.name}
                </button>
              );
            })}
          </div>
          {errors.domain && <p className="mt-2 text-sm text-rose-400">{errors.domain}</p>}
        </div>

        <div>
          <label htmlFor="recommend-reason" className="mb-2 block text-sm font-medium text-slate-200">
            推荐理由
          </label>
          <textarea
            id="recommend-reason"
            value={draft.reason}
            onChange={(e) => onFieldChange('reason', e.target.value)}
            onBlur={() => onFieldBlur('reason')}
            placeholder="请阐述清楚推荐理由，例如这本书为什么值得读、适合什么水平的人读等。"
            rows={5}
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm leading-6 text-slate-50 placeholder:text-slate-500 focus:border-blue-500 focus:outline-none"
          />
          <div className="mt-2 flex items-center justify-between">
            {errors.reason ? (
              <p className="text-sm text-rose-400">{errors.reason}</p>
            ) : (
              <p className="text-sm text-slate-500">推荐理由应帮助他人判断这本书是否适合自己。</p>
            )}
            <span className="text-xs text-slate-500">{draft.reason.trim().length} 字</span>
          </div>
        </div>

        <div>
          <p className="mb-2 block text-sm font-medium text-slate-200">推荐指数</p>
          <div className="flex gap-2">
            {SCORE_OPTIONS.map((score) => {
              const isSelected = draft.score === score;
              return (
                <button
                  key={score}
                  type="button"
                  onClick={() => {
                    onFieldChange('score', score);
                    onFieldBlur('score');
                  }}
                  className={`flex-1 rounded-xl border px-4 py-3 text-sm font-medium transition-colors ${
                    isSelected
                      ? 'border-amber-400 bg-amber-500/15 text-amber-300'
                      : 'border-slate-600 bg-slate-800 text-slate-300 hover:border-slate-500 hover:bg-slate-700'
                  }`}
                >
                  {score} 星
                </button>
              );
            })}
          </div>
          {errors.score && <p className="mt-2 text-sm text-rose-400">{errors.score}</p>}
        </div>
      </div>

      <div className="mt-6 rounded-xl border border-slate-700 bg-slate-800/70 p-4">
        <p className="text-sm leading-6 text-slate-400">
          推荐内容不会自动进入正式雷达。提交后你会收到明确结果反馈。
        </p>
      </div>

      <div className="mt-6 flex items-center justify-between gap-3">
        <p className="text-sm text-slate-500">
          {isComplete ? '当前信息已补全。' : '请先补全必填信息。'}
        </p>
        <button
          type="button"
          onClick={onSubmit}
          disabled={!isComplete || isSubmitting}
          className="rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400 disabled:cursor-not-allowed disabled:bg-slate-700 disabled:text-slate-400"
        >
          {isSubmitting ? '提交中...' : submitLabel}
        </button>
      </div>
    </section>
  );
};

export default RecommendationForm;
