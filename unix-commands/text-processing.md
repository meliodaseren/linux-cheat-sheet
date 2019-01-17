# Text Processing

* head
* tail
* [sort](#sort)
    * shuf (隨機重排所有資料)
* [cut](#cut)
* [split](#split)
* [grep](#grep)
* [sed](#sed)
* [awk](#awk)
* [uniq](#uniq)

---

## head

---

## tail

---

## sort

**去除重複**

`-u` 重新排序並去除重複

**指定排序欄位**

`-t` 指定分隔字元；`-k` 指定第幾欄位至第幾欄位

```shell
$ sort -t, -k2,2 linux.txt
```

```
elementary,1089
Antergos,1129
Solus,1303
Ubuntu,1644
Debian,1677
Manjaro,2405
Mint,2830
openSUSE,813
TrueOS,919
Fedora,963
```

**依照數值大小排序**

`-n` 根據實際數值大小排序

**隨機重新排序**

```shell
$ sort -R linux.txt
```

但要注意相同的資料會被放在一起，如下原始文字檔內容為：

```
orange
apple
orange
mango
apple
```

排序後：

```
mango
orange
orange
apple
apple
```

如希望所有資料都要隨機重排，可使用 `shuf` ：

```shell
$ shuf linux.txt
```

### Reference

https://blog.gtwang.org/linux/linux-sort-command-tutorial-and-examples/

https://stackoverflow.com/questions/17048188/how-to-use-awk-sort-by-column-3

https://unix.stackexchange.com/questions/104525/sort-based-on-the-third-column

https://stackoverflow.com/questions/18309538/sort-by-column-linux

https://unix.stackexchange.com/questions/52762/trying-to-sort-on-two-fields-second-then-first

---

## cut

處理字元及欄位。

**擷取字元**

```shell
# 擷取第 2-3 個、第 5-6 個與第 8-9 個字元
$ ls -l | tail -n 5 | cut -c 2-3,5-6,8-9
```

**排除字元**

```shell
# 排除第 2 個字元至第 10 個字元
$ ls -l | tail -n 5 | cut -c 2-10 --complement
```

**擷取欄位**

```
5.1,3.5,1.4,0.2,"setosa"
4.9,3,1.4,0.2,"setosa"
7,3.2,4.7,1.4,"versicolor"
6.4,3.2,4.5,1.5,"versicolor"
5.9,3,5.1,1.8,"virginica"
```

若要擷取這個 csv 檔的特定欄位，可以加上 `-d` 指定分隔字元，並以 `-f` 指定欲擷取的欄位，例如擷取出第 2 個欄位：

```shell
# 擷取 CSV 檔的第二個欄位
$ cut -d , -f 2 data.csv
$ cut -d , -f 1-3,5 data.csv
```

**輸出分隔字元**

```shell
# 指定輸出欄位分隔字元
$ head -n 5 /etc/passwd | cut -d : -f 1,7 --output-delimiter="_"
```

### Reference

https://blog.gtwang.org/linux/linux-cut-command-tutorial-and-examples/

---

## split

將檔案切割成小檔案。

使用 `-n` 參數，並指定要分成幾個的小檔案，例如若要將 `ubuntu.iso` 檔案均分為 4 個小檔案：

```shell
$ split -n 4 ubuntu.iso "ubuntu.iso.part"
```

`split` 後的檔案，以三個字母作為檔名結尾 (e.g. aaa, aab, aac, ...)

```shell
$ split -a 3 -b 200M ubuntu.iso "ubuntu.iso.part"
```

`split` 後的檔案，以數字作為檔名結尾 (e.g. 00, 01, 02, ...)

```shell
$ split -d -b 200M ubuntu.iso "ubuntu.iso.part"
```

使用 `-l` 以行數分割檔案

```shell
ls -l / > mydata.txt
split -n l/3 mydata.txt mydata.part
```

使用 `-b` 參數指定每個小檔案的大小，並指定輸出檔名的開頭名稱：

```shell
$ split -b 200M ubuntu.iso "ubuntu.iso.part"
```

### Reference

https://blog.gtwang.org/linux/split-large-tar-into-multiple-files-of-certain-size/

---

## grep

```shell
$ grep [-acinv] [--color=auto] '搜尋字串' filename
```

`-a` : 將 binary 檔案以 text 檔案的方式搜尋資料

`-c` : 計算找到 '搜尋字串' 的次數

`-i` : 忽略大小寫的不同，所以大小寫視為相同

`-n` : 順便輸出行號

`-v` : 反向選擇，亦即顯示出沒有 '搜尋字串' 內容的那一行

`--color=auto` : 可以將找到的關鍵字部分加上顏色的顯示喔

```shell
$ last | grep 'root'
$ last | grep -v 'root'
$ last | grep 'root' | cut -d ' ' -f 1
$ grep --color=auto 'MANPATH' /etc/man.conf
```

### egrep

```shell
$ \ls | egrep "\.cfg$"
Illegal variable name.
```

```shell
$ \ls | egrep "\.cfg"$
```

https://stackoverflow.com/questions/53049642/illegal-variable-name-error-when-using-grep-v

### fgrep

### ngrep (Nnetwork Global Regular Expressions Print)

### pgrep (Process-ID Global Regular Expressions Print)

### Reference

http://man.linuxde.net/grep

https://www.thegeekstuff.com/2011/10/grep-or-and-not-operators

https://stackoverflow.com/questions/17863301/how-to-grep-with-a-list-of-words

https://www.arthurtoday.com/2014/03/grep-in-files-and-directories-ahead-behind-line-numbers.html

---

## sed

```shell
$ sed [-nefri] [n1[,n2]]function
```

`-n` : 安靜模式 (silent) 。在一般 sed 的用法中，所有來自 STDIN 的資料會被列印到螢幕。
但如果加上 `-n` 參數後，則只有經過 sed 特殊處理的那一行 (或者動作) 才會被列出來

`-e` : 直接在指令列模式上進行 sed 的動作編輯

`-f` : 直接將 sed 的動作寫在一個檔案內， `-f filename` 則可以執行 `filename` 內的 sed 動作

`-r` : sed 的動作支援的是延伸型正規表示法的語法 (預設是基礎正規表示法語法)

`-i` : 直接修改讀取的檔案內容，而不是由螢幕輸出 (建議不要使用)

### function

`a` : 新增。後面可以接字串，這些字串會在目前的下一行出現

`c` : 取代。後面可以接字串，這些字串可以取代 `n1,n2` 之間的行

`d` : 刪除。後面通常不接任何字串

`i` : 插入。後面可以接字串，這些字串會在目前的上一行出現

`p` : 列印。將某個選擇的資料印出。通常 `p` 會與參數 `sed -n` 一起運作

`s` : 取代。可以搭配正規表示法。例如 `1,20s/old/new/g`

---

1. 刪除 50 至 120 行

```shell
$ cat sed.txt | sed '50,120d' > sedresult1.txt
```

2. 第 63 行後增加 3 行

   123ASD

   KJH983

   apem34kq98

```shell
$ cat sedresult1.txt | sed '63a 123ASD \
> KJH983 \
> apem34kq98' > sedresult2.txt
```

3. 第 30 至 145 行取代成

   abcdefgh

   9876543

   3333333

```shell
$ cat sed.txt | sed '30,145c abcdefgh \
> 9876543 \
> 3333333' > sedresult3.txt
```

4. 只列出第 103 至 120 行

```shell
$ cat sed.txt | sed -n '103,120p' > sedresult4.txt
```

5. 找到字串 SED，並刪除註解行及空白行

```shell
$ cat sed.txt | grep 'SED' | sed 's/#.*$//g' | sed '/^\s*$/d'  > sedresult5.txt
```

6. 找到 /etc/manpath.config 中的字串 MAN，並刪除註解行及空白行

```shell
$ cat /etc/manpath.config | grep 'MAN' | sed 's/#.*$//g' | sed '/^$/d'
```

7. 第 17 行至最後一行刪除，且將 man 取代成 SSEEDD

```shell
$ cat sed.txt | sed -e '17,$d' -e 's/man/SSEEDD/g' > sedresult6.txt
```

8. 將第 7 項的指令編輯為檔案 ds.src 並用 sed 執行

```shell
$ cat ds.src
17,$d
s/man/SSEEDD/g
$ sed -f ds.src sed.txt
```

9. 使用 ifconfig 列出 enp0s8 的 IP

```sell
$ ifconfig enp0s8 | grep 'inet ' | sed 's/^.*addr://g' | \
> sed 's/Bcast.*$//g'
```

10. 利用 sed 直接在 ~/.bashrc 最後一行加入 # This is a test

```shell
$ sed -i '$a # This is a test'  ~/.bashrc
```

### Reference

http://wanggen.myweb.hinet.net/ach3/ach3.html?MywebPageId=2019141547448846194#sed

https://dywang.csie.cyut.edu.tw/dywang/linuxProgram/node40.html

https://unix.stackexchange.com/questions/216544/how-to-print-a-line-if-that-line-or-the-next-line-do-not-contain-a-particular-st/216550#216550

---

## awk

**下面的用詞會以列 (Row) 行 (Column) 為主。**

| 變數名稱 | 代表意義 |
| ----- | ----- |
| NF | 每一列 ($0) 擁有的行位總數 |
| NR  | 目前 awk 所處理的是『第幾列』資料 |
| FS  | 目前欄位的分隔字元，預設是空白鍵 |
| OFS | 輸出欄位的分隔字元，預設是空白鍵 |
| ORS | 輸出列的間隔，預設是空白鍵 |

1. 取出最近登入的 5 個帳號與 IP

```shell
$ last -n 5
$ last -n 5 | awk '{print $1 "\t" $3}'
```

2. 列出每一列 (Row) 的帳號及該帳號所在的列數和該列有多少行 (Column)

```shell
$ last | awk '{print $1 "\t lines: " NR "\t columes: " NF}'
```

3. /etc/passwd 以冒號 ":" 分隔，查詢第三行小於 10 以下的資料，並列出帳號與第三行

```shell
$ cat /etc/passwd | awk '{FS=":"} $3 < 10 {print $1 "\t " $3}'
```

4. 承上，利用關鍵字 BEGIN 讓第一行正確顯示

```shell
$ cat /etc/passwd | awk 'BEGIN {FS=":"} $3 < 10 {print $1 "\t " $3}'
```

5. 計算薪資檔案 pay.txt 中，每個人的薪資總額。
其中，第一行是說明，不要進行加總 (NR==1)；第二行之後開始加總 (NR>=2)。

```shell
$ cat pay.txt | \
> awk '{if(NR==1) printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total"} \
> NR>=2{total = $2 + $3 + $4 \
> printf "%10s %10d %10d %10d %10.2f\n", $1, $2, $3, $4, total}'
```

### Reference

http://wanggen.myweb.hinet.net/ach3/ach3.html?MywebPageId=2019141547448858883#awk

https://dywang.csie.cyut.edu.tw/dywang/linuxProgram/node40.html

[find a string in a string using awk](https://stackoverflow.com/questions/8481143/find-a-string-in-a-string-using-awk)

[How to print 5 consecutive lines after a pattern in file using awk](https://stackoverflow.com/questions/5316572/how-to-print-5-consecutive-lines-after-a-pattern-in-file-using-awk)

[How to print the line number where a string appears in a file?](https://stackoverflow.com/questions/30658703/how-to-print-the-line-number-where-a-string-appears-in-a-file)

---

## uniq

### Reference

https://blog.gtwang.org/linux/linux-uniq-command-tutorial/

---

## 參考

[https://github.com/learnbyexample/Command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing)
