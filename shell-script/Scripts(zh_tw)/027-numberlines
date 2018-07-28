#!/bin/bash

# numberlines--一支提供類似 cat -n 功能的腳本
for filename in "$@"
do
  linecount="1"
  while IFS="\n" read line
  do
    echo "${linecount}: $line"
    linecount="$(( $linecount + 1 ))"
  done < $filename
done

exit 0
