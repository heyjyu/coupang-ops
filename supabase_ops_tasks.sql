-- ============================================================
--  v2.0 — 작업(Task) 별도 테이블. Supabase SQL Editor 에서 1회 실행.
--  스펙: 작업 유형은 상품에 붙는 다중 태그이고, 태그는 "미완료 Task들의 types 집계"로 파생.
--  하나의 작업번호(task_no)가 여러 SKU를 묶을 수 있음(예: 5개 결합 = 번호 1개).
--  ops_products(SKU) 는 그대로 두고 이 테이블만 추가.
-- ============================================================

create table if not exists public.ops_tasks (
  id            bigint generated always as identity primary key,
  task_no       text,                       -- T-2607-0001 (연월+일련번호, 구두 전달용)
  types         text default '',            -- 작업 유형(쉼표): 수정,보강,결합,분리,가격변경,신고
  origin        text default 'INTERNAL',    -- INTERNAL(내부·대표 발의) | COUPANG(쿠팡 발의)
  decision      text,                       -- 쿠팡 발의 시: 검토대기 | 수용 | 거절 | 협의중
  decision_note text,                       -- 거절·협의 사유
  status        text default '진행대기',    -- 진행대기 | 진행중 | 완료 | 보류 | 종결
  target_skus   jsonb default '[]'::jsonb,  -- 대상 SKU들(ops_products.id 배열), 1개 이상
  target_product text,                       -- 결합/분리 대상 Product ID
  memo          text,
  detail        jsonb,                       -- 유형별 상세 입력(모달 필드)
  created_by    text,
  created_at    timestamptz default now(),
  completed_at  timestamptz
);

-- 미완료 작업 조회·태그 집계용 인덱스
create index if not exists ops_tasks_status_idx on public.ops_tasks (status);

-- RLS: 내부 운영 데이터 — 읽기·쓰기 모두 로그인만 (ops_products 와 동일 정책)
alter table public.ops_tasks enable row level security;
drop policy if exists ops_tasks_rw on public.ops_tasks;
create policy ops_tasks_rw on public.ops_tasks
  for all to authenticated using (true) with check (true);

-- 확인:
-- select task_no, types, status, target_skus from public.ops_tasks order by id desc limit 10;
