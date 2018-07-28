#!/bin/bash

# zipcode--指定一組郵遞區號，找出所屬的城市和州名， 使用
#   city-data.com網站，它將每個郵遞區號設定成獨立的網頁。

baseURL="http://www.city-data.com/zips"

/bin/echo -n "郵遞區號 $1 是在 "

curl -s -dump "$baseURL/$1.html" | \
  grep -i '<title>' | \
  cut -d\( -f2 | cut -d\) -f1

exit 0
