-- ============================================================
--  v2.0 2단계 — 작업 히스토리(이력) 컬럼. Supabase SQL Editor 에서 1회 실행.
--  (supabase_ops_tasks.sql 을 이미 실행한 뒤에 이것만 추가)
-- ============================================================

alter table public.ops_tasks
  add column if not exists logs jsonb default '[]'::jsonb;   -- 이력: [{at, actor, action, note}]
