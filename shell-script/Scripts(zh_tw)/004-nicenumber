#!/bin/bash
# nicenumber--輸入一組數字，然後以逗號分隔方式輸出，預期會以小數點及
#   千分位方式建立格式化結果。
#   建立 nicenum 實例，或者，有指定第二組參數時，則直接從螢幕輸出。

nicenumber()
{
  # 假設輸入給腳本的數值是以「.」做為小數點，如果使用者沒有使用 -d
  #   選項指定輸出時的小數點符號，也是以「.」做為輸出數值的小數點。

  integer=$(echo $1 | cut -d. -f1)  # 小數點的左邊
  decimal=$(echo $1 | cut -d. -f2)  # 小數點的右邊

  # 檢查數值是否包含小數部分
  if [ "$decimal" != "$1" ]; then
    # 數值有小數部分，所以要連它一起包含進來
    result="${DD:= '.'}$decimal"
  fi

  thousands=$integer

  while [ $thousands -gt 999 ]; do
    remainder=$(($thousands % 1000))     # 右邊最低的三位數

    # 'remainder' 需為三位數，那要在前面補0嗎?
    while [ ${#remainder} -lt 3 ] ; do   # 強制前面補 0
      remainder="0$remainder"
    done

    result="${TD:=","}${remainder}${result}"  # 從右至左建立結果
    thousands=$(($thousands / 1000))    # 如果還剩，取左邊剩餘部分
  done

  nicenum="${thousands}${result}"
  if [ ! -z $2 ] ; then
    echo $nicenum
  fi
}

DD="." # 小數點符號，用來分隔小數值
TD="," # 千分位符號，用來分隔整數，每三位數一分

# 主程式起點
# =================

   while getopts "d:t:" opt; do
     case $opt in
      d ) DD="$OPTARG" ;;
      t ) TD="$OPTARG" ;;
     esac
  done
  shift $(($OPTIND - 1))

# 驗證輸入資料
if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) [-d c] [-t c] number"
  echo " -d 用以指定小數點的符號"
  echo " -t 用以指定千分位的分隔符號"
  exit 0
fi

nicenumber $1 1   # 第二個參數強制 nicenumber 將結果輸出螢幕.

exit 0
