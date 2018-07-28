#!/bin/bash

# moonphase--回報今天或指定日期的月相（實際的亮度百分比）

# Moongiant.com 網站的請求字串格式為：
#   http://www.moongiant.com/phase/MM/DD/YYYY

# 如果沒有指定日期，則表示查詢今天的月相

if [ $# -eq 0 ] ; then
  thedate="today"
else
  # 有指定的日期，先檢查它的格式是否正確。
   mon="$(echo $1 | cut -d/ -f1)"
   day="$(echo $1 | cut -d/ -f2)"
  year="$(echo $1 | cut -d/ -f3)"

  if [ -z "$year" -o -z "$day" ] ; then     # 長度為0 ?
    echo "錯誤：有效的日期格 MM/DD/YYYY"
    exit 1
  fi

  thedate="$1"     # 不檢查，等於搞破壞
fi

url="http://www.moongiant.com/phase/$thedate"
pattern="照度："

phase="$( curl -s "$url" | grep "$pattern" | tr ',' '\
' | grep "$pattern" | sed 's/[^0-9]//g')"

# 網站回傳的資料格式為 "Illumination: <span>NN%\n<\/span>"

if [ "$thedate" = "today" ] ; then
  echo "今天月亮的照度為 ${phase}%"
else
  echo "在 $thedate 的月亮照度為 ${phase}%"
fi

exit 0
