#!/bin/bash
# screencapture2--使用OS X 的screencapture指令在隱匿情形下擷取
#   主窗口的一連串畫面，如果電腦正好有問題，這可以方便協助除錯！

capture="$(which screencapture) -x -m -C"
freq=60         # 每隔 60 秒擷取一個畫面
maxshots=30     # 最多要擷取幾幀畫面
animate=0       # 是否要組成動畫形式的 gif 檔？預設為No.

while getopts "af:m" opt; do
  case $opt in
    a ) animate=1;                  ;;
    f ) freq=$OPTARG;               ;;
    m ) maxshots=$OPTARG;           ;; # 擷取幾幀之後結束程式
    ? ) echo "執行方式： $0 [-a] [-f frequency] [-m maxcaps]" >&2
        exit 1
  esac
done

counter=0

while [ $counter -lt $maxshots ] ; do
  $capture capture${counter}.jpg   # 畫面計數器持續遞增.
  counter=$(( counter + 1 ))
  sleep $freq   # freq 是指每幀畫面的間隔秒數
done

# 這裡是選用功能，將個別的畫面壓縮到一支動畫播放的 GIF 檔

if [ $animate -eq 1 ] ; then
  convert -delay 100 -loop 0 -resize "33%" capture* animated-captures.gif
fi

# 為了保持隱匿，沒有輸出執行狀態碼
exit 0
