#!/bin/bash
# showfile--顯示檔案的內容及有用的額外資訊

width=72

for input
do
  lines="$(wc -l < $input | sed 's/ //g')"
  chars="$(wc -c < $input | sed 's/ //g')"
  owner="$(ls -ld $input | awk '{print $3}')"
  echo "--------------------------------------------------------------"
  echo "檔案 $input ($lines行； $chars字； 擁有者是 $owner)："
  echo "--------------------------------------------------------------"
  while read line
  do
    if [ ${#line} -gt $width ] ; then
      echo "$line" | fmt | sed -e '1s/^/ /' -e '2,$s/^/+ /'
    else
      echo " $line"
    fi
  done < $input

  echo "--------------------------------------------------------------"
done | ${PAGER:more}

exit 0
