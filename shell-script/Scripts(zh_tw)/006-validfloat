#!/bin/bash

# validfloat--檢測數值是否為有效的浮點數。
#   注意，此腳本不能接受科學記號(1.304e5)的表示法。

# 為測試輸入的數值是否為有效的浮點數，我們需要將這個數拆分成兩個部分：
#   整數部分及小數部分。我們先測試第一部分是否為有效的整數，然後測試
#   第二部分是否為 >=0 的整數，所以 -30.5 是有效的，而-30.-8 則無效。

# 為了將其他腳本當成此腳本的一部分，利用 "." 指定來源，這樣夠簡單了。

. validint                # 注意前面的小數點。

validfloat()
{
  fvalue="$1"
  # 檢查輸入的數值是否有小數點
  if [ ! -z $(echo $fvalue | sed 's/[^.]//g') ] ; then

    # 擷取在小數左邊部分的數字
    decimalPart="$(echo $fvalue | cut -d. -f1)"

    # 擷取在小數右邊部分的數字
    fractionalPart="${fvalue#*\.}"

    # 開始檢查十進位部分，這是小數點左邊的所有內容
    if [ ! -z $decimalPart ] ; then
      # "!" 是邏輯值的反向運算，所以下面式子的意思是指
      #   「假如不是有效的整數」
      if ! validint "$decimalPart" "" "" ; then
        return 1
      fi
    fi

    # 現在來檢查小數部分

    # 開始檢查，在小數點之後不能有負號，像 33.-11，
    #   所以先測試數值有無負號
    if [ "${fractionalPart%${fractionalPart#?}}" = "-" ] ; then
      echo "無效的浮點數： '-' 不能出現在小數點之後。" >&2
      return 1
    fi
    if [ "$fractionalPart" != "" ] ; then
      # 假如小數部分不是有效的整數...
      if ! validint "$fractionalPart" "0" "" ; then
        return 1
      fi
    fi

  else
    # 假如只輸入負號（-），這也不對
    if [ "$fvalue" = "-" ] ; then
      echo "無效的浮點格式。" >&2
      return 1
    fi

    # 最後檢查剩下的數字是否真的是有效整數。
    if ! validint "$fvalue" "" "" ; then
      return 1
    fi
  fi

  return 0
}
