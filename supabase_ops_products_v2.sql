-- ============================================================
--  v2: 쿠팡 상품 URL 컬럼 추가 — Supabase SQL Editor 에서 1회 실행
--  (v1 supabase_ops_products.sql 을 이미 실행한 뒤에 이것만 추가로)
-- ============================================================

alter table public.ops_products
  add column if not exists coupang_url text;   -- 쿠팡 상품 페이지 URL (표에서 쿠팡↗ 링크)
