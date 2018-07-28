#!/bin/bash

# suspenduser--無限期暫停使用者權限

homedir="/home"       # 使用者的家目錄
secs=10               # 在幾秒後將登出使用者帳號

if [ -z $1 ] ; then
  echo "執行方式： $0 account" >&2
  exit 1
elif [ "$(id -un)" != "root" ] ; then
  echo "錯誤： 需要root權限才能執行此命令。" >&2
  exit 1
fi

echo "請將帳號 $1 的新密碼修改成其他內容。"
passwd $1

# 檢查使用者是否有登入系統，如果有就通知他們
if who|grep "$1" > /dev/null ; then

  for tty in $(who | grep $1 | awk '{print $2}'); do

    cat << "EOF" > /dev/$tty

***********************************************************************
來自管理員的緊急通知：

此帳號已被停權，您將在 $secs 秒後被自動登出，請您關閉所有執行中
的程式，並自行登出。


如果有任何疑問，請洽你的主管或資訊室主任 李四。
***********************************************************************
EOF
  done

  echo "（警告 $1，現在等待 $secs秒）"

  sleep $secs

  jobs=$(ps -u $1 | cut -d\ -f1)

  kill -s HUP $jobs                   # 傳送退出信號給他們的應用程序
  sleep 1                             # 給它1秒鐘退出...
  kill -s KILL $jobs > /dev/null 2>1  # 強制結束應用程序

  echo "$1 已登入系統，現在將他們登出。"
fi

# 最後關閉他們的家目錄，以防止有人窺探。
chmod 000 $homedir/$1

echo "帳號 $1 已被停權！"

exit 0
