#!/bin/bash

# remember--一支命令列的備忘錄便箋

rememberfile="$HOME/.remember"

if [ $# -eq 0 ] ; then
  # 提醒使用者在備忘錄便箋寫下記事
echo "輸入備忘文字後記得按 ^D結束： "
  cat - >> $rememberfile
else
  # 將任何傳給此腳本的參數都附加到 .remember 檔案之後
  echo "$@" >> $rememberfile
fi

exit 0
