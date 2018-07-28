#!/bin/bash

# bestcompress--指定一支待壓縮的檔案，嘗試用所有壓縮工具進行壓縮，最後只
#   留下壓縮比最佳的壓縮檔，並將處理結果回報給使用者，假如沒有指定 -a 選
#   項，則輸入的待壓縮檔案中如果已是壓縮檔者就跳過不處理。

Z="compress" gz="gzip" bz="bzip2"
Zout="/tmp/bestcompress.$$.Z"
gzout="/tmp/bestcompress.$$.gz"
bzout="/tmp/bestcompress.$$.bz"
skipcompressed=1

if [ "$1" = "-a" ] ; then
  skipcompressed=0 ; shift
fi

if [ $# -eq 0 ]; then
  echo "執行方式： $0 [-a] 待最佳化壓縮的檔案清單" >&2
  exit 1
fi

trap "/bin/rm -f $Zout $gzout $bzout" EXIT

for name in "$@"
do
  if [ ! -f "$name" ] ; then
    echo "$0: 檔案 $name 未發現，跳過！ " >&2
    continue
  fi

  if [ "$(echo $name | egrep '(\.Z$|\.gz$|\.bz2$)')" != "" ] ; then
    if [ $skipcompressed -eq 1 ] ; then
      echo "跳過檔案 ${name}: 它已經是壓縮過的檔案。"
      continue
    else
      echo "警告： 將對 $name 再次壓縮。"
    fi
  fi

  # 同時進行三種壓縮方式。
  $Z < "$name" > $Zout &
  $gz < "$name" > $gzout &
  $bz < "$name" > $bzout &

  wait  # 等待所有壓縮作業完成

  # 找出壓縮比最佳的
  smallest="$(ls -l "$name" $Zout $gzout $bzout | \
      awk '{print $5"="NR}' | sort -n | cut -d= -f2 | head -1)"

  case "$smallest" in
    1 ) echo "沒有足夠空間儲存壓縮中的 $name。 保留原檔。"
        ;;
    2 ) echo 最佳壓縮方式為compress，檔案已更名為 ${name}.Z
        mv $Zout "${name}.Z" ; rm -f "$name"
        ;;
    3 ) echo 最佳壓縮方式為 gzip，檔案已更名為 ${name}.gz
        mv $gzout "${name}.gz" ; rm -f "$name"
        ;;
    4 ) echo 最佳壓縮方式為 bzip2. ，檔案已更名為 ${name}.bz2
        mv $bzout "${name}.bz2" ; rm -f "$name"
  esac

done

exit 0
