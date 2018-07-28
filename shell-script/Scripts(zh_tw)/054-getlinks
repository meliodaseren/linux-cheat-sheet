#!/bin/bash

# getlinks--指定一組URL，回傳它的所有相對路徑和絕對路徑鏈結。
#   有三個選項：
#     -d 產製每個鏈結的主網域
#     -r 只列出相對於此站臺內部的鏈結（也就是同站臺內的其他頁面）
#     -a 列出外部的絕對路徑鏈結（和 -r 相反).

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 [-d|-r|-a] url" >&2
  echo "-d=只有網域；-r=只有內部鏈結；-a=只有外部鏈結" >&2
  exit 1
fi

if [ $# -gt 1 ] ; then
  case "$1" in
    -d) lastcmd="cut -d/ -f3|sort|uniq"
        shift
        ;;
    -r) basedomain="http://$(echo $2 | cut -d/ -f3)/"
        lastcmd="grep \"^$basedomain\"|sed \"s|$basedomain||g\"|sort|uniq"
        shift
        ;;
    -a) basedomain="http://$(echo $2 | cut -d/ -f3)/"
        lastcmd="grep -v \"^$basedomain\"|sort|uniq"
        shift
        ;;
     *) echo "$0: 無法辨識指定的選項： $1" >&2
        exit 1
  esac
else
  lastcmd="sort|uniq"
fi

lynx -dump "$1"|\
  sed -n '/^References$/,$p'|\
  grep -E '[[:digit:]]+\.'|\
  awk '{print $2}'|\
  cut -d\? -f1|\
  eval $lastcmd

exit 0
