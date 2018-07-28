#!/bin/bash
# webaccess--分析Apache格式的access_log檔案，提取有用及感興趣
#   的統計資訊。

bytes_in_gb=1048576

# 請將下面的 host 值改成你自己的主機名稱，以便進行 referer分析時
#   可排除內部的網址來源。
host="intuitive.com"

if [ $# -eq 0 ] ; then
  echo "執行方式： $(basename $0) logfile" >&2
  exit 1
fi

if [ ! -r "$1" ] ; then
  echo "錯誤： 找不到日誌檔 $1 。" >&2
  exit 1
fi

firstdate="$(head -1 "$1" | awk '{print $4}' | sed 's/\[//')"
lastdate="$(tail -1 "$1" | awk '{print $4}' | sed 's/\[//')"

echo "分析日誌檔 $1 的結果"
echo ""
echo "  起始日期： $(echo $firstdate|sed 's/:/ at /')"
echo "  結束日期： $(echo $lastdate|sed 's/:/ at /')"

hits="$(wc -l < "$1" | sed 's/[^[:digit:]]//g')"

echo "   拜訪次數： $(nicenumber $hits) (存取次數總和)"

pages="$(grep -ivE '(.gif|.jpg|.png)' "$1" | wc -l | sed 's/[^[:digit:]]//g')"

echo " 瀏覽網頁數： $(nicenumber $pages) (扣除圖形的存取次數)"

totalbytes="$(awk '{sum+=$10} END {print sum}' "$1")"

/bin/echo -n "   總共傳送： $(nicenumber $totalbytes) 位元組 "

if [ $totalbytes -gt $bytes_in_gb ] ; then
  echo "($(scriptbc $totalbytes / $bytes_in_gb) GB)"
elif [ $totalbytes -gt 1024 ] ; then
  echo "($(scriptbc $totalbytes / 1024) MB)"
else
  echo ""
fi

# 現在從日誌檔中擷取一些有用的資料

echo ""
echo "前 10 大受歡迎的網頁："

awk '{print $7}' "$1" | grep -ivE '(.gif|.jpg|.png)' | \
  sed 's/\/$//g' | sort | \
  uniq -c | sort -rn | head -10

echo ""

echo "前 10 大常來訪的網址（referrer）："
awk '{print $11}' "$1" | \
  grep -vE "(^\"-\"$|/www.$host|/$host)" | \
  sort | uniq -c | sort -rn | head -10

echo ""
exit 0
