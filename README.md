# 쿠팡 상품 관리 (coupang-ops)

㈜쵸미앤세븐 · SPACE SHIELD 내부 도구. 쿠팡 SKU별로 **"뭘 손봐야 하는지(작업)"** 를 기록·추적합니다.
상품을 등록하거나 리스팅을 고치는 도구가 아니라, **작업 대장**입니다.

**라이브:** https://heyjyu.github.io/coupang-ops/ · **개념 설명:** [guide.html](https://heyjyu.github.io/coupang-ops/guide.html)

## 쓰는 법

1. 위 링크 접속 → 우측 상단 로그인 (카탈로그 관리자와 **같은 계정**)
2. 상품 추가: 쿠팡 상품 페이지를 복사해서 붙여넣기 칸에 그대로 붙이면 상품명·판매가·리뷰수·Product ID를 자동으로 뽑습니다
3. 표에서 SKU를 골라 **작업 배정** → 6종 중 선택: 수정 / 보강·리뉴얼 / 결합 / 분리 / 가격변경 / 신고
4. 쿠팡이 먼저 요청한 건은 상단 **검토 대기**에 뜹니다 → 수용 / 협의 / 거절

## 개발자용

- 정적 HTML + 바닐라 JS. 빌드·npm·CI 없음. `main` push → GitHub Pages 자동 배포.
- 로컬 실행: `python3 -m http.server 8000` (⚠️ `file://` 로 열면 CORS로 Supabase 호출 실패)
- 백엔드는 Supabase (`tnuzqrqxptxrfozzjjek`), 테이블 `ops_products` · `ops_tasks`

**👉 구조·DB·알려진 버그·함정은 `heyjyu/spaceshied-handoff` (private) 의 `apps/coupang-ops.md` 에 있습니다.**
사내 웹앱 4개 전체 그림과 온보딩 순서도 그 repo의 `README.md` 에 있습니다. 접근 권한은 관리자에게 요청하세요.
