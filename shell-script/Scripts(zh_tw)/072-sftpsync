#!/bin/bash

# sftpsync--指定sftp伺服器上的目錄，確保所有新的或修改過的檔案
#   都上傳到遠端系統，利用名為 .timestamp 的時間戳記檔案來追踪
#   檔案的變動。

timestamp=".timestamp"
tempfile="/tmp/sftpsync.$$"
count=0

trap "$(which rm) -f $tempfile" 0 1 15        # 結束時砍掉暫存檔

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 user@host { remotedir }" >&2
  exit 1
fi

user="$(echo $1 | cut -d@ -f1)"
server="$(echo $1 | cut -d@ -f2)"

if [ $# -gt 1 ] ; then
  echo "cd $2" >> $tempfile
fi

if [ ! -f $timestamp ] ; then
  # 如果沒有 .timestamp檔，就上傳所有檔案
  for filename in *
  do
    if [ -f "$filename" ] ; then
      echo "put -P \"$filename\"" >> $tempfile
      count=$(( $count + 1 ))
    fi
  done
else
  for filename in $(find . -newer $timestamp -type f -print)
  do
    echo "put -P \"$filename\"" >> $tempfile
    count=$(( $count + 1 ))
  done
fi

if [ $count -eq 0 ] ; then
  echo "$0: 沒有任何檔案要上傳到 $server" >&2
  exit 1
fi

echo "quit" >> $tempfile

echo "檔案同步中：在本機資料夾找到 $count 支要上傳的檔案。"

if ! sftp -b $tempfile "$user@$server" ; then
  echo "作業完成！所有檔案都與 $server 完成同步。"
  touch $timestamp
fi
exit 0
