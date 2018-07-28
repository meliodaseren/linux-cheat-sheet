#!/bin/bash
# trimmailbox--一個簡單的腳本，確保只有最近4則郵件保留在信箱中，
#   腳本是使用Berkeley Mail（aka Mailx或mail）來寄信，如果使用其
#   他寄信程式，請自行修正！

keep=4    # 預設只保留最近4則郵件。

totalmsgs="$(echo 'x' | mail | sed -n '2p' | awk '{print $2}')"

if [ $totalmsgs -lt $keep ] ; then
  exit 0          # 不必進行任何處理
fi

topmsg="$(( $totalmsgs - $keep ))"

mail > /dev/null << EOF
d1-$topmsg
q
EOF

exit 0
