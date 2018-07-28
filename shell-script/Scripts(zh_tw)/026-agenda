#!/bin/sh

# agenda--掃描整個使用者的 .agenda 檔案，搜尋今天或明天的活動資料


agendafile="$HOME/.agenda"

checkDate()
{
  # 建立用來搜尋今天活動的日期
  weekday=$1 day=$2 month=$3 year=$4
  format1="$weekday" format2="$day$month" format3="$day$month$year"

  # 然後掃描整個檔案，比對所有日期...

  IFS="|"     # 設定IFS(Internal Field Seprator)符號為 |

  echo "今天的活動有："
  while read date description ; do
    if [ "$date" = "$format1" -o "$date" = "$format2" -o \
      "$date" = "$format3" ]
    then
      echo " $description"
    fi
  done < $agendafile
}

if [ ! -e $agendafile ] ; then
  echo "$0: 你似乎還沒有 .agenda 檔。 " >&2
  echo "記得使用 'addagenda' 新增行事曆。" >&2
  exit 1
fi

# 現在可以搜尋今天的約會了...

eval $(date '+weekday="%a" month="%b" day="%e" year="%G"')

day="$(echo $day|sed 's/ //g')" # 移除前面的空格。

checkDate $weekday $day $month $year

exit 0
