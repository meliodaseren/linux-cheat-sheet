#!/bin/bash
# weather--利用指定的郵遞區號，透過Wunderground API 取得天氣狀況

if [ $# -ne 1 ]; then
  echo "執行方式： $0 <zipcode>"
  exit 1
fi

apikey="b03fdsaf3b2e7cd23" # 這不是真的API金鑰，你得自己註冊一把

weather=`curl -s \
    "https://api.wunderground.com/api/$apikey/conditions/q/$1.xml"`
state=`xmllint --xpath \
    //response/current_observation/display_location/full/text\(\) \
    <(echo $weather)`
zip=`xmllint --xpath \
    //response/current_observation/display_location/zip/text\(\) \
    <(echo $weather)`
current=`xmllint --xpath \
    //response/current_observation/temp_f/text\(\) \
    <(echo $weather)`
condition=`xmllint --xpath \
    //response/current_observation/weather/text\(\) \
    <(echo $weather)`

echo $state" ("$zip") ： 目前溫度 "$current"°F ，戶外天氣 "$condition"。"

exit 0
