#!/bin/bash

# remindme--尋找並顯示符合的那行文字，如果不加參數，則顯示資料檔中
#   的所有備忘內容。

rememberfile="$HOME/.remember"

if [ ! -f $rememberfile ] ; then
  echo "$0: 找不到 .remember 檔案。 " >&2
  echo "為了預備 .remember，請先使用 'remember' 加入備忘文字。" >&2
  exit 1
fi

if [ $# -eq 0 ] ; then
  # 如果沒有提供任何搜尋條件時，顯示整個rememberfile 的內容
  more $rememberfile
else
  # 否則，以指定的參數搜尋 rememberfile 內容，並顯示找到的備忘文字
  grep -i -- "$@" $rememberfile | ${PAGER:-more}
fi

exit 0
