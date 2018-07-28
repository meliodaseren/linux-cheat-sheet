#!/bin/bash

# slocate--以特定的模板，嘗試搜尋使用者自己擁有的安全locatedb 資料庫，
#   如果指定的模板無符合對象，表示資料庫不存在，會警示先建立資料庫，如
#   果私人的 .slocatedb 是空的，會改用系統的資料庫。

locatedb="/var/locate.db"
slocatedb="$HOME/.slocatedb"

if [ ! -e $slocatedb -o "$1" = "--explain" ] ; then
  cat << "EOF" >&2
警告：安全的 locate 會為每位使用者維護一組私人的資料庫，但你的資料庫
尚未建立，除非它已建立（也許就在今晚），不然我會先從公開的資料庫中尋
找，它只能提供你符合尋找條件的公用檔案，而不是只屬於 ${USER:-$LOGNAME}
帳號有權存取的檔案。
EOF
  if [ "$1" = "--explain" ] ; then
    exit 0
  fi

  # 開始之前，先建立 .slocatedb 檔， cron 排程在下次執行，mkslocatedb 
  #   將會填補它的內容。

  touch $slocatedb       # mkslocatedb 會在下一次建構它
  chmod 600 $slocatedb   # 以正確的權限開始

elif [ -s $slocatedb ] ; then
  locatedb=$slocatedb
else
  echo "警告：使用公開的資料庫，執行 \"$0 --explain\" 查看詳細說明。" >&2
fi

if [ -z "$1" ] ; then
  echo "執行方式： $0 比對模板" >&2
  exit 1
fi

exec grep -i "$1" $locatedb
