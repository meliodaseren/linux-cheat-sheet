#!/bin/bash

# apm--Apache Password Manager（使用者帳號密碼管理）可讓管理員輕鬆
#   地新增、修改或刪除典型的Appace組態（組態檔為.htaccess）目錄之
#   使用者帳戶和密碼。

echo "Content-type: text/html"
echo ""
echo "<html><title>Apache Password Manager Utility</title><body>"

basedir=$(pwd)
myname="$(basename $0)"
footer="$basedir/apm-footer.html"
htaccess="$basedir/.htaccess"

htpasswd="$(which htpasswd) -b"

# 基於安全目的，強烈建議你加入下列程式碼（刪除每一行前的的 #）：
# if [ "$REMOTE_USER" != "admin" -a -s $htpasswd ] ; then
#   echo "錯誤：你必須要有 <b>admin</b> 權限才能執行 APM。"
#   exit 0
# fi

# 現在從 .htaccess檔案取得密碼檔名稱。

if [ ! -r "$htaccess" ] ; then
  echo "錯誤：無法讀取 $htaccess 檔案。"
  exit 1
fi

passwdfile="$(grep "AuthUserFile" $htaccess | cut -d\ -f2)"
if [ ! -r $passwdfile ] ; then
  echo "錯誤：無法讀取密碼檔，所以無法更新。"
  exit 1
elif [ ! -w $passwdfile ] ; then
  echo "錯誤：無法寫入密碼檔，所以無法更新。"
  exit 1
fi

echo "<center><h1 style='background:#ccf;border-radius:3px;
border:1px solid #9999cc;padding:3px;'>"
echo "Apache 密碼管理工具</h1>"

action="$(echo $QUERY_STRING | cut -c3)"
user="$(echo $QUERY_STRING|cut -d\& -f2|cut -d= -f2|\
tr '[:upper:]' '[:lower:]')"
case "$action" in
  A ) echo "<h3>新增使用者 <u>$user</u></h3>"
        if [ ! -z "$(grep -E "^${user}:" $passwdfile)" ] ; then
          echo "錯誤：使用者 <b>$user</b> 已經存在，無法新增。"
        else
          pass="$(echo $QUERY_STRING|cut -d\& -f3|cut -d= -f2)"
          if [ ! -z "$(echo $pass|tr -d '[[:upper:][:lower:][:digit:]]')" ];
          then
            echo "錯誤：密碼只能使用 a-z A-Z 0-9 ($pass)"
          else
            $htpasswd $passwdfile "$user" "$pass"
            echo "新增成功！<br>"
          fi
        fi
        ;;
  U ) echo "<h3>更新 <u>$user</u> 使用者的密碼</h3>"
        if [ -z "$(grep -E "^${user}:" $passwdfile)" ] ; then
          echo "錯誤：使用者 <b>$user</b> 不存在於密碼檔中，"
          echo "已從 $passwdfile 檔中搜遍使用者 &quot;^${user}:&quot;"
        else
          pass="$(echo $QUERY_STRING|cut -d\& -f3|cut -d= -f2)"
          if [ ! -z "$(echo $pass|tr -d '[[:upper:][:lower:][:digit:]]')" ];
          then
            echo "錯誤：密碼只能使用 a-z A-Z 0-9 ($pass)"
          else
            grep -vE "^${user}:" $passwdfile | tee $passwdfile > /dev/null
            $htpasswd $passwdfile "$user" "$pass"
            echo "更新完成！<br>"
          fi
        fi
        ;;
  D ) echo "<h3>刪除使用者 <u>$user</u></h3>"
        if [ -z "$(grep -E "^${user}:" $passwdfile)" ] ; then
          echo "錯誤：使用者 <b>$user</b> 不存在於密碼檔中。"
        elif [ "$user" = "admin" ] ; then
          echo "錯誤：你不能刪除 'admin' 帳號。"
        else
          grep -vE "^${user}:" $passwdfile | tee $passwdfile >/dev/null
          echo "已刪除完畢！<br>"
        fi
        ;;
esac

# 一律顯示密碼檔中的現有使用者帳號...

echo "<br><br><table border='1' cellspacing='0' width='80%' cellpadding='3'>"
echo "<tr bgcolor='#cccccc'><th colspan='3'>所有使用者清單"
echo " </td></tr>"
oldIFS=$IFS ; IFS=":"     # 更換預設的欄位分隔符號...
while read acct pw ; do
  echo "<tr><th>$acct</th><td align=center><a href=\"$myname?a=D&u=$acct\">"
  echo "[ 刪除 ]</a></td></tr>"
done < $passwdfile
echo "</table>"
IFS=$oldIFS               # ...現在回復成原來的欄位分隔符號.

# 將所有帳號建置成<select>選單方式...

optionstring="$(cut -d: -f1 $passwdfile | sed 's/^/<option>/'|tr '\n' ' ')"

if [ ! -r $footer ] ; then
  echo "警告：無法讀取 $footer"
else
  # ...然後輸出頁腳。
  sed -e "s/--myname--/$myname/g" -e "s/--options--/$optionstring/g" < $footer
fi

exit 0
