alter table public.recommendations
  add column if not exists resource_type text not null default '书籍';

alter table public.recommendations
  add column if not exists url text;

alter table public.recommendations
  add column if not exists fit_for_suggestions text[] not null default '{}'::text[];

alter table public.recommendations
  add column if not exists prerequisite_suggestions text[] not null default '{}'::text[];

alter table public.recommendations
  add column if not exists ability_theme_suggestions text[] not null default '{}'::text[];

drop function if exists public.submit_recommendation(text, text, text, text, numeric, text, text, text, boolean, boolean);

create or replace function public.submit_recommendation(
  p_title text,
  p_author text,
  p_domain text,
  p_reason text,
  p_score numeric,
  p_resource_type text default '书籍',
  p_url text default null,
  p_recommender_name text default '当前会话用户',
  p_fit_for_suggestions text[] default '{}'::text[],
  p_prerequisite_suggestions text[] default '{}'::text[],
  p_ability_theme_suggestions text[] default '{}'::text[],
  p_is_anonymous boolean default false,
  p_allow_duplicate_submit boolean default false
)
returns jsonb
language plpgsql
as $$
declare
  normalized_next_title text;
  normalized_next_author text;
  normalized_resource_type text := coalesce(nullif(trim(p_resource_type), ''), '书籍');
  normalized_url text := nullif(trim(coalesce(p_url, '')), '');
  normalized_recommender_name text := coalesce(nullif(trim(p_recommender_name), ''), '当前会话用户');
  next_fit_for text[] := coalesce(p_fit_for_suggestions, '{}'::text[]);
  next_prerequisites text[] := coalesce(p_prerequisite_suggestions, '{}'::text[]);
  next_ability_themes text[] := coalesce(p_ability_theme_suggestions, '{}'::text[]);
  existing_resource public.resources;
  created_resource public.resources;
  created_recommendation public.recommendations;
  submitted_at timestamptz := now();
  result_status text;
  result_message text;
