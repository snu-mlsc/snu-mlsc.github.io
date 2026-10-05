# MLSC Lab site — Claude Code 인수인계 노트

이 파일은 Claude Code가 다음 세션에서도 프로젝트 맥락을 바로 잡을 수 있도록
정리해둔 노트야. 새 세션 열면 자동으로 로드돼.

프로젝트 자체 사용법은 `README.md` 참고. 여기는 **지금 상태와 앞으로 할 일**에 초점.

---

## 지금 상태 (2026-10-05)

**배포 완료.** GitHub 조직 `snu-mlsc`, 레포 `snu-mlsc/snu-mlsc.github.io`,
주소 <https://snu-mlsc.github.io>. `main` 에 push 하면 Actions 가 자동 배포.
`astro.config.mjs` 의 `site` 도 실제 주소로 설정됨.

### 완료된 작업
- Node.js LTS(24), Git, GitHub CLI 로컬 설치 (winget). `npm install` 완료.
- 학교 서버(`devmlsc.snu.ac.kr`)에서 사진 다운로드 → `public/people/`, `public/research/`.
- **팔레트**: Crisp White + Deep Teal. `src/styles/global.css` 의 `:root` 만 만지면 전체 반영.
- **KaTeX 수식 렌더링** — `<Equation />` 컴포넌트 (아래 "수식 작성법").
- **멤버 사진** 3:4 세로 직사각형, `object-position: top center`.
- **Publications 67편** — youngjoonhong.com/contact (Wix URL 매핑 오류로
  Publication 페이지가 /contact 에 있음) 기준 동기화. 2012~2026.
  2026-10-05 에 NeurIPS 2026 3편 추가 (Risk-Sensitive Deep Optimal Stopping /
  Neural Quantum Spectral Operator Learning / PDE-PFN) — 아직 링크 없음, highlight 아님.
  topic 필터 칩(15개 + All, 자동 생성) 있음. Finance 토픽: 금융 논문 3편.
- **논문 링크** arXiv/OpenReview/publisher URL 대부분 반영.
  링크 없는 것: Spectral coefficient learning (EAAI 2026), NeurIPS 2026 3편.
- **홈페이지 리디자인** — hero 배경 사진(`public/hero-bg.jpg`) + 스크롤 시 텍스트
  sticky, 슬로건 섹션, 뉴스 카드 4개 그리드, 홈 섹션 이름 "Published work"
  (highlight: true 논문만 표시).
- **People** — Visiting students 섹션 추가 (Qunzhi Jin). 그룹 사진 자리:
  `public/lab-photo.jpg` (.jpeg / .png) 넣으면 자동 표시.
- **석박통합과정 반영** — role `mspd` 추가. People 페이지는 "Graduate students" 한 섹션에
  박사(phd) → 석박통합(mspd) → 석사(ms) 순으로 모이고 과정은 title 로 표시.
  박사: Chanyoung Kim, Minkyung Sonn / 석사: Yechan Jeong / 나머지 11명 석박통합.
- **멤버 이름 표기 확인 완료** (당사자 확인, members.yml 표기가 정답).
- **첫 화면 지원 안내/추천서 정책 문구 확인 완료**.
- Alumni 5명(Ko/Seol/Choi/Oh/Chang) 홈페이지와 일치.
- **Gallery 페이지** (`/gallery/`, 상단 메뉴) — 뉴스 .md 의 `photos` 필드에 적힌
  사진(`public/gallery/`)을 이벤트별로 모아 보여줌. 이벤트 3건: 교수님 생신(2026-06-19), 랩 세미나 단체사진(2026-08-28),
  관악산 등산(2026-10-03). 사진은 긴 변 1600px 로 줄여서 넣는 게 좋음.

### 아직 안 한 것
1. **`src/data/publications.yml` 저자 이름을 전체 이름으로** — `Y. Hong` 대신
   `Youngjoon Hong` 처럼 풀면 `members.yml` 의 `name` 과 매칭돼서 굵게 표시됨.
2. **`src/content/news/2026-08-18-new-site.md`** — 실제 소식으로 바꾸거나 삭제.
   (NeurIPS 2026 3편 accept 소식 뉴스로 쓰기 좋음.)
3. NeurIPS 2026 3편 링크(OpenReview/arXiv) 공개되면 추가, highlight 여부 결정.
4. Project 페이지는 아직 없음. 실제 과제 목록 생기면 추가.

---

## 로컬 개발

Windows PowerShell 기준. 새 세션에서 `node` / `npm` / `git` / `gh` 못 찾으면
아래 한 줄로 PATH 재로드:

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

일반 명령:

```powershell
cd mlsc-lab
npm run dev      # http://localhost:4321 (파일 저장하면 HMR 자동 반영)
npm run build    # dist/ 에 완성본 생성, 빌드 에러도 여기서 잡힘
npm run check    # Astro 타입 체크
```

