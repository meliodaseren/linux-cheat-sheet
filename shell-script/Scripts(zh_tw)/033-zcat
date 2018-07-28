#!/bin/bash

# zcat, zmore, 及 zgrep--此腳本使用三組符號連結（軟連結）或硬連結， 
#   讓使用者在操作壓縮檔更容易。

 Z="compress";  unZ="uncompress"  ;  Zlist=""
gz="gzip"    ; ungz="gunzip"      ; gzlist=""
bz="bzip2"   ; unbz="bunzip2"     ; bzlist=""

# 首先是嘗試從命令列隔離這些檔案名稱，我們用一種偷懶的方式，逐一檢查每
#   個參數，看它是不是檔名。如果是檔名且副檔名顯示是壓縮檔，就對這個檔
#   案進行解壓縮，然後換下一個檔名繼續處理。當全部操作完成後，再將解壓
#   縮後的這些檔案重新壓縮起來。

for arg
do
  if [ -f "$arg" ] ; then
    case "$arg" in
      *.Z) $unZ "$arg"
           arg="$(echo $arg | sed 's/\.Z$//')"
           Zlist="$Zlist \"$arg\""
          ;;

     *.gz) $ungz "$arg"
            arg="$(echo $arg | sed 's/\.gz$//')"
            gzlist="$gzlist \"$arg\""
            ;;

    *.bz2) $unbz "$arg"
            arg="$(echo $arg | sed 's/\.bz2$//')"
            bzlist="$bzlist \"$arg\""
            ;;
    esac
  fi
  newargs="${newargs:-""} \"$arg\""
done

case $0 in
   *zcat* ) eval  cat $newargs                  ;;
  *zmore* ) eval more $newargs                  ;;
  *zgrep* ) eval grep $newargs                  ;;
        * ) echo "$0: 未知的檔案名稱，無法處理。" >&2
             exit 1
esac

# 現在將解壓縮後的檔案重新壓縮。

if [ ! -z "$Zlist" ] ; then
  eval $Z $Zlist
fi
if [ ! -z "$gzlist"] ; then
  eval $gz $gzlist
fi
if [ ! -z "$bzlist" ] ; then
  eval $bz $bzlist
fi

# 處理完畢！

exit 0
