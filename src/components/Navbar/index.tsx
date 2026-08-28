import { Link, useLocation } from 'react-router-dom';
import { BookOpen, BookPlus, List as ListIcon } from 'lucide-react';
import { useResourceStore } from '../../store/useResourceStore';

const Navbar = () => {
  const location = useLocation();
  const { openRecommendation } = useResourceStore();

  return (
    <nav className="paper-nav fixed top-0 left-0 right-0 bg-slate-900 border-b border-slate-800 z-50">
      <div className="mx-auto flex h-14 max-w-[1440px] items-center justify-between gap-3 px-4 lg:px-5">
        <Link
          to="/"
          className="min-w-0 flex items-center gap-2 text-slate-50"
        >
          <BookOpen size={22} className="flex-shrink-0 text-[var(--paper-accent)]" />
          <span className="truncate text-base font-bold sm:text-lg">AI-Native 读书雷达</span>
        </Link>

        <div className="flex items-center gap-2 sm:gap-4">
          <Link
            to="/"
            className={`flex items-center gap-2 rounded-lg px-2 py-2 text-sm transition-colors sm:px-0 sm:py-0 ${
              location.pathname === '/'
                ? 'text-[var(--paper-accent)]'
                : 'text-slate-400 hover:text-slate-50'
            }`}
          >
            <BookOpen size={18} />
            <span className="hidden sm:inline">雷达图</span>
          </Link>
          <Link
            to="/list"
            className={`flex items-center gap-2 rounded-lg px-2 py-2 text-sm transition-colors sm:px-0 sm:py-0 ${
              location.pathname === '/list'
                ? 'text-[var(--paper-accent)]'
                : 'text-slate-400 hover:text-slate-50'
            }`}
          >
            <ListIcon size={18} />
            <span className="hidden sm:inline">书单列表</span>
          </Link>

          <button
            type="button"
            onClick={openRecommendation}
            className="inline-flex items-center gap-2 rounded-full bg-[var(--paper-accent)] px-3 py-1.5 text-sm font-medium text-white transition-all hover:opacity-90 hover:shadow-lg hover:shadow-[#0E42D2]/20 sm:px-4"
          >
            <BookPlus size={18} />
            <span className="hidden sm:inline">资料推荐</span>
          </button>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
