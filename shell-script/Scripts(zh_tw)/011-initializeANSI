#!/bin/bash
# ANSI color--使用變數做為不同顏色的輸出及格式，顏色名稱後面
#    帶有f者，表示前景顏色，帶有b者，表示背景顏色。

initializeANSI()
{
  esc="\033"   # 如果無法正常工作，請直接改用「ESC」

  # 前景顏色
  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"

  # 背景顏色
  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
  cyanb="${esc}[46m";    whiteb="${esc}[47m"

  # 粗體、斜體、底線及反相等樣式開關
  boldon="${esc}[1m";     boldoff="${esc}[22m"
  italicson="${esc}[3m";  italicsoff="${esc}[23m"
  ulon="${esc}[4m";       uloff="${esc}[24m"
  invon="${esc}[7m";      invoff="${esc}[27m"

  reset="${esc}[0m"
}
