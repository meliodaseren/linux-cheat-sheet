#!/bin/bash
# states--各州首都的猜測遊戲，需州首都的資料檔案state.capitals.txt。

db="/usr/lib/games/state.capitals.txt"     # 格式為 州[tab]首都

if [ ! -r "$db" ] ; then
  echo "$0: 無法讀取 $db。" >&2
  echo "(請先取得 state.capitals.txt" >&2
  echo "並將它儲存於 $db，再重新執行此遊戲！)" >&2
  exit 1
fi

guesses=0; correct=0; total=0

while [ "$guess" != "quit" ] ; do

  thiskey="$(randomquote $db)"

  # $thiskey 是已選中的那一行內容，現在要抓出州及首都資訊，
  #   而 "match" 是全小寫的首都名稱。

  state="$(echo $thiskey | cut -d\ -f1 | sed 's/-/ /g')"
  city="$(echo $thiskey | cut -d\ -f2 | sed 's/-/ /g')"
  match="$(echo $city | tr '[:upper:]' '[:lower:]')"

  guess="??" ; total=$(( $total + 1 )) ;

  echo ""
  echo "哪個城市是 $state 的首都？"

  # 所有遊戲都在主迴圈中進行，腳本會一直執行到猜對首都或
  #   使用者輸入 next 改猜下一州、或輸入 quit 結束遊戲。

  while [ "$guess" != "$match" -a "$guess" != "next" -a "$guess" != "quit" ]
  do
    /bin/echo -n "請輸入答案： "
    read guess

    if [ "$guess" = "$match" -o "$guess" = "$city" ] ; then
      echo ""
      echo "*** 完全正確！幹得好！ ***"
      correct=$(( $correct + 1 ))
      guess=$match
    elif [ "$guess" = "next" -o "$guess" = "quit" ] ; then
      echo ""
      echo "$city 是 $state 的首都。"   # 你應該已經知道了 :)
      else
      echo "這個答案恐怕不正確哦！"
    fi
  done

done

echo "你猜對了 $correct 題，總共發問 $total 題。"
exit 0
