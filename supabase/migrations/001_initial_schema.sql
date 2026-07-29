create extension if not exists pgcrypto;

create or replace function public.normalize_resource_text(value text)
returns text
language sql
immutable
as $$
  select lower(
    regexp_replace(
      regexp_replace(coalesce(value, ''), '[[:space:]《》"''“”‘’（）()【】\[\]：:，,。\.]+', '', 'g'),
      '[[:space:]]+',
      '',
      'g'
    )
  );
$$;

create table if not exists public.resources (
  id text primary key default gen_random_uuid()::text,
  display_number integer,
  title text not null,
  normalized_title text not null,
  resource_type text not null default '书籍',
  url text,
  author text not null default '作者待补充',
  normalized_author text not null,
  domain text not null check (
    domain in (
      'ai-engineering',
      'ai-product-design',
      'agent-and-intelligent-systems',
      'ai-organizational-transformation',
      'data-intelligence-and-knowledge',
      'ai-business-implementation',
      'ai-ethics-and-governance',
      'ai-frontier-trends'
    )
  ),
  ability_themes text[] not null default '{}',
  difficulty_level smallint not null check (difficulty_level between 1 and 3),
  summary text,
  reason_short text,
  reason_full text,
  tags text[] not null default '{}',
  fit_for text[] not null default '{}',
  takeaways text[] not null default '{}',
  status text not null default 'pending' check (status in ('pending', 'published', 'rejected', 'archived')),
  source_note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (normalized_title, normalized_author)
);

create table if not exists public.recommendations (
  id text primary key default gen_random_uuid()::text,
  resource_id text references public.resources(id) on delete cascade,
  title text not null,
  author text not null default '作者待补充',
  domain text,
  recommender_name text not null default '当前会话用户',
  is_anonymous boolean not null default false,
  reason text not null,
  score numeric(2, 1) not null check (score in (3, 3.5, 4, 4.5, 5)),
  status text not null default 'pending' check (status in ('pending', 'accepted', 'duplicate', 'error', 'adopted')),
  message text,
  created_at timestamptz not null default now()
);

create table if not exists public.ratings (
  id text primary key default gen_random_uuid()::text,
  resource_id text not null references public.resources(id) on delete cascade,
  user_session_id text not null,
  score numeric(2, 1) not null check (score in (3, 3.5, 4, 4.5, 5)),
  reason text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (resource_id, user_session_id)
);

