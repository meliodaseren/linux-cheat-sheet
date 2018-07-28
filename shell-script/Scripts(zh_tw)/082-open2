#!/bin/bash
# open2-- 一支種 OS X實用open指令聰明封裝的腳本，使其更加好用，預設
#   情況下，'open'會綁定 Aqua 環境的檔案類型，將指定的檔案或目錄用
#   適當的程式開啟，但它有個限制，只能啟動 /Applications 目錄下的應用
#   程式。

#   首先，直接用指定的參數來嘗試。

if ! open "$@" >/dev/null 2>&1 ; then
  if ! open -a "$@" >/dev/null 2>&1 ; then

    # 不只一個參數？那就不知道如何處理它，只好結束程式。
    if [ $# -gt 1 ] ; then
      echo "open: 不支援一次使用多組程式。" >&2
      exit 1
    else
      case $(echo $1 | tr '[:upper:]' '[:lower:]') in
        activ*|cpu   ) app="Activity Monitor"           ;;
        addr*        ) app="Address Book"               ;;
        chat         ) app="Messages"                   ;;
        dvd          ) app="DVD Player"                 ;;
        excel        ) app="Microsoft Excel"            ;;
        info*        ) app="System Information"         ;;
        prefs        ) app="System Preferences"         ;;
        qt|quicktime ) app="QuickTime Player"           ;;
        word         ) app="Microsoft Word"             ;;
        *           ) echo "open: 不認識你指定的 $1，因此無法處理" >&2
            exit 1
      esac
      echo "你要求執行 $1，但我覺得你想要的是 $app。" >&2
      open -a "$app"
    fi
  fi
fi

exit 0
