-- Generated from src/mocks/mockData.ts by scripts/export-supabase-seed.mjs
-- Run after supabase/migrations/001_initial_schema.sql.
begin;

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-1', 1, '《AI Engineering: Building Applications with Foundation Models》', 'aiengineeringbuildingapplicationswithfoundationmodels', '书籍',
  null, 'Chip Huyen', 'chiphuyen',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架', '【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)', '【技术-应用】LLM应用技术选型与架构设计', '【技术-平台】LLMOps平台设计与模型全生命周期管理', '【技术-平台】模型推理优化与加速（量化/推理服务）', '【FDE】AI应用生产部署与交付实施']::text[], 1,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['前沿趋势', '技术演进', '行业观察', '趋势判断']::text[],
  array['AI 从业者', '技术研究者', '战略观察者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-0', 'imported-1', '《AI Engineering: Building Applications with Foundation Models》',
  'Chip Huyen', 'ai-frontier-trends', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-1', 7, 0, -0.11481, -0.27716, true,
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

select public.refresh_resource_metrics('imported-1');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-2', 2, '《Designing Large Language Model Applications》', 'designinglargelanguagemodelapplications', '书籍',
  null, 'Suhas Pai', 'suhaspai',
  'ai-engineering', array['【全员通用】Prompt工程基础与进阶', '【技术-应用】LLM应用技术选型与架构设计']::text[], 1,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-10', 'imported-2', '《Designing Large Language Model Applications》',
  'Suhas Pai', 'ai-engineering', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-2', 0, 0, 0.11481, -0.27716, true,
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

select public.refresh_resource_metrics('imported-2');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-3', 3, '《Building a Second Brain》', 'buildingasecondbrain', '书籍',
  null, 'Tiago Forte', 'tiagoforte',
  'data-intelligence-and-knowledge', array['【全员通用】知识工程与Context管理']::text[], 1,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-20', 'imported-3', '《Building a Second Brain》',
  'Tiago Forte', 'data-intelligence-and-knowledge', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-3', 4, 0, -0.11481, 0.27716, true,
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

select public.refresh_resource_metrics('imported-3');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-4', 4, '《AI Agents in Action, Second Edition》', 'aiagentsinactionsecondedition', '书籍',
  null, 'Michael Lanham', 'michaellanham',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AgentOS平台搭建与Agent运行时']::text[], 3,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent', '智能体', '多智能体', '任务规划']::text[],
  array['AI 工程师', '智能体开发者', '系统架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-30', 'imported-4', '《AI Agents in Action, Second Edition》',
  'Michael Lanham', 'agent-and-intelligent-systems', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-4', 2, 2, 0.83149, 0.34442, true,
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

select public.refresh_resource_metrics('imported-4');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-5', 5, '《Evals for AI Engineers》', 'evalsforaiengineers', '书籍',
  null, '作者待补充', '作者待补充',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估']::text[], 3,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['Agent', '智能体', '多智能体', '任务规划']::text[],
  array['AI 工程师', '智能体开发者', '系统架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-40', 'imported-5', '《Evals for AI Engineers》',
  '作者待补充', 'agent-and-intelligent-systems', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-5', 2, 2, 0.83304, 0.23297, true,
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

select public.refresh_resource_metrics('imported-5');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-6', 6, '《A Simple Guide to Retrieval Augmented Generation》', 'asimpleguidetoretrievalaugmentedgeneration', '书籍',
  null, 'Abhinav Kimothi', 'abhinavkimothi',
  'data-intelligence-and-knowledge', array['【技术-数据】语义检索系统设计与RAG']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-50', 'imported-6', '《A Simple Guide to Retrieval Augmented Generation》',
  'Abhinav Kimothi', 'data-intelligence-and-knowledge', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-6', 4, 1, -0.22961, 0.55433, true,
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

select public.refresh_resource_metrics('imported-6');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-7', 7, '《Designing Data-Intensive Applications》', 'designingdata-intensiveapplications', '书籍',
  null, 'Martin Kleppmann', 'martinkleppmann',
  'data-intelligence-and-knowledge', array['【技术-数据】实时数据流与AI集成']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-60', 'imported-7', '《Designing Data-Intensive Applications》',
  'Martin Kleppmann', 'data-intelligence-and-knowledge', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-7', 4, 1, -0.15217, 0.54412, true,
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

select public.refresh_resource_metrics('imported-7');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-8', 8, '《DAMA-DMBOK: Data Management Body of Knowledge》', 'dama-dmbokdatamanagementbodyofknowledge', '书籍',
  null, 'DAMA International', 'damainternational',
  'data-intelligence-and-knowledge', array['【技术-数据】面向AI的数据治理']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-70', 'imported-8', '《DAMA-DMBOK: Data Management Body of Knowledge》',
  'DAMA International', 'data-intelligence-and-knowledge', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-8', 4, 1, -0.31149, 0.55335, true,
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

select public.refresh_resource_metrics('imported-8');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-9', 9, '《Site Reliability Engineering》', 'sitereliabilityengineering', '书籍',
  null, 'Betsy Beyer / Chris Jones / Jennifer Petoff / Niall Richard Murphy', 'betsybeyer/chrisjones/jenniferpetoff/niallrichardmurphy',
  'ai-engineering', array['【技术-平台】AI基础设施运维与可观测性（SRE for AI）']::text[], 3,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-80', 'imported-9', '《Site Reliability Engineering》',
  'Betsy Beyer / Chris Jones / Jennifer Petoff / Niall Richard Murphy', 'ai-engineering', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-9', 0, 2, 0.34442, -0.83149, true,
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

select public.refresh_resource_metrics('imported-9');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-10', 10, '《AI Risk Management Framework》', 'airiskmanagementframework', '书籍',
  null, 'NIST', 'nist',
  'ai-ethics-and-governance', array['【技术-平台】AI安全治理与AI Governance']::text[], 3,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 治理', '风险管理', '伦理', '合规']::text[],
  array['治理负责人', '风险合规人员', 'AI 项目负责人']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-90', 'imported-10', '《AI Risk Management Framework》',
  'NIST', 'ai-ethics-and-governance', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-10', 6, 2, -0.83149, -0.34442, true,
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

select public.refresh_resource_metrics('imported-10');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-11', 11, '《AI Product Management》', 'aiproductmanagement', '书籍',
  null, '作者待补充', '作者待补充',
  'ai-product-design', array['【产品】AI产品需求分析与场景探索', '【产品】AI产品设计与人机协作交互设计', '【产品】快速原型验证与Vibe Coding']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 产品', '产品设计', '方法论', '场景落地']::text[],
  array['AI 产品经理', '产品设计师', '转型 PM']::text[], array['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-100', 'imported-11', '《AI Product Management》',
  '作者待补充', 'ai-product-design', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-11', 1, 1, 0.55433, -0.22961, true,
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

select public.refresh_resource_metrics('imported-11');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-12', 12, '《People + AI Guidebook》', 'people+aiguidebook', '书籍',
  null, 'Google PAIR', 'googlepair',
  'ai-ethics-and-governance', array['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['AI 治理', '风险管理', '伦理', '合规']::text[],
  array['治理负责人', '风险合规人员', 'AI 项目负责人']::text[], array['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-110', 'imported-12', '《People + AI Guidebook》',
  'Google PAIR', 'ai-ethics-and-governance', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-12', 6, 1, -0.55433, -0.22961, true,
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

select public.refresh_resource_metrics('imported-12');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-13', 13, '《BPMN Method and Style》', 'bpmnmethodandstyle', '书籍',
  null, 'Bruce Silver', 'brucesilver',
  'ai-business-implementation', array['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['商业落地', '场景设计', '价值评估', '解决方案']::text[],
  array['业务负责人', '解决方案顾问', '产品负责人']::text[], array['理解 AI 商业落地路径', '掌握价值评估基本框架', '建立场景推进判断']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-120', 'imported-13', '《BPMN Method and Style》',
  'Bruce Silver', 'ai-business-implementation', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-13', 5, 1, -0.55433, 0.22961, true,
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

select public.refresh_resource_metrics('imported-13');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-14', 14, '《Leading Change》', 'leadingchange', '书籍',
  null, 'John P. Kotter', 'johnpkotter',
  'ai-organizational-transformation', array['【FDE】流程变革推动与变革管理']::text[], 2,
  'AI-Native 官方资料库推荐', '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', array['组织变革', 'AI 转型', '管理升级', '变革管理']::text[],
  array['业务管理者', '组织发展负责人', '转型项目负责人']::text[], array['理解组织转型关键机制', '建立 AI 时代组织认知', '掌握变革推进基本方法']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-130', 'imported-14', '《Leading Change》',
  'John P. Kotter', 'ai-organizational-transformation', 'AI-Native 官方资料库', false,
  '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-14', 3, 1, 0.22961, 0.55433, true,
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

select public.refresh_resource_metrics('imported-14');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-15', 15, '本体驱动的AI数据管理', '本体驱动的ai数据管理', '书籍',
  'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910', '作者待补充', '作者待补充',
  'data-intelligence-and-knowledge', array['【技术-数据】面向AI的数据治理']::text[], 2,
  'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理...', 'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理将是未来的主要方向之一', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', 'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-140', 'imported-15', '本体驱动的AI数据管理',
  '作者待补充', 'data-intelligence-and-knowledge', '张为普', false,
  'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理将是未来的主要方向之一', 3, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-15', 4, 1, -0.09365, 0.53689, true,
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

select public.refresh_resource_metrics('imported-15');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-16', 16, '《Hands-On Large Language Models》', 'hands-onlargelanguagemodels', '书籍',
  'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/', 'Jay Alammar / Maarten Grootendorst', 'jayalammar/maartengrootendorst',
  'ai-frontier-trends', array['【全员通用】通用AI素养与AI Fluency 4D框架']::text[], 1,
  '构建对transformers与embeddings如何处理...', '构建对transformers与embeddings如何处理文本的"可视直觉"。Jay Alammar以机器学习可视化指南闻名，本书把这种可视方法贯穿LLM全生命周期，把抽象数学讲得很"落地"。', array['前沿趋势', '技术演进', '行业观察', '趋势判断']::text[],
  array['AI 从业者', '技术研究者', '战略观察者']::text[], array['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野']::text[],
  'published', 'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-150', 'imported-16', '《Hands-On Large Language Models》',
  'Jay Alammar / Maarten Grootendorst', 'ai-frontier-trends', '张娜', false,
  '构建对transformers与embeddings如何处理文本的"可视直觉"。Jay Alammar以机器学习可视化指南闻名，本书把这种可视方法贯穿LLM全生命周期，把抽象数学讲得很"落地"。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-16', 7, 0, -0.12999, -0.23093, true,
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

select public.refresh_resource_metrics('imported-16');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-17', 17, '《LLM Engineer''s Handbook》', 'llmengineershandbook', '书籍',
  'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079', 'Paul Iusztin / Maxime Labonne', 'pauliusztin/maximelabonne',
  'ai-engineering', array['【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)']::text[], 2,
  '动手实现完整的数据与fine-tuning生命周期', '动手实现完整的数据与fine-tuning生命周期。手把手带你构建开源系统LLM Twin，从数据收集到模型部署的完整生命周期。你会学到SFT与preference alignment的实用差异，以及parameter-efficient fine-tuning。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-160', 'imported-17', '《LLM Engineer''s Handbook》',
  'Paul Iusztin / Maxime Labonne', 'ai-engineering', '张娜', false,
  '动手实现完整的数据与fine-tuning生命周期。手把手带你构建开源系统LLM Twin，从数据收集到模型部署的完整生命周期。你会学到SFT与preference alignment的实用差异，以及parameter-efficient fine-tuning。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-17', 0, 1, 0.22961, -0.55433, true,
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

select public.refresh_resource_metrics('imported-17');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-18', 18, '《Designing Multi-Agent Systems》', 'designingmulti-agentsystems', '书籍',
  'https://www.manning.com/books/designing-multi-agent-systems', 'Victor Dibia', 'victordibia',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3,
  '从零学习agent architecture的第一性原理', '从零学习agent architecture的第一性原理。Victor Dibia是微软首席研究员、AutoGen Studio作者，本书走first-principles路子：从零实现feature-complete的agent库。覆盖collaboration、observability、interruptibility等模式。', array['Agent', '智能体', '多智能体', '任务规划']::text[],
  array['AI 工程师', '智能体开发者', '系统架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.manning.com/books/designing-multi-agent-systems'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-170', 'imported-18', '《Designing Multi-Agent Systems》',
  'Victor Dibia', 'agent-and-intelligent-systems', '张娜', false,
  '从零学习agent architecture的第一性原理。Victor Dibia是微软首席研究员、AutoGen Studio作者，本书走first-principles路子：从零实现feature-complete的agent库。覆盖collaboration、observability、interruptibility等模式。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-18', 2, 2, 0.81478, 0.45865, true,
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

select public.refresh_resource_metrics('imported-18');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-19', 19, '《Building Agentic AI》', 'buildingagenticai', '书籍',
  'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772', 'Sinan Ozdemir', 'sinanozdemir',
  'agent-and-intelligent-systems', array['【技术-应用】Agent系统设计与多智能体架构']::text[], 3,
  '为企业环境优化agent workflows', '为企业环境优化agent workflows。Sinan Ozdemir带你超越基本chatbots，构建能产生可量化业务价值的autonomous agents。覆盖multimodal AI、quantization、speculative decoding等优化。', array['Agent', '智能体', '多智能体', '任务规划']::text[],
  array['AI 工程师', '智能体开发者', '系统架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-180', 'imported-19', '《Building Agentic AI》',
  'Sinan Ozdemir', 'agent-and-intelligent-systems', '张娜', false,
  '为企业环境优化agent workflows。Sinan Ozdemir带你超越基本chatbots，构建能产生可量化业务价值的autonomous agents。覆盖multimodal AI、quantization、speculative decoding等优化。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-19', 2, 2, 0.83243, 0.14521, true,
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

select public.refresh_resource_metrics('imported-19');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-20', 20, '《Agentic AI Engineering》', 'agenticaiengineering', '书籍',
  'https://argolong.com/agentic-engineering-book', 'Yi Zhou', 'yizhou',
  'agent-and-intelligent-systems', array['【技术-应用】AI系统与Agent评估监测']::text[], 3,
  '让agents扛住真实世界与合规审计', '让agents扛住真实世界与合规审计。Yi Zhou提出Agentic Stack、Agentic Maturity Ladder、Trust Envelope。你会为"运动中的信任"而工程化——让系统在不确定中推理、又能负责任地自适应。', array['Agent', '智能体', '多智能体', '任务规划']::text[],
  array['AI 工程师', '智能体开发者', '系统架构师']::text[], array['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知']::text[],
  'published', 'https://argolong.com/agentic-engineering-book'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-190', 'imported-20', '《Agentic AI Engineering》',
  'Yi Zhou', 'agent-and-intelligent-systems', '张娜', false,
  '让agents扛住真实世界与合规审计。Yi Zhou提出Agentic Stack、Agentic Maturity Ladder、Trust Envelope。你会为"运动中的信任"而工程化——让系统在不确定中推理、又能负责任地自适应。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-20', 2, 2, 0.77719, 0.54632, true,
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

select public.refresh_resource_metrics('imported-20');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-21', 21, '《LLMOps: Managing Large Language Models in Production》', 'llmopsmanaginglargelanguagemodelsinproduction', '书籍',
  'https://www.oreilly.com/library/view/llmops/9781098154165/', 'Abi Aryan', 'abiaryan',
  'ai-engineering', array['【技术-平台】LLMOps平台设计与模型全生命周期管理']::text[], 3,
  '在真金白银场景下让LLM systems平稳运行', '在真金白银场景下让LLM systems平稳运行。Abi Aryan讲清新的LLMOps学科：如何处理prompt drift、如何运行automated regression tests。传统MLOps面对generative AI会"土崩瓦解"。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', 'https://www.oreilly.com/library/view/llmops/9781098154165/'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-200', 'imported-21', '《LLMOps: Managing Large Language Models in Production》',
  'Abi Aryan', 'ai-engineering', '张娜', false,
  '在真金白银场景下让LLM systems平稳运行。Abi Aryan讲清新的LLMOps学科：如何处理prompt drift、如何运行automated regression tests。传统MLOps面对generative AI会"土崩瓦解"。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-21', 0, 2, 0.23297, -0.83304, true,
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

select public.refresh_resource_metrics('imported-21');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-22', 22, '《AI Systems Performance Engineering》', 'aisystemsperformanceengineering', '书籍',
  null, 'Chris Fregly', 'chrisfregly',
  'ai-engineering', array['【技术-平台】模型推理优化与加速（量化/推理服务）']::text[], 3,
  '在hardware、software、algorithms三...', '在hardware、software、algorithms三层做硬核优化。Chris Fregly深入GPU memory management、CUDA kernels与基于PyTorch的算法。你会学会profile、诊断并清除复杂AI pipelines的performance bottlenecks。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-210', 'imported-22', '《AI Systems Performance Engineering》',
  'Chris Fregly', 'ai-engineering', '张娜', false,
  '在hardware、software、algorithms三层做硬核优化。Chris Fregly深入GPU memory management、CUDA kernels与基于PyTorch的算法。你会学会profile、诊断并清除复杂AI pipelines的performance bottlenecks。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-22', 0, 2, 0.45865, -0.81478, true,
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

select public.refresh_resource_metrics('imported-22');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-23', 23, '《Generative AI Design Patterns》', 'generativeaidesignpatterns', '书籍',
  null, 'Valliappa Lakshmanan / Hannes Hapke', 'valliappalakshmanan/hanneshapke',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2,
  '32个成熟的设计模式，直击你每天遇到的挑战：hallucin...', '32个成熟的设计模式，直击你每天遇到的挑战：hallucinations、nondeterministic responses、knowledge cutoffs。每个pattern都描述特定问题、给出带代码的验证解，并讨论取舍。你和团队会拥有共享词汇。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-220', 'imported-23', '《Generative AI Design Patterns》',
  'Valliappa Lakshmanan / Hannes Hapke', 'ai-engineering', '张娜', false,
  '32个成熟的设计模式，直击你每天遇到的挑战：hallucinations、nondeterministic responses、knowledge cutoffs。每个pattern都描述特定问题、给出带代码的验证解，并讨论取舍。你和团队会拥有共享词汇。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-23', 0, 1, 0.15217, -0.54412, true,
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

select public.refresh_resource_metrics('imported-23');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-24', 24, '《Mastering Retrieval-Augmented Generation》', 'masteringretrieval-augmentedgeneration', '书籍',
  null, 'Ranajoy Bose', 'ranajoybose',
  'data-intelligence-and-knowledge', array['【技术-数据】语义检索系统设计与RAG']::text[], 2,
  '把RAG从周末原型扩到企业级生产系统', '把RAG从周末原型扩到企业级生产系统。Ranajoy Bose系统讲解document processing与vector optimization的成熟技巧，覆盖graph-based approaches与multi-modal systems等高级检索策略。你会学到如何fine-tune embedding models。', array['知识图谱', '语义检索', 'RAG', '数据智能']::text[],
  array['算法工程师', '数据工程师', 'AI 应用开发者']::text[], array['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-230', 'imported-24', '《Mastering Retrieval-Augmented Generation》',
  'Ranajoy Bose', 'data-intelligence-and-knowledge', '张娜', false,
  '把RAG从周末原型扩到企业级生产系统。Ranajoy Bose系统讲解document processing与vector optimization的成熟技巧，覆盖graph-based approaches与multi-modal systems等高级检索策略。你会学到如何fine-tune embedding models。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-24', 4, 1, -0.37668, 0.53585, true,
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

select public.refresh_resource_metrics('imported-24');

insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  'imported-25', 25, '《System Design For Large Language Models》', 'systemdesignforlargelanguagemodels', '书籍',
  null, 'Marc Rolland', 'marcrolland',
  'ai-engineering', array['【技术-应用】LLM应用技术选型与架构设计']::text[], 2,
  '把prompts当成"严肃的系统边界"，而非"文案活儿"', '把prompts当成"严肃的系统边界"，而非"文案活儿"。Marc Rolland构建严谨的systems框架，汲取systems engineering、safety analysis、control theory的方法。你会打造让failure"可被观测"的observability mechanisms。', array['深度学习', '工程入门', 'Python', '神经网络']::text[],
  array['AI 初学者', '应用开发者', '技术产品经理']::text[], array['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知']::text[],
  'published', '来源：AI-Native读书雷达资料共建表'
)
on conflict (id) do update set
  display_number = excluded.display_number,
  title = excluded.title,
  normalized_title = excluded.normalized_title,
  resource_type = excluded.resource_type,
  url = excluded.url,
  author = excluded.author,
  normalized_author = excluded.normalized_author,
  domain = excluded.domain,
  ability_themes = excluded.ability_themes,
  difficulty_level = excluded.difficulty_level,
  reason_short = excluded.reason_short,
  reason_full = excluded.reason_full,
  tags = excluded.tags,
  fit_for = excluded.fit_for,
  takeaways = excluded.takeaways,
  status = excluded.status,
  source_note = excluded.source_note;

insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  'import-rec-240', 'imported-25', '《System Design For Large Language Models》',
  'Marc Rolland', 'ai-engineering', '张娜', false,
  '把prompts当成"严肃的系统边界"，而非"文案活儿"。Marc Rolland构建严谨的systems框架，汲取systems engineering、safety analysis、control theory的方法。你会打造让failure"可被观测"的observability mechanisms。', 4, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;

insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  'imported-25', 0, 1, 0.31149, -0.55335, true,
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

select public.refresh_resource_metrics('imported-25');

commit;
