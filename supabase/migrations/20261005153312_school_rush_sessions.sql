-- Minimal central store for consented completed School Rush research sessions.
-- Public clients never receive table access; only the Edge Function uses service_role.
create table if not exists public.school_rush_sessions (
  id uuid primary key,
  payload jsonb not null,
  created_at timestamptz not null default now(),
  constraint school_rush_payload_size check (pg_column_size(payload) <= 20000)
);

alter table public.school_rush_sessions enable row level security;
revoke all on table public.school_rush_sessions from public, anon, authenticated;
grant select, insert, update, delete on table public.school_rush_sessions to service_role;
