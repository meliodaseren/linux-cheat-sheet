#!/bin/bash

# archivedir--建立指定目錄的壓縮封存檔
maxarchivedir=10          # 大型目錄的大小，單為區塊
compress=gzip             # 可改成你喜歡的壓縮工具
progname=$(basename $0)   # 提供較佳的錯誤訊息輸出格式

if [ $# -eq 0 ] ; then    # 未指定參數？ 這樣有問題。
  echo "執行方式： $progname directory" >&2
  exit 1
fi

if [ ! -d $1 ] ; then
  echo "${progname}: 找不到目錄 $1 進行封存。" >&2
  exit 1
fi

if [ "$(basename $1)" != "$1" -o "$1" = "." ] ; then
  echo "${progname}: 你必須指定一組目錄。" >&2
  exit 1
fi

if [ ! -w . ] ; then
  echo "${progname}: 無法將封存檔儲存到目前目錄。" >&2
  exit 1
fi

# 所產生的封存是否太大？ 讓我們檢查看看...
dirsize="$(du -s $1 | awk '{print $1}')"

if [ $dirsize -gt $maxarchivedir ] ; then
  /bin/echo -n "警告： 目錄 $1 的大小是 $dirsize 區塊，是否要處理？ [n] "
  read answer
  answer="$(echo $answer | tr '[:upper:]' '[:lower:]' | cut -c1)"
  if [ "$answer" != "y" ] ; then
    echo "${progname}: 已取消目錄 $1 的封存作業。" >&2
    exit 0
  fi
fi

archivename="$1.tgz"

if tar cf - $1 | $compress > $archivename ; then
  echo "目錄 $1 已封存成 $archivename"
else
  echo "警告： tar 在封存 $1 時遇到問題。"
fi

exit 0
