#!/bin/bash
# bulkrename--利用取代檔名中的文字，對指定的檔案進行更名作業

printHelp()
{
  echo "執行方式： $0 -f find -r replace FILES_TO_RENAME*"
  echo -e "\t-f 用來尋找檔名中的字"
  echo -e "\t-r 新檔名中要取代的字""
  exit 1
}

while getopts "f:r:" opt
do
  case "$opt" in
    r ) replace="$OPTARG"   ;;
    f ) match="$OPTARG"     ;;
    ? ) printHelp           ;;
  esac
done

shift $(( $OPTIND - 1 ))

if [ -z $replace ] || [ -z $match ]
then
  echo "你需要提供一組用來比對的字串，以及一組用來取代的字串。";
  printHelp
fi

for i in $@
do
  newname=$(echo $i | sed "s/$match/$replace/")
  mv $i $newname
  && echo "已將 $i 更名為 $newname"
done
