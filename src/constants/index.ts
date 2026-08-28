import { Domain, DomainConfig, DifficultyConfig } from '../types';

interface DomainColorToken {
  base: string;
  sector: string;
  sectorHover: string;
  tagBg: string;
  tagBorder: string;
  text: string;
  labelMuted: string;
  dotLight: string;
  dotDark: string;
}

// Arco 参考色衍生的纸感领域色：大面积低透明，标签与书籍点使用更实色。
export const DOMAIN_COLOR_TOKENS: Record<Domain, DomainColorToken> = {
  'ai-engineering': {
    base: '#2F7ED8',
    sector: 'rgba(23, 78, 166, 0.09)',
    sectorHover: 'rgba(23, 78, 166, 0.17)',
    tagBg: 'rgba(47, 126, 216, 0.14)',
    tagBorder: 'rgba(47, 126, 216, 0.34)',
    text: '#174EA6',
    labelMuted: '#5F7690',
    dotLight: '#6BAAF0',
    dotDark: '#174EA6',
  },
  'ai-product-design': {
    base: '#7B49C8',
    sector: 'rgba(91, 45, 163, 0.09)',
    sectorHover: 'rgba(91, 45, 163, 0.17)',
    tagBg: 'rgba(123, 73, 200, 0.14)',
    tagBorder: 'rgba(123, 73, 200, 0.34)',
    text: '#5B2DA3',
    labelMuted: '#746284',
    dotLight: '#A075D8',
    dotDark: '#5B2DA3',
  },
  'agent-and-intelligent-systems': {
    base: '#119A9B',
    sector: 'rgba(8, 127, 140, 0.09)',
    sectorHover: 'rgba(8, 127, 140, 0.17)',
    tagBg: 'rgba(17, 154, 155, 0.14)',
    tagBorder: 'rgba(17, 154, 155, 0.34)',
    text: '#087F8C',
    labelMuted: '#5B8383',
    dotLight: '#54BFC0',
    dotDark: '#087F8C',
  },
  'ai-organizational-transformation': {
    base: '#C4661E',
    sector: 'rgba(154, 58, 8, 0.09)',
    sectorHover: 'rgba(154, 58, 8, 0.17)',
    tagBg: 'rgba(196, 102, 30, 0.14)',
    tagBorder: 'rgba(196, 102, 30, 0.34)',
    text: '#9A3A08',
    labelMuted: '#8E6B4F',
    dotLight: '#DD8D4B',
    dotDark: '#9A3A08',
  },
  'data-intelligence-and-knowledge': {
    base: '#2F8A4B',
    sector: 'rgba(30, 106, 56, 0.09)',
    sectorHover: 'rgba(30, 106, 56, 0.17)',
    tagBg: 'rgba(47, 138, 75, 0.14)',
    tagBorder: 'rgba(47, 138, 75, 0.34)',
    text: '#1E6A38',
    labelMuted: '#687F57',
    dotLight: '#66A86F',
    dotDark: '#1E6A38',
  },
  'ai-business-implementation': {
    base: '#A87322',
    sector: 'rgba(119, 74, 16, 0.09)',
    sectorHover: 'rgba(119, 74, 16, 0.17)',
    tagBg: 'rgba(168, 115, 34, 0.14)',
    tagBorder: 'rgba(168, 115, 34, 0.34)',
    text: '#774A10',
    labelMuted: '#8A7650',
    dotLight: '#C9944A',
    dotDark: '#774A10',
  },
  'ai-ethics-and-governance': {
    base: '#B63A42',
    sector: 'rgba(142, 30, 46, 0.09)',
    sectorHover: 'rgba(142, 30, 46, 0.17)',
    tagBg: 'rgba(182, 58, 66, 0.14)',
    tagBorder: 'rgba(182, 58, 66, 0.34)',
    text: '#8E1E2E',
    labelMuted: '#8B5C61',
    dotLight: '#D06A6A',
    dotDark: '#8E1E2E',
  },
  'ai-frontier-trends': {
    base: '#8E5B2A',
    sector: 'rgba(95, 53, 23, 0.09)',
    sectorHover: 'rgba(95, 53, 23, 0.17)',
    tagBg: 'rgba(142, 91, 42, 0.14)',
    tagBorder: 'rgba(142, 91, 42, 0.34)',
    text: '#5F3517',
    labelMuted: '#7D6A58',
    dotLight: '#B07A43',
    dotDark: '#5F3517',
  },
};

