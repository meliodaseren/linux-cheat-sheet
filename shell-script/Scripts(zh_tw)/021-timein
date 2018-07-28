#!/bin/bash

# timein--顯示指定時區或地理區域的現在時間，不指定參數時，它會顯示
#   格林威治時間。
#   指定 "list" 會顯示已知的地理區域名稱。
#   注意，只有指定有效的時區紀錄檔（cities）時，才有辦法找出符合的
#   地理位置。

#   時區資料庫請參考http://www.twinsun.com/tz/tz-link.htm

zonedir="/usr/share/zoneinfo"

if [ ! -d $zonedir ] ; then
  echo "時區資料庫不存於 $zonedir." >&2
  exit 1
fi

if [ -d "$zonedir/posix" ] ; then
  zonedir=$zonedir/posix        # 目前的 Linux 系統
fi

if [ $# -eq 0 ] ; then
  timezone="UTC"
  mixedzone="UTC"
elif [ "$1" = "list" ] ; then
  ( echo "定義在系統上的所有已知時區及地理區域： "
    cd $zonedir
    find -L * -type f -print | xargs -n 2 | \
      awk '{ printf " %-38s %-38s\n", $1, $2 }'
  ) | more
  exit 0
else

  region="$(dirname $1)"
  zone="$(basename $1)"

  # 所指定的時區是否僅一筆符合？如果是，算我們幸運，否則需要
  #   進一步尋找。開始計算符合的筆數：

  matchcnt="$(find -L $zonedir -name $zone -type f -print |\
        wc -l | sed 's/[^[:digit:]]//g' )"

  # 檢查是否最少有一筆檔案符合
  if [ "$matchcnt" -gt 0 ] ; then
    # 如果有多筆檔案符合就結束腳本
    if [ $matchcnt -gt 1 ] ; then
      echo "\"$zone\" 有多筆符合的時區紀錄。" >&2
      echo "請使用 'list' 查看所有已知的地理區域及時區。" >&2
      exit 1
    fi
    match="$(find -L $zonedir -name $zone -type f -print)"
    mixedzone="$zone"
  else    # 也許是找到符合的時區地理位置，而不是特定時區。
          # 將地理位置和時區名稱的第一個字母大寫，其餘小寫。 
    mixedregion="$(echo ${region%${region#?}} \
                  | tr '[[:lower:]]' '[[:upper:]]')\
                  $(echo ${region#?} | tr '[[:upper:]]' '[[:lower:]]')"
    mixedzone="$(echo ${zone%${zone#?}} | tr '[[:lower:]]' '[[:upper:]]') \
                $(echo ${zone#?} | tr '[[:upper:]]' '[[:lower:]]')"
    if [ "$mixedregion" != "." ] ; then
      # 只在指定地理區域內尋找指定的時區，以便在有多組可能時，
      #   讓使用者指定唯一一組符合的時區。(例如 "Atlantic")。
      match="$(find -L $zonedir/$mixedregion -type f -name $mixedzone -print)"
    else
      match="$(find -L $zonedir -name $mixedzone -type f -print)"
    fi

    # 檔案是否確實符合指定的模板
    if [ -z "$match" ] ; then
      # 檢查模板是否過於含糊、模稜兩可
      if [ ! -z $(find -L $zonedir -name $mixedzone -type d -print) ] ; then
        echo -n "此地理區域 \"$1\" 有一組以上的時區。" >&2
      else   # 或者無法產生任何相符的時區
        echo -n "在 \"$1\" 無法找到任何符合的時區。" >&2
      fi
      echo "請使用 'list' 查看所有已知的地理區域及時區。" >&2
      exit 1
    fi
  fi
  timezone="$match"
fi

nicetz=$(echo $timezone | sed "s|$zonedir/||g")    # 調整輸出的美觀度

echo It\'s $(TZ=$timezone date '+%A, %B %e, %Y, at %l:%M %p') in $nicetz

exit 0
