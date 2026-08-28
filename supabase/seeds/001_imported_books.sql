-- Generated from src/data/副本AI-Native读书雷达·资料共建.xlsx by scripts/export-supabase-seed.mjs
-- Run after supabase/migrations/001_initial_schema.sql through 005_recommendation_resource_curation_fields.sql.
-- Excel rows: 88; unique resources: 72.
begin;

delete from public.recommendations where id like 'import-rec-%' and message = '来自初始化资料共建表';

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8c30b0064dca', 1, '《AI Engineering: Building Applications with Foundation Models》', 'aiengineeringbuildingapplicationswithfoundationmodels',
  '书籍', null, 'Chip Huyen', 'chiphuyen',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架', '【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)', '【技术-应用】LLM应用技术选型与架构设计', '【技术-平台】LLMOps平台设计与模型全生命周期管理', '【技术-平台】模型推理优化与加速（量化/推理服务）', '【FDE】AI应用生产部署与交付实施']::text[], 1, '书籍 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 通识', 'AI 辅助开发', 'LLM 应用架构', 'LLMOps', '模型推理优化', '生产部署 / 交付实施']::text[],
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师', '平台工程师 / 架构师', 'FDE / 解决方案 / 交付']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-71a82619b2442814', (select id from public.resources where normalized_title = 'aiengineeringbuildingapplicationswithfoundationmodels' and normalized_author = 'chiphuyen' limit 1), '《AI Engineering: Building Applications with Foundation Models》',
  'Chip Huyen', 'ai-frontier-trends', '书籍', null,
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师', '平台工程师 / 架构师', 'FDE / 解决方案 / 交付']::text[], array['AI 通识', 'AI 辅助开发', 'LLM 应用架构', 'LLMOps', '模型推理优化', '生产部署 / 交付实施']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架', '【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)', '【技术-应用】LLM应用技术选型与架构设计', '【技术-平台】LLMOps平台设计与模型全生命周期管理', '【技术-平台】模型推理优化与加速（量化/推理服务）', '【FDE】AI应用生产部署与交付实施']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'aiengineeringbuildingapplicationswithfoundationmodels' and normalized_author = 'chiphuyen' limit 1), 7, 0, -0.11481, -0.27716, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'aiengineeringbuildingapplicationswithfoundationmodels' and normalized_author = 'chiphuyen' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-84cd3ffa365e', 2, 'Anthropic《AI Fluency: Framework & Foundations》(Coursera，免费)', 'anthropicaifluencyframework&foundationscoursera免费',
  '在线课程/官方文档', 'https://www.coursera.org/learn/ai-fluency-framework-foundations', 'Anthropic', 'anthropic',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '在线课程/官方文档 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://www.coursera.org/learn/ai-fluency-framework-foundations'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-d157174ff3734c29', (select id from public.resources where normalized_title = 'anthropicaifluencyframework&foundationscoursera免费' and normalized_author = 'anthropic' limit 1), 'Anthropic《AI Fluency: Framework & Foundations》(Coursera，免费)',
  'Anthropic', 'ai-frontier-trends', '在线课程/官方文档', 'https://www.coursera.org/learn/ai-fluency-framework-foundations',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicaifluencyframework&foundationscoursera免费' and normalized_author = 'anthropic' limit 1), 7, 0, -0.12999, -0.23093, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicaifluencyframework&foundationscoursera免费' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-f9e67ad3c63e', 3, 'Skilljar版', 'skilljar版',
  '在线课程/官方文档', 'https://anthropic.skilljar.com/ai-fluency-framework-foundations', 'Anthropic', 'anthropic',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '在线课程/官方文档 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://anthropic.skilljar.com/ai-fluency-framework-foundations'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f63dc0dc9bdc03e1', (select id from public.resources where normalized_title = 'skilljar版' and normalized_author = 'anthropic' limit 1), 'Skilljar版',
  'Anthropic', 'ai-frontier-trends', '在线课程/官方文档', 'https://anthropic.skilljar.com/ai-fluency-framework-foundations',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'skilljar版' and normalized_author = 'anthropic' limit 1), 7, 0, -0.09023, -0.32262, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'skilljar版' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-968673721963', 4, 'Coursera Blog《Anthropic launches five free courses on Coursera》', 'courserabloganthropiclaunchesfivefreecoursesoncoursera',
  '文章/其他资料', 'https://blog.coursera.org/anthropic-launches-five-free-courses-on-coursera-to-help-build-ai-fluency/', 'Anthropic', 'anthropic',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '文章/其他资料 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://blog.coursera.org/anthropic-launches-five-free-courses-on-coursera-to-help-build-ai-fluency/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-de7974529fae374d', (select id from public.resources where normalized_title = 'courserabloganthropiclaunchesfivefreecoursesoncoursera' and normalized_author = 'anthropic' limit 1), 'Coursera Blog《Anthropic launches five free courses on Coursera》',
  'Anthropic', 'ai-frontier-trends', '文章/其他资料', 'https://blog.coursera.org/anthropic-launches-five-free-courses-on-coursera-to-help-build-ai-fluency/',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'courserabloganthropiclaunchesfivefreecoursesoncoursera' and normalized_author = 'anthropic' limit 1), 7, 0, -0.14089, -0.20043, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'courserabloganthropiclaunchesfivefreecoursesoncoursera' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8868a0b9e99b', 5, '《Designing Large Language Model Applications》', 'designinglargelanguagemodelapplications',
  '书籍', null, 'Suhas Pai', 'suhaspai',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶', '【技术-应用】LLM应用技术选型与架构设计']::text[], 1, '书籍 · 【全员通用】Prompt工程基础与进阶',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Prompt 工程', 'LLM 应用架构']::text[],
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-cdb9fc12515a9a83', (select id from public.resources where normalized_title = 'designinglargelanguagemodelapplications' and normalized_author = 'suhaspai' limit 1), '《Designing Large Language Model Applications》',
  'Suhas Pai', 'ai-engineering', '书籍', null,
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师']::text[], array['Prompt 工程', 'LLM 应用架构']::text[], array['【全员通用】Prompt工程基础与进阶', '【技术-应用】LLM应用技术选型与架构设计']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'designinglargelanguagemodelapplications' and normalized_author = 'suhaspai' limit 1), 0, 0, 0.11481, -0.27716, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'designinglargelanguagemodelapplications' and normalized_author = 'suhaspai' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-7dfefeee54ee', 6, 'Anthropic官方互动教程《Prompt Engineering Interactive Tutorial》(GitHub，免费)', 'anthropic官方互动教程promptengineeringinteractivetutorialgithub免费',
  '在线课程/官方文档', 'https://github.com/anthropics/prompt-eng-interactive-tutorial', 'Anthropic', 'anthropic',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶']::text[], 1, '在线课程/官方文档 · 【全员通用】Prompt工程基础与进阶',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Prompt 工程']::text[],
  array['全员 / AI 初学者']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://github.com/anthropics/prompt-eng-interactive-tutorial'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-bab516b8aed0bb00', (select id from public.resources where normalized_title = 'anthropic官方互动教程promptengineeringinteractivetutorialgithub免费' and normalized_author = 'anthropic' limit 1), 'Anthropic官方互动教程《Prompt Engineering Interactive Tutorial》(GitHub，免费)',
  'Anthropic', 'ai-engineering', '在线课程/官方文档', 'https://github.com/anthropics/prompt-eng-interactive-tutorial',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['Prompt 工程']::text[], array['【全员通用】Prompt工程基础与进阶']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropic官方互动教程promptengineeringinteractivetutorialgithub免费' and normalized_author = 'anthropic' limit 1), 0, 0, 0.07137, -0.25521, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropic官方互动教程promptengineeringinteractivetutorialgithub免费' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-00253e7e9116', 7, 'DeepLearning.AI《ChatGPT Prompt Engineering for Developers》', 'deeplearningaichatgptpromptengineeringfordevelopers',
  '在线课程/官方文档', 'https://www.deeplearning.ai/courses/', 'DeepLearning.AI', 'deeplearningai',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶']::text[], 1, '在线课程/官方文档 · 【全员通用】Prompt工程基础与进阶',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Prompt 工程']::text[],
  array['全员 / AI 初学者']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.deeplearning.ai/courses/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-c6b54e26ba1b5f36', (select id from public.resources where normalized_title = 'deeplearningaichatgptpromptengineeringfordevelopers' and normalized_author = 'deeplearningai' limit 1), 'DeepLearning.AI《ChatGPT Prompt Engineering for Developers》',
  'DeepLearning.AI', 'ai-engineering', '在线课程/官方文档', 'https://www.deeplearning.ai/courses/',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['Prompt 工程']::text[], array['【全员通用】Prompt工程基础与进阶']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'deeplearningaichatgptpromptengineeringfordevelopers' and normalized_author = 'deeplearningai' limit 1), 0, 0, 0.16433, -0.29193, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'deeplearningaichatgptpromptengineeringfordevelopers' and normalized_author = 'deeplearningai' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-95afb787b475', 8, 'Anthropic Prompt Engineering官方文档', 'anthropicpromptengineering官方文档',
  '文章/其他资料', 'https://docs.claude.com', 'Anthropic', 'anthropic',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶']::text[], 1, '文章/其他资料 · 【全员通用】Prompt工程基础与进阶',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Prompt 工程']::text[],
  array['全员 / AI 初学者']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://docs.claude.com'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-a5d576b1f5b24971', (select id from public.resources where normalized_title = 'anthropicpromptengineering官方文档' and normalized_author = 'anthropic' limit 1), 'Anthropic Prompt Engineering官方文档',
  'Anthropic', 'ai-engineering', '文章/其他资料', 'https://docs.claude.com',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['Prompt 工程']::text[], array['【全员通用】Prompt工程基础与进阶']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicpromptengineering官方文档' and normalized_author = 'anthropic' limit 1), 0, 0, 0.04210, -0.24136, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicpromptengineering官方文档' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-3c47da2408f5', 9, '《Building a Second Brain》', 'buildingasecondbrain',
  '书籍', null, 'Tiago Forte', 'tiagoforte',
  'data-intelligence-and-knowledge', array['【全员通用】知识工程与Context管理']::text[], 1, '书籍 · 【全员通用】知识工程与Context管理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识工程 / Context 管理']::text[],
  array['全员 / AI 初学者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-60b6cb7198d46889', (select id from public.resources where normalized_title = 'buildingasecondbrain' and normalized_author = 'tiagoforte' limit 1), '《Building a Second Brain》',
  'Tiago Forte', 'data-intelligence-and-knowledge', '书籍', null,
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['知识工程 / Context 管理']::text[], array['【全员通用】知识工程与Context管理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'buildingasecondbrain' and normalized_author = 'tiagoforte' limit 1), 4, 0, -0.11481, 0.27716, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'buildingasecondbrain' and normalized_author = 'tiagoforte' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-e78641b30275', 10, 'Notion官方文档', 'notion官方文档',
  '在线课程/官方文档', 'https://www.notion.com/help', 'Notion', 'notion',
  'data-intelligence-and-knowledge', array['【全员通用】知识工程与Context管理']::text[], 1, '在线课程/官方文档 · 【全员通用】知识工程与Context管理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识工程 / Context 管理']::text[],
  array['全员 / AI 初学者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://www.notion.com/help'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-b53330710cb14ce0', (select id from public.resources where normalized_title = 'notion官方文档' and normalized_author = 'notion' limit 1), 'Notion官方文档',
  'Notion', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://www.notion.com/help',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['知识工程 / Context 管理']::text[], array['【全员通用】知识工程与Context管理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'notion官方文档' and normalized_author = 'notion' limit 1), 4, 0, -0.07137, 0.25521, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'notion官方文档' and normalized_author = 'notion' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-247fbf9f8c0c', 11, 'Obsidian官方文档', 'obsidian官方文档',
  '在线课程/官方文档', 'https://help.obsidian.md', 'Obsidian', 'obsidian',
  'data-intelligence-and-knowledge', array['【全员通用】知识工程与Context管理']::text[], 1, '在线课程/官方文档 · 【全员通用】知识工程与Context管理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识工程 / Context 管理']::text[],
  array['全员 / AI 初学者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://help.obsidian.md'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f795acbe8d654647', (select id from public.resources where normalized_title = 'obsidian官方文档' and normalized_author = 'obsidian' limit 1), 'Obsidian官方文档',
  'Obsidian', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://help.obsidian.md',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['知识工程 / Context 管理']::text[], array['【全员通用】知识工程与Context管理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'obsidian官方文档' and normalized_author = 'obsidian' limit 1), 4, 0, -0.16433, 0.29193, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'obsidian官方文档' and normalized_author = 'obsidian' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-07103459cf91', 12, 'GitHub Copilot官方文档', 'githubcopilot官方文档',
  '在线课程/官方文档', 'https://docs.github.com/copilot', 'GitHub', 'github',
  'ai-engineering', array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[], 2, '在线课程/官方文档 · 【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 辅助开发']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://docs.github.com/copilot'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-5cb7ef21c22a82e1', (select id from public.resources where normalized_title = 'githubcopilot官方文档' and normalized_author = 'github' limit 1), 'GitHub Copilot官方文档',
  'GitHub', 'ai-engineering', '在线课程/官方文档', 'https://docs.github.com/copilot',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 辅助开发']::text[], array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'githubcopilot官方文档' and normalized_author = 'github' limit 1), 0, 1, 0.22961, -0.55433, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'githubcopilot官方文档' and normalized_author = 'github' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ec5f4045cba3', 13, 'Anthropic Claude Code官方文档', 'anthropicclaudecode官方文档',
  '在线课程/官方文档', 'https://docs.claude.com/en/docs/claude-code', 'Anthropic', 'anthropic',
  'ai-engineering', array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[], 2, '在线课程/官方文档 · 【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 辅助开发']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://docs.claude.com/en/docs/claude-code'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-fefecddaa52a5395', (select id from public.resources where normalized_title = 'anthropicclaudecode官方文档' and normalized_author = 'anthropic' limit 1), 'Anthropic Claude Code官方文档',
  'Anthropic', 'ai-engineering', '在线课程/官方文档', 'https://docs.claude.com/en/docs/claude-code',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 辅助开发']::text[], array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicclaudecode官方文档' and normalized_author = 'anthropic' limit 1), 0, 1, 0.15217, -0.54412, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicclaudecode官方文档' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-61b90b7e29db', 14, 'GitHub仓库 chiphuyen/aie-book（书籍配套资源）', 'github仓库chiphuyen/aie-book书籍配套资源',
  '文章/其他资料', 'https://github.com/chiphuyen/aie-book', 'GitHub', 'github',
  'ai-engineering', array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[], 2, '文章/其他资料 · 【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 辅助开发']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://github.com/chiphuyen/aie-book'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-20438a1642c39d0b', (select id from public.resources where normalized_title = 'github仓库chiphuyen/aie-book书籍配套资源' and normalized_author = 'github' limit 1), 'GitHub仓库 chiphuyen/aie-book（书籍配套资源）',
  'GitHub', 'ai-engineering', '文章/其他资料', 'https://github.com/chiphuyen/aie-book',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 辅助开发']::text[], array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'github仓库chiphuyen/aie-book书籍配套资源' and normalized_author = 'github' limit 1), 0, 1, 0.31149, -0.55335, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'github仓库chiphuyen/aie-book书籍配套资源' and normalized_author = 'github' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-af05e64b6c4f', 15, 'O''Reilly图书页', 'oreilly图书页',
  '在线课程/官方文档', 'https://www.oreilly.com/library/view/ai-engineering/9781098166298/', 'O''Reilly', 'oreilly',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计', '【产品】AI产品需求分析与场景探索']::text[], 2, '在线课程/官方文档 · 【技术-应用】LLM应用技术选型与架构设计',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['LLM 应用架构', 'AI 需求分析 / 场景探索']::text[],
  array['AI 应用开发者 / 工程师', 'AI 产品经理 / 产品设计师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.oreilly.com/library/view/ai-engineering/9781098166298/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-6d98071b68eb5ab5', (select id from public.resources where normalized_title = 'oreilly图书页' and normalized_author = 'oreilly' limit 1), 'O''Reilly图书页',
  'O''Reilly', 'ai-engineering', '在线课程/官方文档', 'https://www.oreilly.com/library/view/ai-engineering/9781098166298/',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', 'AI 产品经理 / 产品设计师']::text[], array['LLM 应用架构', 'AI 需求分析 / 场景探索']::text[], array['【技术-应用】LLM应用技术选型与架构设计', '【产品】AI产品需求分析与场景探索']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'oreilly图书页' and normalized_author = 'oreilly' limit 1), 0, 1, 0.09365, -0.53689, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'oreilly图书页' and normalized_author = 'oreilly' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-93f79197ea8c', 16, 'https://www.oreilly.com/library/view/designing-large-language/9781098150495/', 'https//wwworeillycom/library/view/designing-large-language/9781098150495/',
  '在线课程/官方文档', 'https://www.oreilly.com/library/view/designing-large-language/9781098150495/', 'O''Reilly', 'oreilly',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2, '在线课程/官方文档 · 【技术-应用】LLM应用技术选型与架构设计',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['LLM 应用架构']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.oreilly.com/library/view/designing-large-language/9781098150495/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-d6f300a0f5e4d264', (select id from public.resources where normalized_title = 'https//wwworeillycom/library/view/designing-large-language/9781098150495/' and normalized_author = 'oreilly' limit 1), 'https://www.oreilly.com/library/view/designing-large-language/9781098150495/',
  'O''Reilly', 'ai-engineering', '在线课程/官方文档', 'https://www.oreilly.com/library/view/designing-large-language/9781098150495/',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['LLM 应用架构']::text[], array['【技术-应用】LLM应用技术选型与架构设计']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'https//wwworeillycom/library/view/designing-large-language/9781098150495/' and normalized_author = 'oreilly' limit 1), 0, 1, 0.37668, -0.53585, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'https//wwworeillycom/library/view/designing-large-language/9781098150495/' and normalized_author = 'oreilly' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-714206e915ec', 17, '作者播客访谈 The Pragmatic Engineer《AI Engineering with Chip Huyen》', '作者播客访谈thepragmaticengineeraiengineeringwithchiphuyen',
  '文章/其他资料', 'https://newsletter.pragmaticengineer.com/p/ai-engineering-with-chip-huyen', '来源待补充', '来源待补充',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2, '文章/其他资料 · 【技术-应用】LLM应用技术选型与架构设计',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['LLM 应用架构']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://newsletter.pragmaticengineer.com/p/ai-engineering-with-chip-huyen'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-314a42d6cac64f13', (select id from public.resources where normalized_title = '作者播客访谈thepragmaticengineeraiengineeringwithchiphuyen' and normalized_author = '来源待补充' limit 1), '作者播客访谈 The Pragmatic Engineer《AI Engineering with Chip Huyen》',
  '来源待补充', 'ai-engineering', '文章/其他资料', 'https://newsletter.pragmaticengineer.com/p/ai-engineering-with-chip-huyen',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['LLM 应用架构']::text[], array['【技术-应用】LLM应用技术选型与架构设计']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = '作者播客访谈thepragmaticengineeraiengineeringwithchiphuyen' and normalized_author = '来源待补充' limit 1), 0, 1, 0.04860, -0.52275, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = '作者播客访谈thepragmaticengineeraiengineeringwithchiphuyen' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-b14cbfa663c2', 18, '《AI Agents in Action, Second Edition》', 'aiagentsinactionsecondedition',
  '书籍', null, 'Michael Lanham', 'michaellanham',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AgentOS平台搭建与Agent运行时']::text[], 3, '书籍 · 【技术-应用】Agent系统设计与多智能体架构',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent 系统设计', 'AgentOS / 运行时']::text[],
  array['AI 应用开发者 / 工程师', '平台工程师 / 架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-70178e7a07facc3e', (select id from public.resources where normalized_title = 'aiagentsinactionsecondedition' and normalized_author = 'michaellanham' limit 1), '《AI Agents in Action, Second Edition》',
  'Michael Lanham', 'agent-and-intelligent-systems', '书籍', null,
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', '平台工程师 / 架构师']::text[], array['Agent 系统设计', 'AgentOS / 运行时']::text[], array['【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AgentOS平台搭建与Agent运行时']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'aiagentsinactionsecondedition' and normalized_author = 'michaellanham' limit 1), 2, 2, 0.83149, 0.34442, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'aiagentsinactionsecondedition' and normalized_author = 'michaellanham' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-149af6c6bd61', 19, 'Manning图书页', 'manning图书页',
  '在线课程/官方文档', 'https://www.manning.com/books/ai-agents-in-action-second-edition', 'Manning', 'manning',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构', '【技术-数据】语义检索系统设计与RAG']::text[], 3, '在线课程/官方文档 · 【技术-应用】Agent系统设计与多智能体架构',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent 系统设计', '语义检索 / RAG']::text[],
  array['AI 应用开发者 / 工程师', '数据工程师 / 知识工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.manning.com/books/ai-agents-in-action-second-edition'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f2501e18266a107c', (select id from public.resources where normalized_title = 'manning图书页' and normalized_author = 'manning' limit 1), 'Manning图书页',
  'Manning', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://www.manning.com/books/ai-agents-in-action-second-edition',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', '数据工程师 / 知识工程师']::text[], array['Agent 系统设计', '语义检索 / RAG']::text[], array['【技术-应用】Agent系统设计与多智能体架构', '【技术-数据】语义检索系统设计与RAG']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'manning图书页' and normalized_author = 'manning' limit 1), 2, 2, 0.83304, 0.23297, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'manning图书页' and normalized_author = 'manning' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-98abb9f00185', 20, 'Anthropic Model Context Protocol官方文档', 'anthropicmodelcontextprotocol官方文档',
  '在线课程/官方文档', 'https://modelcontextprotocol.io', 'Anthropic', 'anthropic',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3, '在线课程/官方文档 · 【技术-应用】Agent系统设计与多智能体架构',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent 系统设计']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://modelcontextprotocol.io'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-6ba3b385057f204d', (select id from public.resources where normalized_title = 'anthropicmodelcontextprotocol官方文档' and normalized_author = 'anthropic' limit 1), 'Anthropic Model Context Protocol官方文档',
  'Anthropic', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://modelcontextprotocol.io',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['Agent 系统设计']::text[], array['【技术-应用】Agent系统设计与多智能体架构']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicmodelcontextprotocol官方文档' and normalized_author = 'anthropic' limit 1), 2, 2, 0.81478, 0.45865, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicmodelcontextprotocol官方文档' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ba5f084e592b', 21, 'Manning liveBook试读', 'manninglivebook试读',
  '文章/其他资料', 'https://livebook.manning.com/book/ai-agents-in-action-second-edition', 'Manning', 'manning',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3, '文章/其他资料 · 【技术-应用】Agent系统设计与多智能体架构',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent 系统设计']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://livebook.manning.com/book/ai-agents-in-action-second-edition'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-a59f584605918a17', (select id from public.resources where normalized_title = 'manninglivebook试读' and normalized_author = 'manning' limit 1), 'Manning liveBook试读',
  'Manning', 'agent-and-intelligent-systems', '文章/其他资料', 'https://livebook.manning.com/book/ai-agents-in-action-second-edition',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['Agent 系统设计']::text[], array['【技术-应用】Agent系统设计与多智能体架构']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'manninglivebook试读' and normalized_author = 'manning' limit 1), 2, 2, 0.83243, 0.14521, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'manninglivebook试读' and normalized_author = 'manning' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-20c7bb5b2fb6', 22, '《Evals for AI Engineers》', 'evalsforaiengineers',
  '书籍', null, '作者待补充', '作者待补充',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估']::text[], 3, '书籍 · 【技术-应用】AI系统与Agent评估监测',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 系统评估', 'LLM / Agent 测试']::text[],
  array['AI 应用开发者 / 工程师', '测试工程师 / 质量工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-44b5bb8d64253871', (select id from public.resources where normalized_title = 'evalsforaiengineers' and normalized_author = '作者待补充' limit 1), '《Evals for AI Engineers》',
  '作者待补充', 'agent-and-intelligent-systems', '书籍', null,
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', '测试工程师 / 质量工程师']::text[], array['AI 系统评估', 'LLM / Agent 测试']::text[], array['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'evalsforaiengineers' and normalized_author = '作者待补充' limit 1), 2, 2, 0.77719, 0.54632, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'evalsforaiengineers' and normalized_author = '作者待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-dee96be2d5ce', 23, 'Maven课程《AI Evals For Engineers & PMs》', 'maven课程aievalsforengineers&pms',
  '在线课程/官方文档', 'https://maven.com/parlance-labs/evals', 'Maven', 'maven',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估']::text[], 3, '在线课程/官方文档 · 【技术-应用】AI系统与Agent评估监测',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 系统评估', 'LLM / Agent 测试']::text[],
  array['AI 应用开发者 / 工程师', '测试工程师 / 质量工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://maven.com/parlance-labs/evals'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-a102d549fd09d144', (select id from public.resources where normalized_title = 'maven课程aievalsforengineers&pms' and normalized_author = 'maven' limit 1), 'Maven课程《AI Evals For Engineers & PMs》',
  'Maven', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://maven.com/parlance-labs/evals',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', '测试工程师 / 质量工程师']::text[], array['AI 系统评估', 'LLM / Agent 测试']::text[], array['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'maven课程aievalsforengineers&pms' and normalized_author = 'maven' limit 1), 2, 2, 0.82146, 0.07637, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'maven课程aievalsforengineers&pms' and normalized_author = 'maven' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-22d9d70432ef', 24, 'DeepLearning.AI《Automated Testing for LLMOps》', 'deeplearningaiautomatedtestingforllmops',
  '在线课程/官方文档', 'https://www.deeplearning.ai/short-courses/automated-testing-llmops', 'DeepLearning.AI', 'deeplearningai',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测', '【技术-平台】LLMOps平台设计与模型全生命周期管理', '【测试】智能质量门禁与测试左移']::text[], 3, '在线课程/官方文档 · 【技术-应用】AI系统与Agent评估监测',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 系统评估', 'LLMOps', '质量门禁 / 测试左移']::text[],
  array['AI 应用开发者 / 工程师', '平台工程师 / 架构师', '测试工程师 / 质量工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.deeplearning.ai/short-courses/automated-testing-llmops'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-a755a18de6568a3b', (select id from public.resources where normalized_title = 'deeplearningaiautomatedtestingforllmops' and normalized_author = 'deeplearningai' limit 1), 'DeepLearning.AI《Automated Testing for LLMOps》',
  'DeepLearning.AI', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://www.deeplearning.ai/short-courses/automated-testing-llmops',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师', '平台工程师 / 架构师', '测试工程师 / 质量工程师']::text[], array['AI 系统评估', 'LLMOps', '质量门禁 / 测试左移']::text[], array['【技术-应用】AI系统与Agent评估监测', '【技术-平台】LLMOps平台设计与模型全生命周期管理', '【测试】智能质量门禁与测试左移']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'deeplearningaiautomatedtestingforllmops' and normalized_author = 'deeplearningai' limit 1), 2, 2, 0.73105, 0.60669, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'deeplearningaiautomatedtestingforllmops' and normalized_author = 'deeplearningai' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-e0366edc24ab', 25, 'Hamel Husain个人博客/Substack', 'hamelhusain个人博客/substack',
  '文章/其他资料', 'https://hamelhusain.substack.com/', '来源待补充', '来源待补充',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测']::text[], 3, '文章/其他资料 · 【技术-应用】AI系统与Agent评估监测',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 系统评估']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://hamelhusain.substack.com/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-5389cc9015b52669', (select id from public.resources where normalized_title = 'hamelhusain个人博客/substack' and normalized_author = '来源待补充' limit 1), 'Hamel Husain个人博客/Substack',
  '来源待补充', 'agent-and-intelligent-systems', '文章/其他资料', 'https://hamelhusain.substack.com/',
  'AI-Native 官方资料库', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 系统评估']::text[], array['【技术-应用】AI系统与Agent评估监测']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'hamelhusain个人博客/substack' and normalized_author = '来源待补充' limit 1), 2, 2, 0.80993, 0.01029, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'hamelhusain个人博客/substack' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-cf2de504de20', 26, '《A Simple Guide to Retrieval Augmented Generation》', 'asimpleguidetoretrievalaugmentedgeneration',
  '书籍', null, 'Abhinav Kimothi', 'abhinavkimothi',
  'data-intelligence-and-knowledge', array['【技术-数据】语义检索系统设计与RAG']::text[], 2, '书籍 · 【技术-数据】语义检索系统设计与RAG',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['语义检索 / RAG']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-753d59f15b7803a2', (select id from public.resources where normalized_title = 'asimpleguidetoretrievalaugmentedgeneration' and normalized_author = 'abhinavkimothi' limit 1), '《A Simple Guide to Retrieval Augmented Generation》',
  'Abhinav Kimothi', 'data-intelligence-and-knowledge', '书籍', null,
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['语义检索 / RAG']::text[], array['【技术-数据】语义检索系统设计与RAG']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'asimpleguidetoretrievalaugmentedgeneration' and normalized_author = 'abhinavkimothi' limit 1), 4, 1, -0.22961, 0.55433, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'asimpleguidetoretrievalaugmentedgeneration' and normalized_author = 'abhinavkimothi' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8e38d3c9cd91', 27, 'DeepLearning.AI《Building Applications with Vector Databases》(Pinecone) 见', 'deeplearningaibuildingapplicationswithvectordatabasespinecone见',
  '在线课程/官方文档', 'https://www.deeplearning.ai/courses', 'DeepLearning.AI', 'deeplearningai',
  'data-intelligence-and-knowledge', array['【技术-数据】语义检索系统设计与RAG']::text[], 2, '在线课程/官方文档 · 【技术-数据】语义检索系统设计与RAG',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['语义检索 / RAG']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://www.deeplearning.ai/courses'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-995dd4e78818ba11', (select id from public.resources where normalized_title = 'deeplearningaibuildingapplicationswithvectordatabasespinecone见' and normalized_author = 'deeplearningai' limit 1), 'DeepLearning.AI《Building Applications with Vector Databases》(Pinecone) 见',
  'DeepLearning.AI', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://www.deeplearning.ai/courses',
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['语义检索 / RAG']::text[], array['【技术-数据】语义检索系统设计与RAG']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'deeplearningaibuildingapplicationswithvectordatabasespinecone见' and normalized_author = 'deeplearningai' limit 1), 4, 1, -0.15217, 0.54412, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'deeplearningaibuildingapplicationswithvectordatabasespinecone见' and normalized_author = 'deeplearningai' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ebbfb3c8e900', 28, '《Designing Data-Intensive Applications》', 'designingdata-intensiveapplications',
  '书籍', null, 'Martin Kleppmann', 'martinkleppmann',
  'data-intelligence-and-knowledge', array['【技术-数据】实时数据流与AI集成']::text[], 2, '书籍 · 【技术-数据】实时数据流与AI集成',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['实时数据流']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-c97a522d9535b512', (select id from public.resources where normalized_title = 'designingdata-intensiveapplications' and normalized_author = 'martinkleppmann' limit 1), '《Designing Data-Intensive Applications》',
  'Martin Kleppmann', 'data-intelligence-and-knowledge', '书籍', null,
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['实时数据流']::text[], array['【技术-数据】实时数据流与AI集成']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'designingdata-intensiveapplications' and normalized_author = 'martinkleppmann' limit 1), 4, 1, -0.31149, 0.55335, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'designingdata-intensiveapplications' and normalized_author = 'martinkleppmann' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-488300976344', 29, 'Apache Kafka官方文档', 'apachekafka官方文档',
  '在线课程/官方文档', 'https://kafka.apache.org/documentation/', 'Apache', 'apache',
  'data-intelligence-and-knowledge', array['【技术-数据】实时数据流与AI集成']::text[], 2, '在线课程/官方文档 · 【技术-数据】实时数据流与AI集成',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['实时数据流']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://kafka.apache.org/documentation/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-b22cb8a5e6a4a7b8', (select id from public.resources where normalized_title = 'apachekafka官方文档' and normalized_author = 'apache' limit 1), 'Apache Kafka官方文档',
  'Apache', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://kafka.apache.org/documentation/',
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['实时数据流']::text[], array['【技术-数据】实时数据流与AI集成']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'apachekafka官方文档' and normalized_author = 'apache' limit 1), 4, 1, -0.09365, 0.53689, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'apachekafka官方文档' and normalized_author = 'apache' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-c5516ac5a9bf', 30, 'Apache Flink官方文档', 'apacheflink官方文档',
  '在线课程/官方文档', 'https://nightlies.apache.org/flink/flink-docs-stable/', 'Apache', 'apache',
  'data-intelligence-and-knowledge', array['【技术-数据】实时数据流与AI集成']::text[], 2, '在线课程/官方文档 · 【技术-数据】实时数据流与AI集成',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['实时数据流']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://nightlies.apache.org/flink/flink-docs-stable/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-b5b9e78602baaafd', (select id from public.resources where normalized_title = 'apacheflink官方文档' and normalized_author = 'apache' limit 1), 'Apache Flink官方文档',
  'Apache', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://nightlies.apache.org/flink/flink-docs-stable/',
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['实时数据流']::text[], array['【技术-数据】实时数据流与AI集成']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'apacheflink官方文档' and normalized_author = 'apache' limit 1), 4, 1, -0.37668, 0.53585, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'apacheflink官方文档' and normalized_author = 'apache' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-72e34fb26a30', 31, '《DAMA-DMBOK: Data Management Body of Knowledge》', 'dama-dmbokdatamanagementbodyofknowledge',
  '书籍', null, 'DAMA International', 'damainternational',
  'data-intelligence-and-knowledge', array['【技术-数据】面向AI的数据治理']::text[], 2, '书籍 · 【技术-数据】面向AI的数据治理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 数据治理']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-c13b1723f6dfe593', (select id from public.resources where normalized_title = 'dama-dmbokdatamanagementbodyofknowledge' and normalized_author = 'damainternational' limit 1), '《DAMA-DMBOK: Data Management Body of Knowledge》',
  'DAMA International', 'data-intelligence-and-knowledge', '书籍', null,
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['AI 数据治理']::text[], array['【技术-数据】面向AI的数据治理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'dama-dmbokdatamanagementbodyofknowledge' and normalized_author = 'damainternational' limit 1), 4, 1, -0.04860, 0.52275, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'dama-dmbokdatamanagementbodyofknowledge' and normalized_author = 'damainternational' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-16ee790358e9', 32, 'Google Cloud Skills Boost《Introduction to Responsible AI》(免费)', 'googlecloudskillsboostintroductiontoresponsibleai免费',
  '在线课程/官方文档', 'https://www.cloudskillsboost.google', 'Google', 'google',
  'data-intelligence-and-knowledge', array['【技术-数据】面向AI的数据治理']::text[], 2, '在线课程/官方文档 · 【技术-数据】面向AI的数据治理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 数据治理']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://www.cloudskillsboost.google'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f024193b007e2552', (select id from public.resources where normalized_title = 'googlecloudskillsboostintroductiontoresponsibleai免费' and normalized_author = 'google' limit 1), 'Google Cloud Skills Boost《Introduction to Responsible AI》(免费)',
  'Google', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://www.cloudskillsboost.google',
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['AI 数据治理']::text[], array['【技术-数据】面向AI的数据治理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'googlecloudskillsboostintroductiontoresponsibleai免费' and normalized_author = 'google' limit 1), 4, 1, -0.43107, 0.51943, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'googlecloudskillsboostintroductiontoresponsibleai免费' and normalized_author = 'google' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-15fcd6de0981', 33, 'Neo4j GraphAcademy（免费课程）', 'neo4jgraphacademy免费课程',
  '在线课程/官方文档', 'https://graphacademy.neo4j.com', 'Neo4j', 'neo4j',
  'ai-engineering', array['【技术-数据】业务知识建模与知识图谱构建']::text[], 2, '在线课程/官方文档 · 【技术-数据】业务知识建模与知识图谱构建',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['业务知识建模 / 知识图谱']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://graphacademy.neo4j.com'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-e2b64c9cfb3518f9', (select id from public.resources where normalized_title = 'neo4jgraphacademy免费课程' and normalized_author = 'neo4j' limit 1), 'Neo4j GraphAcademy（免费课程）',
  'Neo4j', 'ai-engineering', '在线课程/官方文档', 'https://graphacademy.neo4j.com',
  'AI-Native 官方资料库', false,
  array['数据工程师 / 知识工程师']::text[], array['业务知识建模 / 知识图谱']::text[], array['【技术-数据】业务知识建模与知识图谱构建']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'neo4jgraphacademy免费课程' and normalized_author = 'neo4j' limit 1), 0, 1, 0.43107, -0.51943, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'neo4jgraphacademy免费课程' and normalized_author = 'neo4j' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-d0f23b2737b2', 34, 'DeepLearning.AI × Google Cloud《LLMOps》', 'deeplearningai×googlecloudllmops',
  '在线课程/官方文档', 'https://www.deeplearning.ai/short-courses/llmops/', 'DeepLearning.AI', 'deeplearningai',
  'ai-engineering', array['【技术-平台】LLMOps平台设计与模型全生命周期管理']::text[], 3, '在线课程/官方文档 · 【技术-平台】LLMOps平台设计与模型全生命周期管理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['LLMOps']::text[],
  array['平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.deeplearning.ai/short-courses/llmops/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-4931204ca204ba50', (select id from public.resources where normalized_title = 'deeplearningai×googlecloudllmops' and normalized_author = 'deeplearningai' limit 1), 'DeepLearning.AI × Google Cloud《LLMOps》',
  'DeepLearning.AI', 'ai-engineering', '在线课程/官方文档', 'https://www.deeplearning.ai/short-courses/llmops/',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['LLMOps']::text[], array['【技术-平台】LLMOps平台设计与模型全生命周期管理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'deeplearningai×googlecloudllmops' and normalized_author = 'deeplearningai' limit 1), 0, 2, 0.34442, -0.83149, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'deeplearningai×googlecloudllmops' and normalized_author = 'deeplearningai' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-35e4ce517792', 35, 'Model Context Protocol官方文档', 'modelcontextprotocol官方文档',
  '在线课程/官方文档', 'https://modelcontextprotocol.io', '来源待补充', '来源待补充',
  'agent-and-intelligent-systems', array['【技术-平台】AgentOS平台搭建与Agent运行时']::text[], 3, '在线课程/官方文档 · 【技术-平台】AgentOS平台搭建与Agent运行时',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AgentOS / 运行时']::text[],
  array['平台工程师 / 架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://modelcontextprotocol.io'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-c4c4b79ab517fc4c', (select id from public.resources where normalized_title = 'modelcontextprotocol官方文档' and normalized_author = '来源待补充' limit 1), 'Model Context Protocol官方文档',
  '来源待补充', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://modelcontextprotocol.io',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AgentOS / 运行时']::text[], array['【技术-平台】AgentOS平台搭建与Agent运行时']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'modelcontextprotocol官方文档' and normalized_author = '来源待补充' limit 1), 2, 2, 0.68023, 0.66317, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'modelcontextprotocol官方文档' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-6eeb26d116f7', 36, 'LangGraph官方文档', 'langgraph官方文档',
  '在线课程/官方文档', 'https://langchain-ai.github.io/langgraph/', 'GitHub', 'github',
  'agent-and-intelligent-systems', array['【技术-平台】AgentOS平台搭建与Agent运行时']::text[], 3, '在线课程/官方文档 · 【技术-平台】AgentOS平台搭建与Agent运行时',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AgentOS / 运行时']::text[],
  array['平台工程师 / 架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://langchain-ai.github.io/langgraph/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-af26b45a0c8d4957', (select id from public.resources where normalized_title = 'langgraph官方文档' and normalized_author = 'github' limit 1), 'LangGraph官方文档',
  'GitHub', 'agent-and-intelligent-systems', '在线课程/官方文档', 'https://langchain-ai.github.io/langgraph/',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AgentOS / 运行时']::text[], array['【技术-平台】AgentOS平台搭建与Agent运行时']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'langgraph官方文档' and normalized_author = 'github' limit 1), 2, 2, 0.80528, 0.36708, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'langgraph官方文档' and normalized_author = 'github' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-1f6b7eeaeb5e', 37, 'vLLM官方文档', 'vllm官方文档',
  '在线课程/官方文档', 'https://docs.vllm.ai', '来源待补充', '来源待补充',
  'ai-engineering', array['【技术-平台】模型推理优化与加速（量化/推理服务）', '【FDE】AI应用生产部署与交付实施']::text[], 3, '在线课程/官方文档 · 【技术-平台】模型推理优化与加速（量化/推理服务）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['模型推理优化', '生产部署 / 交付实施']::text[],
  array['平台工程师 / 架构师', 'FDE / 解决方案 / 交付']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://docs.vllm.ai'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-8860868bb03b9ab1', (select id from public.resources where normalized_title = 'vllm官方文档' and normalized_author = '来源待补充' limit 1), 'vLLM官方文档',
  '来源待补充', 'ai-engineering', '在线课程/官方文档', 'https://docs.vllm.ai',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师', 'FDE / 解决方案 / 交付']::text[], array['模型推理优化', '生产部署 / 交付实施']::text[], array['【技术-平台】模型推理优化与加速（量化/推理服务）', '【FDE】AI应用生产部署与交付实施']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'vllm官方文档' and normalized_author = '来源待补充' limit 1), 0, 2, 0.23297, -0.83304, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'vllm官方文档' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-58faa3ea1dc3', 38, '《Site Reliability Engineering》', 'sitereliabilityengineering',
  '书籍', null, 'Betsy Beyer / Chris Jones / Jennifer Petoff / Niall Richard Murphy', 'betsybeyer/chrisjones/jenniferpetoff/niallrichardmurphy',
  'ai-engineering', array['【技术-平台】AI基础设施运维与可观测性（SRE for AI）']::text[], 3, '书籍 · 【技术-平台】AI基础设施运维与可观测性（SRE for AI）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 基础设施 / 可观测性']::text[],
  array['平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-3ff1d65ec297e626', (select id from public.resources where normalized_title = 'sitereliabilityengineering' and normalized_author = 'betsybeyer/chrisjones/jenniferpetoff/niallrichardmurphy' limit 1), '《Site Reliability Engineering》',
  'Betsy Beyer / Chris Jones / Jennifer Petoff / Niall Richard Murphy', 'ai-engineering', '书籍', null,
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AI 基础设施 / 可观测性']::text[], array['【技术-平台】AI基础设施运维与可观测性（SRE for AI）']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'sitereliabilityengineering' and normalized_author = 'betsybeyer/chrisjones/jenniferpetoff/niallrichardmurphy' limit 1), 0, 2, 0.45865, -0.81478, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'sitereliabilityengineering' and normalized_author = 'betsybeyer/chrisjones/jenniferpetoff/niallrichardmurphy' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-e4109ba4c123', 39, 'Google SRE Books官方网站', 'googlesrebooks官方网站',
  '在线课程/官方文档', 'https://sre.google/books/', 'Google', 'google',
  'ai-engineering', array['【技术-平台】AI基础设施运维与可观测性（SRE for AI）']::text[], 3, '在线课程/官方文档 · 【技术-平台】AI基础设施运维与可观测性（SRE for AI）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 基础设施 / 可观测性']::text[],
  array['平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://sre.google/books/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-b3fda52068eb1c4a', (select id from public.resources where normalized_title = 'googlesrebooks官方网站' and normalized_author = 'google' limit 1), 'Google SRE Books官方网站',
  'Google', 'ai-engineering', '在线课程/官方文档', 'https://sre.google/books/',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AI 基础设施 / 可观测性']::text[], array['【技术-平台】AI基础设施运维与可观测性（SRE for AI）']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'googlesrebooks官方网站' and normalized_author = 'google' limit 1), 0, 2, 0.14521, -0.83243, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'googlesrebooks官方网站' and normalized_author = 'google' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8140b5a97106', 40, '《AI Risk Management Framework》', 'airiskmanagementframework',
  '书籍', null, 'NIST', 'nist',
  'ai-ethics-and-governance', array['【技术-平台】AI安全治理与AI Governance']::text[], 3, '书籍 · 【技术-平台】AI安全治理与AI Governance',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 安全治理']::text[],
  array['平台工程师 / 架构师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-1beb04392647ca9b', (select id from public.resources where normalized_title = 'airiskmanagementframework' and normalized_author = 'nist' limit 1), '《AI Risk Management Framework》',
  'NIST', 'ai-ethics-and-governance', '书籍', null,
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AI 安全治理']::text[], array['【技术-平台】AI安全治理与AI Governance']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'airiskmanagementframework' and normalized_author = 'nist' limit 1), 6, 2, -0.83149, -0.34442, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'airiskmanagementframework' and normalized_author = 'nist' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-60186f208118', 41, 'NIST AI RMF官网', 'nistairmf官网',
  '在线课程/官方文档', 'https://www.nist.gov/itl/ai-risk-management-framework', '来源待补充', '来源待补充',
  'ai-ethics-and-governance', array['【技术-平台】AI安全治理与AI Governance']::text[], 3, '在线课程/官方文档 · 【技术-平台】AI安全治理与AI Governance',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 安全治理']::text[],
  array['平台工程师 / 架构师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', 'https://www.nist.gov/itl/ai-risk-management-framework'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-20e361a8f1cf253e', (select id from public.resources where normalized_title = 'nistairmf官网' and normalized_author = '来源待补充' limit 1), 'NIST AI RMF官网',
  '来源待补充', 'ai-ethics-and-governance', '在线课程/官方文档', 'https://www.nist.gov/itl/ai-risk-management-framework',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AI 安全治理']::text[], array['【技术-平台】AI安全治理与AI Governance']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'nistairmf官网' and normalized_author = '来源待补充' limit 1), 6, 2, -0.83304, -0.23297, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'nistairmf官网' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-d0c869c8ea25', 42, 'Anthropic Responsible Scaling Policy', 'anthropicresponsiblescalingpolicy',
  '在线课程/官方文档', 'https://www.anthropic.com/rsp', 'Anthropic', 'anthropic',
  'ai-ethics-and-governance', array['【技术-平台】AI安全治理与AI Governance']::text[], 3, '在线课程/官方文档 · 【技术-平台】AI安全治理与AI Governance',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 安全治理']::text[],
  array['平台工程师 / 架构师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', 'https://www.anthropic.com/rsp'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-58a48bb6495b9830', (select id from public.resources where normalized_title = 'anthropicresponsiblescalingpolicy' and normalized_author = 'anthropic' limit 1), 'Anthropic Responsible Scaling Policy',
  'Anthropic', 'ai-ethics-and-governance', '在线课程/官方文档', 'https://www.anthropic.com/rsp',
  'AI-Native 官方资料库', false,
  array['平台工程师 / 架构师']::text[], array['AI 安全治理']::text[], array['【技术-平台】AI安全治理与AI Governance']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicresponsiblescalingpolicy' and normalized_author = 'anthropic' limit 1), 6, 2, -0.81478, -0.45865, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicresponsiblescalingpolicy' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ac28142b17f3', 43, '《AI Product Management》', 'aiproductmanagement',
  '书籍', null, '作者待补充', '作者待补充',
  'ai-product-design', array['【产品】AI产品需求分析与场景探索', '【产品】AI产品设计与人机协作交互设计', '【产品】快速原型验证与Vibe Coding']::text[], 2, '书籍 · 【产品】AI产品需求分析与场景探索',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 需求分析 / 场景探索', '人机协作交互', '快速原型 / Vibe Coding']::text[],
  array['AI 产品经理 / 产品设计师']::text[], array['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-0817ed45da177be2', (select id from public.resources where normalized_title = 'aiproductmanagement' and normalized_author = '作者待补充' limit 1), '《AI Product Management》',
  '作者待补充', 'ai-product-design', '书籍', null,
  'AI-Native 官方资料库', false,
  array['AI 产品经理 / 产品设计师']::text[], array['AI 需求分析 / 场景探索', '人机协作交互', '快速原型 / Vibe Coding']::text[], array['【产品】AI产品需求分析与场景探索', '【产品】AI产品设计与人机协作交互设计', '【产品】快速原型验证与Vibe Coding']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'aiproductmanagement' and normalized_author = '作者待补充' limit 1), 1, 1, 0.55433, -0.22961, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'aiproductmanagement' and normalized_author = '作者待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-688cd4d8c452', 44, 'Duke University《AI Product Management》Specialization(Coursera)', 'dukeuniversityaiproductmanagementspecializationcoursera',
  '在线课程/官方文档', 'https://www.classcentral.com/course/ai-product-management-duke-89505', 'Coursera', 'coursera',
  'ai-product-design', array['【产品】AI产品需求分析与场景探索']::text[], 2, '在线课程/官方文档 · 【产品】AI产品需求分析与场景探索',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 需求分析 / 场景探索']::text[],
  array['AI 产品经理 / 产品设计师']::text[], array['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架']::text[],
  'published', 'https://www.classcentral.com/course/ai-product-management-duke-89505'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-bd544e1f1e82057b', (select id from public.resources where normalized_title = 'dukeuniversityaiproductmanagementspecializationcoursera' and normalized_author = 'coursera' limit 1), 'Duke University《AI Product Management》Specialization(Coursera)',
  'Coursera', 'ai-product-design', '在线课程/官方文档', 'https://www.classcentral.com/course/ai-product-management-duke-89505',
  'AI-Native 官方资料库', false,
  array['AI 产品经理 / 产品设计师']::text[], array['AI 需求分析 / 场景探索']::text[], array['【产品】AI产品需求分析与场景探索']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'dukeuniversityaiproductmanagementspecializationcoursera' and normalized_author = 'coursera' limit 1), 1, 1, 0.49235, -0.27715, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'dukeuniversityaiproductmanagementspecializationcoursera' and normalized_author = 'coursera' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-94ce60937cd6', 45, 'Google People + AI Research (PAIR) Guidebook', 'googlepeople+airesearchpairguidebook',
  '在线课程/官方文档', 'https://pair.withgoogle.com/guidebook', 'Google', 'google',
  'ai-product-design', array['【产品】AI产品设计与人机协作交互设计']::text[], 2, '在线课程/官方文档 · 【产品】AI产品设计与人机协作交互设计',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['人机协作交互']::text[],
  array['AI 产品经理 / 产品设计师']::text[], array['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架']::text[],
  'published', 'https://pair.withgoogle.com/guidebook'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-2a92876c53499c91', (select id from public.resources where normalized_title = 'googlepeople+airesearchpairguidebook' and normalized_author = 'google' limit 1), 'Google People + AI Research (PAIR) Guidebook',
  'Google', 'ai-product-design', '在线课程/官方文档', 'https://pair.withgoogle.com/guidebook',
  'AI-Native 官方资料库', false,
  array['AI 产品经理 / 产品设计师']::text[], array['人机协作交互']::text[], array['【产品】AI产品设计与人机协作交互设计']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'googlepeople+airesearchpairguidebook' and normalized_author = 'google' limit 1), 1, 1, 0.61154, -0.17103, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'googlepeople+airesearchpairguidebook' and normalized_author = 'google' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-d40c4348a03d', 46, 'Cursor官方文档', 'cursor官方文档',
  '在线课程/官方文档', 'https://docs.cursor.com', '来源待补充', '来源待补充',
  'ai-product-design', array['【产品】快速原型验证与Vibe Coding']::text[], 2, '在线课程/官方文档 · 【产品】快速原型验证与Vibe Coding',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['快速原型 / Vibe Coding']::text[],
  array['AI 产品经理 / 产品设计师']::text[], array['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架']::text[],
  'published', 'https://docs.cursor.com'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-9d3c5716157fb55f', (select id from public.resources where normalized_title = 'cursor官方文档' and normalized_author = '来源待补充' limit 1), 'Cursor官方文档',
  '来源待补充', 'ai-product-design', '在线课程/官方文档', 'https://docs.cursor.com',
  'AI-Native 官方资料库', false,
  array['AI 产品经理 / 产品设计师']::text[], array['快速原型 / Vibe Coding']::text[], array['【产品】快速原型验证与Vibe Coding']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'cursor官方文档' and normalized_author = '来源待补充' limit 1), 1, 1, 0.44586, -0.31342, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'cursor官方文档' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-da6cb702b8fd', 47, 'Arize AI《The Definitive Guide to LLM Evaluation》', 'arizeaithedefinitiveguidetollmevaluation',
  '文章/其他资料', 'https://arize.com/llm-evaluation/', '来源待补充', '来源待补充',
  'ai-engineering', array['【测试】AI辅助测试工程与LLM/Agent测试评估']::text[], 2, '文章/其他资料 · 【测试】AI辅助测试工程与LLM/Agent测试评估',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['LLM / Agent 测试']::text[],
  array['测试工程师 / 质量工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://arize.com/llm-evaluation/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-177da8ce9f3c8bb7', (select id from public.resources where normalized_title = 'arizeaithedefinitiveguidetollmevaluation' and normalized_author = '来源待补充' limit 1), 'Arize AI《The Definitive Guide to LLM Evaluation》',
  '来源待补充', 'ai-engineering', '文章/其他资料', 'https://arize.com/llm-evaluation/',
  'AI-Native 官方资料库', false,
  array['测试工程师 / 质量工程师']::text[], array['LLM / Agent 测试']::text[], array['【测试】AI辅助测试工程与LLM/Agent测试评估']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'arizeaithedefinitiveguidetollmevaluation' and normalized_author = '来源待补充' limit 1), 0, 1, 0.00648, -0.50996, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'arizeaithedefinitiveguidetollmevaluation' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-cc232b733f67', 48, '《People + AI Guidebook》', 'people+aiguidebook',
  '书籍', null, 'Google PAIR', 'googlepair',
  'ai-ethics-and-governance', array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[], 2, '书籍 · 【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['对抗测试 / 偏见检测']::text[],
  array['测试工程师 / 质量工程师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-59fa534d4fe44aed', (select id from public.resources where normalized_title = 'people+aiguidebook' and normalized_author = 'googlepair' limit 1), '《People + AI Guidebook》',
  'Google PAIR', 'ai-ethics-and-governance', '书籍', null,
  'AI-Native 官方资料库', false,
  array['测试工程师 / 质量工程师']::text[], array['对抗测试 / 偏见检测']::text[], array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'people+aiguidebook' and normalized_author = 'googlepair' limit 1), 6, 1, -0.55433, -0.22961, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'people+aiguidebook' and normalized_author = 'googlepair' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-752d34dfe996', 49, 'Google PAIR Guidebook', 'googlepairguidebook',
  '在线课程/官方文档', 'https://pair.withgoogle.com/guidebook', 'Google', 'google',
  'ai-ethics-and-governance', array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[], 2, '在线课程/官方文档 · 【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['对抗测试 / 偏见检测']::text[],
  array['测试工程师 / 质量工程师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', 'https://pair.withgoogle.com/guidebook'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-033abca1aa99c9e7', (select id from public.resources where normalized_title = 'googlepairguidebook' and normalized_author = 'google' limit 1), 'Google PAIR Guidebook',
  'Google', 'ai-ethics-and-governance', '在线课程/官方文档', 'https://pair.withgoogle.com/guidebook',
  'AI-Native 官方资料库', false,
  array['测试工程师 / 质量工程师']::text[], array['对抗测试 / 偏见检测']::text[], array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'googlepairguidebook' and normalized_author = 'google' limit 1), 6, 1, -0.54412, -0.15217, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'googlepairguidebook' and normalized_author = 'google' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-c15315777bf6', 50, 'NIST AI RMF', 'nistairmf',
  '在线课程/官方文档', 'https://www.nist.gov/itl/ai-risk-management-framework', '来源待补充', '来源待补充',
  'ai-ethics-and-governance', array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[], 2, '在线课程/官方文档 · 【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['对抗测试 / 偏见检测']::text[],
  array['测试工程师 / 质量工程师']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', 'https://www.nist.gov/itl/ai-risk-management-framework'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f88c1958335d6465', (select id from public.resources where normalized_title = 'nistairmf' and normalized_author = '来源待补充' limit 1), 'NIST AI RMF',
  '来源待补充', 'ai-ethics-and-governance', '在线课程/官方文档', 'https://www.nist.gov/itl/ai-risk-management-framework',
  'AI-Native 官方资料库', false,
  array['测试工程师 / 质量工程师']::text[], array['对抗测试 / 偏见检测']::text[], array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'nistairmf' and normalized_author = '来源待补充' limit 1), 6, 1, -0.55335, -0.31149, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'nistairmf' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8519dafde184', 51, 'PMI《Artificial Intelligence in Project Management》官方学习中心', 'pmiartificialintelligenceinprojectmanagement官方学习中心',
  '在线课程/官方文档', 'https://www.pmi.org/learning/ai-in-project-management', '来源待补充', '来源待补充',
  'ai-engineering', array['【项目管理】AI辅助项目管理与项目管理数字化工具']::text[], 2, '在线课程/官方文档 · 【项目管理】AI辅助项目管理与项目管理数字化工具',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 项目管理']::text[],
  array['项目经理 / PMO']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.pmi.org/learning/ai-in-project-management'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-346a804563b84567', (select id from public.resources where normalized_title = 'pmiartificialintelligenceinprojectmanagement官方学习中心' and normalized_author = '来源待补充' limit 1), 'PMI《Artificial Intelligence in Project Management》官方学习中心',
  '来源待补充', 'ai-engineering', '在线课程/官方文档', 'https://www.pmi.org/learning/ai-in-project-management',
  'AI-Native 官方资料库', false,
  array['项目经理 / PMO']::text[], array['AI 项目管理']::text[], array['【项目管理】AI辅助项目管理与项目管理数字化工具']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'pmiartificialintelligenceinprojectmanagement官方学习中心' and normalized_author = '来源待补充' limit 1), 0, 1, 0.48167, -0.49406, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'pmiartificialintelligenceinprojectmanagement官方学习中心' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-988ae09219d0', 52, 'PMI《Generative AI Overview for Project Managers》', 'pmigenerativeaioverviewforprojectmanagers',
  '在线课程/官方文档', 'https://www.pmi.org/shop/p-/elearning/generative-ai-overview-for-project-managers/el083', '来源待补充', '来源待补充',
  'ai-engineering', array['【项目管理】AI辅助项目管理与项目管理数字化工具']::text[], 2, '在线课程/官方文档 · 【项目管理】AI辅助项目管理与项目管理数字化工具',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 项目管理']::text[],
  array['项目经理 / PMO']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.pmi.org/shop/p-/elearning/generative-ai-overview-for-project-managers/el083'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-620f543fb6f4e726', (select id from public.resources where normalized_title = 'pmigenerativeaioverviewforprojectmanagers' and normalized_author = '来源待补充' limit 1), 'PMI《Generative AI Overview for Project Managers》',
  '来源待补充', 'ai-engineering', '在线课程/官方文档', 'https://www.pmi.org/shop/p-/elearning/generative-ai-overview-for-project-managers/el083',
  'AI-Native 官方资料库', false,
  array['项目经理 / PMO']::text[], array['AI 项目管理']::text[], array['【项目管理】AI辅助项目管理与项目管理数字化工具']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'pmigenerativeaioverviewforprojectmanagers' and normalized_author = '来源待补充' limit 1), 0, 1, 0.24265, -0.53230, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'pmigenerativeaioverviewforprojectmanagers' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-6aba869a8e9f', 53, 'PMI-CPMAI认证学习路径', 'pmi-cpmai认证学习路径',
  '在线课程/官方文档', 'https://www.pmi.org/learning/ai-in-project-management', '来源待补充', '来源待补充',
  'ai-engineering', array['【项目管理】AI项目组合管理与数据驱动决策']::text[], 2, '在线课程/官方文档 · 【项目管理】AI项目组合管理与数据驱动决策',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['项目组合管理 / 数据驱动决策']::text[],
  array['项目经理 / PMO']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.pmi.org/learning/ai-in-project-management'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-25438e5fdfe45abd', (select id from public.resources where normalized_title = 'pmi-cpmai认证学习路径' and normalized_author = '来源待补充' limit 1), 'PMI-CPMAI认证学习路径',
  '来源待补充', 'ai-engineering', '在线课程/官方文档', 'https://www.pmi.org/learning/ai-in-project-management',
  'AI-Native 官方资料库', false,
  array['项目经理 / PMO']::text[], array['项目组合管理 / 数据驱动决策']::text[], array['【项目管理】AI项目组合管理与数据驱动决策']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'pmi-cpmai认证学习路径' and normalized_author = '来源待补充' limit 1), 0, 1, 0.16658, -0.52417, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'pmi-cpmai认证学习路径' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-645a001018f6', 54, '《BPMN Method and Style》', 'bpmnmethodandstyle',
  '书籍', null, 'Bruce Silver', 'brucesilver',
  'ai-business-implementation', array['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)']::text[], 2, '书籍 · 【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['业务流程建模 / 业务本体']::text[],
  array['FDE / 解决方案 / 交付']::text[], array['理解 AI 商业落地路径', '掌握价值评估基本框架', '建立场景推进判断']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-466704cea19710f2', (select id from public.resources where normalized_title = 'bpmnmethodandstyle' and normalized_author = 'brucesilver' limit 1), '《BPMN Method and Style》',
  'Bruce Silver', 'ai-business-implementation', '书籍', null,
  'AI-Native 官方资料库', false,
  array['FDE / 解决方案 / 交付']::text[], array['业务流程建模 / 业务本体']::text[], array['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'bpmnmethodandstyle' and normalized_author = 'brucesilver' limit 1), 5, 1, -0.55433, 0.22961, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'bpmnmethodandstyle' and normalized_author = 'brucesilver' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-7dd34f445074', 55, 'OMG BPMN官方规范', 'omgbpmn官方规范',
  '在线课程/官方文档', 'https://www.omg.org/spec/BPMN', '来源待补充', '来源待补充',
  'ai-business-implementation', array['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)']::text[], 2, '在线课程/官方文档 · 【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['业务流程建模 / 业务本体']::text[],
  array['FDE / 解决方案 / 交付']::text[], array['理解 AI 商业落地路径', '掌握价值评估基本框架', '建立场景推进判断']::text[],
  'published', 'https://www.omg.org/spec/BPMN'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-e0e04f12ce97d58f', (select id from public.resources where normalized_title = 'omgbpmn官方规范' and normalized_author = '来源待补充' limit 1), 'OMG BPMN官方规范',
  '来源待补充', 'ai-business-implementation', '在线课程/官方文档', 'https://www.omg.org/spec/BPMN',
  'AI-Native 官方资料库', false,
  array['FDE / 解决方案 / 交付']::text[], array['业务流程建模 / 业务本体']::text[], array['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'omgbpmn官方规范' and normalized_author = '来源待补充' limit 1), 5, 1, -0.49235, 0.27715, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'omgbpmn官方规范' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-fd2860e035d6', 56, '《Leading Change》', 'leadingchange',
  '书籍', null, 'John P. Kotter', 'johnpkotter',
  'ai-organizational-transformation', array['【FDE】流程变革推动与变革管理']::text[], 2, '书籍 · 【FDE】流程变革推动与变革管理',
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['流程变革 / 变革管理']::text[],
  array['FDE / 解决方案 / 交付']::text[], array['理解组织转型关键机制', '建立 AI 时代组织认知', '掌握变革推进基本方法']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-c1c1d21a2f6f4715', (select id from public.resources where normalized_title = 'leadingchange' and normalized_author = 'johnpkotter' limit 1), '《Leading Change》',
  'John P. Kotter', 'ai-organizational-transformation', '书籍', null,
  'AI-Native 官方资料库', false,
  array['FDE / 解决方案 / 交付']::text[], array['流程变革 / 变革管理']::text[], array['【FDE】流程变革推动与变革管理']::text[],
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'leadingchange' and normalized_author = 'johnpkotter' limit 1), 3, 1, 0.22961, 0.55433, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'leadingchange' and normalized_author = 'johnpkotter' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ec32013de9ea', 57, '本体驱动的AI数据管理', '本体驱动的ai数据管理',
  '书籍', 'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910', '作者待补充', '作者待补充',
  'data-intelligence-and-knowledge', array['【技术-数据】面向AI的数据治理']::text[], 2, '书籍 · 【技术-数据】面向AI的数据治理',
  'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理...', 'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理将是未来的主要方向之一', array['AI 数据治理']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-e8c4d2a6018effee', (select id from public.resources where normalized_title = '本体驱动的ai数据管理' and normalized_author = '作者待补充' limit 1), '本体驱动的AI数据管理',
  '作者待补充', 'data-intelligence-and-knowledge', '书籍', 'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910',
  '张为普', false,
  array['数据工程师 / 知识工程师']::text[], array['AI 数据治理']::text[], array['【技术-数据】面向AI的数据治理']::text[],
  'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理将是未来的主要方向之一', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = '本体驱动的ai数据管理' and normalized_author = '作者待补充' limit 1), 4, 1, -0.00648, 0.50996, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = '本体驱动的ai数据管理' and normalized_author = '作者待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-f727806475a9', 58, 'Follow bulider', 'followbulider',
  '文章/其他资料', 'https://github.com/zarazhangrui/follow-builders', 'GitHub', 'github',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '文章/其他资料 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  '本人订阅了部分在 AI 领域活跃度较高的博主或行业资深人士的...', '本人订阅了部分在 AI 领域活跃度较高的博主或行业资深人士的相关资讯。', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://github.com/zarazhangrui/follow-builders'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-8252a60919b9fff0', (select id from public.resources where normalized_title = 'followbulider' and normalized_author = 'github' limit 1), 'Follow bulider',
  'GitHub', 'ai-frontier-trends', '文章/其他资料', 'https://github.com/zarazhangrui/follow-builders',
  '邱娟', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  '本人订阅了部分在 AI 领域活跃度较高的博主或行业资深人士的相关资讯。', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'followbulider' and normalized_author = 'github' limit 1), 7, 0, -0.06100, -0.34972, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'followbulider' and normalized_author = 'github' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-002cef20b0a0', 59, 'RTK', 'rtk',
  '在线课程/官方文档', 'https://github.com/rtk-ai/rtk', 'GitHub', 'github',
  'data-intelligence-and-knowledge', array['【全员通用】知识工程与Context管理']::text[], 1, '在线课程/官方文档 · 【全员通用】知识工程与Context管理',
  '能减少token消耗', '能减少token消耗', array['知识工程 / Context 管理']::text[],
  array['全员 / AI 初学者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://github.com/rtk-ai/rtk'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-d65e16bc599133e8', (select id from public.resources where normalized_title = 'rtk' and normalized_author = 'github' limit 1), 'RTK',
  'GitHub', 'data-intelligence-and-knowledge', '在线课程/官方文档', 'https://github.com/rtk-ai/rtk',
  '许巍', false,
  array['全员 / AI 初学者']::text[], array['知识工程 / Context 管理']::text[], array['【全员通用】知识工程与Context管理']::text[],
  '能减少token消耗', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'rtk' and normalized_author = 'github' limit 1), 4, 0, -0.04210, 0.24136, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'rtk' and normalized_author = 'github' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-9a3c0bbe2ef7', 60, '针对奔驰研发客户出的《Core Function AI提效》6周培训课', '针对奔驰研发客户出的corefunctionai提效6周培训课',
  '文章/其他资料', 'https://inspiregroup.feishu.cn/drive/folder/RoDTfZuiKlg5tkdvWsec1yRZnk9', '来源待补充', '来源待补充',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶', '【全员通用】知识工程与Context管理', '【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AI安全治理与AI Governance']::text[], 1, '文章/其他资料 · 【全员通用】Prompt工程基础与进阶',
  '这个是针对奔驰客户出的，目前还不能直接拿去给其他客户，需要脱...', '这个是针对奔驰客户出的，目前还不能直接拿去给其他客户，需要脱敏。资料目前只做了3期，需要可以联系我。', array['Prompt 工程', '知识工程 / Context 管理', 'Agent 系统设计', 'AI 安全治理']::text[],
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师', '平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://inspiregroup.feishu.cn/drive/folder/RoDTfZuiKlg5tkdvWsec1yRZnk9'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-3bb58e74e611811f', (select id from public.resources where normalized_title = '针对奔驰研发客户出的corefunctionai提效6周培训课' and normalized_author = '来源待补充' limit 1), '针对奔驰研发客户出的《Core Function AI提效》6周培训课',
  '来源待补充', 'ai-engineering', '文章/其他资料', 'https://inspiregroup.feishu.cn/drive/folder/RoDTfZuiKlg5tkdvWsec1yRZnk9',
  '张帅', false,
  array['全员 / AI 初学者', 'AI 应用开发者 / 工程师', '平台工程师 / 架构师']::text[], array['Prompt 工程', '知识工程 / Context 管理', 'Agent 系统设计', 'AI 安全治理']::text[], array['【全员通用】Prompt工程基础与进阶', '【全员通用】知识工程与Context管理', '【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AI安全治理与AI Governance']::text[],
  '这个是针对奔驰客户出的，目前还不能直接拿去给其他客户，需要脱敏。资料目前只做了3期，需要可以联系我。', 3, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = '针对奔驰研发客户出的corefunctionai提效6周培训课' and normalized_author = '来源待补充' limit 1), 0, 0, 0.20415, -0.29043, true,
  3, 3, 16.00, 26.00, 0.160, 1.50, 0.720,
  300, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = '针对奔驰研发客户出的corefunctionai提效6周培训课' and normalized_author = '来源待补充' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-06a688227b7b', 61, '《Hands-On Large Language Models》', 'hands-onlargelanguagemodels',
  '书籍', 'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/', 'Jay Alammar / Maarten Grootendorst', 'jayalammar/maartengrootendorst',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '书籍 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  '构建对transformers与embeddings如何处理...', '构建对transformers与embeddings如何处理文本的"可视直觉"。Jay Alammar以机器学习可视化指南闻名，本书把这种可视方法贯穿LLM全生命周期，把抽象数学讲得很"落地"。', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-95917299594a060e', (select id from public.resources where normalized_title = 'hands-onlargelanguagemodels' and normalized_author = 'jayalammar/maartengrootendorst' limit 1), '《Hands-On Large Language Models》',
  'Jay Alammar / Maarten Grootendorst', 'ai-frontier-trends', '书籍', 'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/',
  '张娜', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  '构建对transformers与embeddings如何处理文本的"可视直觉"。Jay Alammar以机器学习可视化指南闻名，本书把这种可视方法贯穿LLM全生命周期，把抽象数学讲得很"落地"。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'hands-onlargelanguagemodels' and normalized_author = 'jayalammar/maartengrootendorst' limit 1), 7, 0, -0.14369, -0.17314, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'hands-onlargelanguagemodels' and normalized_author = 'jayalammar/maartengrootendorst' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-dbec9a56d0da', 62, '《LLM Engineer''s Handbook》', 'llmengineershandbook',
  '书籍', 'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079', 'Paul Iusztin / Maxime Labonne', 'pauliusztin/maximelabonne',
  'ai-engineering', array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[], 2, '书籍 · 【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)',
  '动手实现完整的数据与fine-tuning生命周期', '动手实现完整的数据与fine-tuning生命周期。手把手带你构建开源系统LLM Twin，从数据收集到模型部署的完整生命周期。你会学到SFT与preference alignment的实用差异，以及parameter-efficient fine-tuning。', array['AI 辅助开发']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-3f167ea1cb19339e', (select id from public.resources where normalized_title = 'llmengineershandbook' and normalized_author = 'pauliusztin/maximelabonne' limit 1), '《LLM Engineer''s Handbook》',
  'Paul Iusztin / Maxime Labonne', 'ai-engineering', '书籍', 'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079',
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 辅助开发']::text[], array['【技术-应用】AI辅助开发(架构设计, 编码与代码审查等)']::text[],
  '动手实现完整的数据与fine-tuning生命周期。手把手带你构建开源系统LLM Twin，从数据收集到模型部署的完整生命周期。你会学到SFT与preference alignment的实用差异，以及parameter-efficient fine-tuning。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'llmengineershandbook' and normalized_author = 'pauliusztin/maximelabonne' limit 1), 0, 1, 0.32285, -0.52931, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'llmengineershandbook' and normalized_author = 'pauliusztin/maximelabonne' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-ad9c7c914a47', 63, '《Designing Multi-Agent Systems》', 'designingmulti-agentsystems',
  '书籍', 'https://www.manning.com/books/designing-multi-agent-systems', 'Victor Dibia', 'victordibia',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3, '书籍 · 【技术-应用】Agent系统设计与多智能体架构',
  '从零学习agent architecture的第一性原理', '从零学习agent architecture的第一性原理。Victor Dibia是微软首席研究员、AutoGen Studio作者，本书走first-principles路子：从零实现feature-complete的agent库。覆盖collaboration、observability、interruptibility等模式。', array['Agent 系统设计']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.manning.com/books/designing-multi-agent-systems'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-5fbd925c34102add', (select id from public.resources where normalized_title = 'designingmulti-agentsystems' and normalized_author = 'victordibia' limit 1), '《Designing Multi-Agent Systems》',
  'Victor Dibia', 'agent-and-intelligent-systems', '书籍', 'https://www.manning.com/books/designing-multi-agent-systems',
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['Agent 系统设计']::text[], array['【技术-应用】Agent系统设计与多智能体架构']::text[],
  '从零学习agent architecture的第一性原理。Victor Dibia是微软首席研究员、AutoGen Studio作者，本书走first-principles路子：从零实现feature-complete的agent库。覆盖collaboration、observability、interruptibility等模式。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'designingmulti-agentsystems' and normalized_author = 'victordibia' limit 1), 2, 2, 0.81008, 0.25744, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'designingmulti-agentsystems' and normalized_author = 'victordibia' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8a15b98cc485', 64, '《Building Agentic AI》', 'buildingagenticai',
  '书籍', 'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772', 'Sinan Ozdemir', 'sinanozdemir',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3, '书籍 · 【技术-应用】Agent系统设计与多智能体架构',
  '为企业环境优化agent workflows', '为企业环境优化agent workflows。Sinan Ozdemir带你超越基本chatbots，构建能产生可量化业务价值的autonomous agents。覆盖multimodal AI、quantization、speculative decoding等优化。', array['Agent 系统设计']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-2ec7d960a037213d', (select id from public.resources where normalized_title = 'buildingagenticai' and normalized_author = 'sinanozdemir' limit 1), '《Building Agentic AI》',
  'Sinan Ozdemir', 'agent-and-intelligent-systems', '书籍', 'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772',
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['Agent 系统设计']::text[], array['【技术-应用】Agent系统设计与多智能体架构']::text[],
  '为企业环境优化agent workflows。Sinan Ozdemir带你超越基本chatbots，构建能产生可量化业务价值的autonomous agents。覆盖multimodal AI、quantization、speculative decoding等优化。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'buildingagenticai' and normalized_author = 'sinanozdemir' limit 1), 2, 2, 0.78543, 0.47907, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'buildingagenticai' and normalized_author = 'sinanozdemir' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-fb501f649f5e', 65, '《Agentic AI Engineering》', 'agenticaiengineering',
  '书籍', 'https://argolong.com/agentic-engineering-book', 'Yi Zhou', 'yizhou',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测']::text[], 3, '书籍 · 【技术-应用】AI系统与Agent评估监测',
  '让agents扛住真实世界与合规审计', '让agents扛住真实世界与合规审计。Yi Zhou提出Agentic Stack、Agentic Maturity Ladder、Trust Envelope。你会为"运动中的信任"而工程化——让系统在不确定中推理、又能负责任地自适应。', array['AI 系统评估']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://argolong.com/agentic-engineering-book'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-f7f07c2fee12fa75', (select id from public.resources where normalized_title = 'agenticaiengineering' and normalized_author = 'yizhou' limit 1), '《Agentic AI Engineering》',
  'Yi Zhou', 'agent-and-intelligent-systems', '书籍', 'https://argolong.com/agentic-engineering-book',
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['AI 系统评估']::text[], array['【技术-应用】AI系统与Agent评估监测']::text[],
  '让agents扛住真实世界与合规审计。Yi Zhou提出Agentic Stack、Agentic Maturity Ladder、Trust Envelope。你会为"运动中的信任"而工程化——让系统在不确定中推理、又能负责任地自适应。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'agenticaiengineering' and normalized_author = 'yizhou' limit 1), 2, 2, 0.81216, 0.17115, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'agenticaiengineering' and normalized_author = 'yizhou' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-89073aeae05e', 66, '《LLMOps: Managing Large Language Models in Production》', 'llmopsmanaginglargelanguagemodelsinproduction',
  '书籍', 'https://www.oreilly.com/library/view/llmops/9781098154165/', 'Abi Aryan', 'abiaryan',
  'ai-engineering', array['【技术-平台】LLMOps平台设计与模型全生命周期管理']::text[], 3, '书籍 · 【技术-平台】LLMOps平台设计与模型全生命周期管理',
  '在真金白银场景下让LLM systems平稳运行', '在真金白银场景下让LLM systems平稳运行。Abi Aryan讲清新的LLMOps学科：如何处理prompt drift、如何运行automated regression tests。传统MLOps面对generative AI会"土崩瓦解"。', array['LLMOps']::text[],
  array['平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.oreilly.com/library/view/llmops/9781098154165/'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-a57e97865690cd42', (select id from public.resources where normalized_title = 'llmopsmanaginglargelanguagemodelsinproduction' and normalized_author = 'abiaryan' limit 1), '《LLMOps: Managing Large Language Models in Production》',
  'Abi Aryan', 'ai-engineering', '书籍', 'https://www.oreilly.com/library/view/llmops/9781098154165/',
  '张娜', false,
  array['平台工程师 / 架构师']::text[], array['LLMOps']::text[], array['【技术-平台】LLMOps平台设计与模型全生命周期管理']::text[],
  '在真金白银场景下让LLM systems平稳运行。Abi Aryan讲清新的LLMOps学科：如何处理prompt drift、如何运行automated regression tests。传统MLOps面对generative AI会"土崩瓦解"。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'llmopsmanaginglargelanguagemodelsinproduction' and normalized_author = 'abiaryan' limit 1), 0, 2, 0.54632, -0.77719, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'llmopsmanaginglargelanguagemodelsinproduction' and normalized_author = 'abiaryan' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-10f61300a5e8', 67, '《AI Systems Performance Engineering》', 'aisystemsperformanceengineering',
  '书籍', null, 'Chris Fregly', 'chrisfregly',
  'ai-engineering', array['【技术-平台】模型推理优化与加速（量化/推理服务）']::text[], 3, '书籍 · 【技术-平台】模型推理优化与加速（量化/推理服务）',
  '在hardware、software、algorithms三...', '在hardware、software、algorithms三层做硬核优化。Chris Fregly深入GPU memory management、CUDA kernels与基于PyTorch的算法。你会学会profile、诊断并清除复杂AI pipelines的performance bottlenecks。', array['模型推理优化']::text[],
  array['平台工程师 / 架构师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-0fbb441cb99cb0f3', (select id from public.resources where normalized_title = 'aisystemsperformanceengineering' and normalized_author = 'chrisfregly' limit 1), '《AI Systems Performance Engineering》',
  'Chris Fregly', 'ai-engineering', '书籍', null,
  '张娜', false,
  array['平台工程师 / 架构师']::text[], array['模型推理优化']::text[], array['【技术-平台】模型推理优化与加速（量化/推理服务）']::text[],
  '在hardware、software、algorithms三层做硬核优化。Chris Fregly深入GPU memory management、CUDA kernels与基于PyTorch的算法。你会学会profile、诊断并清除复杂AI pipelines的performance bottlenecks。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'aisystemsperformanceengineering' and normalized_author = 'chrisfregly' limit 1), 0, 2, 0.07637, -0.82146, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'aisystemsperformanceengineering' and normalized_author = 'chrisfregly' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-9c66de396750', 68, '《Generative AI Design Patterns》', 'generativeaidesignpatterns',
  '书籍', null, 'Valliappa Lakshmanan / Hannes Hapke', 'valliappalakshmanan/hanneshapke',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2, '书籍 · 【技术-应用】LLM应用技术选型与架构设计',
  '32个成熟的设计模式，直击你每天遇到的挑战：hallucin...', '32个成熟的设计模式，直击你每天遇到的挑战：hallucinations、nondeterministic responses、knowledge cutoffs。每个pattern都描述特定问题、给出带代码的验证解，并讨论取舍。你和团队会拥有共享词汇。', array['LLM 应用架构']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-fcf4011bba6e25ff', (select id from public.resources where normalized_title = 'generativeaidesignpatterns' and normalized_author = 'valliappalakshmanan/hanneshapke' limit 1), '《Generative AI Design Patterns》',
  'Valliappa Lakshmanan / Hannes Hapke', 'ai-engineering', '书籍', null,
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['LLM 应用架构']::text[], array['【技术-应用】LLM应用技术选型与架构设计']::text[],
  '32个成熟的设计模式，直击你每天遇到的挑战：hallucinations、nondeterministic responses、knowledge cutoffs。每个pattern都描述特定问题、给出带代码的验证解，并讨论取舍。你和团队会拥有共享词汇。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'generativeaidesignpatterns' and normalized_author = 'valliappalakshmanan/hanneshapke' limit 1), 0, 1, 0.10929, -0.51861, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'generativeaidesignpatterns' and normalized_author = 'valliappalakshmanan/hanneshapke' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-9009d830d2fc', 69, '《Mastering Retrieval-Augmented Generation》', 'masteringretrieval-augmentedgeneration',
  '书籍', null, 'Ranajoy Bose', 'ranajoybose',
  'data-intelligence-and-knowledge', array['【技术-数据】语义检索系统设计与RAG']::text[], 2, '书籍 · 【技术-数据】语义检索系统设计与RAG',
  '把RAG从周末原型扩到企业级生产系统', '把RAG从周末原型扩到企业级生产系统。Ranajoy Bose系统讲解document processing与vector optimization的成熟技巧，覆盖graph-based approaches与multi-modal systems等高级检索策略。你会学到如何fine-tune embedding models。', array['语义检索 / RAG']::text[],
  array['数据工程师 / 知识工程师']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-02bb8d430c66fcbc', (select id from public.resources where normalized_title = 'masteringretrieval-augmentedgeneration' and normalized_author = 'ranajoybose' limit 1), '《Mastering Retrieval-Augmented Generation》',
  'Ranajoy Bose', 'data-intelligence-and-knowledge', '书籍', null,
  '张娜', false,
  array['数据工程师 / 知识工程师']::text[], array['语义检索 / RAG']::text[], array['【技术-数据】语义检索系统设计与RAG']::text[],
  '把RAG从周末原型扩到企业级生产系统。Ranajoy Bose系统讲解document processing与vector optimization的成熟技巧，覆盖graph-based approaches与multi-modal systems等高级检索策略。你会学到如何fine-tune embedding models。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'masteringretrieval-augmentedgeneration' and normalized_author = 'ranajoybose' limit 1), 4, 1, -0.48167, 0.49406, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'masteringretrieval-augmentedgeneration' and normalized_author = 'ranajoybose' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-f1f335619d9a', 70, '《System Design For Large Language Models》', 'systemdesignforlargelanguagemodels',
  '书籍', null, 'Marc Rolland', 'marcrolland',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2, '书籍 · 【技术-应用】LLM应用技术选型与架构设计',
  '把prompts当成"严肃的系统边界"，而非"文案活儿"', '把prompts当成"严肃的系统边界"，而非"文案活儿"。Marc Rolland构建严谨的systems框架，汲取systems engineering、safety analysis、control theory的方法。你会打造让failure"可被观测"的observability mechanisms。', array['LLM 应用架构']::text[],
  array['AI 应用开发者 / 工程师']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-db947255c1bd7d03', (select id from public.resources where normalized_title = 'systemdesignforlargelanguagemodels' and normalized_author = 'marcrolland' limit 1), '《System Design For Large Language Models》',
  'Marc Rolland', 'ai-engineering', '书籍', null,
  '张娜', false,
  array['AI 应用开发者 / 工程师']::text[], array['LLM 应用架构']::text[], array['【技术-应用】LLM应用技术选型与架构设计']::text[],
  '把prompts当成"严肃的系统边界"，而非"文案活儿"。Marc Rolland构建严谨的systems框架，汲取systems engineering、safety analysis、control theory的方法。你会打造让failure"可被观测"的observability mechanisms。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'systemdesignforlargelanguagemodels' and normalized_author = 'marcrolland' limit 1), 0, 1, 0.38615, -0.51038, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'systemdesignforlargelanguagemodels' and normalized_author = 'marcrolland' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-0475a467c137', 71, 'Anthropic Official Blog', 'anthropicofficialblog',
  '文章/其他资料', 'https://claude.com/blog', 'Anthropic', 'anthropic',
  'ai-engineering', '{}'::text[], 2, '文章/其他资料 · ai-engineering',
  'Anthropic 作为全球领先的 AI 实验室，其官方博客...', 'Anthropic 作为全球领先的 AI 实验室，其官方博客是获取最新前沿资讯和企业级 AI 使用最佳实践的便捷渠道。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://claude.com/blog'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-e0805628e47dae5b', (select id from public.resources where normalized_title = 'anthropicofficialblog' and normalized_author = 'anthropic' limit 1), 'Anthropic Official Blog',
  'Anthropic', 'ai-engineering', '文章/其他资料', 'https://claude.com/blog',
  '李渊', false,
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['深度学习', '工程入门', 'Python', '神经网络']::text[], '{}'::text[],
  'Anthropic 作为全球领先的 AI 实验室，其官方博客是获取最新前沿资讯和企业级 AI 使用最佳实践的便捷渠道。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'anthropicofficialblog' and normalized_author = 'anthropic' limit 1), 0, 1, 0.06495, -0.50585, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'anthropicofficialblog' and normalized_author = 'anthropic' limit 1));

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'resource-8465f0613fa3', 72, 'tw93 撰写的系列文章', 'tw93撰写的系列文章',
  '文章/其他资料', 'https://tw93.fun/2026-03-21/agent.html', '来源待补充', '来源待补充',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1, '文章/其他资料 · 【全员通用】通用AI素养与AI Fluency 4D框架',
  'Tw93 写了三篇，一篇比一篇深：非技术人怎么上手 AI C...', 'Tw93 写了三篇，一篇比一篇深：非技术人怎么上手 AI Coding → Claude Code 怎么工程化地用 → Agent 原理和架构。实战踩坑多，不是那种空讲趋势的文章。', array['AI 通识']::text[],
  array['全员 / AI 初学者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://tw93.fun/2026-03-21/agent.html'
)
on conflict (normalized_title, normalized_author) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  summary = excluded.summary,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  'import-rec-83077d30f7be0bf7', (select id from public.resources where normalized_title = 'tw93撰写的系列文章' and normalized_author = '来源待补充' limit 1), 'tw93 撰写的系列文章',
  '来源待补充', 'ai-frontier-trends', '文章/其他资料', 'https://tw93.fun/2026-03-21/agent.html',
  'AI-Native 官方资料库', false,
  array['全员 / AI 初学者']::text[], array['AI 通识']::text[], array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[],
  'Tw93 写了三篇，一篇比一篇深：非技术人怎么上手 AI Coding → Claude Code 怎么工程化地用 → Agent 原理和架构。实战踩坑多，不是那种空讲趋势的文章。', 4, 'accepted', '来自初始化资料共建表',
  '2026-07-18T00:00:00+08:00'
)
on conflict (id) do update set
  resource_id = excluded.resource_id,
  title = excluded.title,
  author = excluded.author,
  domain = excluded.domain,
  resource_type = excluded.resource_type,
  url = excluded.url,
  recommender_name = excluded.recommender_name,
  fit_for_suggestions = excluded.fit_for_suggestions,
  prerequisite_suggestions = excluded.prerequisite_suggestions,
  ability_theme_suggestions = excluded.ability_theme_suggestions,
  reason = excluded.reason,
  score = excluded.score,
  status = excluded.status,
  message = excluded.message;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  (select id from public.resources where normalized_title = 'tw93撰写的系列文章' and normalized_author = '来源待补充' limit 1), 7, 0, -0.03471, -0.37339, true,
  4, 4, 21.00, 32.00, 0.280, 2.25, 0.860,
  400, 'none', '2026-07-18T00:00:00+08:00'
)
on conflict (resource_id) do update set
  sector_index = excluded.sector_index,
  ring_index = excluded.ring_index,
  x = excluded.x,
  y = excluded.y,
  radar_visible = excluded.radar_visible,
  radar_priority = excluded.radar_priority,
  visual_weight_score = excluded.visual_weight_score,
  point_radius = excluded.point_radius,
  halo_radius = excluded.halo_radius,
  halo_opacity = excluded.halo_opacity,
  stroke_width = excluded.stroke_width,
  fill_opacity = excluded.fill_opacity,
  z_index_priority = excluded.z_index_priority;

select public.refresh_resource_metrics((select id from public.resources where normalized_title = 'tw93撰写的系列文章' and normalized_author = '来源待补充' limit 1));

commit;
