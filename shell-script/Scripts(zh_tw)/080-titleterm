#!/bin/bash
# titleterm--通知OS X終端機將其標題更改為指定給此腳本的參數內容

if [ $# -eq 0 ]; then
  echo "執行方式： $0 title" >&2
  exit 1
else
  echo -e "\033]0;$@\007"
fi

exit 0
