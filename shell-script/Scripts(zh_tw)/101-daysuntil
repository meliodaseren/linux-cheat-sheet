#!/bin/bash
# daysuntil-- 基本上，這是daysago腳本的反向計算版，把欲計算的日期想像成
#   今天、那麼今天就成了過去的日期，這就成了 daysago 的計算基礎。

# 和前一支腳本相同，如果在OS X 上，使用 'which gdate' ，若在 Linux 上則
#   使用'which date'.
date="$(which gdate)"

function daysInMonth
{
  case $1 in
    1|3|5|7|8|10|12 ) dim=31 ;;   # 大部分月份是31天
    4|6|9|11        ) dim=30 ;;
    2               ) dim=29 ;;   # 要看是不是閏年
    *               ) dim=-1 ;;   # 未知的月份
  esac
}

function isleap
{
  # 如果指定的年份是閏年，則回傳非零值給 $leapyear
  leapyear=$($date -d 12/31/$1 +%j | grep 366)
}

#######################
####主程式區塊
#######################

if [ $# -ne 3 ] ; then
  echo "執行方式： $(basename $0) mon day year"
  echo "   年月日只能用數字（例如 1 1 2020）"
  exit 1
fi

$date --version > /dev/null 2>&1        # 忽略任何錯誤訊息

if [ $? -ne 0 ] ; then
  echo "抱歉！ $(basename $0) 必須搭配 GNU 的 date 指令。" >&2
  exit 1
fi

eval $($date "+thismon=%m;thisday=%d;thisyear=%Y;dayofyear=%j")

endmon=$1; endday=$2; endyear=$3

# 更多的參數檢查邏輯...

daysInMonth $endmon    # 設定 $dim 變數
if [ $endday -lt 0 -o $endday -gt $dim ] ; then
  echo "無效的日期： #$endmon月份只能有 $dim 天。" >&2
  exit 1
fi

if [ $endmon -eq 2 -a $endday -eq 29 ] ; then
  isleap $endyear
  if [ -z "$leapyear" ] ; then
    echo "無效的日期： $endyear年不是閏年，二月只有 28 天。" >&2
    exit 1
  fi
fi

if [ $endyear -lt $thisyear ] ; then
  echo "無效的日期： $endmon/$endday/$endyear 是過去年份。" >&2
  exit 1
fi

if [ $endyear -eq $thisyear -a $endmon -lt $thismon ] ; then
  echo "無效的日期： $endmon/$endday/$endyear 是過去月份。" >&2
  exit 1
fi

if [ $endyear -eq $thisyear -a $endmon -eq $thismon -a $endday -lt $thisday ]
then
  echo "無效的日期： $endmon/$endday/$endyear 是過去日期。" >&2
  exit 1
fi

if [ $endyear -eq $thisyear -a $endmon -eq $thismon -a $endday -eq $thisday ]
then
  echo "今天和 $endmon/$endday/$endyear 是同一天。" >&2
  exit 0
fi

#### 如果是計算同一年份的未來日期，計算方式有點不同。
if [ $endyear -eq $thisyear ] ; then

  totaldays=$(( $($date -d "$endmon/$endday/$endyear" +%j) - $($date +%j) ))

else

  #### 主要的計算區塊，先從今年剩幾天開始

  #### 到今年結束還剩幾天

  # 計算今天的日期字串格式。

  thisdatefmt="$thismon/$thisday/$thisyear"

  calculate="$($date -d "12/31/$thisyear" +%j) - $($date -d $thisdatefmt +%j)"

  daysleftinyear=$(( $calculate ))

  #### 中間年份的天數

  daysbetweenyears=0
  tempyear=$(( $thisyear + 1 ))

  while [ $tempyear -lt $endyear ] ; do
    daysbetweenyears=$(( $daysbetweenyears + \
      $($date -d "12/31/$tempyear" +%j) ))
    tempyear=$(( $tempyear + 1 ))
  done

  #### 在結束日期那一年的天數

  dayofyear=$($date --date $endmon/$endday/$endyear +%j)    # 這很簡單

  #### 現在加總起來

  totaldays=$(( $daysleftinyear + $daysbetweenyears + $dayofyear ))
fi

echo "還要 $totaldays 天才會到達指定的 $endmon/$endday/$endyear。"
exit 0
