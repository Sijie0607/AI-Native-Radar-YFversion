import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, '..');
const mockDataPath = path.join(repoRoot, 'src/mocks/mockData.ts');

const source = fs.readFileSync(mockDataPath, 'utf8');
const match = source.match(/const IMPORTED_BOOKS:[\s\S]*?=\s*(\[[\s\S]*?\n\]);/);

if (!match) {
  throw new Error('Cannot find IMPORTED_BOOKS in src/mocks/mockData.ts');
}

const importedBooks = Function(`"use strict"; return (${match[1]});`)();

const domainOrder = [
  'ai-engineering',
  'ai-product-design',
  'agent-and-intelligent-systems',
  'ai-organizational-transformation',
  'data-intelligence-and-knowledge',
  'ai-business-implementation',
  'ai-ethics-and-governance',
  'ai-frontier-trends',
];

const domainMetadata = {
  'ai-engineering': {
    fitFor: ['AI 初学者', '应用开发者', '技术产品经理'],
    takeaways: ['理解模型基础原理', '掌握工程入门路径', '建立 AI 技术认知'],
    tags: ['深度学习', '工程入门', 'Python', '神经网络'],
  },
  'ai-product-design': {
    fitFor: ['AI 产品经理', '产品设计师', '转型 PM'],
    takeaways: ['掌握 AI 产品设计方法', '理解技术协作边界', '建立落地判断框架'],
    tags: ['AI 产品', '产品设计', '方法论', '场景落地'],
  },
  'agent-and-intelligent-systems': {
    fitFor: ['AI 工程师', '智能体开发者', '系统架构师'],
    takeaways: ['理解智能体架构设计', '掌握多智能体协作思路', '建立任务决策认知'],
    tags: ['Agent', '智能体', '多智能体', '任务规划'],
  },
  'ai-organizational-transformation': {
    fitFor: ['业务管理者', '组织发展负责人', '转型项目负责人'],
    takeaways: ['理解组织转型关键机制', '建立 AI 时代组织认知', '掌握变革推进基本方法'],
    tags: ['组织变革', 'AI 转型', '管理升级', '变革管理'],
  },
  'data-intelligence-and-knowledge': {
    fitFor: ['算法工程师', '数据工程师', 'AI 应用开发者'],
    takeaways: ['理解知识组织基本方法', '掌握语义检索核心原理', '建立 RAG 设计认知'],
    tags: ['知识图谱', '语义检索', 'RAG', '数据智能'],
  },
  'ai-business-implementation': {
    fitFor: ['业务负责人', '解决方案顾问', '产品负责人'],
    takeaways: ['理解 AI 商业落地路径', '掌握价值评估基本框架', '建立场景推进判断'],
    tags: ['商业落地', '场景设计', '价值评估', '解决方案'],
  },
  'ai-ethics-and-governance': {
    fitFor: ['治理负责人', '风险合规人员', 'AI 项目负责人'],
    takeaways: ['理解 AI 治理关键议题', '掌握风险识别基本框架', '建立合规判断意识'],
    tags: ['AI 治理', '风险管理', '伦理', '合规'],
  },
  'ai-frontier-trends': {
    fitFor: ['AI 从业者', '技术研究者', '战略观察者'],
    takeaways: ['理解前沿方向演进脉络', '建立趋势判断框架', '拓展技术视野'],
    tags: ['前沿趋势', '技术演进', '行业观察', '趋势判断'],
  },
};

const sqlString = (value) => {
  if (value === undefined || value === null || value === '') return 'null';
  return `'${String(value).replace(/'/g, "''")}'`;
};

const sqlTextArray = (items) => {
  if (!items || items.length === 0) return "'{}'::text[]";
  return `array[${items.map(sqlString).join(', ')}]::text[]`;
};

