# MLSC Lab website

Astro로 만든 정적 사이트. GitHub Pages에 자동 배포됨.
기존 `devmlsc.snu.ac.kr` 의 내용(PI 소개, 구성원 19명, Alumni 5명, 논문 6편,
연구 분야 3개, 지원 안내, 랩 캘린더)은 이미 다 옮겨져 있어.

---

## 0. 사진부터 받아두기

멤버 사진과 연구 분야 그림은 아직 학교 서버에 있어. 학교 사이트가 내려가기 전에
한 번 돌려두면 `public/` 안으로 다 복사돼.

```bash
bash scripts/fetch-photos.sh
```

받아진 파일 이름은 `members.yml` 에 이미 적혀 있어서, 스크립트만 돌리면 바로 보여.
실패한 게 있으면 학교 사이트에서 직접 저장해서 같은 이름으로 넣으면 돼.

---

## 1. 로컬에서 띄우기

Node 20 이상 필요 ([nodejs.org](https://nodejs.org) 에서 LTS 설치).

```bash
npm install     # 처음 한 번만
npm run dev     # http://localhost:4321 열림
```

파일을 저장하면 브라우저가 알아서 새로고침돼. `npm run build` 는 `dist/` 에
완성본을 만들고, 오타나 빠진 필드가 있으면 여기서 에러로 잡아줘.

---

## 2. GitHub에 올리고 배포하기

1. **조직 만들기** — <https://github.com/organizations/plan> 에서 Free 선택.
   이름은 예를 들어 `mlsc-snu`. 교수님과 후임자를 Owner로 초대해두면 인수인계가 편해.
2. **레포 만들기** — 조직 안에 `<조직이름>.github.io` 이름으로 **public** 레포 생성.
   (이 이름이어야 주소가 `https://<조직이름>.github.io` 가 돼.)
3. **올리기**

   ```bash
   git init && git add -A && git commit -m "Initial site"
   git branch -M main
   git remote add origin https://github.com/<조직이름>/<조직이름>.github.io.git
   git push -u origin main
   ```

4. **Pages 켜기** — 레포 → Settings → Pages → *Build and deployment* 의
   Source 를 **GitHub Actions** 로 바꿔. 그게 전부야.
5. **주소 바꾸기** — `astro.config.mjs` 의 `site` 를 실제 주소로 수정.

이후로는 `main` 에 push 할 때마다 `.github/workflows/deploy.yml` 이 알아서
빌드하고 배포해. 1~2분 걸리고, 진행 상황은 레포의 Actions 탭에서 보여.

> 나중에 `mlsc.snu.ac.kr` 같은 학교 도메인을 붙이고 싶으면: 전산실에 그 이름의
> CNAME 을 `<조직이름>.github.io` 로 걸어달라고 요청하고, `public/CNAME` 파일에
> 도메인 한 줄을 넣은 뒤 Settings → Pages → Custom domain 에 등록하면 돼.
> HTTPS 인증서는 GitHub이 자동으로 발급해줘.

---

## 3. 내용 고치기

거의 모든 내용이 아래 네 군데에 있어. 코드는 안 건드려도 돼.

| 무엇을 | 어디서 |
| --- | --- |
| 멤버 추가·수정 | `src/data/members.yml` |
| 논문 추가 | `src/data/publications.yml` |
| 뉴스 한 건 추가 | `src/content/news/` 에 `.md` 파일 하나 (`_template.md` 복사해서 쓰면 돼) |
| 연구 분야 글 | `src/content/research/` 의 `.md` 파일 |
| 지원 안내 문구 | `src/pages/index.astro` 아래쪽 |

**멤버 사진**은 `public/people/` 에 넣고 `members.yml` 에 파일명만 적으면 돼.
정사각형 400×400 정도로 잘라서 넣는 게 제일 깔끔해. 사진이 없으면 이니셜이
들어간 사각형이 대신 나와.

**이메일**은 `members.yml` 에 평범하게 적으면 돼. 화면에는 기존 사이트처럼
`do3204 [at] snu.ac.kr` 로 바뀌어 나가고 `mailto:` 링크는 안 걸려.

**저자 이름 굵게** 처리는 `publications.yml` 의 저자 이름이 `members.yml` 의
`name` 과 글자까지 똑같을 때만 동작해. `Dohyun Park` 과 `D. Park` 은 다른 사람으로 봐.

**논문 순서**는 신경 안 써도 돼. 연도 기준으로 사이트가 알아서 정렬해.
`highlight: true` 인 논문만 첫 화면에 올라가.

---

## 4. 디자인 손보기

- **색** — `src/styles/global.css` 맨 위 `:root` 블록. 팔레트는 viridis
  colormap 에서 가져왔어. 랩 그림에 쓰는 색이랑 사이트 색이 같아지라고.
  여기 값만 바꾸면 사이트 전체가 따라와.
- **글꼴** — 같은 파일의 `--font-display` / `--font-body` / `--font-mono`.
  본문은 IBM Plex Sans, 제목은 Newsreader, 수식·라벨은 IBM Plex Mono.
  다른 걸 쓰려면 `npm install @fontsource/<이름>` 후 `BaseHead.astro` 에서 import.
- **다크 모드** — 방문자의 OS 설정을 따라가. `global.css` 의
  `@media (prefers-color-scheme: dark)` 블록에서 색만 바꾸면 돼.
- **첫 화면 시뮬레이션** — `src/components/FieldCanvas.astro`.
  정상 소용돌이 흐름 위에서 스칼라장을 이류·확산시키는 유한차분 코드야.
  `NU`(확산), `SPEED`(유속), `DT`(시간 간격)를 만지면 무늬가 달라져.
  `prefers-reduced-motion` 이 켜진 방문자에게는 정지 화면으로 나가.
- **캘린더** — `src/pages/news/index.astro` 위쪽의 `calendar` 변수.
  기존 사이트에 있던 랩 구글 캘린더 주소를 그대로 옮겨놨어.

---

## 확인해야 할 것들

- [ ] `bash scripts/fetch-photos.sh` 돌려서 사진 확보 (학교 사이트 내려가기 전에)
- [ ] `astro.config.mjs` 의 `site` 주소
- [ ] **논문이 6편이 전부인지** — 기존 사이트 Publications 에 검색·필터 UI가 있어서
      숨은 목록이 더 있을 수 있어. 워드프레스 관리자로 들어가서 확인해봐.
- [ ] 논문 저자를 약자(`Y. Hong`) 대신 전체 이름으로 풀지 — 풀면 멤버 이름이 자동으로 굵어져
- [ ] `src/content/news/2026-08-18-new-site.md` — 실제 소식으로 바꾸거나 삭제
- [ ] 첫 화면의 지원 안내·추천서 정책 문구 — 기존 사이트에서 그대로 옮겨왔는데
      교수님이 최신본인지 한 번 봐주시면 좋아
- [ ] Project 페이지는 안 만들었어. 기존 사이트가 "프로젝트 1 주최" 같은 템플릿
      더미 상태라 옮길 내용이 없었거든. 실제 과제 목록이 생기면 그때 추가하자.
