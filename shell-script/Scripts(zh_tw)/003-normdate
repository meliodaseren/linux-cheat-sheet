#!/bin/bash
# normdate--將日期的月份標準化成特定的三個字母的縮寫，第一個為大寫字母，
#   將做為 #7 腳本的日期檢驗輔助功能。若檢驗無誤，將回傳 0。.

monthNumToName()
{
  # 指定 'month' 變數為相對應的月份縮寫
  case $1 in
    1 ) month="Jan" ;; 2 ) month="Feb" ;;
    3 ) month="Mar" ;; 4 ) month="Apr" ;;
    5 ) month="May" ;; 6 ) month="Jun" ;;
    7 ) month="Jul" ;; 8 ) month="Aug" ;;
    9 ) month="Sep" ;; 10) month="Oct" ;;
    11) month="Nov" ;; 12) month="Dec" ;;
    * ) echo "$0: 不認得月份的內容 $1" >&2
      exit 1
  esac
  return 0
}

# 主程式起點--如果要讓此腳本供其他腳本引用，請將隔線以下的程式碼
#   刪除或註解掉
# =================
# 檢驗輸入內容
if [ $# -ne 3 ] ; then
  echo "執行方式： $0 月份 日期 年份" >&2
  echo "參數格式如 August 3 1962 或 8 3 1962" >&2
  exit 1
fi
if [ $3 -le 99 ] ; then
  echo "$0: 年份須為 4 個數字。" >&2
  exit 1
fi

# 輸入的月份是數字格式嗎?
if [ -z $(echo $1|sed 's/[[:digit:]]//g') ]; then
  monthNumToName $1
else
# 將月份名稱轉為三字母縮寫，第一個字母大寫，其餘小寫
  month="$(echo $1|cut -c1|tr '[:lower:]' '[:upper:]')"
  month="$month$(echo $1|cut -c2-3 | tr '[:upper:]' '[:lower:]')"
fi

echo $month $2 $3

exit 0
