#!/bin/bash

# newrm--用來取代現存的 rm 指令
#   此腳本提供基本的還原能力，它會在使用者的家目錄建立一組新目錄，
#   並利用它保存被刪除檔案或目錄，如果使用者指定 -f 選項，就會強制
#   刪除而不進行封存。

# 重要提醒：可能需要一組排程或類似的功能，以便定期清理回收筒，否則
#   系統中的所有檔案都不會真正被刪除，有一天會造成磁碟空間不足。

archivedir="$HOME/.deleted-files"
realrm="$(which rm)"
copy="$(which cp) -R"
if [ $# -eq 0 ] ; then            # 讓 'rm' 輸出使用錯誤訊息
  exec $realrm                    # 用 /bin/rm 的環境取代我們的環境
fi

# 解析所有選項，搜尋 '-f' 參數

flags=""

while getopts "dfiPRrvW" opt
do
  case $opt in
    f ) exec $realrm "$@"     ;; # 直接執行，並結束此腳本
    * ) flags="$flags -$opt"  ;; # 其他選項對我們沒有用處
  esac
done
shift $(( $OPTIND - 1 ))

# 主程式起點
# =================

# 確認 $archivedir 已存在

if [ ! -d $archivedir] ; then
  if [ ! -w $HOME ] ; then
    echo "$0 失敗： 無法在 $HOME 建立 $archivedir " >&2
    exit 1
  fi
  mkdir $archivedir
  chmod 700 $archivedir          # 請維持個人小小的權限
fi

for arg
do
  newname="$archivedir/$(date "+%S.%M.%H.%d.%m").$(basename "$arg")"
  if [ -f "$arg" -o -d "$arg" ] ; then
    $copy "$arg" "$newname"
  fi
done
exec $realrm $flags "$@"         # 我們的環境己被 realrm 取代
