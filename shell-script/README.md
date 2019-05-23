
* [sh, bash](#sh-bourne-shell-bash)
* [csh](#csh-tcsh-c-shell)
* [zsh](#zsh)
* [source](#source)
* [其他](#其它)
    * [13 Tips & Tricks for Writing Shell Scripts with Awesome UX](#13-tips-and-tricks-for-writing-shell-scripts-with-awesome-ux)
    * [Linux 防止 Shell 指令稿重複執行教學](#linux-fang-zhi-shell-zhi-ling-gao-zhong-hang-jiao)
    * [Standard format for usage](#standard-format-for-usage)
* 更多的範例程式碼
    * [Scripts(註解中譯版) - 系統管理員懶人包｜Shell Script自動化指令集](https://github.com/meliodaseren/linux-cheat-sheet/tree/master/shell-script/Scripts(zh_tw)
    * [Collection of shell scripts for Wicked Cool Shell Scripts, 2nd Edition](https://github.com/meliodaseren/linux-cheat-sheet/tree/master/shell-script/wicked_cool_shell_scripts_2e-master)

---

# sh (Bourne shell), bash

https://devhints.io/bash

* 變數名稱只能使用英文字母、數字與底線
* 第一個字元不能為數字
* 系統環境變數全大寫，自定義變數使用小寫

| 變數 | 意義 |
| --- | --- |
| HOME      | 使用者家目錄的絕對路徑 |
| PATH      | 執行檔搜尋路徑 |
| LOGNAME   | 使用者的登入名稱 |
| USER      | 目前的使用者名稱 |
| SHELL     | 目前使用哪個 Shell |
| LS_COLORS | 設定 Shell 顏色 |
| PWD       | 記錄使用者目前所在目錄 |
| UID       | 目前的使用者 UID |
| HISTFILE  | 指令歷史紀錄的檔案位置 |

### List data structure

```shell
#!/bin/bash

for i in 1 2 3; do
    echo "$i"
done
```

```shell
#!/bin/bash

listVar="1 2 3"
for i in $listVar; do
    echo "$i"
done
```

```shell
#!/bin/bash

for i in $(echo 1; echo 2; echo 3); do
    echo "$i"
done
```

```shell
#!/bin/bash

array=("item 1" "item 2" "item 3")
for i in "${array[@]}"; do   # The quotes are necessary here
    echo "$i"
done

for i in ${array[@]}; do
    echo $i
done
```

```shell
#!/bin/bash

list='"item 1" "item 2" "item 3"'
for i in "$list"; do
    echo $i
done

for i in $list; do
    echo $i
done
```

https://stackoverflow.com/questions/12316167/does-linux-shell-support-list-data-structure

### 依序建立 student1 ~ student9，密碼皆為 12345

```shell
#!/bin/bash

for((i=1; i<10; i++))
do
  echo "Adding Student""$i"
  adduser student"$i"
  echo student"$i":12345 | chpasswd
done
```

### 參考

https://dywang.csie.cyut.edu.tw/dywang/linuxSystem/node85.html

https://stackoverflow.com/questions/12316167/does-linux-shell-support-list-data-structure

---

# csh, tcsh (C Shell)

```shell
#!/bin/csh

# Exammple: 1
foreach x (`seq 1 5 20`)
     echo $x
end
#EOF

# Example: 2
@ x = 1
while ($x <= 20)
     echo $x
@ x += 5
end
#EOF

# Example: 3
foreach x (1 2 9 40)
     echo $x
end
#EOF

# Example: 4
foreach x (*.cpp)
     echo $x
end
#EOF
```

### 參考

http://parallel.vub.ac.be/documentation/linux/unixdoc_download/Scripts.html

http://linux.vbird.org/linux_basic/0340bashshell-scripts.php

https://bcc16.ncu.edu.tw/5/csh/

https://www.ibm.com/support/knowledgecenter/zh-tw/ssw_aix_72/com.ibm.aix.osdevice/c_shell.htm

http://n.sfs.tw/content/index/11317

http://n.sfs.tw/content/index/11318

---

# zsh

http://zsh.sourceforge.net/Guide/zshguide.html

---

# source

```shell
$ source test
```

```shell
$ . test
```

`-h` 將所讀取的指令列入過去指令使用記錄（history list）中，但並不執行所讀入的指令。

---

# 其它

## 13 Tips & Tricks for Writing Shell Scripts with Awesome UX

1. 提供 `–help` 選項
2. 檢查所有命令的可用性 - 呼叫可能不存在的命令時，請先檢查它們是否可用
3. 可獨立於當前工作目錄運作 – 從不同的目錄執行腳本可能會發生錯誤，這樣的腳本沒有人會喜歡
4. 如何讀取輸入：環境變數 vs. 腳本參數 – 對於不影響腳本行為的值，可以使用環境變數，而對於可能觸發腳本不同流程的值，可以使用腳本參數。
5. 輸出你對系統執行的所有操作
6. 如果有必要，提供 `–silent` 選項
7. 重新開啓顯示
8. 用動畫的方式顯示進度
9. 使用顏色輸出你的程式結果 – 綠色表示成功，紅色表示失敗，黃色表示警告
10. 出現錯誤立即退出腳本 `set +e;`, `set -e;`
11. 自己執行清理工作 `trap`
12. 在退出時使用不同的錯誤碼 `exit 0`, `exit 1`
13. 在結束時輸出一個新行 `printf -- '\n';`
    * [**What is `printf --` ?**](https://unix.stackexchange.com/questions/22764/dashes-in-printf)

### 參考

[13 Tips & Tricks for Writing Shell Scripts with Awesome UX](https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae)

## Linux 防止 Shell 指令稿重複執行教學

https://blog.gtwang.org/linux/prevent-shell-script-duplicate-executions/

## Standard format for usage

https://en.wikipedia.org/wiki/Usage_message

http://docopt.org/

https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771080(v=ws.11)

https://stackoverflow.com/questions/9725675/is-there-a-standard-format-for-command-line-shell-help-text

https://google.github.io/styleguide/shell.xml

https://zh-google-styleguide.readthedocs.io/en/latest/google-shell-styleguide/contents/
