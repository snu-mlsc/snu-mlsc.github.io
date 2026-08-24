#!/usr/bin/env bash
# 기존 학교 사이트(devmlsc.snu.ac.kr)에 올라가 있는 사진들을 한 번에 받아와.
#   bash scripts/fetch-photos.sh
# 받아지면 public/people/ 과 public/research/ 에 저장되고, 그때부터 사이트에 보여.
# 학교 사이트가 내려가기 전에 한 번 돌려두는 게 좋아. 이미 받은 파일은 건너뛰어.
set -u

cd "$(dirname "$0")/.."
mkdir -p public/people public/research
ok=0; fail=0

get () {  # get <url> <저장경로>
  if [ -f "$2" ]; then echo "skip  $2"; return; fi
  if curl -fsSL --max-time 30 -o "$2" "$1"; then
    echo "ok    $2"; ok=$((ok+1))
  else
    echo "FAIL  $2"; rm -f "$2"; fail=$((fail+1))
  fi
}

get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/03/Professor_Hong_Felling_good.png" "public/people/hong.png"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%86%A1%EC%B0%BD%ED%9B%88%EB%8B%98_%EB%B0%98%EB%AA%85%ED%95%A8%EC%82%AC%EC%9D%B4%EC%A6%88.jpg" "public/people/changhoon-song.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/JlERWOQKLiJM-1.jpg" "public/people/jinsil-lee.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/04/%EC%9D%B4%EB%AA%85%EC%88%98_%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%84.jpg" "public/people/myeong-su-lee.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%84_%EC%B5%9C%EB%AA%85%EC%A0%9C.jpg" "public/people/myungje-choi.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EB%B0%98%EB%AA%85%ED%95%A8.jpg" "public/people/chanyoung-kim.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EA%B9%80%EB%8F%84%ED%98%84_%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%84.jpg" "public/people/dohyun-kim.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/KakaoTalk_20250918_190904203.jpg" "public/people/dohyun-park.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/KakaoTalk_20260505_173206414.jpg" "public/people/dongseok-lee.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/04/KakaoTalk_20260425_212137728.jpg" "public/people/hyeonseok-seo.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/FACE.png" "public/people/juhoon-kang.png"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/IMG_8808.jpg" "public/people/minkyung-sonn.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%82%AC%EC%A7%84.jpg" "public/people/qunzhi-jin.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%A1%B0%ED%98%95%EC%A4%80%EB%8B%98_%EB%AA%85%ED%95%A8%EC%82%AC%EC%9D%B4%EC%A6%88.jpg" "public/people/hyungjun-joe.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/20221016_152528-rotated.jpg" "public/people/jiho-cheon.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/junu_photo.jpeg" "public/people/junu-choi.jpeg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%A0%95%EB%A7%8C%EC%88%98-%EC%9B%90.jpg" "public/people/mansu-chung.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/2021%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%84.jpg" "public/people/seongjae-lim.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EC%A0%95%EC%98%88%EC%B0%AC-%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%84.jpg" "public/people/yechan-jeong.jpg"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/%EB%B3%84%EC%B2%A81_%EA%B9%80%EB%8C%80%ED%98%91_%EC%82%AC%EC%A7%84.jpg" "public/people/daehyeop-kim.jpg"

get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/LogBarron-1.png" "public/research/LogBarron-1.png"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/PINN.png" "public/research/PINN.png"
get "https://devmlsc.snu.ac.kr/wp-content/uploads/sites/256/2026/05/generative.png" "public/research/generative.png"

echo
echo "받음 $ok, 실패 $fail"
[ "$fail" -gt 0 ] && echo "실패한 건 학교 사이트에서 직접 저장해서 같은 이름으로 넣으면 돼."
exit 0
