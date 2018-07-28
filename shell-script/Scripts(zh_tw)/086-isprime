#!/bin/bash
# isprime-- 提供一個數字，判斷它是否為質數，使用所謂的試除法：簡單地
#   用2到（n/2）的所有整數來除，看有沒有能整除的數字。

  counter=2
remainder=1

if [ $# -eq 0 ] ; then
  echo "執行方式： isprime NUMBER" >&2
  exit 1
fi

number=$1

# 3 和 2 是質數，1 不算

if [ $number -lt 2 ] ; then
  echo "不對， $number 不是質數。"
  exit 0
fi

# 現在就進行一些計算。

while [ $counter -le $(expr $number / 2) -a $remainder -ne 0 ]
do
  remainder=$(expr $number % $counter)  # '/' 是除號，'%' 是求餘數
  # echo "  對於計數 $counter，求得的餘數為 $remainder"
  counter=$(expr $counter + 1)
done

if [ $remainder -eq 0 ] ; then
  echo "不對， $number 不是質數。"
else
  echo "是的， $number 是質數。"
fi
exit 0
