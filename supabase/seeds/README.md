# Supabase Seed

This project keeps the current front-end mock books in `src/mocks/mockData.ts`.

To generate SQL that imports those books into the backend tables, run:

```bash
node scripts/export-supabase-seed.mjs > supabase/seeds/001_imported_books.sql
```

Run the generated SQL after `supabase/migrations/001_initial_schema.sql`.

The generated seed writes:

- `resources`: one row per imported book
- `recommendations`: one or more initial recommendation rows per book
- `resource_metrics`: refreshed aggregate metrics for each book
- `radar_display_state`: the current radar coordinates and baseline visual weights

After the backend is configured, the app should read from Supabase when
`VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` are present. Without those
environment variables, it falls back to `mockData.ts` for local development.
