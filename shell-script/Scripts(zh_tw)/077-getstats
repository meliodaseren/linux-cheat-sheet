#!/bin/bash
# getstats--每隔 'n' 分鐘就擷取 netstat 的輸出內容 (利用排程)

logfile="/Users/taylor/.netstatlog"    # 請修正你的設定
temp="/tmp/getstats.$$.tmp"

trap "$(which rm) -f $temp" 0

if [ ! -e $logfile ] ; then            # 第一次執行嗎？
  touch $logfile
fi
( netstat -s -p tcp > $temp
 # 第一次運行時檢查日誌檔案：有些版本的netstat對同一事件會回報
 #   多行資料，這就是為什麼在這裡要使用 "| head -1"的原因。
sent="$(grep 'packets sent' $temp | cut -d\ -f1 | sed \
 's/[^[:digit:]]//g' | head -1)"
 resent="$(grep 'retransmitted' $temp | cut -d\ -f1 | sed \
 's/[^[:digit:]]//g')"
 received="$(grep 'packets received$' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"
 dupacks="$(grep 'duplicate acks' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"
 outoforder="$(grep 'out-of-order packets' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"
 connectreq="$(grep 'connection requests' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"
 connectacc="$(grep 'connection accepts' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"
 retmout="$(grep 'retransmit timeouts' $temp | cut -d\ -f1 | \
   sed 's/[^[:digit:]]//g')"

 /bin/echo -n "time=$(date +%s);"
/bin/echo -n "snt=$sent;re=$resent;rec=$received;dup=$dupacks;"
 /bin/echo -n "oo=$outoforder;creq=$connectreq;cacc=$connectacc;"
 echo "reto=$retmout"

 ) >> $logfile

 exit 0
