# BASH

`tee` : tee 會同時將資料流分送到檔案 (file) 與螢幕 (screen)，輸出至螢幕實際上就是 stdout

```shell
$ perl hello.pl | & tee log
```

---

## 文本處理 grep, sed, awk, uniq

https://github.com/meliodaseren/future_docs/blob/master/linux/unix-commands/grep-sed-awk.md

---

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

### Source Script

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

### C Shell

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

## 參考

http://linux.vbird.org/linux_basic/0340bashshell-scripts.php
