#!/bin/csh

set CWD = `pwd`
echo "Current folder: $CWD"

echo "File list: "
foreach a (`ls`)
  echo $a
end

