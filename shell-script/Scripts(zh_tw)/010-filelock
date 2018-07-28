#!/bin/bash

# filelock--一個靈活的檔案鎖定機制

retries="10"              # 預設的重試次數
action="lock"             # 預設行為
nullcmd="'which true'"    # Null command for lockfile

while getopts "lur:" opt; do
  case $opt in
    l ) action="lock"       ;;
    u ) action="unlock"     ;;
    r ) retries="$OPTARG"   ;;
  esac
done
shift $(($OPTIND - 1))
if [ $# -eq 0 ] ; then      # 輸出多行的錯誤訊息到螢幕上。
  cat << EOF >&2
執行方式： $0 [-l|-u] [-r retries] LOCKFILE
這裡的 -l 表示要求鎖定（預設行為）， -u 表示要求解鎖， -r X 指定在判定為
失敗前，重試的次數（預設為 $retries）。
  EOF
  exit 1
fi

# 確認是否有lockfile指令。
if [ -z "$(which lockfile | grep -v '^no ')" ] ; then
  echo "$0 失敗： 在 PATH 路徑中找不到 'lockfile' 工具程式。" >&2
  exit 1
fi
if [ "$action" = "lock" ] ; then
  if ! lockfile -1 -r $retries "$1" 2> /dev/null; then
    echo "$0: 失敗： 無法及時鎖定檔案。" >&2
    exit 1
  fi
else    # 要執行解鎖動作時
  if [ ! -f "$1" ] ; then
    echo "$0: 警告： 指定的鎖檔 $1 不存在，無法解鎖。 " >&2
    exit 1
  fi
  rm -f "$1"
fi
exit 0