begin
  normalized_next_title := public.normalize_resource_text(p_title);
  normalized_next_author := public.normalize_resource_text(p_author);

  select * into existing_resource
  from public.resources
  where normalized_title = normalized_next_title
    and normalized_author = normalized_next_author
  limit 1;

  if existing_resource.id is not null and not p_allow_duplicate_submit then
    insert into public.recommendations (
      resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
      fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
      reason, score, status, message, created_at
    )
    values (
      existing_resource.id, p_title, p_author, p_domain, normalized_resource_type, normalized_url,
      normalized_recommender_name, p_is_anonymous, next_fit_for, next_prerequisites, next_ability_themes,
      p_reason, p_score, 'duplicate', '该资料已存在，你可以补充推荐理由后再次提交。', submitted_at
    )
    returning * into created_recommendation;

    insert into public.ai_evaluations (
      resource_id, domain_suggestion, difficulty_rationale, quality_signals,
      evidence_summary, human_review_status, created_at
    )
    values (
      existing_resource.id,
      p_domain,
      '待结合适合人群、前置基础、能力主题和推荐理由判断难度。',
      jsonb_build_object(
        'source', 'recommendation_submission',
        'recommendationId', created_recommendation.id,
        'title', p_title,
        'author', p_author,
        'submittedDomain', p_domain,
        'resourceType', normalized_resource_type,
        'url', normalized_url,
        'fitForSuggestions', to_jsonb(next_fit_for),
        'prerequisiteSuggestions', to_jsonb(next_prerequisites),
        'abilityThemeSuggestions', to_jsonb(next_ability_themes),
        'recommendationReason', p_reason
      ),
      concat(
        '资料类型：', normalized_resource_type,
        E'\n适合人群：', coalesce(array_to_string(next_fit_for, '、'), '未填写'),
        E'\n前置能力：', coalesce(array_to_string(next_prerequisites, '、'), '未填写'),
        E'\n能力主题建议：', coalesce(array_to_string(next_ability_themes, '、'), '未填写'),
        E'\n推荐理由：', left(p_reason, 200)
      ),
      'pending',
      submitted_at
    );

    return jsonb_build_object(
      'status', 'duplicate',
      'message', '该资料已存在，你可以补充推荐理由后再次提交。',
      'submittedAt', submitted_at,
      'existingBook', jsonb_build_object(
        'id', existing_resource.id,
        'title', existing_resource.title,
        'author', existing_resource.author,
        'domain', existing_resource.domain,
        'recommendationScore', coalesce((select recommendation_score from public.resource_metrics where resource_id = existing_resource.id), 0)
      )
    );
  end if;

  if existing_resource.id is not null then
    insert into public.recommendations (
      resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
      fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
      reason, score, status, message, created_at
    )
    values (
      existing_resource.id, existing_resource.title, existing_resource.author, existing_resource.domain,
      normalized_resource_type, normalized_url, normalized_recommender_name, p_is_anonymous,
      next_fit_for, next_prerequisites, next_ability_themes,
      p_reason, p_score, 'accepted', '已接收你的补充推荐理由，但不会自动进入正式雷达。', submitted_at
    )
    returning * into created_recommendation;

    insert into public.ai_evaluations (
      resource_id, domain_suggestion, difficulty_rationale, quality_signals,
      evidence_summary, human_review_status, created_at
    )
    values (
      existing_resource.id,
      existing_resource.domain,
      '待结合适合人群、前置基础、能力主题和推荐理由判断难度。',
      jsonb_build_object(
        'source', 'recommendation_submission',
        'recommendationId', created_recommendation.id,
        'title', existing_resource.title,
        'author', existing_resource.author,
        'submittedDomain', p_domain,
        'resourceType', normalized_resource_type,
        'url', normalized_url,
        'fitForSuggestions', to_jsonb(next_fit_for),
        'prerequisiteSuggestions', to_jsonb(next_prerequisites),
        'abilityThemeSuggestions', to_jsonb(next_ability_themes),
        'recommendationReason', p_reason
      ),
      concat(
        '资料类型：', normalized_resource_type,
        E'\n适合人群：', coalesce(array_to_string(next_fit_for, '、'), '未填写'),
        E'\n前置能力：', coalesce(array_to_string(next_prerequisites, '、'), '未填写'),
        E'\n能力主题建议：', coalesce(array_to_string(next_ability_themes, '、'), '未填写'),
        E'\n推荐理由：', left(p_reason, 200)
      ),
      'pending',
      submitted_at
    );

    perform public.refresh_resource_metrics(existing_resource.id);
    perform public.refresh_radar_display_state(existing_resource.id, 'new_recommendation');
    result_status := 'success';
    result_message := '已接收你的补充推荐理由，但不会自动进入正式雷达。';
  else
    insert into public.resources (
      title,
      normalized_title,
      resource_type,
      url,
      author,
      normalized_author,
      domain,
      ability_themes,
      difficulty_level,
      reason_short,
      reason_full,
      tags,
      fit_for,
      status,
      source_note
    )
    values (
      p_title,
      normalized_next_title,
      normalized_resource_type,
      normalized_url,
      coalesce(nullif(p_author, ''), '作者待补充'),
      normalized_next_author,
      p_domain,
      next_ability_themes,
      2,
      left(p_reason, 60),
      p_reason,
      next_prerequisites,
      next_fit_for,
      'pending',
      normalized_url
    )
    returning * into created_resource;

    insert into public.recommendations (
      resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
      fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
      reason, score, status, message, created_at
    )
    values (
      created_resource.id, p_title, p_author, p_domain, normalized_resource_type, normalized_url,
      normalized_recommender_name, p_is_anonymous, next_fit_for, next_prerequisites, next_ability_themes,
      p_reason, p_score, 'pending', '已接收你的资料推荐，但不会自动进入正式雷达。', submitted_at
    )
    returning * into created_recommendation;

    insert into public.ai_evaluations (
      resource_id, domain_suggestion, difficulty_rationale, quality_signals,
      evidence_summary, human_review_status, created_at
    )
    values (
      created_resource.id,
      p_domain,
      '新资料默认 difficulty_level = 2；待结合适合人群、前置基础、能力主题和推荐理由确认难度。',
      jsonb_build_object(
        'source', 'recommendation_submission',
        'recommendationId', created_recommendation.id,
        'title', p_title,
        'author', p_author,
        'submittedDomain', p_domain,
        'resourceType', normalized_resource_type,
        'url', normalized_url,
        'fitForSuggestions', to_jsonb(next_fit_for),
        'prerequisiteSuggestions', to_jsonb(next_prerequisites),
        'abilityThemeSuggestions', to_jsonb(next_ability_themes),
        'recommendationReason', p_reason
      ),
      concat(
        '资料类型：', normalized_resource_type,
        E'\n适合人群：', coalesce(array_to_string(next_fit_for, '、'), '未填写'),
        E'\n前置能力：', coalesce(array_to_string(next_prerequisites, '、'), '未填写'),
        E'\n能力主题建议：', coalesce(array_to_string(next_ability_themes, '、'), '未填写'),
        E'\n推荐理由：', left(p_reason, 200)
      ),
      'pending',
      submitted_at
    );

    perform public.refresh_resource_metrics(created_resource.id);
    result_status := 'success';
    result_message := '已接收你的资料推荐，但不会自动进入正式雷达。';
  end if;

  return jsonb_build_object(
    'status', result_status,
    'message', result_message,
    'submittedAt', submitted_at
  );
