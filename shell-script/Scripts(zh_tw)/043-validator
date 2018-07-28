#!/bin/bash
# validator--確認PATH只包含有效的路徑，然後檢查環境變數是否有效，
#   會檢查SHELL、HOME、PATH、EDITOR、MAIL及PAGER.

errors=0

source library.sh         # 引用 #1 腳本，主要是in_path()函式

validate()
{
  varname=$1
  varvalue=$2

  if [ ! -z $varvalue ] ; then
    if [ "${varvalue%${varvalue#?}}" = "/" ] ; then
      if [ ! -x $varvalue ] ; then
        echo "** $varname 設成 $varvalue，但找不到可執行檔。"
        (( errors++ ))
      fi
    else
      if in_path $varvalue $PATH ; then
        echo "** $varname 設定 $varvalue，但在PATH中找不到。"
        errors=$(( $errors + 1 ))
      fi
    fi
  fi
}

#################
# 主程式區塊
#################

if [ ! -x ${SHELL:?"Cannot proceed without SHELL being defined."} ] ; then
  echo "** SHELL變數設成 $SHELL，但找不到可執行檔。"
  errors=$(( $errors + 1 ))
fi

if [ ! -d ${HOME:?"You need to have your HOME set to your home directory"} ]
then
  echo "** HOME 變數設成 $HOME，但它不是一個目錄。"
  errors=$(( $errors + 1 ))
fi

# 首先測試：在PATH中所指的路徑是否都有效？

oldIFS=$IFS; IFS=":"       # IFS 是分隔符號變數，我們將它改成 ':'.
for directory in $PATH
do
  if [ ! -d $directory ] ; then
    echo "** PATH 含有無效的目錄： $directory."
    errors=$(( $errors + 1 ))
  fi
done

IFS=$oldIFS         # 回復IFS原來的值供後續腳本使用

# 底下的變數每一個都應該有完整的路徑，但有些可能沒有設定或設定的路徑
#   不是執行檔。你可另為站臺或使用者社群加入其他必要的變數。

validate "EDITOR" $EDITOR
validate "MAILER" $MAILER
validate "PAGER"  $PAGER

# 最後依照errors是否 >0 （發生錯誤）而執行不同的結尾動作

if [ $errors -gt 0 ] ; then
  echo "發生錯誤： 請洽系統管理員協助。"
else
  echo "你的環境健檢良好！"
fi

exit 0