// 领域配置
export const DOMAINS: DomainConfig[] = [
  {
    id: 'ai-engineering',
    name: 'AI 工程',
    color: DOMAIN_COLOR_TOKENS['ai-engineering'].base,
    description: 'AI 系统开发与工程实践',
  },
  {
    id: 'ai-product-design',
    name: 'AI 产品设计',
    color: DOMAIN_COLOR_TOKENS['ai-product-design'].base,
    description: 'AI 产品设计与方法论',
  },
  {
    id: 'agent-and-intelligent-systems',
    name: 'Agent 与智能体',
    color: DOMAIN_COLOR_TOKENS['agent-and-intelligent-systems'].base,
    description: '智能体系统设计与多智能体架构',
  },
  {
    id: 'ai-organizational-transformation',
    name: 'AI 组织变革',
    color: DOMAIN_COLOR_TOKENS['ai-organizational-transformation'].base,
    description: '组织 AI 转型与变革管理',
  },
  {
    id: 'data-intelligence-and-knowledge',
    name: '数据智能与知识',
    color: DOMAIN_COLOR_TOKENS['data-intelligence-and-knowledge'].base,
    description: '数据治理与知识图谱构建',
  },
  {
    id: 'ai-business-implementation',
    name: 'AI 商业落地',
    color: DOMAIN_COLOR_TOKENS['ai-business-implementation'].base,
    description: 'AI 商业应用与落地实践',
  },
  {
    id: 'ai-ethics-and-governance',
    name: 'AI 伦理治理',
    color: DOMAIN_COLOR_TOKENS['ai-ethics-and-governance'].base,
    description: 'AI 安全治理与伦理规范',
  },
  {
    id: 'ai-frontier-trends',
    name: 'AI 前沿趋势',
    color: DOMAIN_COLOR_TOKENS['ai-frontier-trends'].base,
    description: 'AI 前沿技术与趋势',
  },
];

export const getDomainConfig = (domain: Domain): DomainConfig =>
  DOMAINS.find(d => d.id === domain) || DOMAINS[0];

// 领域标签
export const DOMAIN_LABELS: Record<Domain, string> = Object.fromEntries(
  DOMAINS.map(d => [d.id, d.name])
) as Record<Domain, string>;

// 领域颜色
export const DOMAIN_COLORS: Record<Domain, string> = Object.fromEntries(
  DOMAINS.map(d => [d.id, d.color])
) as Record<Domain, string>;

export const getDomainColorToken = (domain: Domain): DomainColorToken =>
  DOMAIN_COLOR_TOKENS[domain] ?? DOMAIN_COLOR_TOKENS['ai-engineering'];

// 难度配置
export const DIFFICULTIES: DifficultyConfig[] = [
  {
    level: 1,
    name: '入门认知',
    description: '适合 AI 初学者',
    radius: 0.3,
  },
  {
    level: 2,
    name: '方法实践',
    description: '适合有一定基础的从业者',
    radius: 0.6,
  },
  {
    level: 3,
    name: '深度进阶',
    description: '适合资深从业者深入研究',
    radius: 0.9,
  },
];

export const RESOURCE_TYPE_OPTIONS = ['书籍', '在线课程/官方文档', '文章/其他资料'];

interface RecommendationAudienceOption {
  label: string;
  sourcePrefixes: string[];
}

