#!/bin/bash

# scriptbc-- bc 的封包腳本，回傳計算的結果
if ["$1" = "-p" ] ; then
  precision=$2
  shift 2
else
precision=2           # 設一個預設精度
fi

bc -q -l << EOF
  scale=$precision
  $*
  quit
EOF
exit 0
