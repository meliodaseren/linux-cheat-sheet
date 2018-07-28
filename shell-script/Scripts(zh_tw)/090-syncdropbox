#!/bin/bash
# syncdropbox--將一組檔案或指定的資料夾與Dropbox同步，透過將資料夾
#   複製到~/Dropbox或將一組檔案儲存到Dropbox的同步資料夾，然後啟動
#   Dropbox.app來達成同步的目的。

name="syncdropbox"
dropbox="$HOME/Dropbox"
sourcedir=""
targetdir="sync"     # 個別檔案在Dropbox上的目標資料夾

# 檢查啟動參數

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 [-d source-folder] {file, file, file}" >&2
  exit 1
fi

if [ "$1" = "-d" ] ; then
  sourcedir="$2"
  shift; shift
fi

# 有效性檢查

if [ ! -z "$sourcedir" -a $# -ne 0 ] ; then
  echo "$name: 你不能同時指定目錄及檔案。" >&2
  exit 1
fi

if [ ! -z "$sourcedir" ] ; then
  if [ ! -d "$sourcedir" ] ; then
    echo "$name: 請使用 -d 來指定來源目錄。" >&2
    exit 1
  fi
fi

#######################
#### 主程式區塊
#######################

if [ ! -z "$sourcedir" ] ; then
  if [ -f "$dropbox/$sourcedir" -o -d "$dropbox/$sourcedir" ] ; then
    echo "$name: 所指定的來源目錄 $sourcedir 已存在。" >&2
    exit 1
  fi

  echo "複製 $sourcedir 的內容到 $dropbox..."
  # -a 是遞迴複製（即包括子目錄）,保留擁有者資訊等等。
  cp -a "$sourcedir" $dropbox
else
  # 沒有來源目錄，因為指定個別檔案。
  if [ ! -d "$dropbox/$targetdir" ] ; then
    mkdir "$dropbox/$targetdir"
    if [ $? -ne 0 ] ; then
      echo "$name: 執行mkdir $dropbox/$targetdir（建立目錄）時發生錯誤。" >&2
      exit 1
    fi
  fi

  # 萬事俱備！開始複製指定的檔案

  cp -p -v "$@" "$dropbox/$targetdir"
fi

# 如果需要就啟動Dropbox應用程式，以便讓它進行實際的同步作業。
exec startdropbox -s
