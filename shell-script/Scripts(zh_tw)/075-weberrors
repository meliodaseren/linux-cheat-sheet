#!/bin/bash
# weberrors--掃描Apache 的error_log檔，回報重要的錯誤及直接列出其他紀錄

temp="/tmp/$(basename $0).$$"

# 要讓腳本運作良好，請視您的環境調整下列三行的定義。

htdocs="/usr/local/etc/httpd/htdocs/"
myhome="/usr/home/taylor/"
cgibin="/usr/local/etc/httpd/cgi-bin/"

sedstr="s/^/ /g;s|$htdocs|[htdocs] |;s|$myhome|[homedir] "
sedstr=$sedstr"|;s|$cgibin|[cgi-bin] |"

screen="(File does not exist|Invalid error redirect|premature EOF"
screen=$screen"|Premature end of script|script not found)"

length=5                # 每種分類要顯示的紀錄筆數

checkfor()
{
  grep "${2}:" "$1" | awk '{print $NF}' \
    | sort | uniq -c | sort -rn | head -$length | sed "$sedstr" > $temp
  if [ $(wc -l < $temp) -gt 0 ] ; then
    echo ""
    echo "$2 的錯誤："
    cat $temp
  fi
}

trap "$(which rm) -f $temp" 0

if [ "$1" = "-l" ] ; then
  length=$2; shift 2
fi

if [ $# -ne 1 -o ! -r "$1" ] ; then
  echo "執行方式： $(basename $0) [-l len] error_log" >&2
  exit 1
fi

echo 輸入的檔案 $1 內有 $(wc -l < "$1") 筆紀錄。

start="$(grep -E '\[.*:.*:.*\]' "$1" | head -1 \
  | awk '{print $1" "$2" "$3" "$4" "$5 }')"
end="$(grep -E '\[.*:.*:.*\]' "$1" | tail -1 \
  | awk '{print $1" "$2" "$3" "$4" "$5 }')"

/bin/echo -n "紀錄內容從 $start 到 $end 結束"

echo ""

### 檢查各種常見的錯誤：

checkfor "$1" "File does not exist"
checkfor "$1" "Invalid error redirection directive"
checkfor "$1" "Premature EOF"
checkfor "$1" "Script not found or unable to stat"
checkfor "$1" "Premature end of script headers"

grep -vE "$screen" "$1" | grep "\[error\]" | grep "\[client " \
  | sed 's/\[error\]/\`/' | cut -d\` -f2 | cut -d\ -f4- \
  | sort | uniq -c | sort -rn | sed 's/^/ /' | head -$length > $temp

if [ $(wc -l < $temp) -gt 0 ] ; then
  echo ""
  echo "日誌檔中的其他類型錯誤："
  cat $temp
fi

echo ""
echo "在日誌檔中沒有錯誤訊息的紀錄："

grep -vE "$screen" "$1" | grep -v "\[error\]" \
  | sort | uniq -c | sort -rn \
  | sed 's/^/ /' | head -$length

exit 0
