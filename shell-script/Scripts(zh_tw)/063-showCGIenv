#!/bin/bash

# showCGIenv--顯示此系統上CGI的執行環境。
echo "Content-type: text/html"
echo ""

# 真正的資訊...

echo "<html><body bgcolor=\"white\"><h2>CGI Runtime Environment</h2>"
echo "<pre>"
env || printenv
echo "</pre>"
echo "<h3>Input stream is:</h3>"
echo "<pre>"
cat -
echo "(end of input stream)</pre></body></html>"

exit 0
