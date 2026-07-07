-- ============================================================
--  쿠팡 상품 운영 관리 (coupang-ops) — 테이블 생성
--  Supabase 대시보드 → SQL Editor 에 붙여넣고 Run (1회).
--  카탈로그와 같은 프로젝트를 쓰지만 별도 테이블(ops_products)이라
--  기존 products/categories 에는 영향 없음.
-- ============================================================

create table if not exists public.ops_products (
  id         bigint generated always as identity primary key,
  sku        text,                    -- SKU ID (예: CSK-240801)
  name       text not null,           -- SKU 명
  barcode    text,                    -- 바코드
  price      integer,                 -- 판매가(원)
  supply     integer,                 -- 공급가(원) — 여백률 = (판매가-공급가)/판매가
  status     text default '정상',     -- 정상 / 품절 / 판매중지 / 승인대기
  reviews    integer,                 -- 리뷰 수
  flags      text default '',         -- 작업 필요: 수정,보강,리뉴얼,결합,분리,가격변경,신고 (쉼표 구분)
  note       text,                    -- 운영 메모
  created_at timestamptz default now()
);

-- RLS: 공급가 등 내부 데이터라 읽기·쓰기 모두 "로그인한 사용자"만.
--  (카탈로그 products 와 달리 anon 읽기 정책을 만들지 않음)
alter table public.ops_products enable row level security;
drop policy if exists ops_products_rw on public.ops_products;
create policy ops_products_rw on public.ops_products
  for all to authenticated using (true) with check (true);

-- 확인:
-- select * from public.ops_products limit 5;
