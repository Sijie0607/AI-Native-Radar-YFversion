import { useResourceStore } from '../../store/useResourceStore';
import ResourceCard from '../ResourceCard';

const ResourceList = () => {
  const { filteredBooks } = useResourceStore();
  const books = filteredBooks();

  if (books.length === 0) {
    return (
      <div className="text-center py-16">
        <p className="text-slate-400 text-lg">没有找到符合条件的书籍</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {books.map((book) => (
        <ResourceCard key={book.id} resource={book} />
      ))}
    </div>
  );
};

export default ResourceList;
