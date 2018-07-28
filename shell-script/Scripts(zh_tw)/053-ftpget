#!/bin/bash

# ftpget--指定ftp網址，解析並嘗試以匿名ftp方式取得檔案。

anonpass="$LOGNAME@$(hostname)"

if [ $# -ne 1 ] ; then
  echo "執行方式： $0 ftp://..." >&2
  exit 1
fi

# 輸入 URL: ftp://ftp.ncftp.com/unixstuff/q2getty.tar.gz

if [ "$(echo $1 | cut -c1-6)" != "ftp://" ] ; then
  echo "$0: 不正確的網址格式，必須以 ftp:// 起頭。" >&2
  exit 1
fi

server="$(echo $1 | cut -d/ -f3)"
filename="$(echo $1 | cut -d/ -f4-)"
basefile="$(basename $filename)"

echo ${0}: 正從 $server 伺服器下載 $basefile 中...
ftp -np << EOF
open $server
user ftp $anonpass
get "$filename" "$basefile"
quit
EOF

if [ $? -eq 0 ] ; then
  ls -l $basefile
fi

exit 0
