import { Book, Domain } from '../types';
import { DOMAINS } from '../constants';

// 计算书籍在雷达图上的位置
function calculatePosition(
  sectorIndex: number,
  ringIndex: number,
  slotIndex = 0,
): { x: number; y: number } {
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
}

export const MOCK_BOOKS: Book[] = [
  {
    id: '1',
    title: '深度学习入门',
    subtitle: '基于 Python 的理论与实现',
    author: '斋藤康毅',
    cover: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=200&h=300&fit=crop',
    domain: 'ai-engineering',
    difficultyLevel: 1,
    sectorIndex: 0,
    ringIndex: 0,
    x: calculatePosition(0, 0).x,
    y: calculatePosition(0, 0).y,
    recommendationScore: 4.5,
    reasonShort: 'AI 入门必读，通俗易懂',
    reasonFull: '这本书是深度学习入门的最佳选择，从基础的神经网络概念讲起，配有大量 Python 代码示例。不需要深厚的数学背景也能理解。',
    fitFor: ['AI 初学者', '程序员', '产品经理'],
    takeaways: ['理解神经网络基本原理', '能够实现简单的深度学习模型', '建立 AI 技术知识体系'],
    contentType: '书籍',
    tags: ['深度学习', '入门', 'Python', '神经网络'],
    votesCount: 128,
    competenceThemes: ['全员通用 - 通用AI素养'],
    recommendations: [
      {
        id: 'r1',
        recommender: '张明',
        isAnonymous: false,
        reason: '深度学习领域的经典入门教材，系统全面。',
        score: 5,
        recommendedAt: '2024-01-15',
      },
    ],
  },
  {
    id: '2',
    title: 'AI 产品经理实战手册',
    subtitle: '',
    author: '王曦',
    cover: 'https://images.unsplash.com/photo-1589998059171-988d887dfdf5?w=200&h=300&fit=crop',
    domain: 'ai-product-design',
    difficultyLevel: 2,
    sectorIndex: 1,
    ringIndex: 1,
    x: calculatePosition(1, 1).x,
    y: calculatePosition(1, 1).y,
    recommendationScore: 4.2,
    reasonShort: 'AI PM 必备，系统性强',
    reasonFull: '从产品视角讲解 AI 产品设计，包含大量实战案例，帮助产品经理理解技术边界和设计原则。',
    fitFor: ['AI 产品经理', '产品设计师', '转岗 PM'],
    takeaways: ['AI 产品设计方法论', '技术与产品的协作方式', 'AI 产品落地路径'],
    contentType: '书籍',
    tags: ['产品设计', 'AI PM', '方法论'],
    votesCount: 95,
    competenceThemes: ['产品 - AI产品需求分析'],
    recommendations: [
      {
        id: 'r2',
        recommender: '李华',
        isAnonymous: false,
        reason: '非常适合AI产品经理入门，案例丰富。',
        score: 4,
        recommendedAt: '2024-02-01',
      },
    ],
  },
  {
    id: '3',
    title: 'Building Intelligent Agents',
    subtitle: '',
    author: 'Stuart Russell',
    cover: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=200&h=300&fit=crop',
    domain: 'agent-and-intelligent-systems',
    difficultyLevel: 3,
    sectorIndex: 2,
    ringIndex: 2,
    x: calculatePosition(2, 2).x,
    y: calculatePosition(2, 2).y,
    recommendationScore: 4.8,
    reasonShort: 'Agent 领域权威著作',
    reasonFull: '全面讲解智能体系统设计，从理论到实践，是 Agent 开发的必读之作。',
    fitFor: ['AI 工程师', '研究员', '架构师'],
    takeaways: ['智能体架构设计', '多智能体协作', '决策理论'],
    contentType: '书籍',
    tags: ['Agent', '智能体', '人工智能'],
    votesCount: 156,
    competenceThemes: ['技术-应用 - Agent系统设计'],
    recommendations: [
      {
        id: 'r3',
        recommender: '王芳',
        isAnonymous: false,
        reason: '当前最实用的Agent设计指南。',
        score: 5,
        recommendedAt: '2024-02-10',
      },
    ],
  },
  {
    id: '4',
    title: 'AI 时代的组织变革',
    subtitle: '',
    author: '陈春花',
    cover: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=200&h=300&fit=crop',
    domain: 'ai-organizational-transformation',
    difficultyLevel: 2,
    sectorIndex: 3,
    ringIndex: 1,
    x: calculatePosition(3, 1).x,
    y: calculatePosition(3, 1).y,
    recommendationScore: 4.0,
    reasonShort: '组织 AI 转型必读',
    reasonFull: '从管理学角度讲解企业如何在 AI 时代进行组织变革和能力升级。',
    fitFor: ['管理者', 'HR', '组织发展'],
    takeaways: ['组织转型方法论', 'AI 时代的组织能力', '变革管理实践'],
    contentType: '书籍',
    tags: ['组织变革', '管理', 'AI 转型'],
    votesCount: 78,
    competenceThemes: ['FDE - 业务流程建模'],
    recommendations: [
      {
        id: 'r4',
        recommender: '赵强',
        isAnonymous: false,
        reason: '从组织角度理解AI变革。',
        score: 4,
        recommendedAt: '2024-02-15',
      },
    ],
  },
  {
    id: '5',
    title: '知识图谱与语义检索',
    subtitle: '',
    author: '刘知远',
    cover: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=200&h=300&fit=crop',
    domain: 'data-intelligence-and-knowledge',
    difficultyLevel: 2,
    sectorIndex: 4,
    ringIndex: 1,
    x: calculatePosition(4, 1).x,
    y: calculatePosition(4, 1).y,
    recommendationScore: 4.6,
    reasonShort: 'RAG 系统必备知识',
    reasonFull: '系统讲解知识图谱构建和语义检索技术，是学习 RAG 系统的必备参考书。',
    fitFor: ['算法工程师', '数据科学家', 'AI 工程师'],
    takeaways: ['知识图谱技术', '语义检索原理', 'RAG 系统设计'],
    contentType: '书籍',
    tags: ['知识图谱', 'RAG', '语义检索'],
    votesCount: 112,
    competenceThemes: ['技术-数据 - 语义检索系统设计'],
    recommendations: [
      {
        id: 'r5',
        recommender: '孙丽',
        isAnonymous: false,
        reason: 'RAG系统必备的基础知识。',
        score: 5,
        recommendedAt: '2024-02-20',
      },
    ],
  },
];

