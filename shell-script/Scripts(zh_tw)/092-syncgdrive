#!/bin/bash
# syncgdrive--讓您指定一支以上的檔案，以便自動複製到你的Google
#   雲端硬碟，和你的雲端帳戶達成同步

gdrive="$HOME/Google Drive"
gsync="$gdrive/gsync"
gapp="Google Drive.app"

if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) [file or files to sync]" >&2
  exit 1
fi

# 首先確認 Google Driver是否正在運行？ 如果沒有，就啟動它。
if [ -z "$(ps -ef | grep "$gapp" | grep -v grep)" ] ; then
  echo "正在啟動 Google Drive 服務..."
  open -a "$gapp"
fi

# 現在來看看 /gsync 資料夾是否存在？
if [ ! -d "$gsync" ] ; then
  mkdir "$gsync"
  if [ $? -ne 0 ] ; then
    echo "$(basename $0): 嘗試建立（mkdir） $gsync 失敗。" >&2
    exit 1
  fi
fi

for name                # 以迴圈方式處理傳遞給此腳本的所有參數
do
  echo "複製檔案 $name 到你的 Google 雲端硬碟。"
  cp -a "$name" "$gdrive/gsync/"
done

exit 0
