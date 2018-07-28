#!/bin/bash
# toolong--只會將輸入串流中文字長度超過指定長度的那一行餵給 fmt 處理

width=72

if [ ! -r "$1" ] ; then
  echo "無法讀取檔案 $1" >&2
  echo "執行方式： $0 檔案路徑" >&2
  exit 1
fi

while read input
do
  if [ ${#input} -gt $width ] ; then
    echo "$input" | fmt
  else
    echo "$input"
  fi
done < $1

exit 0