사진 다시 받기 (Windows 에서는 bash 스크립트라 Git Bash 사용):

```powershell
& "C:\Program Files\Git\bin\bash.exe" scripts/fetch-photos.sh
```

---

## 세션 지속성 (Claude Code)

- Claude Code 대화는 자동 저장돼. CLI 창을 닫아도 `claude --continue` 로
  같은 대화 이어서 가능. 이 CLAUDE.md 는 자동으로 다시 로드됨.
- **`npm run dev` 프로세스는 Claude Code 가 백그라운드 태스크로 관리 중**.
  Claude Code 세션이 살아있는 동안만 유지됨. PC 껐다 켜면 다시 시작 필요.
- 실사용에서는 dev 서버를 별도 PowerShell 창에서 켜두는 게 안정적. 그러면
  Claude Code 를 껐다 켜도 서버는 계속 살아있음.
- Windows 라 tmux 는 필요 없음 (tmux 는 Linux/macOS 도구). 그냥 새 PowerShell 창
  열어서 `npm run dev` 하면 됨.

---

## 콘텐츠 편집 위치 (자주 쓰는 것부터)

| 무엇을 | 어디서 |
| --- | --- |
| 멤버 추가·수정 | `src/data/members.yml` (사진은 `public/people/` 에 400×400 정사각형 권장) |
| 논문 추가 | `src/data/publications.yml` |
| 뉴스 1건 추가 | `src/content/news/YYYY-MM-DD-slug.md` (`_template.md` 복사) |
| 갤러리 사진 | `public/gallery/` 에 넣고 뉴스 .md 의 `photos: [파일명]` (kind: event) |
| 연구 분야 글 | `src/content/research/*.md` |
| 지원 안내 문구 | `src/pages/index.astro` 아래쪽 (`.join` 섹션) |
| 색·글꼴 | `src/styles/global.css` 의 `:root` 블록 |
| 캘린더 URL | `src/pages/news/index.astro` 위쪽 `calendar` 변수 |
| 첫 화면 시뮬레이션 파라미터 | `src/components/FieldCanvas.astro` (NU, SPEED, DT) |

---

## 수식 작성법 (KaTeX)

이제 수식은 **진짜 LaTeX 문법**으로 적어. `Equation` 컴포넌트를 통해 서버사이드
KaTeX 로 렌더링돼.

Astro 페이지/컴포넌트에서:
```astro
---
import Equation from '../components/Equation.astro';
---
<Equation formula="\| u - u_\theta \| \le C\, N^{-\alpha}" />
<Equation formula="e^{i\pi} + 1 = 0" display />  {/* display=true 로 블록 모드 */}
```

Frontmatter(YAML) 문자열에 넣을 때는 백슬래시를 두 번 써야 해:
```yaml
equation: "\\mathcal{L}[u] = f, \\quad u|_{\\partial\\Omega} = g"
```

이미 등록된 위치:
- `src/content/research/*.md` 의 `equation` 필드 3개
- `src/components/FieldCanvas.astro` (히어로 캡션)
- `src/pages/404.astro`
- `src/pages/index.astro`, `src/pages/research.astro` (research equation 참조)

---

## GitHub 배포 (이미 완료 — 새로 세팅할 때 참고용)

```powershell
# 1. GitHub CLI 로그인 (브라우저 열림)
gh auth login

# 2. 조직 안에 레포 생성 (조직은 웹에서 먼저 만들어야 함)
gh repo create <org>/<org>.github.io --public --source=. --remote=origin

# 3. push
git init
git branch -M main
git add -A
git commit -m "Initial site"
git push -u origin main

# 4. 웹에서: 레포 Settings → Pages → Source 를 "GitHub Actions" 로.
# 5. astro.config.mjs 의 site 를 실제 주소(https://<org>.github.io)로 수정.
```

이후로는 `main` 에 push 하면 `.github/workflows/deploy.yml` 이 자동 빌드·배포.

---

## 알려진 이슈

- `npm audit` 경고 3건 (low 1, high 2). Astro 5.x 의 dev deps 관련이라
  프로덕션 영향 없음. `npm audit fix --force` 는 breaking change 유발 가능,
  안 해도 됨.
- `sharp` / `esbuild` postinstall 경고는 npm 11 의 새로운 allow-scripts 정책
  관련. 이미지 최적화 필요할 때 문제되면 `npm approve-scripts` 로 승인.
- Astro 최신 버전은 7.2.2 지만 현재 5.18.2 사용 중. 5.x 로도 정상 동작하고,
  올릴 이유가 생길 때 `npx @astrojs/upgrade` 한 번 돌리면 됨.
