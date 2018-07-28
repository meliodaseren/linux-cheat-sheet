#!/bin/bash

# changetrack--追蹤指定的網址，如果自上次拜訪後發生變更，會以
#   電子郵件將新網頁發送到指定的位址

sendmail=$(which sendmail)
sitearchive="/tmp/changetrack"
tmpchanges="$sitearchive/changes.$$"   # 暫存檔
fromaddr="webscraper@intuitive.com"
dirperm=755        # 目錄的擁有者有 讀、寫及執行權限
fileperm=644       # 擁有者具 讀、寫權限，其他人只能 讀

trap "$(which rm) -f $tmpchanges" 0 1 15 # 先刪除已存在的暫存檔

if [ $# -ne 2 ] ; then
  echo "執行方式： $(basename $0) url email" >&2
  echo "提示： 若要將變更只顯示在螢幕上，請將電子郵件位址設為 '-'" >&2
  exit 1
fi

if [ ! -d $sitearchive ] ; then
  if ! mkdir $sitearchive ; then
    echo "$(basename $0) 失敗： 無法建立封存目錄。" >&2
    exit 1
  fi
  chmod $dirperm $sitearchive
fi

if [ "$(echo $1 | cut -c1-5)" != "http:" ] ; then
  echo "請使用完整的網址，(即以 'http(s)://' 開頭)" >&2
  exit 1
fi

fname="$(echo $1 | sed 's/http:\/\///g' | tr '/?&' '...')"
baseurl="$(echo $1 | cut -d/ -f1-3)/"

# 抓取網頁的複本並將其放入封存檔，注意，我們是利用檢查內容追蹤變更
#   （即 -dump，而不是-source），因此可以忽略任何HTML解析....

lynx -dump "$1" | uniq > $sitearchive/${fname}.new
if [ -f "$sitearchive/$fname" ] ; then
  # 我們之前檢查的網頁，所以要用 diff 比較兩者的差異
  diff $sitearchive/$fname $sitearchive/${fname}.new > $tmpchanges
  if [ -s $tmpchanges ] ; then
    echo "狀態： 站臺 $1 從上回檢查之後有新的變更。"
  else
    echo "狀態： $1 站臺從上次檢查之後都還沒有變動過。"
    rm -f $sitearchive/${fname}.new   # 沒有新的東西...
    exit 0                            # 沒有變更，就此結束
  fi
else
  echo "狀態： 第一次拜訪 $1，先複製備份以供未來分析。"
  mv $sitearchive/${fname}.new $sitearchive/$fname
  chmod $fileperm $sitearchive/$fname
  exit 0
fi

# 如果已經到這裡，表示網站內容已經改變，需要將 .new的檔案內容發送給
#   使用者，並用 .new的內容取代原來的內容，以便下次腳本執行時使用。

if [ "$2" != "-" ] ; then     # 如果電子郵件的參數值是 - 表不發送

( echo "Content-type: text/html"
  echo "From: $fromaddr (Web Site Change Tracker)"
  echo "Subject: Web Site $1 Has Changed"
  echo "To: $2"
  echo ""

  lynx -s -dump $1 | \
  sed -e "s|src=\"|SRC=\"$baseurl|gi" \
      -e "s|href=\"|HREF=\"$baseurl|gi" \
      -e "s|$baseurl\/http:|http:|g"
) | $sendmail -t

else
  # 顯示在螢幕上的變更差異資料有些醜。如何解決？
  diff $sitearchive/$fname $sitearchive/${fname}.new
fi

# 更新已保存的網站快照。
mv $sitearchive/${fname}.new $sitearchive/$fname
chmod 755 $sitearchive/$fname
exit 0
