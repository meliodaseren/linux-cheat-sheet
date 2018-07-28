#!/bin/bash
# getbtcaddr--回報指定的比特幣位址之相關訊息

if [ $# -ne 1 ]; then
  echo "執行方式： $0 <address>"
  exit 1
fi

base_url="https://blockchain.info/q/"   # 比特幣區塊API

balance=$(curl -s $base_url"addressbalance/"$1)
recv=$(curl -s $base_url"getreceivedbyaddress/"$1)
sent=$(curl -s $base_url"getsentbyaddress/"$1)
first_made=$(curl -s $base_url"addressfirstseen/"$1)

echo "有關 $1 位址的詳細資訊："
echo -e "\t　　　　 開戶日期： "$(date -d @$first_made)
echo -e "\t　　　　 目前餘額： "$balance
echo -e "\t提款總額(Satoshi)： "$sent
echo -e "\t存入總額(Satoshi)： "$recv
