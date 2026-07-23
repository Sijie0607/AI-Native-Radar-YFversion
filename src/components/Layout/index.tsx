import { Outlet } from 'react-router-dom';
import Navbar from '../Navbar';
import RecommendationDrawer from '../RecommendationDrawer';
import { useResourceStore } from '../../store/useResourceStore';

const Layout = () => {
  const { viewState, closeRecommendation } = useResourceStore();

  return (
    <div className="min-h-screen bg-slate-900">
      <Navbar />
      <Outlet />
      <RecommendationDrawer
        isOpen={viewState.isRecommendationOpen}
        onClose={closeRecommendation}
      />
    </div>
  );
};

export default Layout;
