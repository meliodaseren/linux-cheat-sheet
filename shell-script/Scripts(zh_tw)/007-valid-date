#!/bin/bash
# valid-date--使用閏年規則來驗證指定的日期

normdate="這裡請指定 normdate.sh 腳本的路徑"

exceedsDaysInMonth()
{
  # 指定一個月份名稱及日期，如果日期的值小於等於該月份的最大日數，就回傳 0，
  #   否則回傳1

  case $(echo $1|tr '[:upper:]' '[:lower:]') in
    jan* ) days=31    ;;  feb* ) days=28    ;;
    mar* ) days=31    ;;  apr* ) days=30    ;;
    may* ) days=31    ;;  jun* ) days=30    ;;
    jul* ) days=31    ;;  aug* ) days=31    ;;
    sep* ) days=30    ;;  oct* ) days=31    ;;
    nov* ) days=30    ;;  dec* ) days=31    ;;
       * ) echo "$0: 月份名稱不可辨認 $1" >&2
          exit 1
  esac
  if [ $2 -lt 1 -o $2 -gt $days ] ; then
    return 1
  else
    return 0   # 有效的日期值
  fi
}

isLeapYear()
{
  # 如果指定的年份是閏年就回傳 0，否則回傳 1。
  # 檢查年份是否為閏年的公式如下：
  #   1. 年份無法被4整除就不是閏年。
  #   2. 年份可以被4及400整除就是閏年。
  #   3. 年份可以被4及100整除，但不能被400整除就不是閏年。
  #   4. 其他能被4整除的年份都是閏年。

  year=$1
  if [ "$((year % 4))" -ne 0 ] ; then
    return 1  # 不是閏年
  elif [ "$((year % 400))" -eq 0 ] ; then
    return 0  # 是閏年
  elif [ "$((year % 100))" -eq 0 ] ; then
    return 1
  else
    return 0
  fi
}

# 主程式起點
# =================

if [ $# -ne 3 ] ; then
  echo "執行方式： $0 month day year" >&2
  echo "典型的輸入格式是： August 3 1962 及 8 3 1962" >&2
  exit 1
fi

# 將日期進行格式標準化，並儲存回傳結果，以便檢查日期有無錯誤

newdate="$($normdate "$@")"

if [ $? -eq 1 ] ; then
  exit 1        # 由normdate 回傳測試結果有誤 
fi

  # 拆分經過格式標準化的日期，第一組= month，第二組= day，第三組= year
  month="$(echo $newdate | cut -d\ -f1)"
  day="$(echo $newdate | cut -d\ -f2)"
  year="$(echo $newdate | cut -d\ -f3)"

  # 現在已有標準化的日期，讓我們檢查日期值是否合法且有效，
  #   例如七月不會有36日。

  if ! exceedsDaysInMonth $month "$2" ; then
    if [ "$month" = "Feb" -a "$2" -eq "29" ] ; then
      if ! isLeapYear $3 ; then
        echo "$0: $3 不是閏年，所以二月不會有 29 天。" >&2
        exit 1
      fi
    else
      echo "$0: 錯誤的日期值： $month 不會有 $2 天。" >&2
      exit 1
    fi
fi

echo "有效的日期： $newdate"

exit 0
