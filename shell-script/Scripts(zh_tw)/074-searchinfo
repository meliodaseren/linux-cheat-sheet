#!/bin/bash
# searchinfo--從通用日誌格式的 referer 欄位擷取和分析來自
#   搜尋引擎的流量

host="intuitive.com"     # 請換成你自己的網域
maxmatches=20
count=0
temp="/tmp/$(basename $0).$$"

trap "$(which rm) -f $temp" 0

if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) logfile" >&2
  exit 1
fi

if [ ! -r "$1" ] ; then
  echo "錯誤：無法開啟日誌檔 $1，因此無法分析。" >&2
  exit 1
fi

for URL in $(awk '{ if (length($11) > 4) { print $11 } }' "$1" | \
  grep -vE "(/www.$host|/$host)" | grep '?')
  do
  searchengine="$(echo $URL | cut -d/ -f3 | rev | cut -d. -f1-2 | rev)"
  args="$(echo $URL | cut -d\? -f2 | tr '&' '\n' | \
    grep -E '(^q=|^sid=|^p=|query=|item=|ask=|name=|topic=)' | \
   sed -e 's/+/ /g' -e 's/%20/ /g' -e 's/"//g' | cut -d= -f2)"
  if [ ! -z "$args" ] ; then
    echo "${searchengine}: $args" >> $temp
  else
    # 沒有常見的搜尋引擎，以完整 GET 字串取代...
    echo "${searchengine} $(echo $URL | cut -d\? -f2)" >> $temp
  fi
  count="$(( $count + 1 ))"
done

echo "已從 ${1} 擷取搜尋引擎的來訪資訊(referrer)："

sort $temp | uniq -c | sort -rn | head -$maxmatches | sed 's/^/ /g'

echo ""

echo 已掃描 $count 筆紀錄，來自日誌檔的紀錄共有 $(wc -l < "$1") 筆。

exit 0
