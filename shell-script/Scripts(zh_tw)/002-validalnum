#!/bin/bash
# validAlphaNum--確認輸入的資料只包含英文字母及數字

validAlphaNum()
{
  # 驗證參數：如果參數是由大寫、小寫或數字組成，就回傳 0 ，否則回傳1

  # 先移除所有不符合的字元
  validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [ "$validchars" = "$1" ] ; then
    return 0
  else
    return 1
  fi
}

# 主程式起點--如果讓此腳本供其他腳本引用，請將下列隔線以下的程式碼
#   刪除或註解掉
# =================
/bin/echo -n "請輸入資料: "
read input

# 對輸入結果進行驗證
if ! validAlphaNum "$input" ; then
  echo "只能使用大小寫英文字母及數字。" >&2
  exit 1
else
  echo "已輸入有效資料。"
fi

exit 0
