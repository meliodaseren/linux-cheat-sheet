#!/bin/bash
# inpath--驗證指定的程式是否有效，或者可以從PATH環境變數所儲存的路徑中找到

in_path()
{
  # 指定一支指令及PATH 變數，嘗試找出這支指令，如找到指令，且可被執行就
  #   回傳0；如果不是就回傳 1。
  #   注意，它會暫時修改IFS（欄位分隔符號），在執行完成之後記得要回復。

  cmd=$1 ourpath=$2 result=1
  oldIFS=$IFS IFS=":"

  for directory in "$ourpath"
  do
    if [ -x $directory/$cmd ] ; then
      result=0       # 如果執行到這裡，表示找到指定的指令。
    fi
  done

  IFS=$oldIFS
  return $result
}

checkForCmdInPath()
{
  var=$1

  if [ "$var" != "" ] ; then
    if [ "${var:0:1}" = "/" ] ; then
      if [ ! -x $var ] ; then
        return 1
      fi
    elif ! in_path $var "$PATH" ; then
      return 2
    fi
  fi
}
