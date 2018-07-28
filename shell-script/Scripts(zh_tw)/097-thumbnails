#!/bin/bash
# thumbnails--為指定圖檔建立縮圖，讓它符合或不超過指定的尺寸

convargs="-unsharp 0x.5 -resize"
count=0; exact=""; fit=""

usage()
{
  echo "執行方式： $0 (-e|-f) thumbnail-size image [image] [image]" >&2
  echo "-e  忽略原圖比例，讓縮圖填滿指定的大小" >&2
  echo "-f  依照原圖比例，將縮圖填入指定的大小" >&2
  echo "-s  剔除 EXIF 資料（供網頁使用）" >&2
  echo "    請使用 WIDTHxHEIGHT 指定尺寸（例如100x100）"
  exit 1
}

#############
## 主程式區塊
#############

if [ $# -eq 0 ] ; then
  usage
fi

while getopts "e:f:s" opt; do
  case $opt in
   e ) exact="$OPTARG";              ;;
   f ) fit="$OPTARG";                ;;
   s ) strip="-strip";             ;;
   ? ) usage;                        ;;
  esac
done
shift $(($OPTIND - 1))         # 載入所有已剖析的參數

rwidth="$(echo $exact $fit | cut -dx -f1)"    # 取得寬度
rheight="$(echo $exact $fit | cut -dx -f2)"   # 取得高度

for image
do
  width="$(identify -format "%w" "$image")"
  height="$(identify -format "%h" "$image")"

  # 為圖檔 $image 建立縮圖，寬度為 $width、高度為 $height
  if [ $width -le $rwidth -a $height -le $rheight ] ; then
    echo "圖檔 $image 已經比指定的尺寸還小，略過，不處理。"
  else

    # 建立新的檔案名稱
    suffix="$(echo $image | rev | cut -d. -f1 | rev)"
    prefix="$(echo $image | rev | cut -d. -f2- | rev)"
    newname="$prefix-thumb.$suffix"

    # 忽略原圖比例者，需要在尾端加入 "!"

    if [ -z "$fit" ] ; then
      size="$exact!"
      echo "為 $image 建立 ${rwidth}x${rheight}（符合大小）的縮圖。"
    else
      size="$fit"
      echo "為 $image 建立 ${rwidth}x${rheight}（原圖比例）的縮圖"
    fi

    convert "$image" $strip $convargs "$size" "$newname"
  fi
  count=$(( $count + 1 ))
done

if [ $count -eq 0 ] ; then
  echo "警告：找不到要處理的圖片。"
fi
exit 0
