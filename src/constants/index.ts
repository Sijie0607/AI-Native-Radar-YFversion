import { Domain, DomainConfig, DifficultyConfig } from '../types';

// 领域配置
export const DOMAINS: DomainConfig[] = [
  {
    id: 'ai-engineering',
    name: 'AI 工程',
    color: '#3B82F6',
    description: 'AI 系统开发与工程实践',
  },
  {
    id: 'ai-product-design',
    name: 'AI 产品设计',
    color: '#06B6D4',
    description: 'AI 产品设计与方法论',
  },
  {
    id: 'agent-and-intelligent-systems',
    name: 'Agent 与智能体',
    color: '#10B981',
    description: '智能体系统设计与多智能体架构',
  },
  {
    id: 'ai-organizational-transformation',
    name: 'AI 组织变革',
    color: '#F59E0B',
    description: '组织 AI 转型与变革管理',
  },
  {
    id: 'data-intelligence-and-knowledge',
    name: '数据智能与知识',
    color: '#8B5CF6',
    description: '数据治理与知识图谱构建',
  },
  {
    id: 'ai-business-implementation',
    name: 'AI 商业落地',
    color: '#EC4899',
    description: 'AI 商业应用与落地实践',
  },
  {
    id: 'ai-ethics-and-governance',
    name: 'AI 伦理治理',
    color: '#6366F1',
    description: 'AI 安全治理与伦理规范',
  },
  {
    id: 'ai-frontier-trends',
    name: 'AI 前沿趋势',
    color: '#F43F5E',
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
