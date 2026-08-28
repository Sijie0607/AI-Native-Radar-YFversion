import crypto from 'node:crypto';
import { execFileSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, '..');
const mockDataPath = path.join(repoRoot, 'src/mocks/mockData.ts');
const excelDataPath = path.join(repoRoot, 'src/data/副本AI-Native读书雷达·资料共建.xlsx');

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

const audienceByPrefix = {
  '全员通用': '全员 / AI 初学者',
  '技术-应用': 'AI 应用开发者 / 工程师',
  '技术-数据': '数据工程师 / 知识工程师',
  '技术-平台': '平台工程师 / 架构师',
  '产品': 'AI 产品经理 / 产品设计师',
  '测试': '测试工程师 / 质量工程师',
  '项目管理': '项目经理 / PMO',
  'FDE': 'FDE / 解决方案 / 交付',
};

const prerequisiteOptions = [
  { label: 'AI 通识', sourceThemes: ['【全员通用】通用AI素养与AI Fluency 4D框架'] },
  { label: 'Prompt 工程', sourceThemes: ['【全员通用】Prompt工程基础与进阶'] },
  { label: '知识工程 / Context 管理', sourceThemes: ['【全员通用】知识工程与Context管理'] },
  { label: 'AI 辅助开发', sourceThemes: ['【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)'] },
  { label: 'LLM 应用架构', sourceThemes: ['【技术-应用】LLM应用技术选型与架构设计'] },
  { label: 'Agent 系统设计', sourceThemes: ['【技术-应用】Agent系统设计与多智能体架构'] },
  { label: 'AI 系统评估', sourceThemes: ['【技术-应用】AI系统与Agent评估监测'] },
  { label: '语义检索 / RAG', sourceThemes: ['【技术-数据】语义检索系统设计与RAG'] },
  { label: '实时数据流', sourceThemes: ['【技术-数据】实时数据流与AI集成'] },
  { label: 'AI 数据治理', sourceThemes: ['【技术-数据】面向AI的数据治理'] },
  { label: '业务知识建模 / 知识图谱', sourceThemes: ['【技术-数据】业务知识建模与知识图谱构建'] },
  { label: 'LLMOps', sourceThemes: ['【技术-平台】LLMOps平台设计与模型全生命周期管理'] },
  { label: 'AgentOS / 运行时', sourceThemes: ['【技术-平台】AgentOS平台搭建与Agent运行时'] },
  { label: '模型推理优化', sourceThemes: ['【技术-平台】模型推理优化与加速（量化/推理服务）'] },
  { label: 'AI 基础设施 / 可观测性', sourceThemes: ['【技术-平台】AI基础设施运维与可观测性（SRE for AI）'] },
  { label: 'AI 安全治理', sourceThemes: ['【技术-平台】AI安全治理与AI Governance'] },
  { label: 'AI 需求分析 / 场景探索', sourceThemes: ['【产品】AI产品需求分析与场景探索'] },
  { label: '人机协作交互', sourceThemes: ['【产品】AI产品设计与人机协作交互设计'] },
  { label: '快速原型 / Vibe Coding', sourceThemes: ['【产品】快速原型验证与Vibe Coding'] },
  { label: 'LLM / Agent 测试', sourceThemes: ['【测试】AI辅助测试工程与LLM/Agent测试评估'] },
  { label: '对抗测试 / 偏见检测', sourceThemes: ['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）'] },
  { label: '质量门禁 / 测试左移', sourceThemes: ['【测试】智能质量门禁与测试左移'] },
  { label: 'AI 项目管理', sourceThemes: ['【项目管理】AI辅助项目管理与项目管理数字化工具'] },
  { label: '项目组合管理 / 数据驱动决策', sourceThemes: ['【项目管理】AI项目组合管理与数据驱动决策'] },
  { label: '业务流程建模 / 业务本体', sourceThemes: ['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)'] },
  { label: '生产部署 / 交付实施', sourceThemes: ['【FDE】AI应用生产部署与交付实施'] },
  { label: '流程变革 / 变革管理', sourceThemes: ['【FDE】流程变革推动与变革管理'] },
];

