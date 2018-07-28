#!/bin/bash
# setdate--友善的date 指令前端界面
# 日期命令格式： [[[[[cc]yy]mm]dd]hh]mm[.ss]

# 讓操作方式更友善，此腳本會在[]裡頭顯示目前的日期及時間做為預設值。

. library.sh     # 載入我們的腳本庫，以便調用echon() 函式

askvalue()
{
  # $1 = 欄位名稱, $2 = 預設值, $3 = 最大值,
  # $4 = 要求的字元或數字個數

  echon "$1 [$2] : "
  read answer
  if [ ${answer:=$2} -gt $3 ] ; then
    echo "$0: $1 $answer 無效。"
    exit 0
  elif [ "$(( $(echo $answer | wc -c) - 1 ))" -lt $4 ] ; then
    echo "$0: $1 $answer 太短： 請指定 $4 位數"
    exit 0
  fi
  eval $1=$answer     # 以指定的值重新載入變數
}

eval $(date "+nyear=%Y nmon=%m nday=%d nhr=%H nmin=%M")

askvalue 年 $nyear 3000 4
askvalue 月 $nmon 12 2
askvalue 日 $nday 31 2
askvalue 時 $nhr 24 2
askvalue 分 $nmin 59 2

squished="$year$month$day$hour$minute"

# 如果你是在Linux系統上執行，請改用下列這條指令：
#   squished="$month$day$hour$minute$year"
#   是的，Linux 及 OS X/BSD 系統使用不同的格式，有幫助吧！

echo "要將日期設為 $squished，可能會要求你輸入 sudo 的密碼。"
sudo date $squished

exit 0
