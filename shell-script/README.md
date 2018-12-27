
* [sh, bash]()
* [csh]()
* [zsh]()
* [Scripts(註解中譯版) - 系統管理員懶人包｜Shell Script自動化指令集](https://github.com/meliodaseren/linux-cheat-sheet/tree/master/shell-script/Scripts(zh_tw))
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

## List data structure

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

## 依序建立 student1 ~ student9，密碼皆為 12345

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

---

# zsh

http://zsh.sourceforge.net/Guide/zshguide.html

---

# Source

```shell
$ source test
```

```shell
$ . test
```

`-h` 將所讀取的指令列入過去指令使用記錄（history list）中，但並不執行所讀入的指令。

---

## 其它

[幾種常見的 Shell：sh、bash、csh、tcsh、ash](http://c.biancheng.net/cpp/view/6995.html)

[Linux 防止 Shell 指令稿重複執行教學](https://blog.gtwang.org/linux/prevent-shell-script-duplicate-executions/)

[13 Tips & Tricks for Writing Shell Scripts with Awesome UX](https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae)

