#!/bin/bash

# randomquote--指定一行代表一條資料的檔案，隨機選擇其中一行並顯示它，
#   最好是在網頁中以SSI方式呼叫此腳本。

awkscript="/tmp/randomquote.awk.$$"

if [ $# -ne 1 ] ; then
  echo "執行方式： randomquote datafilename" >&2
  exit 1
elif [ ! -r "$1" ] ; then
  echo "錯誤： 引用的檔案 $1 不存在或無權讀取！" >&2
  exit 1
fi

trap "$(which rm) -f $awkscript" 0

cat << "EOF" > $awkscript
BEGIN { srand() }
      { s[NR] = $0 }
END   { print s[randint(NR)] }
function randint(n) { return int (n * rand() ) + 1 }
EOF

awk -f $awkscript < "$1"

exit 0
