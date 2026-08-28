alter table public.ratings
  add column if not exists recommender_name text not null default '当前会话用户';

alter table public.rating_events
  add column if not exists recommender_name text not null default '当前会话用户';

drop function if exists public.submit_book_score(text, text, numeric, text);

create or replace function public.submit_book_score(
  p_resource_id text,
  p_user_session_id text,
  p_score numeric,
  p_reason text,
  p_recommender_name text default '当前会话用户'
)
returns jsonb
language plpgsql
as $$
declare
  existing_rating public.ratings;
  changed_rating public.ratings;
  action_type text;
  previous_score numeric;
  previous_recommendation_score numeric;
  next_metrics public.resource_metrics;
  next_update_type text;
  submitted_at timestamptz := now();
  updated_book jsonb;
  normalized_recommender_name text := coalesce(nullif(trim(p_recommender_name), ''), '当前会话用户');
begin
  select * into existing_rating
  from public.ratings
  where resource_id = p_resource_id
    and user_session_id = p_user_session_id
  limit 1;

  previous_score := existing_rating.score;
  action_type := case when existing_rating.id is null then 'create' else 'update' end;

  select recommendation_score into previous_recommendation_score
  from public.resource_metrics
  where resource_id = p_resource_id;

  insert into public.ratings (
    resource_id,
    user_session_id,
    recommender_name,
    score,
    reason,
    created_at,
    updated_at
  )
  values (
    p_resource_id,
    p_user_session_id,
    normalized_recommender_name,
    p_score,
    p_reason,
    submitted_at,
    submitted_at
  )
  on conflict (resource_id, user_session_id) do update set
    recommender_name = excluded.recommender_name,
    score = excluded.score,
    reason = excluded.reason
  returning * into changed_rating;

  insert into public.rating_events (
    rating_id,
    resource_id,
    user_session_id,
    recommender_name,
    action_type,
    previous_score,
    next_score,
    reason,
    created_at
  )
  values (
    changed_rating.id,
    p_resource_id,
    p_user_session_id,
    normalized_recommender_name,
    action_type,
    previous_score,
    p_score,
    p_reason,
    submitted_at
  );

  select * into next_metrics from public.refresh_resource_metrics(p_resource_id);

  next_update_type := case
    when previous_recommendation_score is null then 'new_rating'
    when next_metrics.recommendation_score >= previous_recommendation_score then 'score_up'
    else 'score_down'
  end;

  perform public.refresh_radar_display_state(p_resource_id, next_update_type, previous_recommendation_score);

  select to_jsonb(rb.*) into updated_book
  from public.radar_books rb
  where rb.id = p_resource_id
  limit 1;

  return jsonb_build_object(
    'result',
    jsonb_build_object(
      'status', 'success',
      'actionType', action_type,
      'message', case
        when action_type = 'update' then '你的评分已更新，推荐指数已同步刷新。'
        else '你的评分已生效，推荐指数已同步刷新。'
      end,
      'submittedAt', submitted_at,
      'bookId', p_resource_id,
      'updatedRecommendationScore', next_metrics.recommendation_score,
      'updatedVotesCount', next_metrics.rating_count + next_metrics.recommendation_count
    ),
    'updatedBook', updated_book,
    'sessionScore',
    jsonb_build_object(
      'bookId', p_resource_id,
      'recommenderName', normalized_recommender_name,
      'score', p_score,
      'reason', p_reason,
      'submittedAt', submitted_at
    )
  );
end;
$$;
