#!/bin/bash
# bulkrun--遍歷目錄中的檔案，同時執行多組程式，以平行方式處理這些檔案。

printHelp()
{
  echo "執行方式： $0 -p 3 -i inputDirectory/ -x \"command -to run/\""
  echo -e "\t-p 同時啟用的最大處理序數"
  echo -e "\t-i 指令欲處理的檔案所在之目錄路徑"
  echo -e "\t-x 用來處理檔案的指令"
  exit 1
}

while getopts "p:x:i:" opt
do
  case "$opt" in
    p ) procs="$OPTARG"    ;;
    x ) command="$OPTARG"  ;;
    i ) inputdir="$OPTARG" ;;
    ? ) printHelp          ;;
  esac
done

if [[ -z $procs || -z $command || -z $inputdir ]]
then
  echo "無效的參數！"
  printHelp
fi

total=$(ls $inputdir | wc -l)
files="$(ls -Sr $inputdir)"

for k in $(seq 1 $procs $total)
do
  for i in $(seq 0 $procs)
  do
    if [[ $((i+k)) -gt $total ]]
    then
      wait
      exit 0
    fi

    file=$(echo "$files" | sed $(expr $i + $k)"q;d")
    echo "正在執行 $command $inputdir/$file"
    $command "$inputdir/$file"&
  done
wait
done