const normalize = (value) =>
  String(value || '')
    .replace(/[《》"'“”‘’（）()【】\[\]：:，,。\.\s]+/g, '')
    .toLowerCase();

const mapThemeToDomain = (theme) => {
  if (theme.includes('Agent系统设计') || theme.includes('AgentOS') || theme.includes('Agent评估')) {
    return 'agent-and-intelligent-systems';
  }
  if (
    theme.includes('知识工程') ||
    theme.includes('语义检索') ||
    theme.includes('实时数据流') ||
    theme.includes('数据治理')
  ) {
    return 'data-intelligence-and-knowledge';
  }
  if (theme.includes('AI安全治理') || theme.includes('Governance') || theme.includes('质量验证')) {
    return 'ai-ethics-and-governance';
  }
  if (theme.includes('流程变革') || theme.includes('变革管理')) {
    return 'ai-organizational-transformation';
  }
  if (theme.includes('业务流程建模') || theme.includes('交付实施')) {
    return 'ai-business-implementation';
  }
  if (theme.includes('产品') || theme.includes('Vibe Coding')) {
    return 'ai-product-design';
  }
  if (theme.includes('AI Fluency') || theme.includes('通用AI素养')) {
    return 'ai-frontier-trends';
  }
  return 'ai-engineering';
};

const mapThemeToDifficulty = (theme) => {
  if (theme.includes('通用AI素养') || theme.includes('Prompt工程') || theme.includes('知识工程')) {
    return 1;
  }
  if (
    theme.includes('技术-平台') ||
    theme.includes('Agent系统设计') ||
    theme.includes('AgentOS') ||
    theme.includes('Agent评估')
  ) {
    return 3;
  }
  return 2;
};

const scoreFromDegree = (degree) => (degree.includes('⭐⭐⭐⭐') ? 4 : 3);

const buildReasonShort = (reason) => {
  if (reason.includes('官方推荐')) return 'AI-Native 官方资料库推荐';
  const normalizedReason = reason.replace(/。+/g, '。').trim();
  const firstSentence = normalizedReason.split('。')[0]?.trim() || normalizedReason;
  return firstSentence.length > 30 ? `${firstSentence.slice(0, 30)}...` : firstSentence;
};

const calculatePosition = (sectorIndex, ringIndex, slotIndex = 0) => {
  const baseAngle = ((sectorIndex + 0.5) * Math.PI * 2) / 8 - Math.PI / 2;
  const radii = [0.3, 0.6, 0.9];
  const baseRadius = radii[ringIndex] || 0.5;
  const angleOffsets = [0, -0.12, 0.12, -0.22, 0.22];
  const radiusOffsets = [0, -0.035, 0.035, -0.055, 0.055];
  const offsetIndex = slotIndex % angleOffsets.length;
  const angle = baseAngle + angleOffsets[offsetIndex];
  const radius = Math.max(0.18, Math.min(0.95, baseRadius + radiusOffsets[offsetIndex]));
  return {
    x: Math.cos(angle) * radius,
    y: Math.sin(angle) * radius,
  };
};

const slotCountMap = new Map();

const rows = importedBooks.map((seed, index) => {
  const primaryTheme = seed.themes[0] || '';
  const domain = mapThemeToDomain(primaryTheme);
  const difficultyLevel = mapThemeToDifficulty(primaryTheme);
  const ringIndex = difficultyLevel - 1;
  const sectorIndex = domainOrder.indexOf(domain);
  const key = `${sectorIndex}-${ringIndex}`;
  const slotIndex = slotCountMap.get(key) || 0;
  const position = calculatePosition(sectorIndex, ringIndex, slotIndex);
  const metadata = domainMetadata[domain];
  const score = scoreFromDegree(seed.degree);
  const recommenders = seed.recommenders.length > 0 ? seed.recommenders : ['AI-Native 官方资料库'];
  slotCountMap.set(key, slotIndex + 1);

  return {
    ...seed,
    id: `imported-${index + 1}`,
    displayNumber: index + 1,
    normalizedTitle: normalize(seed.title),
    normalizedAuthor: normalize(seed.author),
    domain,
    difficultyLevel,
    ringIndex,
    sectorIndex,
    x: position.x,
    y: position.y,
    reasonShort: buildReasonShort(seed.reason),
    score,
    recommenders,
    metadata,
  };
});

const lines = [
  '-- Generated from src/mocks/mockData.ts by scripts/export-supabase-seed.mjs',
  '-- Run after supabase/migrations/001_initial_schema.sql.',
  'begin;',
  '',
];

for (const row of rows) {
  lines.push(
    `insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  ${sqlString(row.id)}, ${row.displayNumber}, ${sqlString(row.title)}, ${sqlString(row.normalizedTitle)}, '书籍',
  ${sqlString(row.link)}, ${sqlString(row.author)}, ${sqlString(row.normalizedAuthor)},
  ${sqlString(row.domain)}, ${sqlTextArray(row.themes)}, ${row.difficultyLevel},
  ${sqlString(row.reasonShort)}, ${sqlString(row.reason)}, ${sqlTextArray(row.metadata.tags)},
  ${sqlTextArray(row.metadata.fitFor)}, ${sqlTextArray(row.metadata.takeaways)},
  'published', ${sqlString(row.link || '来源：AI-Native读书雷达资料共建表')}
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
  source_note = excluded.source_note;`,
    ''
  );

  row.recommenders.forEach((recommender, recommenderIndex) => {
    lines.push(
      `insert into public.recommendations (
  id, resource_id, title, author, domain, recommender_name, is_anonymous, reason, score, status, message, created_at
) values (
  ${sqlString(`import-rec-${(row.displayNumber - 1) * 10 + recommenderIndex}`)}, ${sqlString(row.id)}, ${sqlString(row.title)},
  ${sqlString(row.author)}, ${sqlString(row.domain)}, ${sqlString(recommender)}, false,
  ${sqlString(row.reason)}, ${row.score}, 'accepted', '来自初始化资料共建表', '2026-07-18T00:00:00+08:00'
)
on conflict (id) do nothing;`,
      ''
    );
  });

  const normalizedScore = Math.max(0, Math.min(1, (row.score - 3) / 2));
  const pointRadius = (16 + normalizedScore * 10).toFixed(2);
  const haloRadius = (26 + normalizedScore * 12).toFixed(2);
  const haloOpacity = (0.16 + normalizedScore * 0.24).toFixed(3);
  const strokeWidth = (1.5 + normalizedScore * 1.5).toFixed(2);
  const fillOpacity = (0.72 + normalizedScore * 0.28).toFixed(3);

  lines.push(
    `insert into public.radar_display_state (
  resource_id, sector_index, ring_index, x, y, radar_visible, radar_priority, visual_weight_score,
  point_radius, halo_radius, halo_opacity, stroke_width, fill_opacity, z_index_priority,
  update_type, first_appeared_at
) values (
  ${sqlString(row.id)}, ${row.sectorIndex}, ${row.ringIndex}, ${row.x.toFixed(5)}, ${row.y.toFixed(5)}, true,
  ${row.score}, ${row.score}, ${pointRadius}, ${haloRadius}, ${haloOpacity}, ${strokeWidth}, ${fillOpacity},
  ${Math.round(row.score * 100)}, 'none', '2026-07-18T00:00:00+08:00'
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
  z_index_priority = excluded.z_index_priority;`,
    '',
    `select public.refresh_resource_metrics(${sqlString(row.id)});`,
    ''
  );
}

lines.push('commit;', '');

process.stdout.write(lines.join('\n'));
