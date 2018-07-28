#!/bin/bash

# getdope--擷取最新"The Straight Dope"專欄。
#   如果願意的話，也可以將腳本安排在cron的排程中每日執行。

now="$(date +%y%m%d)"
start="http://www.straightdope.com/ "
to="testing@yourdomain.com"     # 請改成適當的郵件位址

# 首先取得最新專欄的網址

URL="$(curl -s "$start" | \
grep -A1 'teaser' | sed -n '2p' | \
cut -d\" -f2 | cut -d\" -f1)"

# 現在準備處理這些資料，以便產生電子郵件。

 ( cat << EOF
Subject: The Straight Dope for $(date "+%A, %d %B, %Y")
From: Cecil Adams <dont@reply.com>
Content-type: text/html
To: $to

EOF

curl "$URL"
) | /usr/sbin/sendmail -t

exit 0
