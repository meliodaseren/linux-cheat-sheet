#!/bin/bash
# hangman-- 簡單的hangman猜字遊戲版本，不是真的顯示一個逐漸出現
#   的上吊人體，這只是猜錯時的倒數計步器，它只有一個選用的到絞刑
#   檯距離的參數。

wordlib="/usr/lib/games/long-words.txt"
empty="\."      # 當 $guessed="" 時，要有些東西給 sed [set] 處理
games=0

# 首先測試字詞庫資料檔。

if [ ! -r "$wordlib" ] ; then
  echo "$0: 找不到字詞庫 $wordlib" >&2
  echo "(請從 http://www.intuitive.com/wicked/examples/long-words.txt 下載，" >&2
  echo "並將檔案儲存到 $wordlib，再重新執行此遊戲！)" >&2
  exit 1
fi

# 大while迴圈的開始，主要功能都在這裡頭。

while [ "$guess" != "quit" ] ; do
  match="$(randomquote $wordlib)" # 從字詞庫中選擇一個新字。

  if [ $games -gt 0 ] ; then
    echo ""
    echo "*** 新的回合！ ***"
  fi

  games="$(( $games + 1 ))"
  guessed="" ; guess="" ; bad=${1:-6}
  partial="$(echo $match | sed "s/[^$empty${guessed}]/-/g")"

  # 下面迴圈處理：猜字 > 分析 > 顯示結果 > 再循環.

  while [ "$guess" != "$match" -a "$guess" != "quit" ] ; do

    echo ""
    if [ ! -z "$guessed" ] ; then   # 提示：「! –z」意思是非空值
      /bin/echo -n "你猜過的字母： $guessed，"
    fi
    echo "離絞刑檯 $bad 步，目前結果： $partial"

    /bin/echo -n "請猜一個字母： "
    read guess
    echo ""

    if [ "$guess" = "$match" ] ; then   # 猜中了！
      echo "你答對了！"
    elif [ "$guess" = "quit" ] ; then   # 你要結束遊戲，對吧！
      exit 0
      # 現在要用各種篩選方式來驗證猜測的結果。
    elif [ $(echo $guess | wc -c | sed 's/[^[:digit:]]//g') -ne 2 ] ; then
      echo "哦!哦!一次只能猜一個字母而已。"
    elif [ ! -z "$(echo $guess | sed 's/[[:lower:]]//g')" ] ; then
      echo "哦!哦!請使用小寫字母。"
    elif [ -z "$(echo $guess | sed "s/[$empty$guessed]//g")" ] ; then
      echo "哦!哦!「$guess」你已經猜過了。"
      # 如果所猜的字母是字詞中的字母，現在來看發生什麼事。
    elif [ "$(echo $match | sed "s/$guess/-/g")" != "$match" ] ; then
      guessed="$guessed$guess"
      partial="$(echo $match | sed "s/[^$empty${guessed}]/-/g")"
      if [ "$partial" = "$match" ] ; then
        echo "**任務完成！你已經被赦免了！這個字是 \"$match\"。"
        guess="$match"
      else
        echo "* 很好！字母 \"$guess\" 有出現在字詞中！"
      fi
    elif [ $bad -eq 1 ] ; then
      echo "** 哦!哦!你已走到絞刑檯，準備受死吧..."
      echo "** The word you were trying to guess was \"$match\""
      guess="$match"
    else
      echo "* 不妙！ \"$guess\" 沒有出現在字詞中！"
      guessed="$guessed$guess"
      bad=$(( $bad - 1 ))
    fi
  done
done
exit 0
