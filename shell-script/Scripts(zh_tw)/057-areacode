#!/bin/bash
# areacode--指定三位數的美國電話區域號碼，使用Bennet Yee網站上
#   的簡單表格資料找出城市和州名。

source="http://www.bennetyee.org/ucsd-pages/area.html"

if [ -z "$1" ] ; then
  echo "執行方式： areacode <美國三位數的區域號碼>"
  exit 1
fi

# wc -c 回傳區域號碼三碼 + End Of Line字元，所以是 4 個字元
if [ "$(echo $1 | wc -c)" -ne 4 ] ; then
  echo "區域號碼： 不正確的長度： 只能使用三位數的美國區域號碼。"
  exit 1
fi

# 都是數字嗎？
if [ ! -z "$(echo $1 | sed 's/[[:digit:]]//g')" ] ; then
  echo "區域號碼： 不是數字，區域號碼只能使用數字。"
  exit 1
fi

# 現在可以進行區域號碼查詢了...

result="$(curl -s -dump $source | grep "name=\"$1" | \
  sed 's/<[^>]*>//g;s/^ //g' | \
  cut -f2- -d\ | cut -f1 -d\( )"

echo "區域號碼 $1 =$result"

exit 0
