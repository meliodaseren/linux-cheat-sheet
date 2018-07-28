#!/bin/bash

# mklocatedb--利用find建立索引資料，使用者必須要有root權限才能執行此腳本。

locatedb="/var/locate.db"
if [ "$(whoami)" != "root" ] ; then
  echo "執行這支指令需要root權限。" >&2
  exit 1
fi

find / -print > $locatedb

exit 0
