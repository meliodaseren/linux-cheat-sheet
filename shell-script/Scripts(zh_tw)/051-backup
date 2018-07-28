#!/bin/bash

# backup--建立系統上一組事先指定的目錄之完整或增量備份，預設情況，輸出
#   檔案以壓縮方式儲存在 /tmp，並在檔名加上時間戳記，或者另外指定輸出
#   目的設備（另一個磁碟、卸除式設備或其他任何地方）。

compress="bzip2"                # 請自行改成你喜歡的壓縮工具。
 inclist="/tmp/backup.inclist.$(date +%d%m%y)"
  output="/tmp/backup.$(date +%d%m%y).bz2"
  tsfile="$HOME/.backup.timestamp"
   btype="增量"                 # 預設採增量備份
   noinc=0                      # 是否要更新時間戳記

trap "/bin/rm -f $inclist" EXIT

usageQuit()
{
  cat << "EOF" >&2
執行方式： $0 [-o output] [-i|-f] [-n]
  -o 自行指定備份的目的路徑（檔案或設備）
  -i 採增量備份；  -f 採完整備份；
  -n 當完成增量備份作業時，不要更新時間戳記
EOF
  exit 1
}

########## 主要程式區塊從這裡開始 ###########

while getopts "o:ifn" arg; do
  case "$opt" in
    o ) output="$OPTARG";    ;; # 使用getopts 自動處理 OPTARG.
    i ) btype="增量"; ;;
    f ) btype="完整";        ;;
    n ) noinc=1;             ;;
    ? ) usageQuit            ;;
  esac
done

shift $(( $OPTIND - 1 ))

echo "執行$btype備份，將輸出儲存到 $output"

timestamp="$(date +'%m%d%I%M')"  # 從date的輸出抓取 月、日、時、分 的值
                                 # 想知道 date 格式嗎？執行"man strftime"

if [ "$btype" = "增量" ] ; then
  if [ ! -f $tsfile ] ; then
    echo "錯誤： 無法進行增量備份：找不到時間戳記檔。" >&2
    exit 1
  fi
  find $HOME -depth -type f -newer $tsfile -user ${USER:-LOGNAME} | \
  pax -w -x tar | $compress > $output
  failure="$?"
else
  find $HOME -depth -type f -user ${USER:-LOGNAME} | \
  pax -w -x tar | $compress > $output
  failure="$?"
fi

if [ "$noinc" = "0" -a "$failure" = "0" ] ; then
  touch -t $timestamp $tsfile
fi
exit 0
