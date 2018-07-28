#!/bin/bash

# adduser--為標準的Unix/Linux系統新增一名使用者，包括建立他們的
#   家目錄、複製預設的組態資料等等。不適用於 OS X。

pwfile="/etc/passwd"
shadowfile="/etc/shadow"
gfile="/etc/group"
hdir="/home"

if [ "$(id -un)" != "root" ] ; then
  echo "錯誤： 需要有root權限才能執行此指令。" >&2
  exit 1
fi

echo "新增使用者帳號到 $(hostname)"
/bin/echo -n "登入帳號： " ; read login

# 下一行將可用的最大使用者代號設為5000，但你應該調整這個數字，
#   以便與你系統的使用者代號範圍相符。
uid="$(awk -F: '{ if (big < $3 && $3 < 5000) big=$3 } END { print big + 1 }'\
        $pwfile)"
homedir=$hdir/$login

# 我們是指定使用者擁有自己的群組
gid=$uid

/bin/echo -n "帳號全名： "  ; read fullname
/bin/echo -n "命令環境： "  ; read shell

echo "設定使用者帳號 $login 給 $fullname..."

echo ${login}:x:${uid}:${gid}:${fullname}:${homedir}:$shell >> $pwfile
echo ${login}:*:11647:0:99999:7::: >> $shadowfile

echo "${login}:x:${gid}:$login" >> $gfile

mkdir $homedir
cp -R /etc/skel/.[a-zA-Z]* $homedir
chmod 755 $homedir
chown -R ${login}:${login} $homedir

# 設定初始密碼
exec passwd $login
