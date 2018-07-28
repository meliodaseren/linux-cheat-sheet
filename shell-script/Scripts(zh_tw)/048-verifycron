#!/bin/bash
# verifycron--檢查crontab檔案，以確認它的格式正確。
#   要求 min hr dom mon cmd CMD的標準cron表示式，其中min是0-59，
#   hr是0-23，dom是1-31，mon為1-12（或名稱），dow為0-7（或名稱 ）。
#   欄位可以是範圍（a-e）或逗號分隔的清單（a,c,z）或是一個星號。
#   注意，目前版本的腳本不支持Vixie cron的步進值表示式（例如 2-6/2）。

validNum()
{
  # 如果提供的數值是有效的整數，就回傳0，否則回傳 1。
  #   同時提供待測的值及最大值做為參數給此函式
  num=$1 max=$2

  # 為了簡化起見，欄位中的星號會被改寫為"X"，因此任何以"X"
  #   形式表示的數字都是有效的。

  if [ "$num" = "X" ] ; then
    return 0
  elif [ ! -z $(echo $num | sed 's/[[:digit:]]//g') ] ; then
    # 移除所有數字，最後不是空的？表示有問題。
    return 1
  elif [ $num -gt $max ] ; then
    # 待測的數字大於允許的最大值。
    return 1
  else
    return 0
  fi
}

validDay()
{
  # 如果傳給此函數的星期名稱是有效的就回傳0，否則回傳 1

  case $(echo $1 | tr '[:upper:]' '[:lower:]') in
    sun*|mon*|tue*|wed*|thu*|fri*|sat*) return 0 ;;
    X) return 0 ;;        # 特殊情況，它是"*"的改寫值
    *) return 1
  esac
}

validMon()
{
  # 如果傳給此函數的月份名稱是有效的就回傳0，否則回傳 1.

  case $(echo $1 | tr '[:upper:]' '[:lower:]') in
    jan*|feb*|mar*|apr*|may|jun*|jul*|aug*) return 0      ;;
    sep*|oct*|nov*|dec*) return 0                         ;;
    X) return 0 ;;       #特殊情況，它是"*"的改寫值"
    *) return 1          ;;
  esac
}

fixvars()
{
  # 將所有'*'轉換為'X'以繞過命令環境的擴展問題。
  # 將原始輸入儲存到"sourceline"做為錯誤訊息。

  sourceline="$min $hour $dom $mon $dow $command"
    min=$(echo "$min" | tr '*' 'X')   # 分
    hour=$(echo "$hour" | tr '*' 'X') # 時
    dom=$(echo "$dom" | tr '*' 'X')   # 月份的日期
    mon=$(echo "$mon" | tr '*' 'X')   # 月份
    dow=$(echo "$dow" | tr '*' 'X')   # 星期幾
}

if [ $# -ne 1 ] || [ ! -r $1 ] ; then
  # 如果沒有指定crontab檔案或無法讓腳本讀取，則檢查失敗。
  echo "執行方式： $0 usercrontabfile" >&2
  exit 1
fi

lines=0 entries=0 totalerrors=0

# 逐行瀏覽crontab內容，檢查每筆設定。

while read min hour dom mon dow command
do
  lines="$(( $lines + 1 ))"
  errors=0

  if [ -z "$min" -o "${min%${min#?}}" = "#" ] ; then
    # 如果是空白行或第一個字符是"#"就略過。
    continue # Nothing to check
  fi

  ((entries++))

  fixvars

  # 到這裡，目前這一行中的所有欄位已拆分為獨立的變數，為方便起見，所有
  #   星號都替換為"X"，讓我們檢查輸入欄位的有效性...

  #   檢查分鐘

  for minslice in $(echo "$min" | sed 's/[,-]/ /g') ; do
    if ! validNum $minslice 59 ; then
      echo "Line ${lines}: 無效的分鐘數 \"$minslice\""
      errors=1
    fi
  done

  # 檢查小時

  for hrslice in $(echo "$hour" | sed 's/[,-]/ /g') ; do
    if ! validNum $hrslice 23 ; then
      echo "Line ${lines}: 無效的小時值 \"$hrslice\""
      errors=1
    fi
  done

  # 檢查每月日子

  for domslice in $(echo $dom | sed 's/[,-]/ /g') ; do
    if ! validNum $domslice 31 ; then
      echo "Line ${lines}: 無效每月的日子 \"$domslice\""
      errors=1
    fi
  done

  # 月份檢查：必須同時檢查數值型和名稱型。
  #   記住，"if ! cond" 是用指不符合指定cond條件時才成。

  for monslice in $(echo "$mon" | sed 's/[,-]/ /g') ; do
    if ! validNum $monslice 12 ; then
      if ! validMon "$monslice" ; then
        echo "Line ${lines}: 無效的月份值或名稱 \"$monslice\""
        errors=1
      fi
    fi
  done

  # 星期檢查：星期幾仍然可能使用名稱型或數值型。

  for dowslice in $(echo "$dow" | sed 's/[,-]/ /g') ; do
    if ! validNum $dowslice 7 ; then
      if ! validDay $dowslice ; then
        echo "Line ${lines}: 無效的星期值或名稱 \"$dowslice\""
        errors=1
      fi
    fi
  done

  if [ $errors -gt 0 ] ; then
    echo ">>>> ${lines}: $sourceline"
    echo ""
    totalerrors="$(( $totalerrors + 1 ))"
  fi
done < $1 # 讀取傳給此腳本做為參數的crontab 

# 這裡要注意，在while迴圈最後將輸入導向進來，這樣使用者指定的檔案
#   就能被腳本檢查！

echo "檢查完畢！找到 $totalerrors 筆錯誤，從 $entries 筆crontab 的項目中。"

exit 0
