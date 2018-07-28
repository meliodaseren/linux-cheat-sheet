#!/bin/bash

# diskhogs--Unix的磁碟空間配額分析工具，假設所有使用者的代號都在100以上，
#    會對個別使用者發送警示電子郵件，並在螢幕上顯示摘要訊息


MAXDISKUSAGE=500
violators="/tmp/diskhogs0.$$"

trap "$(which rm) -f $violators" 0

for name in $(cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 { print $1 }')
do
  /bin/echo -n "$name "
  #你可能需要修改下面的目錄清單，以便和你的磁碟配置相符，最常見的是
  #   將 /Users 改成 /home。
  find / /usr /var /Users -xdev -user $name -type f -ls | \
    awk '{ sum += $7 } END { print sum / (1024*1024) }'

done | awk "\$2 > $MAXDISKUSAGE { print \$0 }" > $violators

if [ ! -s $violators ] ; then
  echo "沒有使用者超過 ${MAXDISKUSAGE}MB 的磁碟空間配額。"
  cat $violators
  exit 0
fi

while read account usage ; do

  cat << EOF | fmt | mail -s "警告： $account 超出磁碟空間配額" 
  你的磁碟使用量是 ${usage}MB，但你只被配置 ${MAXDISKUSAGE}MB，也就是
  說你必須刪除一些不必要的個人檔案、或者對檔案進行壓縮（可使用強力的
  'gzip' 或 'bzip2'，或者選用容易操作的 compression 程式）。或者通知我
  們為您增加空間配置。

  感謝您的合作！

  你的好鄰居 sysadmin 敬上
  EOF

  echo "使用者 $account 已使用 $usage MB 的磁碟空間。已通知使用者。"

done < $violators

exit 0
