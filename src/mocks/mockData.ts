import { Book, DifficultyLevel, Domain, Recommendation } from '../types';
import { DOMAINS } from '../constants';

interface ImportedBookSeed {
  title: string;
  author: string;
  themes: string[];
  degree: string;
  reason: string;
  link?: string;
  recommenders: string[];
}

const DOMAIN_BOOK_METADATA: Record<
  Domain,
  Pick<Book, 'fitFor' | 'takeaways' | 'tags'>
> = {
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

function getStructuredBookMetadata(domain: Domain): Pick<Book, 'fitFor' | 'takeaways' | 'tags'> {
  const metadata = DOMAIN_BOOK_METADATA[domain];
  return {
    fitFor: [...metadata.fitFor],
    takeaways: [...metadata.takeaways],
    tags: [...metadata.tags],
  };
}

const IMPORTED_BOOKS: ImportedBookSeed[] = [
  {
    title: '《AI Engineering: Building Applications with Foundation Models》',
    author: 'Chip Huyen',
    themes: [
      '【全员通用】通用AI素养与AI Fluency 4D框架',
      '【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)',
      '【技术-应用】LLM应用技术选型与架构设计',
      '【技术-平台】LLMOps平台设计与模型全生命周期管理',
      '【技术-平台】模型推理优化与加速（量化/推理服务）',
      '【FDE】AI应用生产部署与交付实施',
    ],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Designing Large Language Model Applications》',
    author: 'Suhas Pai',
    themes: ['【全员通用】Prompt工程基础与进阶', '【技术-应用】LLM应用技术选型与架构设计'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Building a Second Brain》',
    author: 'Tiago Forte',
    themes: ['【全员通用】知识工程与Context管理'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《AI Agents in Action, Second Edition》',
    author: 'Michael Lanham',
    themes: ['【技术-应用】Agent系统设计与多智能体架构', '【技术-平台】AgentOS平台搭建与Agent运行时'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Evals for AI Engineers》',
    author: '作者待补充',
    themes: ['【技术-应用】AI系统与Agent评估监测', '【测试】AI辅助测试工程与LLM/Agent测试评估'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《A Simple Guide to Retrieval Augmented Generation》',
    author: 'Abhinav Kimothi',
    themes: ['【技术-数据】语义检索系统设计与RAG'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Designing Data-Intensive Applications》',
    author: 'Martin Kleppmann',
    themes: ['【技术-数据】实时数据流与AI集成'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《DAMA-DMBOK: Data Management Body of Knowledge》',
    author: 'DAMA International',
    themes: ['【技术-数据】面向AI的数据治理'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Site Reliability Engineering》',
    author: 'Betsy Beyer / Chris Jones / Jennifer Petoff / Niall Richard Murphy',
    themes: ['【技术-平台】AI基础设施运维与可观测性（SRE for AI）'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《AI Risk Management Framework》',
    author: 'NIST',
    themes: ['【技术-平台】AI安全治理与AI Governance'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《AI Product Management》',
    author: '作者待补充',
    themes: ['【产品】AI产品需求分析与场景探索', '【产品】AI产品设计与人机协作交互设计', '【产品】快速原型验证与Vibe Coding'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《People + AI Guidebook》',
    author: 'Google PAIR',
    themes: ['【测试】AI系统专项质量验证（对抗测试/偏见检测/可解释性）'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《BPMN Method and Style》',
    author: 'Bruce Silver',
    themes: ['【FDE】业务流程建模与重构（价值流/业务本体/知识管理等)'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '《Leading Change》',
    author: 'John P. Kotter',
    themes: ['【FDE】流程变革推动与变革管理'],
    degree: '⭐⭐⭐',
    reason: '来自AI-Native能力模型_学习进阶路径与参考资料库的官方推荐',
    recommenders: [],
  },
  {
    title: '本体驱动的AI数据管理',
    author: '作者待补充',
    themes: ['【技术-数据】面向AI的数据治理'],
    degree: '⭐⭐⭐',
    reason: 'AI时代，数据管理已发生重大变化，基于本体驱动的AI数据管理将是未来的主要方向之一',
    link: 'https://baike.baidu.com/item/%E6%9C%AC%E4%BD%93%E9%A9%B1%E5%8A%A8%E7%9A%84AI%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86/67865910',
    recommenders: ['张为普'],
  },
  {
    title: '《Hands-On Large Language Models》',
    author: 'Jay Alammar / Maarten Grootendorst',
    themes: ['【全员通用】通用AI素养与AI Fluency 4D框架'],
    degree: '⭐⭐⭐⭐',
    reason: '构建对transformers与embeddings如何处理文本的"可视直觉"。Jay Alammar以机器学习可视化指南闻名，本书把这种可视方法贯穿LLM全生命周期，把抽象数学讲得很"落地"。',
    link: 'https://www.oreilly.com/library/view/hands-on-large-language/9781098150969/',
    recommenders: ['张娜'],
  },
  {
    title: "《LLM Engineer's Handbook》",
    author: 'Paul Iusztin / Maxime Labonne',
    themes: ['【技术-应用】AI辅助开发(架构设计,  编码与代码审查等)'],
    degree: '⭐⭐⭐⭐',
    reason: '动手实现完整的数据与fine-tuning生命周期。手把手带你构建开源系统LLM Twin，从数据收集到模型部署的完整生命周期。你会学到SFT与preference alignment的实用差异，以及parameter-efficient fine-tuning。',
    link: 'https://www.packtpub.com/en-US/product/llm-engineers-handbook-9781836200079',
    recommenders: ['张娜'],
  },
  {
    title: '《Designing Multi-Agent Systems》',
    author: 'Victor Dibia',
    themes: ['【技术-应用】Agent系统设计与多智能体架构'],
    degree: '⭐⭐⭐⭐',
    reason: '从零学习agent architecture的第一性原理。Victor Dibia是微软首席研究员、AutoGen Studio作者，本书走first-principles路子：从零实现feature-complete的agent库。覆盖collaboration、observability、interruptibility等模式。',
    link: 'https://www.manning.com/books/designing-multi-agent-systems',
    recommenders: ['张娜'],
  },
  {
    title: '《Building Agentic AI》',
    author: 'Sinan Ozdemir',
    themes: ['【技术-应用】Agent系统设计与多智能体架构'],
    degree: '⭐⭐⭐⭐',
    reason: '为企业环境优化agent workflows。Sinan Ozdemir带你超越基本chatbots，构建能产生可量化业务价值的autonomous agents。覆盖multimodal AI、quantization、speculative decoding等优化。',
    link: 'https://www.informit.com/store/building-agentic-ai-workflows-fine-tuning-optimization-9780135489772',
    recommenders: ['张娜'],
  },
  {
    title: '《Agentic AI Engineering》',
    author: 'Yi Zhou',
    themes: ['【技术-应用】AI系统与Agent评估监测'],
    degree: '⭐⭐⭐⭐',
    reason: '让agents扛住真实世界与合规审计。Yi Zhou提出Agentic Stack、Agentic Maturity Ladder、Trust Envelope。你会为"运动中的信任"而工程化——让系统在不确定中推理、又能负责任地自适应。',
    link: 'https://argolong.com/agentic-engineering-book',
    recommenders: ['张娜'],
  },
  {
    title: '《LLMOps: Managing Large Language Models in Production》',
    author: 'Abi Aryan',
    themes: ['【技术-平台】LLMOps平台设计与模型全生命周期管理'],
    degree: '⭐⭐⭐⭐',
    reason: '在真金白银场景下让LLM systems平稳运行。Abi Aryan讲清新的LLMOps学科：如何处理prompt drift、如何运行automated regression tests。传统MLOps面对generative AI会"土崩瓦解"。',
    link: 'https://www.oreilly.com/library/view/llmops/9781098154165/',
    recommenders: ['张娜'],
  },
  {
    title: '《AI Systems Performance Engineering》',
    author: 'Chris Fregly',
    themes: ['【技术-平台】模型推理优化与加速（量化/推理服务）'],
    degree: '⭐⭐⭐⭐',
    reason: '在hardware、software、algorithms三层做硬核优化。Chris Fregly深入GPU memory management、CUDA kernels与基于PyTorch的算法。你会学会profile、诊断并清除复杂AI pipelines的performance bottlenecks。',
    recommenders: ['张娜'],
  },
  {
    title: '《Generative AI Design Patterns》',
    author: 'Valliappa Lakshmanan / Hannes Hapke',
    themes: ['【技术-应用】LLM应用技术选型与架构设计'],
    degree: '⭐⭐⭐⭐',
    reason: '32个成熟的设计模式，直击你每天遇到的挑战：hallucinations、nondeterministic responses、knowledge cutoffs。每个pattern都描述特定问题、给出带代码的验证解，并讨论取舍。你和团队会拥有共享词汇。',
    recommenders: ['张娜'],
  },
  {
    title: '《Mastering Retrieval-Augmented Generation》',
    author: 'Ranajoy Bose',
    themes: ['【技术-数据】语义检索系统设计与RAG'],
    degree: '⭐⭐⭐⭐',
    reason: '把RAG从周末原型扩到企业级生产系统。Ranajoy Bose系统讲解document processing与vector optimization的成熟技巧，覆盖graph-based approaches与multi-modal systems等高级检索策略。你会学到如何fine-tune embedding models。',
    recommenders: ['张娜'],
  },
  {
    title: '《System Design For Large Language Models》',
    author: 'Marc Rolland',
    themes: ['【技术-应用】LLM应用技术选型与架构设计'],
    degree: '⭐⭐⭐⭐',
    reason: '把prompts当成"严肃的系统边界"，而非"文案活儿"。Marc Rolland构建严谨的systems框架，汲取systems engineering、safety analysis、control theory的方法。你会打造让failure"可被观测"的observability mechanisms。',
    recommenders: ['张娜'],
  },
];

function mapThemeToDomain(theme: string): Domain {
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
}

function mapThemeToDifficulty(theme: string): DifficultyLevel {
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
}

function scoreFromDegree(degree: string): number {
  if (degree.includes('⭐⭐⭐⭐')) {
    return 4;
  }
  return 3;
}

function buildReasonShort(reason: string): string {
  if (reason.includes('官方推荐')) {
    return 'AI-Native 官方资料库推荐';
  }
  const normalized = reason.replace(/。+/g, '。').trim();
  const firstSentence = normalized.split('。')[0]?.trim() || normalized;
  return firstSentence.length > 30 ? `${firstSentence.slice(0, 30)}...` : firstSentence;
}

function buildImportedRecommendations(
  seed: ImportedBookSeed,
  score: number,
  recommendationIdStart: number,
): Recommendation[] {
  const recommenders = seed.recommenders.length > 0 ? seed.recommenders : ['AI-Native 官方资料库'];
  return recommenders.map((recommender, index) => ({
    id: `import-rec-${recommendationIdStart + index}`,
    recommender,
    isAnonymous: false,
    reason: seed.reason,
    score,
    recommendedAt: '2026-07-18',
  }));
}

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

export const MOCK_BOOKS: Book[] = [];

// 生成更多模拟书籍
export function generateMockBooks(): Book[] {
  const books: Book[] = [...MOCK_BOOKS];
  const slotCountMap = new Map<string, number>();

  MOCK_BOOKS.forEach((book) => {
    const key = `${book.sectorIndex}-${book.ringIndex}`;
    slotCountMap.set(key, (slotCountMap.get(key) || 0) + 1);
  });
  
  // 添加 Excel 导入的真实书籍数据
  IMPORTED_BOOKS.forEach((seed, index) => {
    const primaryTheme = seed.themes[0] || '';
    const domain = mapThemeToDomain(primaryTheme);
    const difficultyLevel = mapThemeToDifficulty(primaryTheme);
    const ringIndex = difficultyLevel - 1;
    const sectorIndex = DOMAINS.findIndex((item) => item.id === domain);
    const key = `${sectorIndex}-${ringIndex}`;
    const slotIndex = slotCountMap.get(key) || 0;
    const pos = calculatePosition(sectorIndex, ringIndex, slotIndex);
    const structuredMetadata = getStructuredBookMetadata(domain);
    const recommendationScore = scoreFromDegree(seed.degree);
    const recommendations = buildImportedRecommendations(seed, recommendationScore, index * 10);
    slotCountMap.set(key, slotIndex + 1);

    books.push({
      id: `imported-${index + 1}`,
      title: seed.title,
      subtitle: '',
      author: seed.author,
      domain,
      difficultyLevel,
      sectorIndex,
      ringIndex,
      x: pos.x,
      y: pos.y,
      recommendationScore,
      reasonShort: buildReasonShort(seed.reason),
      reasonFull: seed.reason,
      fitFor: structuredMetadata.fitFor,
      takeaways: structuredMetadata.takeaways,
      contentType: '书籍',
      tags: structuredMetadata.tags,
      votesCount: recommendations.length,
      sourceNote: seed.link || '来源：AI-Native读书雷达资料共建表',
      competenceThemes: seed.themes,
      recommendations,
    });
  });

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
