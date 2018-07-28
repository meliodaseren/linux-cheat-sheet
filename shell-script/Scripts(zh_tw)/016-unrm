#!/bin/bash
# unrm--尋找指定的封存檔案或目錄，如果有多組符合指定條件，會依時間戳記
#   顯示所有清單，然後由使用者選擇其中一支封存檔案進行還原。

archivedir="$HOME/.deleted-files"
realrm="$(which rm)"
move="$(which mv)"

dest=$(pwd)

if [ ! -d $archivedir ] ; then
  echo "$0: 找不到回收筒： unrm 無法處理" >&2
  exit 1
fi
cd $archivedir

# 如果不指定參數，就顯示所有已刪除的檔案
if [ $# -eq 0 ] ; then
  echo "被刪除檔案的內容（依日期排列）："
  ls -FC | sed -e 's/\([[:digit:]][[:digit:]]\.\)\{5\}//g' \
    -e 's/^/ /'
  exit 0
fi
# 否則需要使用者指定處理的樣式，查看有哪些封存的檔案或目錄符合指定樣式

matches="$(ls -d *"$1" 2> /dev/null | wc -l)"

if [ $matches -eq 0 ] ; then
  echo "找不到符合 \"$1\" 的封存檔案。" >&2
  exit 1
fi

if [ $matches -gt 1 ] ; then
  echo "有多支符合的封存檔案或目錄："
  index=1
  for name in $(ls -td *"$1")
  do
    datetime="$(echo $name | cut -c1-14| \
      awk -F. '{ print $5"/"$4" at "$3":"$2":"$1 }')"
    filename="$(echo $name | cut -c16-)"
    if [ -d $name ] ; then
      filecount="$(ls $name | wc -l | sed 's/[^[:digit:]]//g')"
      echo " $index) $filename (目錄內容 = ${filecount} 項目, " \
           " 刪除時間 = $datetime)"
    else
      size="$(ls -sdk1 $name | awk '{print $1}')"
      echo " $index) $filename (檔案大小 = ${size}Kb, 刪除時間 = $datetime)"
    fi
    index=$(( $index + 1))
  done
  echo ""
  /bin/echo -n "我要還原的 $1 封存檔版本是(按 '0' 離開)？ [1]： "
  read desired
  if [ ! -z "$(echo $desired | sed 's/[[:digit:]]//g')" ] ; then
    echo "$0: 還原動作已被使用者中斷： 無效的輸入。" >&2
    exit 1
  fi

  if [ ${desired:=1} -ge $index ] ; then
    echo "$0: 還原動作已被使用者中斷： 指定的索引值太大。" >&2
    exit 1
  fi

  if [ $desired -lt 1 ] ; then
    echo "$0: 還原動作已被使用者中斷。" >&2
    exit 1
  fi

  restore="$(ls -td1 *"$1" | sed -n "${desired}p")"

  if [ -e "$dest/$1" ] ; then
    echo "\"$1\" 已存在指定的目錄中，無法覆蓋。" >&2
    exit 1
  fi

  /bin/echo -n "正在還原檔案 \"$1\" ..."
  $move "$restore" "$dest/$1"
  echo "已完成。"

  /bin/echo -n "要刪除其他封存檔的副本嗎？ [y] "
  read answer

  if [ ${answer:=y} = "y" ] ; then
    $realrm -rf *"$1"
    echo "已刪除。"
  else
    echo "其他封存檔的副本繼續保留。"
  fi
else
  if [ -e "$dest/$1" ] ; then
    echo "\"$1\" 已存在指定的目錄中，無法覆蓋。" >&2
    exit 1
  fi

  restore="$(ls -d *"$1")"
  /bin/echo -n "正在還原檔案 \"$1\" ... "
  $move "$restore" "$dest/$1"
  echo "已完成。"
fi

exit 0
