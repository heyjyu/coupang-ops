-- ============================================================
--  v4: 컬럼 추가 누적본 — Supabase SQL Editor 에서 1회 실행
--  (v2/v3 를 건너뛰었어도 이것 하나로 전부 커버)
-- ============================================================

alter table public.ops_products
  add column if not exists coupang_url text,   -- 쿠팡 상품 페이지 URL (목록의 쿠팡↗ 링크)
  add column if not exists product_id  text,   -- 쿠팡 노출 상품 ID — 같으면 한 페이지에 노출·후기 공유
  add column if not exists merge_group text,   -- 결합 그룹 — 같은 값끼리 표에서 붙여 표시 (분리된 동일 상품 묶음)
  add column if not exists improve     text;   -- 보강·리뉴얼 요소별 변경 내용 JSON (예: {"노출상품명":"a → b"})
