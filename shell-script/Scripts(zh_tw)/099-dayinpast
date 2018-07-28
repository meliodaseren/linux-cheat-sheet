#!/bin/bash
# dayinpast--指定一個日期，回報告該日期是星期幾。

if [ $# -ne 3 ] ; then
  echo "執行方式： $(basename $0) mon day year" >&2
  echo "   年月日只能用數字（例如 7 7 1776）" >&2
exit 1
fi

date --version > /dev/null 2>&1    # 如果發生錯誤，就將它拋棄
baddate="$?"                       # 檢查執行結果碼

if [ ! $baddate ] ; then
  date -d $1/$2/$3 +" 這一天是 %A"
else

  if [ $2 -lt 10 ] ; then
    pattern=" $2[^0-9]"
  else
    pattern="$2[^0-9]"
  fi

  dayofweek="$(ncal $1 $3 | grep "$pattern" | cut -c1-2)"
  case $dayofweek in
    Su ) echo "是 星期日";         ;;
    Mo ) echo "是 星期一";         ;;
    Tu ) echo "是 星期二";         ;;
    We ) echo "是 星期三";         ;;
    Th ) echo "是 星期四";         ;;
    Fr ) echo "是 星期五";         ;;
    Sa ) echo "是 星期六";         ;;
  esac
fi
exit 0