const cleanText = (value) => String(value || '').replace(/\s+/g, ' ').trim();

const sourceThemeToPrerequisite = new Map(
  prerequisiteOptions.flatMap((option) => option.sourceThemes.map((theme) => [cleanText(theme), option.label])),
);

const providerHints = [
  ['Anthropic', /anthropic/i],
  ['DeepLearning.AI', /deeplearning\.ai/i],
  ['OpenAI', /openai/i],
  ['Coursera', /coursera/i],
  ['Skilljar', /skilljar/i],
  ['GitHub', /github/i],
  ['Notion', /notion/i],
  ['Obsidian', /obsidian/i],
  ['Hugging Face', /hugging\s*face/i],
  ['LangChain', /langchain/i],
  ['LlamaIndex', /llamaindex/i],
  ['Microsoft', /microsoft|azure/i],
  ['Google', /google/i],
  ['AWS', /\baws\b|amazon/i],
  ['Databricks', /databricks/i],
  ['Snowflake', /snowflake/i],
  ['Neo4j', /neo4j/i],
  ['Apache', /apache|kafka|flink/i],
  ["O'Reilly", /o'?reilly/i],
  ['Manning', /manning/i],
  ['Maven', /maven/i],
  ['arXiv', /arxiv/i],
];

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

const unique = (items) => {
  const seen = new Set();
  const result = [];

  for (const item of items) {
    const normalizedItem = cleanText(item);
    if (!normalizedItem || seen.has(normalizedItem)) continue;
    seen.add(normalizedItem);
    result.push(normalizedItem);
  }

  return result;
};

const hash = (value, length = 12) =>
  crypto.createHash('sha1').update(String(value)).digest('hex').slice(0, length);

const readMockBooks = () => {
  if (!fs.existsSync(mockDataPath)) return [];

  const source = fs.readFileSync(mockDataPath, 'utf8');
  const match = source.match(/const IMPORTED_BOOKS:[\s\S]*?=\s*(\[[\s\S]*?\n\]);/);
  if (!match) return [];

  return Function(`"use strict"; return (${match[1]});`)();
};

const readExcelRows = () => {
  if (!fs.existsSync(excelDataPath)) {
    throw new Error(`Cannot find source Excel file: ${excelDataPath}`);
  }

  const pythonScript = String.raw`
import json
import re
import sys
from openpyxl import load_workbook

path = sys.argv[1]
workbook = load_workbook(path, read_only=True, data_only=True)
worksheet = workbook['推荐资料库']

headers = [cell.value for cell in next(worksheet.iter_rows(min_row=1, max_row=1))]
index = {header: i for i, header in enumerate(headers)}
required_headers = ['资料名称', '资料类型', '资料链接', '能力主题', '推荐程度', '推荐理由', '推荐人']

for header in required_headers:
    if header not in index:
        raise ValueError(f'Missing Excel header: {header}')

def clean(value):
    if value is None:
        return ''
    return ' '.join(str(value).split()).strip()

def split_themes(value):
    raw = '' if value is None else str(value)
    matches = re.findall(r'【[^】]+】[^【]+', raw)
    parts = matches if matches else re.split(r'[\n;；]+', raw)
    return [clean(part).strip(' ,，;；') for part in parts if clean(part).strip(' ,，;；')]

def split_people(value):
    raw = '' if value is None else str(value)
    return [clean(part) for part in re.split(r'[\n,，;；、]+', raw) if clean(part)]

rows = []
for row in worksheet.iter_rows(min_row=2, values_only=True):
    if not any(row):
        continue

    title = clean(row[index['资料名称']])
    if not title:
        continue

    rows.append({
        'title': title,
        'resourceType': clean(row[index['资料类型']]) or '书籍',
        'link': clean(row[index['资料链接']]),
        'themes': split_themes(row[index['能力主题']]),
        'degree': clean(row[index['推荐程度']]),
        'reason': clean(row[index['推荐理由']]) or '来自 AI-Native 读书雷达资料共建表',
        'recommenders': split_people(row[index['推荐人']]),
    })

print(json.dumps(rows, ensure_ascii=False))
`;

  const stdout = execFileSync('python3', ['-c', pythonScript, excelDataPath], {
    encoding: 'utf8',
    maxBuffer: 10 * 1024 * 1024,
  });

  return JSON.parse(stdout);
};

const mockBooks = readMockBooks();
const authorByTitle = new Map(
  mockBooks
    .filter((book) => book.author && book.author !== '作者待补充')
    .map((book) => [normalize(book.title), book.author]),
);

const inferAuthorOrSource = (row) => {
  const mockedAuthor = authorByTitle.get(normalize(row.title));
  if (mockedAuthor) return mockedAuthor;

  const searchable = `${row.title} ${row.link}`;
  const provider = providerHints.find(([, pattern]) => pattern.test(searchable));
  if (provider) return provider[0];

  return row.resourceType === '书籍' ? '作者待补充' : '来源待补充';
};

const getThemePrefix = (theme) => {
  const match = cleanText(theme).match(/^【([^】]+)】/);
  return match?.[1] || '';
};

const stripThemePrefix = (theme) => cleanText(theme).replace(/^【[^】]+】/, '').trim();

const deriveFitFor = (themes, domain) => {
  const fromThemes = themes.map(getThemePrefix).map((prefix) => audienceByPrefix[prefix]).filter(Boolean);
  return unique(fromThemes.length > 0 ? fromThemes : domainMetadata[domain].fitFor);
};

const derivePrerequisites = (themes, domain) => {
  const labels = themes
    .map((theme) => sourceThemeToPrerequisite.get(cleanText(theme)) || stripThemePrefix(theme))
    .filter(Boolean);
  return unique(labels.length > 0 ? labels : domainMetadata[domain].tags);
};

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

const scoreFromDegree = (degree) => {
  const raw = cleanText(degree);
  const starCount = raw.match(/⭐/g)?.length ?? 0;
  if (starCount > 0) return Math.max(3, Math.min(5, starCount));

  const numericScore = Number(raw);
  if (Number.isFinite(numericScore)) return Math.max(3, Math.min(5, numericScore));

  return 3;
};

const buildReasonShort = (reason) => {
  if (!reason) return '来自 AI-Native 读书雷达资料共建表';
  if (reason.includes('官方推荐')) return 'AI-Native 官方资料库推荐';
  const normalizedReason = reason.replace(/。+/g, '。').trim();
  const firstSentence = normalizedReason.split('。')[0]?.trim() || normalizedReason;
  return firstSentence.length > 30 ? `${firstSentence.slice(0, 30)}...` : firstSentence;
};

const choosePrimaryReason = (reasons) => {
  const normalizedReasons = unique(reasons);
  return (
    normalizedReasons.find((reason) => !reason.includes('官方推荐')) ||
    normalizedReasons[0] ||
    '来自 AI-Native 读书雷达资料共建表'
  );
};

const calculatePosition = (sectorIndex, ringIndex, slotIndex = 0) => {
  const baseAngle = ((sectorIndex + 0.5) * Math.PI * 2) / 8 - Math.PI / 2;
  const radii = [0.3, 0.6, 0.9];
  const baseRadius = radii[ringIndex] || 0.5;
  const angleOffsets = [0, -0.12, 0.12, -0.22, 0.22, -0.3, 0.3, -0.38, 0.38];
  const radiusOffsets = [0, -0.035, 0.035, -0.055, 0.055, -0.075, 0.075, -0.09, 0.09];
  const offsetIndex = slotIndex % angleOffsets.length;
  const lapIndex = Math.floor(slotIndex / angleOffsets.length);
  const angle = baseAngle + angleOffsets[offsetIndex] + lapIndex * 0.035;
  const radius = Math.max(0.18, Math.min(0.95, baseRadius + radiusOffsets[offsetIndex] - lapIndex * 0.015));
  return {
    x: Math.cos(angle) * radius,
    y: Math.sin(angle) * radius,
  };
};

const getResourceKey = (row) => normalize(row.title);

const excelRows = readExcelRows();
const groupedRows = new Map();

for (const row of excelRows) {
  const normalizedRow = {
    ...row,
    title: cleanText(row.title),
    resourceType: cleanText(row.resourceType) || '书籍',
    link: cleanText(row.link),
    themes: unique(row.themes),
    degree: cleanText(row.degree),
    reason: cleanText(row.reason) || '来自 AI-Native 读书雷达资料共建表',
    recommenders: unique(row.recommenders),
    author: inferAuthorOrSource(row),
  };
  const key = getResourceKey(normalizedRow);

  if (!groupedRows.has(key)) {
    groupedRows.set(key, {
      sourceRows: [],
      title: normalizedRow.title,
      author: normalizedRow.author,
      normalizedTitle: normalize(normalizedRow.title),
      normalizedAuthor: normalize(normalizedRow.author),
      resourceTypes: [],
      links: [],
      themes: [],
      degrees: [],
      reasons: [],
      recommendationSeeds: [],
    });
  }

  const group = groupedRows.get(key);
  group.sourceRows.push(normalizedRow);
  group.resourceTypes.push(normalizedRow.resourceType);
  group.links.push(normalizedRow.link);
  group.themes.push(...normalizedRow.themes);
  group.degrees.push(normalizedRow.degree);
  group.reasons.push(normalizedRow.reason);

  const recommenders =
    normalizedRow.recommenders.length > 0 ? normalizedRow.recommenders : ['AI-Native 官方资料库'];

  for (const recommender of recommenders) {
    group.recommendationSeeds.push({
      recommender,
      reason: normalizedRow.reason,
      score: scoreFromDegree(normalizedRow.degree),
    });
  }
}

const slotCountMap = new Map();

const rows = [...groupedRows.values()].map((group, index) => {
  const themes = unique(group.themes);
  const primaryTheme = themes[0] || '';
  const domain = mapThemeToDomain(primaryTheme);
  const difficultyLevel = mapThemeToDifficulty(primaryTheme);
  const ringIndex = difficultyLevel - 1;
  const sectorIndex = Math.max(0, domainOrder.indexOf(domain));
  const key = `${sectorIndex}-${ringIndex}`;
  const slotIndex = slotCountMap.get(key) || 0;
  const position = calculatePosition(sectorIndex, ringIndex, slotIndex);
  const metadata = domainMetadata[domain];
  const score = Math.max(...group.degrees.map(scoreFromDegree), 3);
  const reason = choosePrimaryReason(group.reasons);
  const resourceType = unique(group.resourceTypes)[0] || '书籍';
  const link = unique(group.links)[0] || '';
  const fitFor = deriveFitFor(themes, domain);
  const prerequisites = derivePrerequisites(themes, domain);
  const recommendations = [];
  const recommendationKeys = new Set();

  for (const seed of group.recommendationSeeds) {
    const recommendationKey = `${normalize(seed.recommender)}|${normalize(seed.reason)}|${seed.score}`;
    if (recommendationKeys.has(recommendationKey)) continue;
    recommendationKeys.add(recommendationKey);
    recommendations.push(seed);
  }

  slotCountMap.set(key, slotIndex + 1);

  return {
    id: `resource-${hash(`${group.normalizedTitle}|${group.normalizedAuthor}`)}`,
    displayNumber: index + 1,
    title: group.title,
    author: group.author,
    normalizedTitle: group.normalizedTitle,
    normalizedAuthor: group.normalizedAuthor,
    resourceType,
    link,
    domain,
    difficultyLevel,
    ringIndex,
    sectorIndex,
    x: position.x,
    y: position.y,
    reasonShort: buildReasonShort(reason),
    reason,
    summary: `${resourceType} · ${primaryTheme || domain}`,
    score,
    recommendations,
    fitFor,
    takeaways: metadata.takeaways,
    tags: prerequisites.length > 0 ? prerequisites : metadata.tags,
    themes,
  };
});

const resourceIdRef = (row) =>
  `(select id from public.resources where normalized_title = ${sqlString(row.normalizedTitle)} and normalized_author = ${sqlString(row.normalizedAuthor)} limit 1)`;

const lines = [
  '-- Generated from src/data/副本AI-Native读书雷达·资料共建.xlsx by scripts/export-supabase-seed.mjs',
  '-- Run after supabase/migrations/001_initial_schema.sql through 005_recommendation_resource_curation_fields.sql.',
  `-- Excel rows: ${excelRows.length}; unique resources: ${rows.length}.`,
  'begin;',
  '',
  "delete from public.recommendations where id like 'import-rec-%' and message = '来自初始化资料共建表';",
  '',
];

for (const row of rows) {
  lines.push(
    `insert into public.resources (
  id, display_number, title, normalized_title, resource_type, url, author, normalized_author,
  domain, ability_themes, difficulty_level, summary, reason_short, reason_full, tags, fit_for, takeaways,
  status, source_note
) values (
  ${sqlString(row.id)}, ${row.displayNumber}, ${sqlString(row.title)}, ${sqlString(row.normalizedTitle)},
  ${sqlString(row.resourceType)}, ${sqlString(row.link)}, ${sqlString(row.author)}, ${sqlString(row.normalizedAuthor)},
  ${sqlString(row.domain)}, ${sqlTextArray(row.themes)}, ${row.difficultyLevel}, ${sqlString(row.summary)},
  ${sqlString(row.reasonShort)}, ${sqlString(row.reason)}, ${sqlTextArray(row.tags)},
  ${sqlTextArray(row.fitFor)}, ${sqlTextArray(row.takeaways)},
  'published', ${sqlString(row.link || '来源：AI-Native读书雷达资料共建表')}
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
  source_note = excluded.source_note;`,
    '',
  );

  row.recommendations.forEach((recommendation, recommendationIndex) => {
    const recommendationId = `import-rec-${hash(
      `${row.normalizedTitle}|${row.normalizedAuthor}|${recommendation.recommender}|${recommendation.reason}|${recommendationIndex}`,
      16,
    )}`;

    lines.push(
      `insert into public.recommendations (
  id, resource_id, title, author, domain, resource_type, url, recommender_name, is_anonymous,
  fit_for_suggestions, prerequisite_suggestions, ability_theme_suggestions,
  reason, score, status, message, created_at
) values (
  ${sqlString(recommendationId)}, ${resourceIdRef(row)}, ${sqlString(row.title)},
  ${sqlString(row.author)}, ${sqlString(row.domain)}, ${sqlString(row.resourceType)}, ${sqlString(row.link)},
  ${sqlString(recommendation.recommender)}, false,
  ${sqlTextArray(row.fitFor)}, ${sqlTextArray(row.tags)}, ${sqlTextArray(row.themes)},
  ${sqlString(recommendation.reason)}, ${recommendation.score}, 'accepted', '来自初始化资料共建表',
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
  message = excluded.message;`,
      '',
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
  ${resourceIdRef(row)}, ${row.sectorIndex}, ${row.ringIndex}, ${row.x.toFixed(5)}, ${row.y.toFixed(5)}, true,
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
    `select public.refresh_resource_metrics(${resourceIdRef(row)});`,
    '',
  );
}

lines.push('commit;', '');

process.stdout.write(lines.join('\n'));
