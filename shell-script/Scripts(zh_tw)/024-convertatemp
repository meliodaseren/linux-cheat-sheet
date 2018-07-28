#!/bin/bash

# convertatemp--一支溫度換算腳本，可以輸入華氏、攝氏及凱氏（又稱絕對溫度）
#   溫度，然後輸出等價的另二種溫度值。

if [ $# -eq 0 ] ; then
  cat << EOF >&2
執行方式： $0 temperature[F|C|K]
後置符號表示：
    F    輸入的是華式（預設）
    C    輸入的是攝式
    K    輸入的是凱式
EOF
  exit 1
fi

unit="$(echo $1|sed -e 's/[-[:digit:]]*//g' | tr '[:lower:]' '[:upper:]' )"
temp="$(echo $1|sed -e 's/[^-[:digit:]]*//g')"

case ${unit:=F}
in
F ) # 華氏溫度轉攝氏的公式為： Tc = (F - 32) / 1.8
  farn="$temp"
  cels="$(echo "scale=2;($farn - 32) / 1.8" | bc)"
  kelv="$(echo "scale=2;$cels + 273.15" | bc)"
  ;;

C ) # 攝氏溫度轉華氏的公式為： Tf = (9/5)*Tc+32
  cels=$temp
  kelv="$(echo "scale=2;$cels + 273.15" | bc)"
  farn="$(echo "scale=2;(1.8 * $cels) + 32" | bc)"
  ;;

K ) # 攝氏溫度 = 凱氏 - 273.15，然後再利用攝氏轉華氏的公式
  kelv=$temp
  cels="$(echo "scale=2; $kelv - 273.15" | bc)"
  farn="$(echo "scale=2; (1.8 * $cels) + 32" | bc)"
  ;;

  *)
  echo "不支援你所指定的溫度單位"
  exit 1
esac

echo "華氏溫度 = $farn"
echo "攝氏溫度 = $cels"
echo "凱氏溫度 = $kelv"

exit 0