create table if not exists public.rating_events (
  id text primary key default gen_random_uuid()::text,
  rating_id text references public.ratings(id) on delete set null,
  resource_id text not null references public.resources(id) on delete cascade,
  user_session_id text not null,
  action_type text not null check (action_type in ('create', 'update')),
  previous_score numeric(2, 1),
  next_score numeric(2, 1) not null check (next_score in (3, 3.5, 4, 4.5, 5)),
  reason text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.resource_metrics (
  resource_id text primary key references public.resources(id) on delete cascade,
  average_rating numeric(3, 2) not null default 0,
  recommendation_score numeric(3, 2) not null default 0,
  rating_count integer not null default 0,
  recommendation_count integer not null default 0,
  unique_recommender_count integer not null default 0,
  weighted_score numeric(6, 3) not null default 0,
  confidence_score numeric(6, 3) not null default 0,
  hotness_score numeric(6, 3) not null default 0,
  quality_score numeric(6, 3) not null default 0,
  last_recommended_at timestamptz,
  last_rated_at timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.radar_display_state (
  resource_id text primary key references public.resources(id) on delete cascade,
  sector_index integer not null check (sector_index between 0 and 7),
  ring_index integer not null check (ring_index between 0 and 2),
  x numeric(8, 5) not null,
  y numeric(8, 5) not null,
  radar_visible boolean not null default false,
  radar_priority numeric(6, 3) not null default 0,
  visual_weight_score numeric(6, 3) not null default 0,
  point_radius numeric(5, 2) not null default 18,
  halo_radius numeric(5, 2) not null default 27,
  halo_opacity numeric(4, 3) not null default 0.2,
  stroke_width numeric(4, 2) not null default 2,
  fill_opacity numeric(4, 3) not null default 1,
  z_index_priority integer not null default 0,
  update_type text not null default 'none' check (
    update_type in ('none', 'new_resource', 'score_up', 'score_down', 'new_recommendation', 'new_rating')
  ),
  previous_recommendation_score numeric(3, 2),
  score_delta numeric(4, 2),
  first_appeared_at timestamptz,
  recently_updated_at timestamptz,
  updated_at timestamptz not null default now()
);

create table if not exists public.ai_evaluations (
  id text primary key default gen_random_uuid()::text,
  resource_id text not null references public.resources(id) on delete cascade,
  domain_suggestion text,
  difficulty_suggestion smallint check (difficulty_suggestion between 1 and 3),
  quality_score numeric(4, 2),
  confidence_score numeric(4, 3),
  domain_rationale text,
  difficulty_rationale text,
  quality_signals jsonb not null default '{}'::jsonb,
  evidence_summary text,
  human_review_status text not null default 'pending' check (
    human_review_status in ('pending', 'confirmed', 'needs_revision', 'rejected')
  ),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_resources_updated_at on public.resources;
create trigger set_resources_updated_at
before update on public.resources
for each row execute function public.set_updated_at();

drop trigger if exists set_ratings_updated_at on public.ratings;
create trigger set_ratings_updated_at
before update on public.ratings
for each row execute function public.set_updated_at();

drop trigger if exists set_resource_metrics_updated_at on public.resource_metrics;
create trigger set_resource_metrics_updated_at
before update on public.resource_metrics
for each row execute function public.set_updated_at();

drop trigger if exists set_radar_display_state_updated_at on public.radar_display_state;
create trigger set_radar_display_state_updated_at
before update on public.radar_display_state
for each row execute function public.set_updated_at();

drop trigger if exists set_ai_evaluations_updated_at on public.ai_evaluations;
create trigger set_ai_evaluations_updated_at
before update on public.ai_evaluations
for each row execute function public.set_updated_at();

create or replace function public.refresh_resource_metrics(target_resource_id text)
returns public.resource_metrics
language plpgsql
as $$
declare
  rating_avg numeric(3, 2);
  ratings_total integer;
  recommendation_avg numeric(3, 2);
  recommendations_total integer;
  unique_recommenders_total integer;
  next_score numeric(3, 2);
  next_confidence numeric(6, 3);
  next_hotness numeric(6, 3);
  next_weighted numeric(6, 3);
  next_last_recommended_at timestamptz;
  next_last_rated_at timestamptz;
  refreshed public.resource_metrics;
begin
  select
    coalesce(round(avg(score)::numeric, 2), 0),
    count(*)::integer,
    max(updated_at)
  into rating_avg, ratings_total, next_last_rated_at
  from public.ratings
  where resource_id = target_resource_id;

  select
    coalesce(round(avg(score)::numeric, 2), 0),
    count(*)::integer,
    count(distinct recommender_name)::integer,
    max(created_at)
  into recommendation_avg, recommendations_total, unique_recommenders_total, next_last_recommended_at
  from public.recommendations
  where resource_id = target_resource_id
    and status in ('accepted', 'adopted');

  next_score := case
    when ratings_total > 0 then rating_avg
    when recommendations_total > 0 then recommendation_avg
    else 0
  end;

  next_confidence := least(1, ((ratings_total + recommendations_total)::numeric / 5));
  next_hotness := round((ratings_total * 0.65 + recommendations_total * 0.35)::numeric, 3);
  next_weighted := round((next_score * (0.7 + 0.3 * next_confidence) + least(next_hotness, 10) * 0.05)::numeric, 3);

  insert into public.resource_metrics (
    resource_id,
    average_rating,
    recommendation_score,
    rating_count,
    recommendation_count,
    unique_recommender_count,
    weighted_score,
    confidence_score,
    hotness_score,
    last_recommended_at,
    last_rated_at
  )
  values (
    target_resource_id,
    rating_avg,
    next_score,
    ratings_total,
    recommendations_total,
    unique_recommenders_total,
    next_weighted,
    next_confidence,
    next_hotness,
    next_last_recommended_at,
    next_last_rated_at
  )
  on conflict (resource_id) do update set
    average_rating = excluded.average_rating,
    recommendation_score = excluded.recommendation_score,
    rating_count = excluded.rating_count,
    recommendation_count = excluded.recommendation_count,
    unique_recommender_count = excluded.unique_recommender_count,
    weighted_score = excluded.weighted_score,
    confidence_score = excluded.confidence_score,
    hotness_score = excluded.hotness_score,
    last_recommended_at = excluded.last_recommended_at,
    last_rated_at = excluded.last_rated_at
  returning * into refreshed;

  return refreshed;
end;
$$;

create or replace function public.refresh_radar_display_state(
  target_resource_id text,
  next_update_type text default 'none',
  previous_score numeric default null
)
returns public.radar_display_state
language plpgsql
as $$
declare
  resource_record public.resources;
  metric_record public.resource_metrics;
  display_record public.radar_display_state;
  normalized_score numeric;
begin
  select * into resource_record from public.resources where id = target_resource_id;
  if resource_record.id is null then
    raise exception 'Resource % not found', target_resource_id;
  end if;

  select * into metric_record from public.refresh_resource_metrics(target_resource_id);

  normalized_score := greatest(0, least(1, (coalesce(metric_record.recommendation_score, 3) - 3) / 2));

  insert into public.radar_display_state (
    resource_id,
    sector_index,
    ring_index,
    x,
    y,
    radar_visible,
    radar_priority,
    visual_weight_score,
    point_radius,
    halo_radius,
    halo_opacity,
    stroke_width,
    fill_opacity,
    z_index_priority,
    update_type,
    previous_recommendation_score,
    score_delta,
    first_appeared_at,
    recently_updated_at
  )
  values (
    target_resource_id,
    0,
    resource_record.difficulty_level - 1,
    0,
    0,
    resource_record.status = 'published',
    metric_record.weighted_score,
    metric_record.recommendation_score,
    round((16 + normalized_score * 10)::numeric, 2),
    round((26 + normalized_score * 12)::numeric, 2),
    round((0.16 + normalized_score * 0.24)::numeric, 3),
    round((1.5 + normalized_score * 1.5)::numeric, 2),
    round((0.72 + normalized_score * 0.28)::numeric, 3),
    round(metric_record.weighted_score * 100)::integer,
    next_update_type,
    previous_score,
    case when resource_record.status = 'published' then now() else null end,
    case when next_update_type <> 'none' then now() else null end
  )
  on conflict (resource_id) do update set
    radar_visible = excluded.radar_visible,
    radar_priority = excluded.radar_priority,
    visual_weight_score = excluded.visual_weight_score,
    point_radius = excluded.point_radius,
    halo_radius = excluded.halo_radius,
    halo_opacity = excluded.halo_opacity,
    stroke_width = excluded.stroke_width,
    fill_opacity = excluded.fill_opacity,
    z_index_priority = excluded.z_index_priority,
    update_type = excluded.update_type,
    previous_recommendation_score = excluded.previous_recommendation_score,
    score_delta = excluded.visual_weight_score - coalesce(previous_score, excluded.visual_weight_score),
    first_appeared_at = coalesce(public.radar_display_state.first_appeared_at, excluded.first_appeared_at),
    recently_updated_at = excluded.recently_updated_at
  returning * into display_record;

  return display_record;
end;
$$;

create or replace view public.radar_books as
select
  r.id,
  r.display_number,
  r.title,
  r.summary as subtitle,
  r.author,
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
  r.source_note,
  r.ability_themes as competence_themes,
  coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', rec.id,
        'recommender', rec.recommender_name,
        'isAnonymous', rec.is_anonymous,
        'reason', rec.reason,
        'score', rec.score::float,
        'recommendedAt', rec.created_at
      )
      order by rec.created_at desc
    ) filter (where rec.id is not null),
    '[]'::jsonb
  ) as recommendations,
  coalesce(ds.visual_weight_score, m.recommendation_score, 0)::float as visual_weight_score,
  coalesce(ds.point_radius, 18)::float as point_radius,
  coalesce(ds.halo_radius, 27)::float as halo_radius,
  coalesce(ds.halo_opacity, 0.2)::float as halo_opacity,
  coalesce(ds.stroke_width, 2)::float as stroke_width,
  coalesce(ds.fill_opacity, 1)::float as fill_opacity,
  coalesce(ds.update_type, 'none') as update_type,
  ds.score_delta::float,
  ds.recently_updated_at