// 生成更多模拟书籍
export function generateMockBooks(): Book[] {
  const books: Book[] = [...MOCK_BOOKS];
  const slotCountMap = new Map<string, number>();

  MOCK_BOOKS.forEach((book) => {
    const key = `${book.sectorIndex}-${book.ringIndex}`;
    slotCountMap.set(key, (slotCountMap.get(key) || 0) + 1);
  });
  
  // 添加更多模拟书籍
  for (let i = 6; i <= 20; i++) {
    const sectorIndex = (i - 1) % 8;
    const ringIndex = (i - 1) % 3;
    const domain = DOMAINS[sectorIndex].id as Domain;
    const key = `${sectorIndex}-${ringIndex}`;
    const slotIndex = slotCountMap.get(key) || 0;
    const pos = calculatePosition(sectorIndex, ringIndex, slotIndex);
    slotCountMap.set(key, slotIndex + 1);
    
    books.push({
      id: String(i),
      title: `AI 相关书籍 ${i}`,
      subtitle: '',
      author: `作者 ${i}`,
      cover: `https://images.unsplash.com/photo-${1500000000000 + i * 1000}?w=200&h=300&fit=crop`,
      domain,
      difficultyLevel: (ringIndex + 1) as any,
      sectorIndex,
      ringIndex,
      x: pos.x,
      y: pos.y,
      recommendationScore: 3 + Math.random() * 2,
      reasonShort: '这是一本值得阅读的 AI 书籍',
      reasonFull: '这本书详细讲解了 AI 相关的重要概念和实践方法，适合相关领域的从业者阅读。',
      fitFor: ['从业者', '学习者'],
      takeaways: ['知识1', '知识2', '知识3'],
      contentType: '书籍',
      tags: ['AI', '技术'],
      votesCount: Math.floor(Math.random() * 100),
      competenceThemes: [DOMAINS[sectorIndex].name],
      recommendations: [
        {
          id: `r${i}`,
          recommender: `推荐人 ${i}`,
          isAnonymous: Math.random() > 0.5,
          reason: '这本书很有价值，推荐阅读。',
          score: 3 + Math.floor(Math.random() * 3),
          recommendedAt: '2024-01-01',
        },
      ],
    });
  }
  
  return books;
}

// 模拟 API 服务
export const mockService = {
  async fetchBooks(): Promise<Book[]> {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(generateMockBooks());
      }, 800);
    });
  },
};
