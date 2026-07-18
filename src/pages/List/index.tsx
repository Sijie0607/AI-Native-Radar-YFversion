import { useEffect, useState } from 'react';
import Navbar from '../../components/Navbar';
import SearchFilter from '../../components/SearchFilter';
import ResourceList from '../../components/ResourceList';
import BookScoringDrawer from '../../components/BookScoringDrawer';
import { useResourceStore } from '../../store/useResourceStore';
import { mockService } from '../../mocks/mockData';
import { Book } from '../../types';

const List = () => {
  const [isScoringOpen, setIsScoringOpen] = useState(false);
  const [activeScoringBook, setActiveScoringBook] = useState<Book | null>(null);
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
          <ResourceList
            onScoreClick={(book) => {
              setActiveScoringBook(book);
              setIsScoringOpen(true);
            }}
          />
        </div>
      </main>

      <BookScoringDrawer
        isOpen={isScoringOpen}
        book={activeScoringBook}
        onClose={() => {
          setIsScoringOpen(false);
          setActiveScoringBook(null);
        }}
      />
    </div>
  );
};

export default List;
