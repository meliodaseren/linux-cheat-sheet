#!/bin/bash
# netperf--分析netstat執行的效能日誌，識別重要的結果和趨勢

log="/Users/taylor/.netstatlog"       # 請修正你的設定
stats="/tmp/netperf.stats.$$"
awktmp="/tmp/netperf.awk.$$"

trap "$(which rm) -f $awktmp $stats" 0

if [ ! -r $log ] ; then
  echo "錯誤： 無法讀取 netstat 的日誌檔 $log" >&2
  exit 1
fi

# 首先，報告日誌檔案中最新項目的基本統計資訊...
eval $(tail -1 $log)    # 所有值都轉存到腳本的變數裡
rep="$(scriptbc -p 3 $re/$snt\*100)"
repn="$(scriptbc -p 4 $re/$snt\*10000 | cut -d. -f1)"
repn="$(( $repn / 100 ))"
retop="$(scriptbc -p 3 $reto/$snt\*100)";
retopn="$(scriptbc -p 4 $reto/$snt\*10000 | cut -d. -f1)"
retopn="$(( $retopn / 100 ))"
dupp="$(scriptbc -p 3 $dup/$rec\*100)";
duppn="$(scriptbc -p 4 $dup/$rec\*10000 | cut -d. -f1)"
duppn="$(( $duppn / 100 ))"
oop="$(scriptbc -p 3 $oo/$rec\*100)";
oopn="$(scriptbc -p 4 $oo/$rec\*10000 | cut -d. -f1)"
oopn="$(( $oopn / 100 ))"

echo "Netstat 的最新報告如下："

/bin/echo -n "  $snt 封包已發送，其中 $re 個重送 ($rep%)，"
echo " $reto 個重送逾時 ($retop%)"
/bin/echo -n "  $rec 封包已接收，其中 $dup 個重複 ($dupp%)，"
echo " $oo 個不合順序（亂序） ($oop%)"
echo "   $creq 連線請求總和，其中 $cacc 個被接受。"
echo ""

## 現在來看看是否有任何重要的問題要舉報。
if [ $repn -ge 5 ] ; then
  echo "*** 警告： 重送比例 >= 5%，可能是： "
  echo "閘道器或路由器是否流量過大（泛洪？）。"
fi
if [ $retopn -ge 5 ] ; then
  echo "*** 警告： 傳輸逾時比例 >= 5%，可能是： "
  echo "閘道器或路由器是否流量過大（泛洪？）。"
fi
if [ $duppn -ge 5 ] ; then
  echo "*** 警告： 重複接收比例 >= 5% ： "
  echo "可能是另一端的問題。"
fi
if [ $oopn -ge 5 ] ; then
  echo "*** 警告： 亂序封包比例 >= 5%，可能是： "
  echo "網站流量過大或閘道器／路由器泛洪。"
fi

# 現在來看看一些歷史趨勢...

echo "分析歷史趨勢..."

while read logline ; do
    eval "$logline"
    rep2="$(scriptbc -p 4 $re / $snt \* 10000 | cut -d. -f1)"
    retop2="$(scriptbc -p 4 $reto / $snt \* 10000 | cut -d. -f1)"
    dupp2="$(scriptbc -p 4 $dup / $rec \* 10000 | cut -d. -f1)"
    oop2="$(scriptbc -p 4 $oo / $rec \* 10000 | cut -d. -f1)"
    echo "$rep2 $retop2 $dupp2 $oop2" >> $stats
done < $log

echo ""

# 現在計算一些統計數字，並與目前的數值進行比較。
cat << "EOF" > $awktmp
    { rep += $1; retop += $2; dupp += $3; oop += $4 }
END { rep /= 100; retop /= 100; dupp /= 100; oop /= 100;
      print "reps="int(rep/NR) ";retops=" int(retop/NR) \
        ";dupps=" int(dupp/NR) ";oops="int(oop/NR) }
EOF

eval $(awk -f $awktmp < $stats)

if [ $repn -gt $reps ] ; then
  echo "*** 警告： 目前的重送比例高於平均值。"
  echo " (平均值為 $reps%，而目前為 $repn%)"
fi
if [ $retopn -gt $retops ] ; then
  echo "*** 警告：目前的傳輸逾時比例高於平均值。"
  echo " (平均值為 $retops%，而目前為 $retopn%)"
fi
if [ $duppn -gt $dupps ] ; then
  echo "*** 警告： 目前的重複接收比例高於平均值。"
  echo " (平均值為 $dupps%，而目前為 $duppn%)"
fi
if [ $oopn -gt $oops ] ; then
  echo "*** 警告：目前的亂序比例高於平均值。"
  echo " (平均值為 $oops%，而目前為 $oopn%)"
fi
echo \(已分析並計算 $(wc -l < $stats) 筆 netstat 日誌紀錄\)
exit 0
