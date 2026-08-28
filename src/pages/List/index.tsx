import { useEffect, useState } from 'react';
import SearchFilter from '../../components/SearchFilter';
import ResourceList from '../../components/ResourceList';
import BookScoringDrawer from '../../components/BookScoringDrawer';
import ListRecommendationShelf from '../../components/ListRecommendationShelf';
import { useResourceStore } from '../../store/useResourceStore';
import { resourceService } from '../../services/resourceService';
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
          const books = await resourceService.fetchBooks();
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
    <main className="pt-14">
      <div className="mx-auto max-w-[1280px] px-4 py-5">
        <h1 className="mb-5 text-3xl font-bold text-slate-50">
          书单列表
        </h1>
        <div className="paper-panel mb-5 rounded-xl border border-slate-700 bg-slate-800 p-4">
          <h3 className="mb-3 text-base font-semibold text-slate-50">筛选</h3>
          <SearchFilter />
        </div>
        <ResourceList
          onScoreClick={(book) => {
            setActiveScoringBook(book);
            setIsScoringOpen(true);
          }}
        />
        <ListRecommendationShelf books={books} />
      </div>

      <BookScoringDrawer
        isOpen={isScoringOpen}
        book={activeScoringBook}
        onClose={() => {
          setIsScoringOpen(false);
          setActiveScoringBook(null);
        }}
      />
    </main>
  );
};

export default List;
