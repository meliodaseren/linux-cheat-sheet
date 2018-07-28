#!/bin/bash

# 函式庫測試腳本

# 開始以獲得檔案方式讀入library.sh 檔。

. library.sh     # 注意前面的小數點。

initializeANSI   # 設定所有 ANSI escape 序列。

# 測試 validint 功能。
echon "第一關，echo 指令是否在PATH所指的路徑內？ (1=yes, 2=no) "
read answer
while ! validint $answer 1 2 ; do
  echon "${boldon}再試一次${boldoff}，你的 echo 指令"
  echon "在PATH所指的路徑內嗎？ (1=yes, 2=no) "
  read answer
done

# 檢查這組命令是否真的在PATH所指的路徑內？
if ! checkForCmdInPath "echo" ; then
  echo "不！找不到 echo 指令。"
else
  echo "echo 指令是在PATH所指的路徑內。"
fi

echo ""
echon "請輸入一組年份，以便測試它是不是閏年： "
read year

# 使用 validint 並指定最小及最大值，測試指定的年份是在 1到9999之間。
while ! validint $year 1 9999 ; do
  echon "請輸入一組${boldon}正確{boldoff}格式的年份： "
  read year
done

# 現在真正檢測它是不是閏年。
if isLeapYear $year ; then
  echo "${greenf}正確！ $year 是閏年。${reset}"
else
  echo "${redf}哦！哦！這不是閏年！${reset}"
fi

exit 0
