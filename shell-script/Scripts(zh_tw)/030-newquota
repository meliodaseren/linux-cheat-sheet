#!/bin/bash
# newquota-- quota 的前端腳本，可以使用GNU風格的完整文字選項表示法

# quota 有三種可能的選項 -g、-v及-q，但此腳本也允許使用完整文字的選項
#   '--group'、'--verbose'及'--quiet'

flags=""
realquota="$(which quota)"

while [ $# -gt 0 ]
do
  case $1
  in
    --help)    echo "執行方式： $0 [--group --verbose --quiet -gvq]" >&2
                     exit 1 ;;
    --group)   flags="$flags -g";  shift ;;
    --verbose) flags="$flags -v";  shift ;;
    --quiet)   flags="$flags -q";  shift ;;
    --)        shift; break             ;;
    *)         break;           # 結束 'while' 迴圈!
  esac
done

exec $realquota $flags "$@"
