#!/bin/bash
# aceyduecey: 發牌者翻開兩張牌，你猜從牌堆翻開的下一張牌點數是否會落
#   在這兩張牌之間，例如，兩張牌是6和8，則7是在兩者之間，而9就不是。

function initializeDeck
{
    # 產生一副撲克牌

    card=1
    while [ $card –le 52 ]      # 一副牌有52 張，你應該知道吧？
    do
      deck[$card]=$card
      card=$(( $card + 1 ))
    done
}

function shuffleDeck
{
    # 這不是真的洗牌，只是以隨機方式從牌組中取出牌卡的值，然後建立
    #   「洗牌」後的牌堆 newdeck []陣列。

    count=1

    while [ $count != 53 ]
    do
      pickCard
      newdeck[$count]=$picked
      count=$(( $count + 1 ))
    done
}

function pickCard
{
    # 這是最有趣的功能：從牌堆隨機挑一張牌卡。利用deck[]陣列找出可用的牌。

    local errcount randomcard

    threshold=10       # 設定最大隨機抽牌失敗次數
    errcount=0

    # 隨機選擇一張尚未從牌組中移走的牌，隨機嘗試失敗最多為$threshold
    #   次，超過這個次數就算洗牌失敗（避免它繼續猜測已經移走的牌而形成
    #   無限迴圈）。

    while [ $errcount -lt $threshold ]
      do
        randomcard=$(( ( $RANDOM % 52 ) + 1 ))
        errcount=$(( $errcount + 1 ))

        if [ ${deck[$randomcard]} -ne 0 ] ; then
          picked=${deck[$randomcard]}
          deck[$picked]=0                # 牌已抽走
          return $picked
        fi
      done

      # 若走到這裡，已不能再隨機抽牌，只能掃描整個陣列，直到找到一張
      #   可用的牌。

      randomcard=1

    while [ ${desk[$randomcard]} -eq 0 ]  # 原文程式碼這一行有誤，已修正
      do
        randomcard=$(( $randomcard + 1 ))
      done

      picked=$randomcard
      deck[$picked]=0          # 牌已抽走

      return $picked
}

function showCard
{
    # 這組副程式使用div和mod計算花色和點數，雖然在這個遊戲中，只有點數
    #   是重點，但是顯示結果仍然重要，這會讓過程更加合理。

    card=$1

    if [ $card -lt 1 -o $card -gt 52 ] ; then
      echo "錯誤的點數： $card"
      exit 1
    fi

    # div 及 mod -- 看吧！學校學的算術都沒有浪費！

    suit="$(( ( ( $card - 1) / 13 ) + 1))"
    rank="$(( $card % 13))"

    case $suit in
      1 ) suit="紅心"    ;;
      2 ) suit="梅花"    ;;
      3 ) suit="黑桃"    ;;
      4 ) suit="紅磚"    ;;
      * ) echo "錯誤的花色值： $suit"
          exit 1
    esac

    case $rank in
      0 ) rank="King"     ;;
      1 ) rank="Ace"      ;;
      11) rank="Jack"     ;;
      12) rank="Queen"    ;;
    esac

    cardname="$suit$rank"
}

function dealCards
{
    # Acey Deucey 要先翻兩張牌...

    card1=${newdeck[1]}    # 已經完成洗牌動作，從牌組的上面翻兩張牌
    card2=${newdeck[2]}    
    card3=${newdeck[3]}    # 抽出的第三張牌暫時蓋起來

    rank1=$(( ${newdeck[1]} % 13 ))   # 接著算出這些牌的點數，
    rank2=$(( ${newdeck[2]} % 13 ))   # 讓接下來的計算變容易。
    rank3=$(( ${newdeck[3]} % 13 ))

    # 修正 king的值，內設是0，要轉成 13。

    if [ $rank1 -eq 0 ] ; then
      rank1=13;
    fi
    if [ $rank2 -eq 0 ] ; then
      rank2=13;
    fi
    if [ $rank3 -eq 0 ] ; then
      rank3=13;
    fi

    # 現在整理一下翻開的牌，讓第一張牌的點數總是小於第二張牌

    if [ $rank1 -gt $rank2 ] ; then
      temp=$card1; card1=$card2; card2=$temp
      temp=$rank1; rank1=$rank2; rank2=$temp
    fi

    showCard $card1 ; cardname1=$cardname
    showCard $card2 ; cardname2=$cardname

    showCard $card3 ; cardname3=$cardname    # 噓！這張牌是秘密。

    echo "我已經發了：" ; echo " $cardname1" ; echo " $cardname2"

}

function introblurb
{
cat << EOF

歡迎來到Acey Deucey。這個遊戲的目標是，我從牌組中翻兩張牌，你正確猜出第三張
牌的點數是否會落這兩張牌之間，比如，我翻出紅心5和紅磚jack（11），你要賭下
一張牌是否比5大及比jack小（即任何花色的6、7、8、9或10）。

準備好了嗎？開始玩囉！
EOF
}

#######################
##  主程式從這裡開始
#######################

games=0                     # 計算玩了幾次
won=0                       # 計算贏了幾次

if [ $# -gt 0 ] ; then      # 如果指定參數，就顯示實用的訊息
  introblurb
fi

while [ /bin/true ] ; do

  initializeDeck
  shuffleDeck
  dealCards

  splitValue=$(( $rank2 - $rank1 ))

  if [ $splitValue -eq 0 ] ; then
    echo "當兩張牌同點數時，沒有點數可賭！"
    continue
  fi

  /bin/echo -n "兩張牌的差距是 $splitValue，你猜下一張牌的點數"
  /bin/echo -n "會落在它們之間嗎？(y/n/q) "
  read answer

  if [ "$answer" = "q" ] ; then
    echo ""
    echo "你玩了 $games 次，共贏了 $won 次。"
    exit 0
  fi

  echo "我抽的是： $cardname3"

  # 它在兩者之間嗎？ 我們檢查一下，記住，點數相等就算輸。
  if [ $rank3 -gt $rank1 -a $rank3 -lt $rank2 ] ; then  # 贏家!
    winner=1
  else
    winner=0
  fi

  if [ $winner -eq 1 -a "$answer" = "y" ] ; then
    echo "你賭它會落在兩者之間，事實也是，你贏！"
    won=$(( $won + 1 ))
  elif [ $winner -eq 0 -a "$answer" = "n" ] ; then
    echo "你賭它不會落在兩者之間，事實也是，你贏！"
    won=$(( $won + 1 ))
  else
    echo "不良的投注策略。你輸了！"
  fi

  games=$(( $games + 1 ))    # 你總共玩了幾次？

done

exit 0
