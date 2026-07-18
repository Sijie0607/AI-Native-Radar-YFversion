import { useMemo } from 'react';
import { BookScoringDraft, BookScoringDraftErrors, BookScoringScore } from '../../types';

interface BookScoringFormProps {
  draft: BookScoringDraft;
  errors: BookScoringDraftErrors;
  bookTitle: string;
  onFieldChange: <K extends keyof BookScoringDraft>(field: K, value: BookScoringDraft[K]) => void;
  onFieldBlur: (field: keyof BookScoringDraft) => void;
  onSubmit: () => void;
  isSubmitting: boolean;
}

const SCORE_OPTIONS: BookScoringScore[] = [3, 3.5, 4, 4.5, 5];

const BookScoringForm = ({
  draft,
  errors,
  bookTitle,
  onFieldChange,
  onFieldBlur,
  onSubmit,
  isSubmitting,
}: BookScoringFormProps) => {
  const isComplete = useMemo(
    () => Boolean(draft.score !== null && draft.reason.trim()),
    [draft.reason, draft.score],
  );

  const isEditMode = draft.mode === 'edit';

  return (
    <section className="rounded-xl border border-slate-700 bg-slate-900/40 p-5">
      <div className="mb-5">
        <h3 className="text-lg font-semibold text-slate-50">
          {isEditMode ? '修改评分' : '评分表单'}
        </h3>
        <p className="mt-1 text-sm leading-6 text-slate-400">
          你正在为《{bookTitle}》填写评分。评分支持 3-5 星和 0.5 分颗粒度，评分理由为必填。
        </p>
      </div>

      <div className="space-y-5">
        <div>
          <p className="mb-2 block text-sm font-medium text-slate-200">推荐指数</p>
          <div className="grid grid-cols-2 gap-2 sm:grid-cols-5">
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
                  className={`rounded-xl border px-4 py-3 text-sm font-medium transition-colors ${
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

        <div>
          <label htmlFor="score-reason" className="mb-2 block text-sm font-medium text-slate-200">
            评分理由
          </label>
          <textarea
            id="score-reason"
            value={draft.reason}
            onChange={(e) => onFieldChange('reason', e.target.value)}
            onBlur={() => onFieldBlur('reason')}
            placeholder="请说明这本书为什么值得读、适合什么人、与你的实际判断依据是什么。"
            rows={6}
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm leading-6 text-slate-50 placeholder:text-slate-500 focus:border-blue-500 focus:outline-none"
          />
          <div className="mt-2 flex items-center justify-between">
            {errors.reason ? (
              <p className="text-sm text-rose-400">{errors.reason}</p>
            ) : (
              <p className="text-sm text-slate-500">你的判断会影响该书的推荐指数展示结果。</p>
            )}
            <span className="text-xs text-slate-500">{draft.reason.trim().length} 字</span>
          </div>
        </div>
      </div>

      <div className="mt-6 rounded-xl border border-slate-700 bg-slate-800/70 p-4">
        <p className="text-sm leading-6 text-slate-400">
          提交后，推荐指数会实时更新；当前会话内，同一本书只保留你的一条有效评分。本轮不会改变雷达展示。
        </p>
      </div>

      <div className="mt-6 flex items-center justify-between gap-3">
        <p className="text-sm text-slate-500">
          {isComplete ? '当前信息已补全。' : '请先完成评分和理由。'}
        </p>
        <button
          type="button"
          onClick={onSubmit}
          disabled={!isComplete || isSubmitting}
          className="rounded-xl bg-blue-500 px-4 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400 disabled:cursor-not-allowed disabled:bg-slate-700 disabled:text-slate-400"
        >
          {isSubmitting ? '提交中...' : isEditMode ? '更新评分' : '提交评分'}
        </button>
      </div>
    </section>
  );
};

export default BookScoringForm;
