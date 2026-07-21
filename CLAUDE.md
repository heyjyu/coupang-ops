# CLAUDE.md — coupang-ops

㈜쵸미앤세븐 SPACE SHIELD **쿠팡 SKU별 작업 관리**(v2.0). 상품 등록 도구가 아니라 "뭘 손볼지" 작업 대장.
작업 6종: 수정·보강·결합·분리·가격변경·신고. 정적 HTML 1파일(`index.html`), 바닐라 JS, 빌드 없음.
`main` push → GitHub Pages 자동 배포. 백엔드 = Supabase(`tnuzqrqxptxrfozzjjek`), 테이블 `ops_products`·`ops_tasks`.

## 이 repo 규칙 (어기면 인수인계가 깨짐)
- **DB 컬럼 추가/변경 시 `normTask`(index.html) 매핑도 같이 고치기.** DB에서 온 필드를 화면 객체로 옮기는 함수인데, 이걸 빠뜨려 `decision_note`(거절·협의 사유)·`completed_at`이 새로고침하면 사라지는 버그가 있었음(수정 완료). 같은 실수 반복 금지.
- **DB 변경은 대시보드 클릭 말고 SQL 파일로** 만들고 커밋. `_v4`/`_v2` 처럼 앞 파일에 이어지는 ALTER 방식.
- **CDN 고정 유지:** `@supabase/supabase-js@2.110.5`. `@2`로 되돌리지 말 것.
- **화면에 뿌리는 DB 텍스트는 escape**(현재 `innerHTML` 직접 사용). 단 `ops_products`는 공급가 때문에 anon read가 없어 로그인해야 보임.
- 스마트 붙여넣기(`parseSmart`)는 쿠팡 페이지 텍스트를 정규식으로 긁는 취약한 방식 — 쿠팡이 페이지 바꾸면 깨짐.

## 검증
`file://` 금지(CORS). `python3 -m http.server 8000` 로 열기. 로그인 계정은 카탈로그 admin과 동일. 로컬도 운영 DB에 붙음.

## 상세·전체 맥락
private repo `heyjyu/spaceshied-handoff` → `apps/coupang-ops.md`, `README.md`, `DEV_IN_CLAUDE.md`. 접근은 오너에게 요청.
