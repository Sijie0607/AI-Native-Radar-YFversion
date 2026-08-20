-- 003_radar_versions.sql
-- 历史版本对比：周版本快照存储 + 版本生成 + 版本差异查询。
-- 只新增对象，不改动 001/002 中的表、视图、RPC。

-- ---------------------------------------------------------------------------
-- 1. 版本元数据
-- ---------------------------------------------------------------------------
create table if not exists public.radar_versions (
  id text primary key default gen_random_uuid()::text,
  version_number integer not null unique,
  week_start date,
  week_end date,
  generated_at timestamptz not null default now(),
  note text
);

-- ---------------------------------------------------------------------------
-- 2. 版本内书籍快照
-- resource_id 故意不加外键：允许插入演示用"幽灵书"（上版有、当前无 → 删除残影）。
-- ---------------------------------------------------------------------------
create table if not exists public.radar_version_books (
  id text primary key default gen_random_uuid()::text,
  version_id text not null references public.radar_versions(id) on delete cascade,
  resource_id text not null,
  title text not null,
  author text,
  domain text,
  difficulty_level smallint,
  sector_index integer,
  ring_index integer,
  x numeric(8, 5),
  y numeric(8, 5),
  recommendation_score numeric(3, 2),
  votes_count integer,
  point_radius numeric(5, 2),
  halo_radius numeric(5, 2),
  halo_opacity numeric(4, 3),
  stroke_width numeric(4, 2),
  fill_opacity numeric(4, 3),
  radar_visible boolean not null default true,
  unique (version_id, resource_id)
);

create index if not exists radar_version_books_version_id_idx
  on public.radar_version_books (version_id);

-- ---------------------------------------------------------------------------
-- 3. 生成一个新版本 = 当前雷达（radar_books 视图）全量快照。
-- 只写版本表，不改动实时雷达（不碰 radar_visible / display_state）。
-- ---------------------------------------------------------------------------
create or replace function public.generate_weekly_version()
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_next_number integer;
  v_version_id text;
  v_snapshot_count integer;
begin
  select coalesce(max(version_number), 0) + 1
  into v_next_number
  from public.radar_versions;

  insert into public.radar_versions (version_number, week_start, week_end, note)
  values (v_next_number, current_date - 6, current_date, 'weekly snapshot')
  returning id into v_version_id;

  insert into public.radar_version_books (
    version_id, resource_id, title, author, domain, difficulty_level,
    sector_index, ring_index, x, y, recommendation_score, votes_count,
    point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, radar_visible
  )
  select
    v_version_id, id, title, author, domain, difficulty_level,
    sector_index, ring_index, x, y, recommendation_score, votes_count,
    point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, true
  from public.radar_books;

  get diagnostics v_snapshot_count = row_count;

  return jsonb_build_object(
    'version_id', v_version_id,
    'version_number', v_next_number,
    'snapshot_books', v_snapshot_count
  );
end;
$$;

-- ---------------------------------------------------------------------------
-- 4. 查询最近两版：当前版元数据 + 上一版元数据 + 上一版书目快照。
-- 前端拿上一版快照与本地当前 books 自行算 diff（只读对比）。
-- 0 版 → current/previous 均 null、previous_books=[]；
-- 1 版 → previous=null、previous_books=[]。
-- ---------------------------------------------------------------------------
create or replace function public.get_version_diff()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  with ordered as (
    select v.id, v.version_number, v.week_start, v.week_end, v.generated_at
    from public.radar_versions v
    order by v.version_number desc
    limit 2
  ),
  cur as (select * from ordered limit 1 offset 0),
  prev as (select * from ordered limit 1 offset 1)
  select jsonb_build_object(
    'current_version', (
      select jsonb_build_object(
        'version_number', version_number,
        'generated_at', generated_at,
        'week_start', week_start,
        'week_end', week_end
      )
      from cur
    ),
    'previous_version', (
      select jsonb_build_object(
        'version_number', version_number,
        'generated_at', generated_at,
        'week_start', week_start,
        'week_end', week_end
      )
      from prev
    ),
    'previous_books', coalesce(
      (
        select jsonb_agg(jsonb_build_object(
          'resource_id', vb.resource_id,
          'title', vb.title,
          'author', vb.author,
          'domain', vb.domain,
          'difficulty_level', vb.difficulty_level,
          'sector_index', vb.sector_index,
          'ring_index', vb.ring_index,
          'x', vb.x,
          'y', vb.y,
          'recommendation_score', vb.recommendation_score,
          'votes_count', vb.votes_count,
          'point_radius', vb.point_radius,
          'halo_radius', vb.halo_radius,
          'halo_opacity', vb.halo_opacity,
          'stroke_width', vb.stroke_width,
          'fill_opacity', vb.fill_opacity
        ) order by vb.resource_id)
        from prev p
        join public.radar_version_books vb on vb.version_id = p.id
      ),
      '[]'::jsonb
    )
  );
$$;

-- ===========================================================================
-- 【演示数据·可删除】构造"上周 vs 本周"假差异，让首次 get_version_diff 就有 4 种状态。
-- 流程：v1=当前雷达快照 → 编辑 v1 行模拟"上一周" → v2=再快照（= 当前真实雷达）。
-- 之后 get_version_diff 返回 v2(当前) vs v1(被编辑的上一周)。
-- 依赖：上方函数 + seeds/001 已导入 25 本书（imported-1..25）。
-- 注意：必须先建 v1、改 v1、再建 v2——get_version_diff 比的是最近两版快照。
-- ===========================================================================
begin;

delete from public.radar_version_books;
delete from public.radar_versions;

select public.generate_weekly_version(); -- v1

-- 2 本书"上周"没有 → 本周 = 新增
delete from public.radar_version_books
where version_id = (select id from public.radar_versions order by version_number desc limit 1)
  and resource_id in ('imported-1', 'imported-2');

-- 3 本书上周分数更低(-0.5) → 本周 = 指数升
update public.radar_version_books
set recommendation_score = recommendation_score - 0.5
where version_id = (select id from public.radar_versions order by version_number desc limit 1)
  and resource_id in ('imported-3', 'imported-4', 'imported-5');

-- 2 本书上周分数更高(+0.5) → 本周 = 指数降
update public.radar_version_books
set recommendation_score = recommendation_score + 0.5
where version_id = (select id from public.radar_versions order by version_number desc limit 1)
  and resource_id in ('imported-6', 'imported-7');

-- 1 本"幽灵书"只存在于上周 → 本周 = 删除（残影）
insert into public.radar_version_books (
  version_id, resource_id, title, author, domain, difficulty_level,
  sector_index, ring_index, x, y, recommendation_score, votes_count, radar_visible
)
select
  (select id from public.radar_versions order by version_number desc limit 1),
  'ghost-demo-1', '《Ghost Demo Book: Vanished Weekly》', 'Ghost Author',
  'ai-frontier-trends', 2, 7, 1,
  cos(((7 + 0.5) * 2 * pi() / 8) - pi() / 2) * 0.5,
  sin(((7 + 0.5) * 2 * pi() / 8) - pi() / 2) * 0.5,
  4.3, 12, true;

select public.generate_weekly_version(); -- v2 = 干净快照（当前真实雷达）

commit;