interface RecommendationPrerequisiteOption {
  label: string;
  audiences: string[];
  sourceThemes: string[];
}

export const RECOMMENDATION_AUDIENCE_OPTIONS: RecommendationAudienceOption[] = [
  {
    label: '全员 / AI 初学者',
    sourcePrefixes: ['全员通用'],
  },
  {
    label: 'AI 应用开发者 / 工程师',
    sourcePrefixes: ['技术-应用'],
  },
  {
    label: '数据工程师 / 知识工程师',
    sourcePrefixes: ['技术-数据'],
  },
  {
    label: '平台工程师 / 架构师',
    sourcePrefixes: ['技术-平台'],
  },
  {
    label: 'AI 产品经理 / 产品设计师',
    sourcePrefixes: ['产品'],
  },
  {
    label: '测试工程师 / 质量工程师',
    sourcePrefixes: ['测试'],
  },
  {
    label: '项目经理 / PMO',
    sourcePrefixes: ['项目管理'],
  },
  {
    label: 'FDE / 解决方案 / 交付',
    sourcePrefixes: ['FDE'],
  },
];

export const DEFAULT_RECOMMENDATION_AUDIENCE = '全员 / AI 初学者';

export const RECOMMENDATION_PREREQUISITE_OPTIONS: RecommendationPrerequisiteOption[] = [
  {
    label: 'AI 通识',
    audiences: ['全员 / AI 初学者'],
    sourceThemes: ['【全员通用】通用AI素养与AI Fluency 4D框架'],
  },
  {
    label: 'Prompt 工程',
    audiences: ['全员 / AI 初学者'],
    sourceThemes: ['【全员通用】Prompt工程基础与进阶'],
  },
  {
    label: '知识工程 / Context 管理',
    audiences: ['全员 / AI 初学者'],
    sourceThemes: ['【全员通用】知识工程与Context管理'],
  },
  {
    label: 'AI 辅助开发',
    audiences: ['AI 应用开发者 / 工程师'],
    sourceThemes: ['【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)'],
  },
  {
    label: 'LLM 应用架构',
    audiences: ['AI 应用开发者 / 工程师'],
    sourceThemes: ['【技术-应用】LLM应用技术选型与架构设计'],
  },
  {
    label: 'Agent 系统设计',
    audiences: ['AI 应用开发者 / 工程师'],
    sourceThemes: ['【技术-应用】Agent系统设计与多智能体架构'],
  },
  {
    label: 'AI 系统评估',
    audiences: ['AI 应用开发者 / 工程师'],
    sourceThemes: ['【技术-应用】AI系统与Agent评估监测'],
  },
  {
    label: '语义检索 / RAG',
    audiences: ['数据工程师 / 知识工程师'],
    sourceThemes: ['【技术-数据】语义检索系统设计与RAG'],
  },
  {
    label: '实时数据流',
    audiences: ['数据工程师 / 知识工程师'],
    sourceThemes: ['【技术-数据】实时数据流与AI集成'],
  },
  {
    label: 'AI 数据治理',
    audiences: ['数据工程师 / 知识工程师'],
    sourceThemes: ['【技术-数据】面向AI的数据治理'],
  },
  {
    label: '业务知识建模 / 知识图谱',
    audiences: ['数据工程师 / 知识工程师', 'FDE / 解决方案 / 交付'],
    sourceThemes: ['【技术-数据】业务知识建模与知识图谱构建'],
  },
  {
    label: 'LLMOps',
    audiences: ['平台工程师 / 架构师'],
    sourceThemes: ['【技术-平台】LLMOps平台设计与模型全生命周期管理'],
  },
  {
    label: 'AgentOS / 运行时',
    audiences: ['平台工程师 / 架构师'],
    sourceThemes: ['【技术-平台】AgentOS平台搭建与Agent运行时'],
  },
  {
    label: '模型推理优化',
    audiences: ['平台工程师 / 架构师'],
    sourceThemes: ['【技术-平台】模型推理优化与加速（量化/推理服务）'],
  },
  {
    label: 'AI 基础设施 / 可观测性',
    audiences: ['平台工程师 / 架构师'],
    sourceThemes: ['【技术-平台】AI基础设施运维与可观测性（SRE for AI）'],
  },
  {
    label: 'AI 安全治理',
    audiences: ['平台工程师 / 架构师'],
    sourceThemes: ['【技术-平台】AI安全治理与AI Governance'],
  },
  {
    label: 'AI 需求分析 / 场景探索',
    audiences: ['AI 产品经理 / 产品设计师'],
    sourceThemes: ['【产品】AI产品需求分析与场景探索'],
  },
  {
    label: '人机协作交互',
    audiences: ['AI 产品经理 / 产品设计师'],
    sourceThemes: ['【产品】AI产品设计与人机协作交互设计'],
  },
  {
    label: '快速原型 / Vibe Coding',
    audiences: ['AI 产品经理 / 产品设计师'],
    sourceThemes: ['【产品】快速原型验证与Vibe Coding'],
  },
  {
    label: 'LLM / Agent 测试',
    audiences: ['测试工程师 / 质量工程师'],
    sourceThemes: ['【测试】AI辅助测试工程与LLM/Agent测试评估'],
  },
  {
    label: '对抗测试 / 偏见检测',
    audiences: ['测试工程师 / 质量工程师'],
    sourceThemes: ['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）'],
  },
  {
    label: '质量门禁 / 测试左移',
    audiences: ['测试工程师 / 质量工程师'],
    sourceThemes: ['【测试】智能质量门禁与测试左移'],
  },
  {
    label: 'AI 项目管理',
    audiences: ['项目经理 / PMO'],
    sourceThemes: ['【项目管理】AI辅助项目管理与项目管理数字化工具'],
  },
  {
    label: '项目组合管理 / 数据驱动决策',
    audiences: ['项目经理 / PMO'],
    sourceThemes: ['【项目管理】AI项目组合管理与数据驱动决策'],
  },
  {
    label: '业务流程建模 / 业务本体',
    audiences: ['FDE / 解决方案 / 交付'],
    sourceThemes: ['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)'],
  },
  {
    label: '生产部署 / 交付实施',
    audiences: ['FDE / 解决方案 / 交付'],
    sourceThemes: ['【FDE】AI应用生产部署与交付实施'],
  },
  {
    label: '流程变革 / 变革管理',
    audiences: ['FDE / 解决方案 / 交付'],
    sourceThemes: ['【FDE】流程变革推动与变革管理'],
  },
];

export const getPrerequisiteOptionsForAudiences = (audiences: string[]) => {
  const effectiveAudiences = audiences.length > 0 ? audiences : [DEFAULT_RECOMMENDATION_AUDIENCE];

  return RECOMMENDATION_PREREQUISITE_OPTIONS.filter((option) =>
    option.audiences.some((audience) => effectiveAudiences.includes(audience)),
  );
};

export const getAbilityThemeSuggestions = (prerequisites: string[]) => {
  const selected = new Set(prerequisites);

  return RECOMMENDATION_PREREQUISITE_OPTIONS
    .filter((option) => selected.has(option.label))
    .flatMap((option) => option.sourceThemes);
};

// 颜色配置
export const COLORS = {
  primary: '#0F172A',
  secondary: '#1E293B',
  accent: '#3B82F6',
  accent2: '#06B6D4',
  text: {
    primary: '#F8FAFC',
    secondary: '#64748B',
    muted: '#94A3B8',
  },
  background: {
    primary: '#0F172A',
    secondary: '#1E293B',
    card: '#1E293B',
  },
  state: {
    success: '#10B981',
    warning: '#F59E0B',
    error: '#EF4444',
  },
};
