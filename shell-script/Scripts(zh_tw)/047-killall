#!/bin/bash

# killall--將指定的信號發送到和指定的程式名稱相符的所有程序

# 預設情況下，它只終止和執行此腳本相同擁有者的程序，除非你是root。
#   使用 -s SIGNAL指定要發送到程序的信號；-u USER指使用者；-t TTY指
#   定終端機；-n預演模式，僅回報腳本執行過程，但沒有真正終止程序。

signal="-INT"  # 預設信號是 interrupt（中斷）.
user="" tty="" donothing=0

while getopts "s:u:t:n" opt; do
  case "$opt" in
        # 注意下面的技巧：實際上 kill需用 -SIGNAL，但我們用 SIGNAL，
        #   所以在下面會看到我們加了 "-"。

    s ) signal="-$OPTARG";               ;;
    u ) if [ ! -z "$tty" ] ; then
          # 邏輯錯誤：不能同時指定使用者和終端機
          echo "$0: 錯誤： -u 和 -t 不能同時使用（彼此互斥）" >&2
          exit 1
        fi
        user=$OPTARG;                   ;;
    t ) if [ ! -z "$user" ] ; then
          echo "$0: 錯誤： -u 和 -t 不能同時使用（彼此互斥）" >&2
          exit 1
        fi
        tty=$2;                         ;;
    n ) donothing=1; ;;
    ? ) echo "執行方式： $0 [-s signal] [-u user|-t tty] [-n] pattern" >&2
        exit 1
  esac
done

# 已利用getopts處理完所有指定的啟動選項...
shift $(( $OPTIND - 1 ))

# 如果使用者有指定任何啟動參數 （上面是檢測 -?）

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 [-s signal] [-u user|-t tty] [-n] pattern" >&2
  exit 1
fi

# 現在，需要根據指定的終端機、指定的使用者或目前使用者，產生符合查詢之 
#   PID的清單。
if [ ! -z "$tty" ] ; then
  pids=$(ps cu -t $tty | awk "/ $1$/ { print \$2 }")
elif [ ! -z "$user" ] ; then
  pids=$(ps cu -U $user | awk "/ $1$/ { print \$2 }")
else
  pids=$(ps cu -U ${USER:-LOGNAME} | awk "/ $1$/ { print \$2 }")
fi

# 都沒有符合的？那還不簡單！
if [ -z "$pids" ] ; then
  echo "$0: 找不符合「$1」的程序。" >&2
  exit 1
fi

for pid in $pids
do
  # 發送信號 $signal到程序代號 $pid： 如果遇到程序已執行完畢或者使用者
  #   無權終止此程序等情形，kill可能發出錯誤訊息，但無所謂，至少我們的
  #   目的已經達成。
  if [ $donothing -eq 1 ] ; then
    echo "kill $signal $pid"  # -n 選項 "只預演，不實際執行"
  else
    kill $signal $pid
  fi
done

exit 0
