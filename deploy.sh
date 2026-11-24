#!/bin/bash
# 用法:./deploy.sh "這次改了什麼"
# 把目前的 index.html、assets/、og-image.jpg 推上 GitHub Pages。
# 檔案規則:index.html 只放最新版;上一次上線的版本先存到 archive/index_YYYY-MM-DD_HHMM.html
set -e
cd "$(dirname "$0")"
MSG="${1:-更新賀卡}"
if git cat-file -e HEAD:index.html 2>/dev/null && ! git diff --quiet HEAD -- index.html; then
  mkdir -p archive
  STAMP="$(date '+%Y-%m-%d_%H%M')"
  git show HEAD:index.html > "archive/index_${STAMP}.html"
  echo "↪ 舊版已封存:archive/index_${STAMP}.html"
fi
git add -A
git commit -m "$MSG" || echo "(沒有新變更)"
git push origin main
echo "✓ 已推上 GitHub,約 1 分鐘後生效:https://jessicahuang-star.github.io/xmas-card/"