end;
$$;

create or replace view public.radar_books as
select
  r.id,
  r.display_number,
  r.title,
  r.summary as subtitle,
  r.author,
  r.url,
  null::text as cover,
  r.domain,
  r.difficulty_level,
  coalesce(ds.sector_index, 0) as sector_index,
  coalesce(ds.ring_index, r.difficulty_level - 1) as ring_index,
  coalesce(ds.x, 0)::float as x,
  coalesce(ds.y, 0)::float as y,
  coalesce(m.recommendation_score, 0)::float as recommendation_score,
  coalesce(r.reason_short, r.reason_full, '') as reason_short,
  coalesce(r.reason_full, r.reason_short, '') as reason_full,
  r.fit_for,
  r.takeaways,
  r.resource_type as content_type,
  r.tags,
  coalesce(m.rating_count + m.recommendation_count, 0) as votes_count,
  m.recommendation_count,
  m.rating_count,
  r.source_note,
  r.created_at,
  r.updated_at,
  m.last_recommended_at,
  r.ability_themes as competence_themes,
  coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', rec.id,
        'recommender', rec.recommender_name,
        'isAnonymous', rec.is_anonymous,
        'reason', rec.reason,
        'score', rec.score,
        'recommendedAt', rec.created_at,
        'resourceType', rec.resource_type,
        'url', rec.url,
        'fitForSuggestions', rec.fit_for_suggestions,
        'prerequisiteSuggestions', rec.prerequisite_suggestions,
        'abilityThemeSuggestions', rec.ability_theme_suggestions
      )
      order by rec.created_at desc
    ) filter (where rec.id is not null),
    '[]'::jsonb
  ) as recommendations,
  ds.visual_weight_score::float,
  ds.point_radius::float,
  ds.halo_radius::float,
  ds.halo_opacity::float,
  ds.stroke_width::float,
  ds.fill_opacity::float,
  ds.update_type,
  ds.previous_recommendation_score::float,
  ds.score_delta::float,
  ds.recently_updated_at
from public.resources r
left join public.resource_metrics m on m.resource_id = r.id
left join public.radar_display_state ds on ds.resource_id = r.id
left join public.recommendations rec on rec.resource_id = r.id and rec.status in ('accepted', 'adopted')
where r.status = 'published'
  and coalesce(ds.radar_visible, true) = true
group by r.id, m.resource_id, ds.resource_id;
