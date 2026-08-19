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
  ds.recently_updated_at,
  r.created_at,
  r.updated_at,
  coalesce(m.recommendation_count, 0) as recommendation_count,
  coalesce(m.rating_count, 0) as rating_count,
  m.last_recommended_at
from public.resources r
left join public.resource_metrics m on m.resource_id = r.id
left join public.radar_display_state ds on ds.resource_id = r.id
left join public.recommendations rec on rec.resource_id = r.id and rec.status in ('accepted', 'adopted')
where r.status = 'published'
  and coalesce(ds.radar_visible, true) = true
group by r.id, m.resource_id, ds.resource_id;
