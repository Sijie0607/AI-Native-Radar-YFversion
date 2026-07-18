import { useEffect } from 'react';
import Navbar from '../../components/Navbar';
import SearchFilter from '../../components/SearchFilter';
import ResourceList from '../../components/ResourceList';
import { useResourceStore } from '../../store/useResourceStore';
import { mockService } from '../../mocks/mockData';

const List = () => {
  const { setBooks, setLoadingStatus, books } = useResourceStore();

  // 加载数据（如果尚未加载）
  useEffect(() => {
    if (books.length === 0) {
      const loadData = async () => {
        setLoadingStatus('loading');
        try {
          const books = await mockService.fetchBooks();
          setBooks(books);
          setLoadingStatus('success');
        } catch (error) {
          setLoadingStatus('error');
        }
      };

      loadData();
    }
  }, [books.length, setBooks, setLoadingStatus]);

  return (
    <div className="min-h-screen bg-slate-900">
      <Navbar />
      <main className="pt-16">
        <div className="container mx-auto px-4 py-8">
          <h1 className="text-4xl font-bold text-slate-50 mb-8">
            书单列表
          </h1>
          <div className="mb-8">
            <SearchFilter />
          </div>
          <ResourceList />
        </div>
      </main>
    </div>
  );
};

export default List;
