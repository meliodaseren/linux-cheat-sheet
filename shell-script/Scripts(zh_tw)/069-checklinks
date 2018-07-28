#!/bin/bash

# checklinks--掃描網站上的所有內部網址，並將所有錯誤記錄在
#   「traverse.errors」檔案中

# 當執行完畢後，刪除所有lynx掃描的輸出檔案。
trap "$(which rm) -f traverse.dat traverse2.dat" 0

if [ -z "$1" ] ; then
  echo "執行方式： checklinks URL" >&2
  exit 1
fi

baseurl="$(echo $1 | cut -d/ -f3 | sed 's/http:\/\///')"

lynx -traversal -accept_all_cookies -realm "$1" > /dev/null

if [ -s "traverse.errors" ] ; then
  /bin/echo -n 發現 $(wc -l < traverse.errors) 個錯誤。
  echo 已檢查 $(grep '^http' traverse.dat | wc -l) 頁，從網址 ${1}:
  sed "s|$1||g" < traverse.errors
  mv traverse.errors ${baseurl}.errors
  echo "一組輸出的複本已儲存到 ${baseurl}.errors"
else
  /bin/echo -n "沒有發生任何錯誤！ ";
  echo已檢查 $(grep '^http' traverse.dat | wc -l) 頁，從網址 ${1}
fi

if [ -s "reject.dat" ]; then
  mv reject.dat ${baseurl}.rejects
fi

exit 0
