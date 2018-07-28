#!/bin/bash

# mkslocatedb--以nobody建立集中、公開的locae資料庫，同時遍歷所有使用
#   者的家目錄，尋找 .slocatedb，如果找到，就會為該目錄的使用者額外
#   建立屬私有的 locate 資料庫。

locatedb="/var/locate.db"
slocatedb=".slocatedb"

if [ "$(id -nu)" != "root" ] ; then
  echo "$0: 錯誤： 必須以root身份執行本命令。" >&2
  exit 1
fi

if [ "$(grep '^nobody:' /etc/passwd)" = "" ] ; then
  echo "$0: 錯誤： 必須要有一組 'nobody' 的帳號以便建立" >&2
  echo "預設的 slocate 資料庫。" >&2
  exit 1
fi

cd /            # 規避使用 su pwd 的權限問題

# 首先建立或更新公開的資料庫
su -fm nobody -c "find / -print" > $locatedb 2>/dev/null
echo "建立預設的 slocate 資料庫 (使用者為 nobody)"
echo ... 結果共有 $(wc -l < $locatedb)筆。

# 現在遍歷所有系統使用者帳號的家目錄，尋找.slocatedb 檔案。
for account in $(cut -d: -f1 /etc/passwd)
do
  homedir="$(grep "^${account}:" /etc/passwd | cut -d: -f6)"

  if [ "$homedir" = "/" ] ; then
    continue    # 拒絕在根目錄建立。
  elif [ -e $homedir/$slocatedb ] ; then
    echo "為使用者 $account建立 slocate 資料庫。"
    su -m $account -c "find / -print" > $homedir/$slocatedb \
      2>/dev/null
    chmod 600 $homedir/$slocatedb
    chown $account $homedir/$slocatedb
    echo ... 結果共有 $(wc -l < $homedir/$slocatedb)筆。
  fi
done

exit 0
