-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
create table if not exists wealth_portfolio (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table wealth_portfolio enable row level security;
create policy "own wealth rows" on wealth_portfolio
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
