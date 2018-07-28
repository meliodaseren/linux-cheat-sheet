#!/bin/bash
# validint--驗證輸入的整數值，也可以處理負數

validint()
{
  # 驗證第一個參數，如果有指定最小值 $2及/或最大值 $3，則再與它們
  #   進行比對，如果輸入的數值不在指定範圍內，或者含有非數字字元，
  #   就無法通過驗證。

  number="$1";     min="$2";     max="$3"
   if [ -z $number ] ; then
    echo "你未輸入任何資料，請輸入一筆數字。" >&2
    return 1
  fi

  # 第一個字元是負號（-）嗎?
   if [ "${number%${number#?}}" = "-" ] ; then
    testvalue="${number#?}" # 擷取第一個字元以外的所有字元 
  else
    testvalue="$number"
  fi

  # 建立這個數值不含任何數字的版本（剔除所有數字）
   nodigits="$(echo $testvalue | sed 's/[[:digit:]]//g')"

  # 檢查非數字字元
  if [ ! -z $nodigits ] ; then
    echo "無效的數值格式！只能使用數字，不能有逗號、空格等其他符號。" >&2
    return 1
  fi
   if [ ! -z $min ] ; then
    # 輸入的值是否比最小值還小?
    if [ "$number" -lt "$min" ] ; then
      echo "輸入的值太小： 可接受的最小值為 $min." >&2
      return 1
    fi
  fi
  if [ ! -z $max ] ; then
    # 輸入的值是否比最大值還大?
    if [ "$number" -gt "$max" ] ; then
      echo "輸入的值太大： 可接受的最大值為 $max." >&2
      return 1
    fi
  fi
  return 0
}
