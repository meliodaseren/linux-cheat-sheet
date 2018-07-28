#!/bin/bash
# watch_and_nice-監視指定的程序名稱，並在查看時將它調整為指定的等級。

if [ $# -ne 2 ] ; then
  echo "執行方式： $(basename $0) desirednice jobname" >&2
  exit 1
fi

pid="$(renicename -p "$2")"

if [ "$pid" == "" ] ; then
  echo "找不到指定的程序 $2"
  exit 1
fi

if [ ! -z "$(echo $pid | sed 's/[0-9]*//g')" ] ; then
  echo "從程序清單中無法找到唯一的 $2" >&2
  exit 1
fi

currentnice="$(ps -lp $pid | tail -1 | awk '{print $6}')"

if [ $1 -gt $currentnice ] ; then
  echo "將優先等級從 $2 調為 $1"
  renice $1 $pid
fi

exit 0
