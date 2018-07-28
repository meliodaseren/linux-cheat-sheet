#!/bin/bash
# startdropbox--確認Dropbox正在OS X上運行。

app="Dropbox.app"
verbose=1

running="$(ps aux | grep -i $app | grep -v grep)"

if [ "$1" = "-s" ] ; then         # -s 是靜音模式
  verbose=0
fi

if [ ! -z "$running" ] ; then
  if [ $verbose -eq 1 ] ; then
    echo "$app 正在運行，PID是 $(echo $running | cut -d\ -f2)"
  fi
else
  if [ $verbose -eq 1 ] ; then
    echo "正在啟動 $app"
  fi
  open -a $app
fi

exit 0
