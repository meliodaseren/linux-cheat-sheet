#!/bin/bash
# rolldice--解析使用者要求「擲」出的骰子，並模擬它們的滾動。
#   例如：        d6 = 一顆6面的骰子
#               2d12 = 二顆12 面的骰子
#        d4 3d8 2d20 = 一顆 4 面、三顆 8 面及二顆 20 面的骰子

rolldie()
{
  dice=$1
  dicecount=1
  sum=0

  # 第一步：將參數分解成MdN（M是顆數，N是面數）。
  if [ -z "$(echo $dice | grep 'd')" ] ; then
    quantity=1
    sides=$dice
  else
    quantity=$(echo $dice | cut -dd -f1)
    if [ -z "$quantity" ] ; then       # 使用者指定dN，而非只有 N
      quantity=1
    fi
    sides=$(echo $dice | cut -dd -f2)
  fi

  echo "" ; echo "擲出 $quantity 顆 $sides 面的骰子。"

  # 現在來擲骰子...

  while [ $dicecount -le $quantity ] ; do
    roll=$(( ( $RANDOM % $sides ) + 1 ))
    sum=$(( $sum + $roll ))
    echo " roll #$dicecount = $roll"
    dicecount=$(( $dicecount + 1 ))
  done

  echo 我擲 $dice 小計為 $sum
}

while [ $# -gt 0 ] ; do
  rolldie $1
  sumtotal=$(( $sumtotal + $sum ))
  shift
done

echo ""
echo "這些骰子加總結果為 $sumtotal"
echo ""
exit 0
