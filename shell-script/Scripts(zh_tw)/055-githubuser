#!/bin/bash
# githubuser--指定一位GitHub使用者的名稱，取得有關此使用者的資訊

if [ $# -ne 1 ]; then
  echo "執行方式： $0 <username>"
  exit 1
fi

# -s 選項可關閉 curl 的一般執行過程訊息
curl -s "https://api.github.com/users/$1" | \
        awk -F'"' '
            /\"name\":/ {
              print $4" 是GitHub 使用者的名稱。"
            }
            /\"followers\":/{
              split($3, a, " ")
              sub(/,/, "", a[2])
              print "有 "a[2]" 位追蹤者。"
            }
            /\"following\":/{
              split($3, a, " ")
              sub(/,/, "", a[2])
              print "正在追蹤其他 "a[2]" 位使用者。"
            }
            /\"created_at\":/{
              print "他們的帳號是建立在 "$4"."
            }
            '
exit 0
