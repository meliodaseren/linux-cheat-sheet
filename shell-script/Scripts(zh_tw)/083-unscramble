#!/bin/bash
# unscramble--挑選一個單字或片語，將字母攪亂，然後要求使用者
#   猜出原來的單字或片語是什麼

wordlib="/usr/lib/games/long-words.txt"

scrambleword()
{
  # 從wordlib中隨機選擇一個字詞，並將它攪亂。
  #   原來的字存在 $match，攪亂後的字存在 $scrambled.

match="$(randomquote $wordlib)"

echo "已挑選一個字詞！"

len=${#match}
scrambled=""; lastval=1

for (( val=1; $val < $len ; ))
do
    if [ $(($RANDOM % 2)) -eq 1 ] ; then
      scrambled=$scrambled$(echo $match | cut -c$val)
    else
      scrambled=$(echo $match | cut -c$val)$scrambled
    fi
    val=$(( $val + 1 ))
  done
}

if [ ! -r $wordlib ] ; then
  echo "$0: 找不到字詞庫檔 $wordlib" >&2
  echo "(請從 http://www.intuitive.com/wicked/examples/long-words.txt 下載，" >&2
  echo "並將檔案儲存到 $wordlib ，再重新執行此遊戲！)" >&2
  exit 1
fi

newgame=""; guesses=0; correct=0; total=0

until [ "$guess" = "quit" ] ; do

  scrambleword
  echo ""
  echo "你需要將這個字還原： $scrambled"

  guess="??" ; guesses=0
  total=$(( $total + 1 ))

  while [ "$guess" != "$match" -a "$guess" != "quit" -a "$guess" != "next" ]
  do
    echo ""
    /bin/echo -n "請輸入你猜的內容 (quit|next)： "
    read guess

    if [ "$guess" = "$match" ] ; then
      guesses=$(( $guesses + 1 ))
      echo ""
      echo "*** 你猜測的次數是： ${guesses}！ 完全命中！***"
      echo ""
      correct=$(( $correct + 1 ))
    elif [ "$guess" = "next" -o "$guess" = "quit" ] ; then
      echo "原來的字詞是 \"$match\"，你已猜的次數是： $guesses"
    else
      echo "哦哦！這個字不對哦！請再試一遍。"
      guesses=$(( $guesses + 1 ))
    fi
  done
done

echo "執行完畢！你總共猜對 $correct 字，全部測驗共 $total 字。"
exit 0
