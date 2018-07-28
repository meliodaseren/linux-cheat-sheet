#!/bin/bash

# diskspace--加總磁碟可用空間，並以人類易解讀的格式顯示

tempfile="/tmp/available.$$"

trap "rm -f $tempfile" EXIT

cat << 'EOF' > $tempfile
    { sum += $4 }
END { mb = sum / 1024
        gb = mb / 1024
        printf "%.0f MB (%.2fGB) 的可用磁碟空間\n", mb, gb
    }
EOF

df -k | awk -f $tempfile

exit 0
