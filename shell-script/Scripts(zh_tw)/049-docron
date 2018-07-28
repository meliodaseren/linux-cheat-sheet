#!/bin/bash

# docron--執行在關機時間內應啟動而未啟動的每日、每週和每月系統排程。

rootcron="/etc/crontab"    #依據Unix或Linux版本而有很大的不同。

if [ $# -ne 1 ] ; then
  echo "執行方式： $0 [daily|weekly|monthly]" >&2
  exit 1
fi

# 此腳本如果不是以管理員權限執行，則會失敗。
#   前面介紹的腳本中，應已看過USER和LOGNAME的檢測，但在這裡，
#   我們將直接檢查使用者代號（UID），Root 的UID為 0。

if [ "$(id -u)" -ne 0 ] ; then
  # 視需要亦可改用「$(whoami) != "root"」
  echo "$0: 此指令須以'root'身份執行" >&2
  exit 1
fi

# 假設root cron有"daily"、"weekly"和"monthly"作業項目， 如果找不到
#   與指定的項目相符者，算是一個錯誤，如果有符合者（我們的期望），
#   會試著取得此項目所指定的命令。

job="$(awk "NF > 6 && /$1/ { for (i=7;i<=NF;i++) print \$i }" $rootcron)"

if [ -z "$job" ] ; then   # 沒符合的排程？怪了！好吧，這是一個錯誤。.
  echo "$0: 錯誤： 沒有  $1 排在在 $rootcron" >&2
  exit 1
fi

SHELL=$(which sh)         # 和 cron的預設環境一致

eval $job                 # 一旦作業完成，就結束腳本。
