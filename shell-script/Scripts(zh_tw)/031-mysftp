#!/bin/bash

# mysftp--讓 sftp 的啟始連線過程來更像 ftp

/bin/echo -n "User account: "
read account

if [ -z $account ] ; then
  exit 0;       # 改變心意了嗎？大概吧！
fi

if [ -z "$1" ] ; then
  /bin/echo -n "Remote host: "
  read host
  if [ -z $host ] ; then
    exit 0
  fi
else
  host=$1
fi

# 切換執行 sftp 後結束腳本，利用 -C 選項可以啟用壓縮功能

exec sftp -C $account@$host
