import { Link, useLocation } from 'react-router-dom';
import { BookOpen, BookPlus, List as ListIcon } from 'lucide-react';
import { useResourceStore } from '../../store/useResourceStore';

const Navbar = () => {
  const location = useLocation();
  const { openRecommendation } = useResourceStore();

  return (
    <nav className="fixed top-0 left-0 right-0 bg-slate-900 border-b border-slate-800 z-50">
      <div className="container mx-auto flex h-16 items-center justify-between gap-3 px-4">
        <Link
          to="/"
          className="min-w-0 flex items-center gap-2 text-slate-50"
        >
          <BookOpen size={24} className="flex-shrink-0 text-blue-500" />
          <span className="truncate text-base font-bold sm:text-xl">AI-Native 读书雷达</span>
        </Link>

        <div className="flex items-center gap-2 sm:gap-4">
          <Link
            to="/"
            className={`flex items-center gap-2 rounded-lg px-2 py-2 text-sm transition-colors sm:px-0 sm:py-0 ${
              location.pathname === '/'
                ? 'text-blue-500'
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
                ? 'text-blue-500'
                : 'text-slate-400 hover:text-slate-50'
            }`}
          >
            <ListIcon size={18} />
            <span className="hidden sm:inline">书单列表</span>
          </Link>

          <button
            type="button"
            onClick={openRecommendation}
            className="inline-flex items-center gap-2 rounded-full bg-blue-500 px-3 py-2 text-sm font-medium text-white transition-all hover:bg-blue-400 hover:shadow-lg hover:shadow-blue-500/20 sm:px-4"
          >
            <BookPlus size={18} />
            <span className="hidden sm:inline">书籍推荐</span>
          </button>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
