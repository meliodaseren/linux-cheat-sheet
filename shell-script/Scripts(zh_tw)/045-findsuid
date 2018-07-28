#!/bin/bash

# findsuid--檢查所有SUID檔案或程式，查看它們是否可寫入，並以友善
#   實用的格式輸出符合的項目

mtime="7"            # 指定檢查幾天內被修改的命令（單位：日）。
verbose=0            # 預設，以靜音模式執行（不顯示過程的訊息）

if [ "$1" = "-v" ] ; then
  verbose=1          # 使用者指定用  -v 選項，改以聒噪模式。
fi

# find -perm   查看檔案的權限旗標：4000（含）以上是setuid/setgid.

find / -type f -perm +4000 -print0 | while read -d '' -r match
do
  if [ -x "$match" ] ; then

    # 從 ls -ld 的輸出中拆分出檔案的擁有者及權限

    owner="$(ls -ld $match | awk '{print $3}')"
    perms="$(ls -ld $match | cut -c5-10 | grep 'w')"

    if [ ! -z $perms ] ; then
      echo "**** $match (可寫且 setuid 是 $owner)"
    elif [ ! -z $(find $match -mtime -$mtime -print) ] ; then
      echo "**** $match (在 $mtime 天內被更改，且 setuid 是 $owner)"
    elif [ $verbose -eq 1 ] ; then
      # 預設，只顯示有危險的腳本，若為聒噪模式就全部顯示
      lastmod="$(ls -ld $match | awk '{print $6, $7, $8}')"
      echo "     $match (setuid 是 $owner，最近更改為 $lastmod)"
    fi
  fi
done

exit 0
