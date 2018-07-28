#!/bin/bash
# daysago--指定月/日/年格式的日期，計算到現在總共過了多少天，包括閏年
#   的影響。

# 底下這一行指令：如果是在Linux上，只需要改用「which date」即可，如果
#   是在OS X，請先用brew安裝具有gdate的核心工具，或自行以源碼編譯。
date="$(which gdate)"

function daysInMonth
{
  case $1 in
    1|3|5|7|8|10|12 ) dim=31 ;;  # 大部分月份是31天
    4|6|9|11        ) dim=30 ;;
    2               ) dim=29 ;;  # 要看是不是閏年
    *               ) dim=-1 ;;  # 未知的月份
  esac
}

function isleap
{
  # 如果$1是閏年，則回傳非零值給 $leapyear 
    leapyear=$($date -d 12/31/$1 +%j | grep 366)
}

#######################
#### 主程式區塊
#######################

if [ $# -ne 3 ] ; then
  echo "執行方式： $(basename $0) mon day year"
  echo "   年月日只能用數字（例如 7 7 1776）"
  exit 1
fi

$date --version > /dev/null 2>&1        # 忽略任何錯誤訊息

if [ $? -ne 0 ] ; then
  echo "抱歉！ $(basename $0) 必須搭配 GNU 的 date 指令。" >&2
  exit 1
fi

eval $($date "+thismon=%m;thisday=%d;thisyear=%Y;dayofyear=%j")

startmon=$1; startday=$2; startyear=$3

daysInMonth $startmon   # 設定全域變數 dim.

if [ $startday -lt 0 -o $startday -gt $dim ] ; then
  echo "無效的日期： #$startmon 月份只能有 $dim 天。" >&2
  exit 1
fi

if [ $startmon -eq 2 -a $startday -eq 29 ] ; then
  isleap $startyear
  if [ -z "$leapyear" ] ; then
    echo "無效的日期： $startyear 年不是閏年，二月只有 28 天。" >&2
    exit 1
  fi
fi

#######################
#### 計算天數
#######################

#### 從起始日期到現在過了幾天

# 計算指定的開始日期之日期字串格式。
startdatefmt="$startmon/$startday/$startyear"

calculate="$((10#$($date -d "12/31/$startyear" +%j))) \
  -$((10#$($date -d $startdatefmt +%j)))"

daysleftinyear=$(( $calculate ))

#### 中間年份的天數

daysbetweenyears=0
tempyear=$(( $startyear + 1 ))

while [ $tempyear -lt $thisyear ] ; do
  daysbetweenyears=$(($daysbetweenyears + \
  $((10#$($date -d "12/31/$tempyear" +%j)))))
  tempyear=$(( $tempyear + 1 ))
done

#### 今年的天數

dayofyear=$($date +%j)   # 這很簡單

#### 現在加總起來

totaldays=$(( $((10#$daysleftinyear)) + \
  $((10#$daysbetweenyears)) + \
  $((10#$dayofyear)) ))
/bin/echo -n "共有 $totaldays 天存在於 "
/bin/echo -n "$startmon/$startday/$startyear "
echo "和今天之間，其中 $dayofyear 天是在 $thisyear 年。"
exit 0
