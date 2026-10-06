-- Let a one-time anonymous Supabase user submit a single private game session.
-- The publishable API key alone cannot submit or read rows.
alter table public.school_rush_sessions
  add column if not exists participant_id uuid references auth.users(id) on delete cascade;

-- This project starts empty. Enforce one response owner for every new row.
alter table public.school_rush_sessions
  alter column participant_id set not null;

create unique index if not exists school_rush_sessions_participant_id_key
  on public.school_rush_sessions (participant_id);

grant insert on table public.school_rush_sessions to authenticated;

drop policy if exists "anonymous participants can submit one session"
  on public.school_rush_sessions;
create policy "anonymous participants can submit one session"
  on public.school_rush_sessions
  for insert
  to authenticated
  with check (
    participant_id = (select auth.uid())
    and (select auth.jwt() ->> 'is_anonymous') = 'true'
  );
