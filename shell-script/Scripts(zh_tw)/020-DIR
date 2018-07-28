#!/bin/bash
# DIR--假裝我們是DOS上的DIR指令，接受標準的 DIR 選項及顯示指定的檔案內容

function usage
{
cat << EOF >&2
  執行方式： $0 [DOS選項] 目錄或目錄清單
  可用的選項有：
   /D       以多行方式呈現，由上至下以檔名排序
   /H       顯示此腳本的輔助說明
   /N       檔名在右邊的詳細清單模式
   /OD      依日期由舊到最新排序
   /O-D     依日期由新到最舊排序
   /P       分頁顯示，每滿一個螢幕畫面時暫停
   /Q       顯示檔案的擁有者
   /S       連子目錄的內容也顯示
   /W       以多行方式呈現，由左至右以檔名排序
EOF
  exit 1
}

#####################
### 主程式區塊
#####################

postcmd=""
flags=""

while [ $# -gt 0 ]
do
  case $1 in
    /D     ) flags="$flags -x"     ;;
    /H     ) usage                 ;;
    /[NQW] ) flags="$flags -l"     ;;
    /OD    ) flags="$flags -rt"    ;;
    /O-D   ) flags="$flags -t"     ;;
    /P     ) postcmd="more"        ;;
    /S     ) flags="$flags -s"     ;;
         * ) # 選項無法辨認: 可能指定的 DIR 參數有誤；所以結束迴圈
  esac
  shift      # 此選項已處理，再看看有沒有其他選項

done

# 已處理所有選項，現在輪到處理命令本身了：

if [ ! -z "$postcmd" ] ; then
  ls $flags "$@" | $postcmd
else
  ls $flags "$@"
fi

exit 0
