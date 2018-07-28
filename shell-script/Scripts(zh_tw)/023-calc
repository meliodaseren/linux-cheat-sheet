#!/bin/bash

# calc--一支互動式的命令列計算機，功能類似 bc

scale=2


show_help()
{
cat << EOF
  除了標準的算術功能，calc 也支援：

  a % b     a/b 的餘數
  a ^ b     冪次: 計算 a 的 b 次方
  s(x)      x 的 sin， x 是角度
  c(x)      x 的 cos， x 是角度
  a(x)      x 的 arctan
  l(x)      x 的自然對數（log），10的x次方
  e(x)      指數對數，e 的 x次方
  j(n,x)    x整數的 n階Bessel函數
  scale N   顯示的小數位數（預設 = 2）
EOF
}

if [ $# -gt 0 ] ; then
  exec scriptbc "$@"
fi

echo "Calc--簡單的計算機，輸入 'help' 查看輔助說明，'quit' 結束程式"

/bin/echo -n "calc> "

while read command args
do
  case $command
  in
    quit|exit) exit 0                                 ;;
    help|\?)   show_help                              ;;
    scale)     scale=$args                            ;;
    *)         scriptbc -p $scale "$command" "$args"  ;;
  esac

  /bin/echo -n "calc> "
done

echo ""

exit 0
