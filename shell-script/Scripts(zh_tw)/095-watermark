#!/bin/bash
# watermark--將指定的文字當作浮水印，添加到輸入的圖片上，然後儲存成
#   尾隨「+wm」標記的檔案。 

wmfile="/tmp/watermark.$$.png"
fontsize="44"                           # 應該改成參數方式

trap "$(which rm) -f $wmfile" 0 1 15    # 在完成之後不會留下暫存檔

if [ $# -ne 2 ] ; then
  echo "執行方式： $(basename $0) imagefile \"浮水印文字\"" >&2
  exit 1
fi

if [ ! -r "$1" ] ; then
  echo "$(basename $0): 無法讀取輸入的圖片檔 $1" >&2
  exit 1
fi

# 一開始先取得圖片的尺寸。
dimensions="$(identify -format "%G" "$1")"

# 建立臨時的浮水印圖層。
convert -size $dimensions xc:none -pointsize $fontsize -gravity south \
  -draw "fill black text 1,1 '$2' text 0,0 '$2' fill white text 2,2 '$2'" \
  $wmfile

# 現在將浮水印圖層與原圖結合。
suffix="$(echo $1 | rev | cut -d. -f1 | rev)"
prefix="$(echo $1 | rev | cut -d. -f2- | rev)"
newfilename="$prefix+wm.$suffix"
composite -dissolve 75% -gravity south $wmfile "$1" "$newfilename"

echo "新建立的浮水印圖片為： $newfilename。"
exit 0
