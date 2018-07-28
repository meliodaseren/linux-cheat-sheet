#!/bin/bash

# fixguest--當guest登出後，清除訪客的帳號及相關資料。

# 不要相信環境變數，它可能參照到唯讀的來源。

iam=$(id -un)
myhome="$(grep "^${iam}:" /etc/passwd | cut -d: -f6)"

# *** 請不要在一般正常的帳號上執行此腳本！

if [ "$iam" != "guest" ] ; then
  echo "錯誤： 你真的不會想把 fixguest 用在這個帳號上！" >&2
  exit 1
fi

if [ ! -d $myhome/..template ] ; then
  echo "$0: 找不到模板目錄，所以無法重建。" >&2
  exit 1
fi

# 移除家目錄下的檔案及目錄

cd $myhome

rm -rf * $(find . -name ".[a-zA-Z0-9]*" -print)

# 現在要做的就是將模板目錄（..template）內的標準檔案複製到訪客家目錄

cp -Rp ..template/* .
exit 0
