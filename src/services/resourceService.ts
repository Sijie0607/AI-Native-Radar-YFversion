import { mockService } from '../mocks/mockData';
import { Book } from '../types';
import { backendRequest, isBackendConfigured } from './backendClient';
import { BackendRadarBookRow, mapBackendBook } from './bookMapper';

export const resourceService = {
  async fetchBooks(): Promise<Book[]> {
    if (!isBackendConfigured) {
      return mockService.fetchBooks();
    }

    try {
      const rows = await backendRequest<BackendRadarBookRow[]>(
        '/rest/v1/radar_books?select=*&order=display_number.asc',
      );
      return rows.map(mapBackendBook);
    } catch (error) {
      console.warn('Falling back to local mock books because backend fetch failed.', error);
      return mockService.fetchBooks();
    }
  },
};
