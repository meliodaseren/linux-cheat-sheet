#!/bin/bash
# frameit--使用ImageMagick讓添加圖片邊框的工作更輕鬆

usage()
{
cat << EOF
執行方式： $(basename $0) -b border -c color imagename
    或者： $(basename $0) -f frame -m color imagename

第一種情況，以WIDTHxHEIGHT或百分比方式指定邊框大小，後面跟著的
    是邊框顏色（使用RGB值或顏色名稱）。

第二種情況，指定新畫布的大小及偏移量，後面跟著紋路的顏色。

執行範例：
  $(basename $0) -b 15x15 -c black imagename
  $(basename $0) -b 10%x10% -c gray imagename

  $(basename $0) -f 10x10+10+0 imagename
  $(basename $0) -f 6x6+2+2 -m tomato imagename
EOF
exit 1
}
##########################
#### 主程式區塊
##########################

# 主要是在解析執行時指定的參數！

while getopts "b:c:f:m:" opt; do
  case $opt in
    b ) border="$OPTARG";          ;;
    c ) bordercolor="$OPTARG";     ;;
    f ) frame="$OPTARG";           ;;
    m ) mattecolor="$OPTARG";      ;;
    ? ) usage;                     ;;
  esac
done
shift $(($OPTIND - 1))      # 載入所有已解析的參數。

if [ $# -eq 0 ] ; then      # 沒有指定圖片檔？
  usage
fi

# 同時指定了邊界和畫布大小？

if [ ! -z "$bordercolor" -a ! -z "$mattecolor" ] ; then
  echo "$0: 你不能同時指定單一顏色（-c），又指定顏色紋路（-m）值。" >&2
  exit 1
fi

if [ ! -z "$frame" -a ! -z "$border" ] ; then
  echo "$0: 你不能同時指定邊框（-b），又指定新畫布大小（-f）。" >&2
  exit 1
fi

if [ ! -z "$border" ] ; then
 args="-bordercolor $bordercolor -border $border"
else
 args="-mattecolor $mattecolor -frame $frame"
fi


for name
do
  suffix="$(echo $name | rev | cut -d. -f1 | rev)"
  prefix="$(echo $name | rev | cut -d. -f2- | rev)"
  newname="$prefix+f.$suffix"
  echo "將畫框加到 $name，並儲存成 $newname"
  convert $name $args $newname
done

exit 0
