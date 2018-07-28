#!/bin/bash

# convertcurrency--指定金額和幣別，將它轉換成指定的目標貨幣，
#   幣別以ISO貨幣代號表示。
#   利用Google的匯率換算網頁簡化開發難度：
#   http：//www.google.com/finance/converter

if [ $# -eq 0 ]; then
  echo "執行方式： $(basename $0) 金額 原始幣別 to 目標幣別"
  echo "目標幣別前面的「to」不能省略！"
  echo "常用的幣別有： CAD、CNY、EUR、USD、INR、JPY及 TWD"
  echo "使用 \"$(basename $0) list\" 列出所有可換算的幣別。"
fi

if [ $(uname) = "Darwin" ]; then
  LANG=C   # 在 OS X 上的無效元位組序和lynx 問題
fi

     url="https://www.google.com/finance/converter"
tempfile="/tmp/converter.$$"
    lynx=$(which lynx)

# 因為會多次使用，所以在處理之前先抓取所有資料

currencies=$($lynx -source "$url" | grep "option value=" | \
  cut -d\" -f2- | sed 's/">/ /' | cut -d\( -f1 | sort | uniq)

########### 處理所有非換算的請求

if [ $# -ne 4 ] ; then
  if [ "$1" = "list" ] ; then
    # 由換算器產生所有已知的貨幣代號
    echo "所有可換算的貨幣清單："
    echo "$currencies"
  fi
  exit 0
fi

########### 現在處理換算問題

if [ $3 != "to" ] ; then
  echo "執行方式： $(basename $0) 金額 原始幣別 to 目標幣別"
  echo "(目標幣別前面的「to」不能省略！)"
  echo "(使用 \"$(basename $0) list\" 列出所有可換算的幣別。)"
  exit 0
fi

amount=$1
basecurrency="$(echo $2 | tr '[:lower:]' '[:upper:]')"
targetcurrency="$(echo $4 | tr '[:lower:]' '[:upper:]')"

# 清理不必要的文字，完成換算作業

$lynx -source "$url?a=$amount&from=$basecurrency&to=$targetcurrency" | \
  grep 'id=currency_converter_result' | sed 's/<[^>]*>//g'

exit 0
