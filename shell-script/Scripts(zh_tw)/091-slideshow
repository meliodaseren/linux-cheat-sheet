#!/bin/bash
# slideshow--使用ImageMagick的"display"工具程式為指定目錄中的
#   照片製作幻燈片。

delay=2              # 預設幻燈片停留的時間長度
psize="1200x900>"    # 顯示時的圖片尺寸

if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) watch-directory" >&2
  exit 1
fi

watch="$1"

if [ ! -d "$watch" ] ; then
  echo "$(basename $0): 所指定的 $watch 不是一組目錄。" >&2
  exit 1
fi

cd "$watch"

if [ $? -ne 0 ] ; then
  echo "$(basename $0): 嘗試切換（cd）到目錄 $watch 失敗。" >&2
  exit 1
fi

suffixes="$(file * | grep image | cut -d: -f1 | rev | cut -d. -f1 | \
  rev | sort | uniq | sed 's/^/\*./')"

if [ -z "$suffixes" ] ; then
  echo "$(basename $0): 在 $watch 資料夾中沒有照片可顯示。" >&2
  exit 1
fi

/bin/echo -n "正顯示 $(ls $suffixes | wc -l) 張在 $watch 裡頭的圖片"
set -f ; echo "，其中副檔名為 $suffixes" ; set +f

display -loop 0 -delay $delay -resize $psize -backdrop $suffixes

exit 0
