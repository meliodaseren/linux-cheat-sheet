#!/bin/bash

# addagenda--提示使用者加入新的活動，以便供agenda使用

agendafile="$HOME/.agenda"

isDayName()
{
  # 若順利完成就回傳 0 ，若發生錯誤就回傳 1

  case $(echo $1 | tr '[[:upper:]]' '[[:lower:]]') in
    sun*|mon*|tue*|wed*|thu*|fri*|sat*) retval=0 ;;
    * ) retval=1 ;;
  esac
  return $retval
}

isMonthName()
{
  case $(echo $1 | tr '[[:upper:]]' '[[:lower:]]') in
    jan*|feb*|mar*|apr*|may|jun*) return 0 ;;
    jul*|aug*|sep*|oct*|nov*|dec*) return 0 ;;
    * ) return 1 ;;
  esac
}

normalize()
{
  # 回傳第一個字母大寫，其餘小寫的字串
  /bin/echo -n $1 | cut -c1 | tr '[[:lower:]]' '[[:upper:]]'
  echo $1 | cut -c2-3| tr '[[:upper:]]' '[[:lower:]]'
}

if [ ! -w $HOME ] ; then
  echo "$0: 無法將檔案寫到你的家目錄 ($HOME)" >&2
  exit 1
fi

echo "Agenda: Unix提醒服務"
/bin/echo -n "活動日期 (日 月, 日 月 年,或 星期名稱)： "
read word1 word2 word3 junk

if isDayName $word1 ; then
  if [ ! -z "$word2" ] ; then
    echo "日期格式錯誤： 只能指定星期名稱。" >&2
    exit 1
  fi
  date="$(normalize $word1)"

else

  if [ -z "$word2" ] ; then
    echo "日期格式錯誤： 未知的星期名稱。" >&2
    exit 1
  fi

  if [ ! -z "$(echo $word1|sed 's/[[:digit:]]//g')" ] ; then
    echo "日期格式錯誤： 第一個值是數字型式的日期號碼。" >&2
    exit 1
  fi

  if [ "$word1" -lt 1 -o "$word1" -gt 31 ] ; then
    echo "日期格式錯誤： 日期號碼只能在1到31之間。" >&2
    exit 1
  fi

  if [ ! isMonthName $word2 ] ; then
    echo "日期格式錯誤： 未知的月份名稱。" >&2
    exit 1
  fi

  word2="$(normalize $word2)"

  if [ -z "$word3" ] ; then
    date="$word1$word2"
  else
    if [ ! -z "$(echo $word3|sed 's/[[:digit:]]//g')" ] ; then
      echo "日期格式錯誤： 第三組參數必須是年份。" >&2
      exit 1
    elif [ $word3 -lt 2000 -o $word3 -gt 2500 ] ; then
      echo "日期格式錯誤： 年份數字範圍應在2000至2500之間。" >&2
      exit 1
    fi
    date="$word1$word2$word3"
  fi
fi

/bin/echo -n "請輸入一行活動內容： "
read description

# 預備寫到資料檔中

echo "$(echo $date|sed 's/ //g')|$description" >> $agendafile

exit 0
