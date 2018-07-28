#!/bin/bash

# deleteuser--刪除使用者帳號而不留追蹤紀錄，不適用於OS X 系統

homedir="/home"
pwfile="/etc/passwd"
shadow="/etc/shadow"
newpwfile="/etc/passwd.new"
newshadow="/etc/shadow.new"
suspend="$(which suspenduser)"
locker="/etc/passwd.lock"

if [ -z $1 ] ; then
  echo "執行方式： $0 account" >&2
  exit 1
elif [ "$(whoami)" != "root" ] ; then
  echo "錯誤： 需要root權限才能執行此命令。">&2
  exit 1
fi

$suspend $1     # 在處理後續作業之前先暫停使用者權限

uid="$(grep -E "^${1}:" $pwfile | cut -d: -f3)"

if [ -z $uid ] ; then
  echo "錯誤： 帳號 $1 不存在於 $pwfile" >&2
  exit 1
fi

# 從 password 及 shadow 檔案刪除使用者資料
grep -vE "^${1}:" $pwfile > $newpwfile
grep -vE "^${1}:" $shadow > $newshadow

lockcmd="$(which lockfile)"          # 尋找lockfile程式
if [ ! -z $lockcmd ] ; then          # 使用系統的lockfile
  eval $lockcmd -r 15 $locker
else                                 # 哦！我們自己處理
  while [ -e $locker ] ; do
    echo "等待 password 的使用權" ; sleep 1
  done
  touch $locker                           # 建立檔案鎖定.
fi

mv $newpwfile $pwfile
mv $newshadow $shadow
rm -f $locker                           # 喀！再次開鎖

chmod 644 $pwfile
chmod 400 $shadow

# 現在刪除家目錄及其他相關的東東
rm -rf $homedir/$1

echo "檔案會全部移除（如果有的話）："
find / -uid $uid -print 2>/dev/null | sed 's/^/ /'

echo ""
echo "帳號 $1 (uid $uid) 已經被刪除，他們的家目錄"
echo "($homedir/$1)也已經移除。"

exit 0
