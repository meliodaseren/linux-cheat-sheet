#!/bin/bash
# ituneslist--以簡潔有吸引力的方式列出iTunes音樂庫的清單，以便與
#   他人分享，或利用diff在不同電腦間進行iTunes同步。

itunehome="$HOME/Music/iTunes"
ituneconfig="$itunehome/iTunes Music Library.xml"

musiclib="/$(grep '>Music Folder<' "$ituneconfig" | cut -d/ -f5- | \
  cut -d\< -f1 | sed 's/%20/ /g')"

echo "你的音樂庫在 $musiclib"

if [ ! -d "$musiclib" ] ; then
  echo "$0: 有疑問： 指定的 $musiclib 音樂庫不是檔案目錄？" >&2
  exit 1
fi

exec find "$musiclib" -type d -mindepth 2 -maxdepth 2 \! -name '.*' -print \
  | sed "s|$musiclib/||"
