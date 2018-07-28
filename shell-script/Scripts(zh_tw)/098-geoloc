#!/bin/bash
# geoloc--對於含有GPS資訊的圖片，將這些資訊轉換成一組可供Google Maps 
#   或 Bing Maps使用的字串。

tempfile="/tmp/geoloc.$$"

trap "$(which rm) -f $tempfile" 0 1 15

if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) image" >&2
  exit 1
fi

for filename
do
  identify -format "%[EXIF:*]" "$filename" | grep GPSL > $tempfile


  latdeg=$(head -1 $tempfile | cut -d, -f1 | cut -d= -f2)
  latdeg=$(scriptbc -p 0 $latdeg)
  latmin=$(head -1 $tempfile | cut -d, -f2)
  latmin=$(scriptbc -p 0 $latmin)
  latsec=$(head -1 $tempfile | cut -d, -f3)
  latsec=$(scriptbc $latsec)
  latorientation=$(sed -n '2p' $tempfile | cut -d= -f2)

  longdeg=$(sed -n '3p' $tempfile | cut -d, -f1 | cut -d= -f2)
  longdeg=$(scriptbc -p 0 $longdeg)
  longmin=$(sed -n '3p' $tempfile | cut -d, -f2)
  longmin=$(scriptbc -p 0 $longmin)
  longsec=$(sed -n '3p' $tempfile | cut -d, -f3)
  longsec=$(scriptbc $longsec)
  longorientation=$(sed -n '4p' $tempfile | cut -d= -f2)

  echon "地理座標： $latdeg ${latmin}' ${latsec}\" $latorientation, "
  echo "$longdeg ${longmin}' ${longsec}\" $longorientation"

done
exit 0
