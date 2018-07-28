#!/bin/bash
# sayit--使用"say"指令朗讀指定的內容（限OS X使用）

dosay="$(which say) --quality=127"
format="$(which fmt) -w 70"

voice=""                # 使用預設的系統語音
rate=""                 # 使用預設的標準朗讀速度

demovoices()
{
  # 提供每種語音可用的樣本。

  voicelist=$( say -v \? | grep "en_" | cut -c1-12 \
    | sed 's/ /_/;s/ //g;s/_$//')

  if [ "$1" = "list" ] ; then
    echo "可用語音有： $(echo $voicelist | sed 's/ /, /g;s/_/ /g') \
      | $format"
    echo "小小提示： 使用 \"$(basename $0) demo\" 可聽到各種語音展示。"
    exit 0
  fi

  for name in $voicelist ; do
    myname=$(echo $name | sed 's/_/ /')
    echo "Voice: $myname"
    $dosay -v "$myname" "Hi! 我是 $myname，這是我的聲音。"
  done

  exit 0
}

usage()
{
  echo "執行方式： sayit [-v voice] [-r rate] [-f file] phrase"
  echo "  或者用： sayit demo"
  exit 0
}

while getopts "df:r:v:" opt; do
  case $opt in
    d ) demovoices list    ;;
    f ) input="$OPTARG"    ;;
    r ) rate="-r $OPTARG"  ;;
    v ) voice="$OPTARG"    ;;
  esac
done

shift $(($OPTIND - 1))

if [ $# -eq 0 -a -z "$input" ] ; then
  $dosay "嘿! 你沒有給我任何參數，我無法表現。"
  echo "錯誤： 未指定任何參數，請指定一支檔案或一段文字。"
  exit 0
fi

if [ "$1" = "demo" ] ; then
  demovoices
fi

if [ ! -z "$input" ] ; then
  $dosay $rate -v "$voice" -f $input
else
  $dosay $rate -v "$voice" "$*"
fi
exit 0
