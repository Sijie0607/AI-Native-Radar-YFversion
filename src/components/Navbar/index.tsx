import { Link, useLocation } from 'react-router-dom';
import { BookOpen, BookPlus, List as ListIcon } from 'lucide-react';

interface NavbarProps {
  onRecommendClick?: () => void;
}

const Navbar = ({ onRecommendClick }: NavbarProps) => {
  const location = useLocation();

  return (
    <nav className="fixed top-0 left-0 right-0 bg-slate-900 border-b border-slate-800 z-50">
      <div className="container mx-auto px-4 h-16 flex items-center justify-between">
        <Link
          to="/"
          className="flex items-center gap-2 text-slate-50 font-bold text-xl"
        >
          <BookOpen size={24} className="text-blue-500" />
          AI-Native 读书雷达
        </Link>

        <div className="flex items-center gap-4">
          <Link
            to="/"
            className={`flex items-center gap-2 transition-colors ${
              location.pathname === '/'
                ? 'text-blue-500'
                : 'text-slate-400 hover:text-slate-50'
            }`}
          >
            <BookOpen size={20} />
            雷达图
          </Link>
          <Link
            to="/list"
            className={`flex items-center gap-2 transition-colors ${
              location.pathname === '/list'
                ? 'text-blue-500'
                : 'text-slate-400 hover:text-slate-50'
            }`}
          >
            <ListIcon size={20} />
            书单列表
          </Link>

          {onRecommendClick && (
            <button
              type="button"
              onClick={onRecommendClick}
              className="inline-flex items-center gap-2 rounded-full bg-blue-500 px-4 py-2 text-sm font-medium text-white transition-all hover:bg-blue-400 hover:shadow-lg hover:shadow-blue-500/20"
            >
              <BookPlus size={18} />
              推荐一本书
            </button>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
