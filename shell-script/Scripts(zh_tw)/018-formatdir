#!/bin/bash

# formatdir--以好看有用的格式輸出目錄內容

# 必須確認 "scriptbc"(#9的腳本)在當前的路徑中，因為此腳本會多次調用它 

scriptbc=$(which scriptbc)


# 將 KB的值轉換成 KB、MB或GB，讓輸出結果更容易閱讀
readablesize()
{
  if [ $1 -ge 1048576 ] ; then
    echo "$($scriptbc -p 2 $1 / 1048576)GB"
  elif [ $1 -ge 1024 ] ; then
    echo "$($scriptbc -p 2 $1 / 1024)MB"
  else
    echo "${1}KB"
  fi
}

#################
## 主程式碼

if [ $# -gt 1 ] ; then
  echo "執行方式： $0 [目錄名稱]" >&2
  exit 1
elif [ $# -eq 1 ] ; then    # 指定的目錄是當前目錄嗎？
  cd "$@"                   # 切換到指定目錄
  if [ $? -ne 0 ] ; then    # 如果目錄不存在就結束腳本
    exit 1
  fi
fi

for file in *
do
  if [ -d "$file" ] ; then
    size=$(ls "$file" | wc -l | sed 's/[^[:digit:]]//g')
    if [ $size -eq 1 ] ; then
      echo "$file ($size entry)|"
    else
      echo "$file ($size entries)|"
    fi
  else
    size="$(ls -sk "$file" | awk '{print $1}')"
    echo "$file ($(readablesize $size))|"
  fi
done | \
  sed 's/ /^^^/g' | \
  xargs -n 2 | \
  sed 's/\^\^\^/ /g' | \
  awk -F\| '{ printf "%-39s %-39s\n", $1, $2 }'

exit 0
