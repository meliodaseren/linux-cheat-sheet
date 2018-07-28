#!/bin/bash
# hilow--一支簡單的數字猜謎遊戲

biggest=100                  # 最大的數值
guess=0                      # 玩家所猜的數字
guesses=0                    # 玩家已猜過的次數
number=$(( $$ % $biggest )   # 腳本隨機產生的數值，會落在1到 $biggest之間
echo "請猜一個 1 到 $biggest之間的數字"

while [ "$guess" -ne $number ] ; do
  /bin/echo -n "你猜的數？ " ; read answer
  if [ "$guess" -lt $number ] ; then
    echo "... 太大！"
  elif [ "$guess" -gt $number ] ; then
    echo "... 太小！
  fi
  guesses=$(( $guesses + 1 ))
done

echo "賓果！你猜的 $number 是在 $guesses 次內猜中。"

exit 0
