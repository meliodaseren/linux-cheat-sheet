#!/bin/bash

# fquota--Unix的磁碟使用量分析工具，假設所有使用者的UID都大於 100

MAXDISKUSAGE=20000      # 單位為 MB (megabytes)

for name in $(cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 {print $1}')
do
  /bin/echo -n "使用者 $name 超出磁碟空間配額，磁碟使用量為： "
  # 你可能需要修改下面的目錄清單，以便和你的磁碟配置相符，最常見的是
  #   將 /Users 改成 /home。

  find / /usr /var /Users -xdev -user $name -type f -ls | \
  awk '{ sum += $7 } END { print sum / (1024*1024) " Mbytes" }'

done | awk "\$9 > $MAXDISKUSAGE { print \$0 }"

exit 0
