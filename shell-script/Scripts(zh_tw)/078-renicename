#!/bin/bash
# renicename--讓Renices 可以調整指定名稱的程式之執行優先權。

user=""; tty=""; showpid=0; niceval="+1"     # 設定初始值

while getopts "n:u:t:p" opt; do
  case $opt in
  n ) niceval="$OPTARG";              ;;
  u ) if [ ! -z "$tty" ] ; then
        echo "$0: 錯誤： -u 和 -t 不能同時使用。" >&2
        exit 1
      fi
      user=$OPTARG                    ;;
  t ) if [ ! -z "$user" ] ; then
        echo "$0: 錯誤： -u 和 -t 不能同時使用。" >&2
        exit 1
      fi
      tty=$OPTARG                     ;;
  p ) showpid=1;                      ;;
  ? ) echo "執行方式： $0 [-n niceval] [-u user|-t tty] [-p] pattern" >&2
      echo "預設的 niceval 變更是 \"$niceval\" （正號(+)是降低優先權、" >&2
      echo "負號(-)是提高優先權，但需要 root權限才能設在 0以下）" >&2
      exit 1
  esac
done
shift $(($OPTIND - 1))     # 讀入所有剖析後的參數

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 [-n niceval] [-u user|-t tty] [-p] pattern" >&2
  exit 1
fi

if [ ! -z "$tty" ] ; then
  pid=$(ps cu -t $tty | awk "/ $1/ { print \\$2 }")
elif [ ! -z "$user" ] ; then
  pid=$(ps cu -U $user | awk "/ $1/ { print \\$2 }")
else
  pid=$(ps cu -U ${USER:-LOGNAME} | awk "/ $1/ { print \$2 }")
fi

if [ -z "$pid" ] ; then
  echo "$0: 找不到符合 $1 的程序" >&2
  exit 1
elif [ ! -z "$(echo $pid | grep ' ')" ] ; then
  echo "$0: 有超過一個以上的程序符合 ${1}:"
  if [ ! -z "$tty" ] ; then
    runme="ps cu -t $tty"
  elif [ ! -z "$user" ] ; then
    runme="ps cu -U $user"
  else
    runme="ps cu -U ${USER:-LOGNAME}"
  fi

  eval $runme | \
    awk "/ $1/ { printf \" user %-8.8s pid %-6.6s job %s\n\", \
    \$1,\$2,\$11 }"
  echo "使用 -u user 或 -t tty 以縮小選擇的範圍。"
elif [ $showpid -eq 1 ] ; then
  echo $pid
else
  # 萬事俱備，整軍出發！
  /bin/echo -n "調整程序的優先權\""
  /bin/echo -n $(ps cp $pid | sed 's/ [ ]*/ /g' | tail -1 | cut -d\ -f6-)
  echo "\" ($pid)"
  renice $niceval $pid
fi

exit 0
