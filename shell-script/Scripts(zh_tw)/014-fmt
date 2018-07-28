#!/bin/bash
# fmt--文字格式化工具，其功能就是將nroff封裝起來，另加入兩個實用的
#   選項：-w X 設定每一行的寬度；-h 允許利用連字號，達到更佳的填補。

while getopts "hw:" opt; do
  case $opt in
    h ) hyph=1              ;;
    w ) width="$OPTARG"     ;;
  esac
done
shift $(($OPTIND - 1))

nroff << EOF
.ll ${width:-72}
.na
.hy ${hyph:-0}
.pl 1
$(cat "$@")
EOF

exit 0
