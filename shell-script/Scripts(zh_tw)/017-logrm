#!/bin/bash
# logrm--除非使用 -s 選項，否則會記錄所有刪除檔案的請求

removelog="/var/log/remove.log"
if [ $# -eq 0 ] ; then
  echo "執行方式： $0 [-s] 檔案或目錄清單" >&2
  exit 1
fi

if [ "$1" = "-s" ] ; then
  # 要求使用靜音模式，不會記錄刪除行為
  shift
else
  echo "$(date): ${USER}: $@" >> $removelog
fi

/bin/rm "$@"

exit 0
