# Shell script

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

## C Shell

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

http://linux.vbird.org/linux_basic/0340bashshell-scripts.php

http://parallel.vub.ac.be/documentation/linux/unixdoc_download/Scripts.html

---

# Source

直接將以下文檔 `test` 作為腳本用 source 執行

```shell
$ source test
```

文檔內容

```
cp README.md 01
cp README.md 02
cp README.md 03
cp README.md 04
...
cp README.md 10
```

---

## 其它

[幾種常見的 Shell：sh、bash、csh、tcsh、ash](http://c.biancheng.net/cpp/view/6995.html)

[Linux 防止 Shell 指令稿重複執行教學](https://blog.gtwang.org/linux/prevent-shell-script-duplicate-executions/)

[13 Tips & Tricks for Writing Shell Scripts with Awesome UX](https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae)

