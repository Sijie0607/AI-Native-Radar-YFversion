import { ReactNode, useMemo } from 'react';
import { BookRecommendationDraft, RecommendationDraftErrors, RecommendationScore } from '../../types';
import {
  DOMAINS,
  getDomainColorToken,
  getPrerequisiteOptionsForAudiences,
  RECOMMENDATION_AUDIENCE_OPTIONS,
  RESOURCE_TYPE_OPTIONS,
} from '../../constants';

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

interface FieldTitleProps {
  children: ReactNode;
  htmlFor?: string;
}

const choiceButtonBaseClass = 'rounded-full border px-2.5 py-1.5 text-xs font-medium transition-colors';

const FieldTitle = ({ children, htmlFor }: FieldTitleProps) => {
  const content = (
    <>
      <span className="h-3.5 w-1 rounded-full bg-[var(--paper-accent)]" />
      <span>{children}</span>
    </>
  );
  const className = 'mb-2 flex items-center gap-2 text-[13px] font-semibold text-slate-100';

  if (htmlFor) {
    return (
      <label htmlFor={htmlFor} className={className}>
        {content}
      </label>
    );
  }

  return <p className={className}>{content}</p>;
};

const isValidOptionalUrl = (value: string) => {
  const trimmed = value.trim();
  return !trimmed || /^https?:\/\//i.test(trimmed);
};

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
          draft.score !== null &&
          isValidOptionalUrl(draft.url)
      ),
    [draft]
  );

  const prerequisiteOptions = useMemo(
    () => getPrerequisiteOptionsForAudiences(draft.fitFor),
    [draft.fitFor],
  );

  const toggleArrayValue = (field: 'fitFor' | 'prerequisites', value: string) => {
    const currentValues = draft[field];
    const nextValues = currentValues.includes(value)
      ? currentValues.filter((item) => item !== value)
      : [...currentValues, value];

    onFieldChange(field, nextValues);
    onFieldBlur(field);
  };

  const toggleAudience = (value: string) => {
    const nextFitFor = draft.fitFor.includes(value)
      ? draft.fitFor.filter((item) => item !== value)
      : [...draft.fitFor, value];
    const nextPrerequisiteOptions = getPrerequisiteOptionsForAudiences(nextFitFor);
    const visiblePrerequisites = new Set(nextPrerequisiteOptions.map((option) => option.label));
    const nextPrerequisites = draft.prerequisites.filter((item) => visiblePrerequisites.has(item));

    onFieldChange('fitFor', nextFitFor);
    if (nextPrerequisites.length !== draft.prerequisites.length) {
      onFieldChange('prerequisites', nextPrerequisites);
    }
    onFieldBlur('fitFor');
  };

  return (
    <section className="paper-panel rounded-xl border border-slate-700 bg-slate-900/40 p-4">
      <div className="mb-5">
        <h3 className="text-lg font-semibold text-slate-50">推荐表单</h3>
        <p className="mt-1 text-sm text-slate-400">
          请填写资料名称、作者/来源、所属领域、推荐理由和推荐指数。推荐人、链接、适合人群和前置能力可选填。
        </p>
      </div>

      <div className="space-y-4">
        <div>
          <FieldTitle>资料类型</FieldTitle>
          <div className="flex flex-wrap gap-1.5">
            {RESOURCE_TYPE_OPTIONS.map((resourceType) => {
              const isSelected = draft.resourceType === resourceType;

              return (
                <button
                  key={resourceType}
                  type="button"
                  onClick={() => {
                    onFieldChange('resourceType', resourceType);
                    onFieldBlur('resourceType');
                  }}
                  className={`${choiceButtonBaseClass} ${
                    isSelected
                      ? 'border-[var(--paper-accent)] bg-[var(--paper-accent)] text-white'
                      : 'border-slate-600 bg-slate-800 text-slate-300 hover:border-slate-500 hover:bg-slate-700'
                  }`}
                >
                  {resourceType}
                </button>
              );
            })}
          </div>
        </div>

        <div>
          <FieldTitle htmlFor="recommend-title">资料名称</FieldTitle>
          <input
            id="recommend-title"
            type="text"
            value={draft.title}
            onChange={(e) => onFieldChange('title', e.target.value)}
            onBlur={() => onFieldBlur('title')}
            placeholder="例如：深度学习入门 / 官方文档 / 在线课程"
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-[var(--paper-accent)] focus:outline-none"
          />
          {errors.title && <p className="mt-2 text-sm text-rose-400">{errors.title}</p>}
        </div>

        <div>
          <FieldTitle htmlFor="recommend-author">作者/来源</FieldTitle>
          <input
            id="recommend-author"
            type="text"
            value={draft.author}
            onChange={(e) => onFieldChange('author', e.target.value)}
            onBlur={() => onFieldBlur('author')}
            placeholder="例如：斋藤康毅 / Anthropic / DeepLearning.AI"
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-[var(--paper-accent)] focus:outline-none"
          />
          {errors.author && <p className="mt-2 text-sm text-rose-400">{errors.author}</p>}
        </div>

        <div>
          <FieldTitle htmlFor="recommend-url">资料链接（选填）</FieldTitle>
          <input
            id="recommend-url"
            type="url"
            value={draft.url}
            onChange={(e) => onFieldChange('url', e.target.value)}
            onBlur={() => onFieldBlur('url')}
            placeholder="https://..."
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-[var(--paper-accent)] focus:outline-none"
          />
          {errors.url ? (
            <p className="mt-2 text-sm text-rose-400">{errors.url}</p>
          ) : (
            <p className="mt-2 text-sm text-slate-500">用于后续进入资料详情、去重和 AI 评估参考。</p>
          )}
        </div>

        <div>
          <FieldTitle htmlFor="recommend-recommender">推荐人（选填）</FieldTitle>
          <input
            id="recommend-recommender"
            type="text"
            value={draft.recommenderName}
            onChange={(e) => onFieldChange('recommenderName', e.target.value)}
            onBlur={() => onFieldBlur('recommenderName')}
            placeholder="例如：你的姓名 / 昵称"
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm text-slate-50 placeholder:text-slate-500 focus:border-[var(--paper-accent)] focus:outline-none"
          />
          <p className="mt-2 text-sm text-slate-500">不填写时会以当前会话用户记录。</p>
        </div>

        <div>
          <FieldTitle>所属领域</FieldTitle>
          <div className="flex flex-wrap gap-1.5">
            {DOMAINS.map((domain) => {
              const isSelected = draft.domain === domain.id;
              const colorToken = getDomainColorToken(domain.id);

              return (
                <button
                  key={domain.id}
                  type="button"
                  onClick={() => {
                    onFieldChange('domain', domain.id);
                    onFieldBlur('domain');
                  }}
                  className={choiceButtonBaseClass}
                  style={{
                    backgroundColor: isSelected ? colorToken.base : colorToken.tagBg,
                    borderColor: isSelected ? colorToken.base : colorToken.tagBorder,
                    color: isSelected ? '#fffaf0' : colorToken.text,
                    boxShadow: isSelected ? `0 8px 18px ${colorToken.sectorHover}` : undefined,
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
          <FieldTitle>适合人群（多选）</FieldTitle>
          <div className="flex flex-wrap gap-1.5">
            {RECOMMENDATION_AUDIENCE_OPTIONS.map((option) => {
              const isSelected = draft.fitFor.includes(option.label);

              return (
                <button
                  key={option.label}
                  type="button"
                  onClick={() => toggleAudience(option.label)}
                  className={`${choiceButtonBaseClass} ${
                    isSelected
                      ? 'border-[var(--paper-accent)] bg-[var(--paper-accent)] text-white'
                      : 'border-slate-600 bg-slate-800 text-slate-300 hover:border-slate-500 hover:bg-slate-700'
                  }`}
                >
                  {option.label}
                </button>
              );
            })}
          </div>
        </div>

        <div>
          <FieldTitle>能力类型（多选）</FieldTitle>
          <div className="flex flex-wrap gap-1.5">
            {prerequisiteOptions.map((option) => {
              const isSelected = draft.prerequisites.includes(option.label);

              return (
                <button
                  key={option.label}
                  type="button"
                  onClick={() => toggleArrayValue('prerequisites', option.label)}
                  className={`${choiceButtonBaseClass} ${
                    isSelected
                      ? 'border-amber-400 bg-amber-500/15 text-amber-300'
                      : 'border-slate-600 bg-slate-800 text-slate-300 hover:border-slate-500 hover:bg-slate-700'
                  }`}
                >
                  {option.label}
                </button>
              );
            })}
          </div>
        </div>

        <div>
          <FieldTitle htmlFor="recommend-reason">推荐理由</FieldTitle>
          <textarea
            id="recommend-reason"
            value={draft.reason}
            onChange={(e) => onFieldChange('reason', e.target.value)}
            onBlur={() => onFieldBlur('reason')}
            placeholder="请阐述清楚推荐理由，例如这份资料为什么值得读、适合什么水平的人读等。"
            rows={5}
            className="w-full rounded-xl border border-slate-600 bg-slate-800 px-4 py-3 text-sm leading-6 text-slate-50 placeholder:text-slate-500 focus:border-[var(--paper-accent)] focus:outline-none"
          />
          <div className="mt-2 flex items-center justify-between">
            {errors.reason ? (
              <p className="text-sm text-rose-400">{errors.reason}</p>
            ) : (
              <p className="text-sm text-slate-500">推荐理由应帮助他人判断这份资料是否适合自己。</p>
            )}
            <span className="text-xs text-slate-500">{draft.reason.trim().length} 字</span>
          </div>
        </div>

        <div>
          <FieldTitle>推荐指数</FieldTitle>
          <div className="flex gap-1.5">
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
                  className={`flex-1 rounded-lg border px-3 py-2 text-sm font-medium transition-colors ${
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

      <div className="paper-card mt-6 rounded-xl border border-slate-700 bg-slate-800/70 p-4">
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
          className="rounded-xl bg-[var(--paper-accent)] px-4 py-3 text-sm font-medium text-white transition-colors hover:opacity-90 disabled:cursor-not-allowed disabled:bg-slate-700 disabled:text-slate-400"
        >
          {isSubmitting ? '提交中...' : submitLabel}
        </button>
      </div>
    </section>
  );
};

export default RecommendationForm;
