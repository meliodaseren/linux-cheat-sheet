#!/bin/bash

# ssync--如果有任何改變，建立一支包裹檔（tarball），再利用sftpsync
#   搭配sftp同步到遠端目錄。

sftpacct="taylor@intuitive.com"
tarballname="AllFiles.tgz"
localsource="$HOME/Desktop/Wicked Cool Scripts/scripts"
remotedir="/wicked/scripts"
timestamp=".timestamp"
count=0

# 第一步，檢查本機目錄已存在且內有檔案。

if [ ! -d "$localsource" ] ; then
  echo "$0: 錯誤：目錄 $localsource 不存在！" >&2
  exit 1
fi

cd "$localsource"

# 現在計算到底有幾支檔案已修正過。

if [ ! -f $timestamp ] ; then
  for filename in *
  do
    if [ -f "$filename" ] ; then
      count=$(( $count + 1 ))
    fi
  done
else
  count=$(find . -newer $timestamp -type f -print | wc -l)
fi

if [ $count -eq 0 ] ; then
  echo "$(basename $0): 在目錄 $localsource 找不到要同步的檔案。"
  exit 0
fi

echo "打包檔案，以供上傳。"
tar -czf $tarballname ./*

# 已完成！切換到 sftpsync 腳本

exec sftpsync $sftpacct $remotedir
