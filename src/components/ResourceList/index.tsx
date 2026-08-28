import { useResourceStore } from '../../store/useResourceStore';
import ResourceCard from '../ResourceCard';
import { Book } from '../../types';

interface ResourceListProps {
  onScoreClick?: (book: Book) => void;
}

const ResourceList = ({ onScoreClick }: ResourceListProps) => {
  const { filteredBooks } = useResourceStore();
  const books = filteredBooks();

  if (books.length === 0) {
    return (
      <div className="py-10 text-center">
        <p className="text-base text-slate-400">没有找到符合条件的资料</p>
      </div>
    );
  }

  return (
    <div className="mb-6 grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3">
      {books.map((book) => (
        <ResourceCard key={book.id} resource={book} onScoreClick={onScoreClick} />
      ))}
    </div>
  );
};

export default ResourceList;
