#!/bin/bash

# loancalc--指定貸款的本金、利率及還款期間（年），計算每期應付金額

# 公式為 M = P * ( J / (1 - (1 + J) ^ -N)),
#   P = 本金、J = 是月利率（＝年利率/12）、N = 期數（月）

# 使用者輸入 P、I（年利率）及 L （貸款年數）

. library.sh          # 引用腳本庫


if [ $# -ne 3 ] ; then
  echo "執行方式： $0 本金 年利率 貸款年數" >&2
  exit 1
fi

P=$1 I=$2 L=$3
J="$(scriptbc -p 8 $I / \( 12 \* 100 \) )"
N="$(( $L * 12 ))"
M="$(scriptbc -p 8 $P \* \( $J / \(1 - \(1 + $J\) \^ -$N\) \) )"

# 現在美化輸出的數值：

dollars="$(echo $M | cut -d. -f1)"
cents="$(echo $M | cut -d. -f2 | cut -c1-2)"

cat << EOF
貸款 $L 年，年利率 $I%，若貸款本金為 $(nicenumber $P 1 )元，則每月應還
\$$dollars.$cents元，共需償款 $N 個月。
EOF
exit 0
