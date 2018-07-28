#!/bin/bash

# log-duckduckgo-search--提供一個搜尋請求，然後記錄模板內容之後
#   再將整個資訊轉遞給真正的DuckDuckGo搜索系統。
# 請確認做為記錄日誌的檔案及目錄是可以由執行Web伺服器的使用者
#   身份寫入。
logfile="/var/www/wicked/scripts/searchlog.txt"

if [ ! -f $logfile ] ; then
  touch $logfile
  chmod a+rw $logfile
fi

if [ -w $logfile ] ; then
    echo "$(date): $QUERY_STRING" | sed 's/q=//g;s/+/ /g' >> $logfile
fi

echo "Location: https://duckduckgo.com/html/?$QUERY_STRING"
echo ""

exit 0