from public.resources r
left join public.resource_metrics m on m.resource_id = r.id
left join public.radar_display_state ds on ds.resource_id = r.id
left join public.recommendations rec on rec.resource_id = r.id and rec.status in ('accepted', 'adopted')
where r.status = 'published'
  and coalesce(ds.radar_visible, true) = true
group by r.id, m.resource_id, ds.resource_id;

create or replace function public.submit_recommendation(
  p_title text,
  p_author text,
  p_domain text,
  p_reason text,
  p_score numeric,
  p_resource_type text default '书籍',
  p_url text default null,
  p_recommender_name text default '当前会话用户',
  p_is_anonymous boolean default false,
  p_allow_duplicate_submit boolean default false
)
returns jsonb
language plpgsql
as $$
declare
  normalized_next_title text;
  normalized_next_author text;
  existing_resource public.resources;
  created_resource public.resources;
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
      resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
    )
    values (
      existing_resource.id, p_title, p_author, p_domain, p_recommender_name, p_is_anonymous, p_reason, p_score,
      'duplicate', '该书已存在，你可以补充推荐理由后再次提交。', submitted_at
    );

    return jsonb_build_object(
      'status', 'duplicate',
      'message', '该书已存在，你可以补充推荐理由后再次提交。',
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
      resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
    )
    values (
      existing_resource.id, existing_resource.title, existing_resource.author, existing_resource.domain,
      p_recommender_name, p_is_anonymous, p_reason, p_score,
      'accepted', '已接收你的补充推荐理由，但不会自动进入正式雷达。', submitted_at
    );

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
      status,
      source_note
    )
    values (
      p_title,
      normalized_next_title,
      coalesce(nullif(p_resource_type, ''), '书籍'),
      p_url,
      coalesce(nullif(p_author, ''), '作者待补充'),
      normalized_next_author,
      p_domain,
      '{}',
      2,
      left(p_reason, 60),
      p_reason,
      'pending',
      p_url
    )
    returning * into created_resource;

    insert into public.recommendations (
      resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
    )
    values (
      created_resource.id, p_title, p_author, p_domain, p_recommender_name, p_is_anonymous, p_reason, p_score,
      'pending', '已接收你的书籍推荐，但不会自动进入正式雷达。', submitted_at
    );

    perform public.refresh_resource_metrics(created_resource.id);
    result_status := 'success';
    result_message := '已接收你的书籍推荐，但不会自动进入正式雷达。';
  end if;

  return jsonb_build_object(
    'status', result_status,
    'message', result_message,
    'submittedAt', submitted_at
  );
end;
$$;

create or replace function public.submit_book_score(
  p_resource_id text,
  p_user_session_id text,
  p_score numeric,
  p_reason text
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

  insert into public.ratings (resource_id, user_session_id, score, reason, created_at, updated_at)
  values (p_resource_id, p_user_session_id, p_score, p_reason, submitted_at, submitted_at)
  on conflict (resource_id, user_session_id) do update set
    score = excluded.score,
    reason = excluded.reason
  returning * into changed_rating;

  insert into public.rating_events (
    rating_id,
    resource_id,
    user_session_id,
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
      'score', p_score,
      'reason', p_reason,
      'submittedAt', submitted_at
    )
  );
end;
$$;
