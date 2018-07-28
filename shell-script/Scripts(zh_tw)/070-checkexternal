#!/bin/bash

# checkexternal--測試網站上的所有URL以便建立外部參照清單，然後
#   逐一檢查URL以確定哪些可能已停止服務或失效， -a選項讓此腳本
#   列出所有符合的鏈結，不論它們是否可存取; 預設只顯示無法存取
#   （無效）的鏈結。

listall=0; errors=0; checked=0

if [ "$1" = "-a" ] ; then
  listall=1; shift
fi

if [ -z "$1" ] ; then
  echo "執行方式： $(basename $0) [-a] URL" >&2
  exit 1
fi

trap "$(which rm) -f traverse*.errors reject*.dat traverse*.dat" 0

outfile="$(echo "$1" | cut -d/ -f3).errors.ext"
URLlist="$(echo $1 | cut -d/ -f3 | sed 's/www\.//').rejects"

rm -f $outfile     # 已可接受新的輸出

if [ ! -e "$URLlist" ] ; then
  echo "檔案 $URLlist 找不到，請先執行 checklinks 腳本。" >&2
  exit 1
fi

if [ ! -s "$URLlist" ] ; then
  echo "沒有發現任何的外部鏈結 ($URLlist 是空的)。" >&2
  exit 1
fi

#### 現在萬事俱備，就要開始了...
for URL in $(cat $URLlist | sort | uniq)
do
  curl -s "$URL" > /dev/null 2>&1; return=$?
  if [ $return -eq 0 ] ; then
    if [ $listall -eq 1 ] ; then
      echo "找到 $URL"
    fi
  else
    echo "$URL 無效，錯誤碼為 $return"
    errors=$(( $errors + 1 ))
  fi
  checked=$(( $checked + 1 ))
done

echo ""
echo "處理完成！已檢查 $checked 筆鏈結，並發現 $errors 個錯誤。"
exit 0
