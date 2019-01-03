# Useful UNIX Commands

* [目錄及環境](#目錄及環境)
* [檔案與目錄的檢視](#檔案與目錄的檢視-ls)
    * ls
* [複製、刪除與移動](#複製刪除與移動-cp-rm-mv)
    * cp
    * rm
    * mv
* [壓縮及解壓縮](#壓縮及解壓縮-tar)
    * tar
* [尋找檔案](#尋找檔案-find)
    * find
* [磁碟與檔案系統管理](#磁碟與檔案系統管理-df-du)
    * df
    * du
    * ncdu (NCurses Disk Usage)
* [程序管理](#程序管理-jobs)
    * jobs
    * bjobs (IBM Spectrum LSF)
* [數據重導向](#數據重導向-tee)
    * tee
* [計算機](#計算機-bc)
    * bc
* [文本處理](#command-for-text-processing)
    * sort
    * cut
    * split
    * grep
    * sed 
    * awk
    * uniq
* [gnome-terminal](#gnome-terminal)


---

## 目錄及環境

### 特殊目錄

```
.         # 代表此層目錄
..        # 代表上一層目錄
-         # 代表前一個工作目錄
~         # 代表『目前使用者身份』所在的家目錄
~account  # 代表 account 這個使用者的家目錄(account是個帳號名稱)
```

### Linux 系統目錄

```
/         # 根目錄
/home/    # 各帳號家目錄的集中地
/root/    # root 的家目錄
/bin/     # 存放系統的基本使用者指令
/sbin/    # 存放基本的系統管理者指令，例如 fdisk
/lib/     # 存放基本的函式庫及核心模組驅動
/usr/     # 存放系統的主要程序、圖形介面所需的檔案、或自行安裝的軟體等
/tmp/     # 存放暫存檔案，所有使用者對該目錄都有讀寫權限
/dev/     # 存放裝置檔案 (device file)，包含鍵盤、滑鼠、硬碟、USB等
/etc/     # 存放系統的設定檔案，例如使用者帳戶資訊、主機名稱等
/var/     # 存放長度可變的檔案，例如伺服器的記錄檔案
/sys/     # 目錄下的檔案用來檢視及設定系統硬碟資訊
/proc/    # 目錄下的檔案可取得 process 與系統的狀態
/mnt/     # 預設掛載點 (mount point)
/opt/     # 作為 optional 檔案和程式的存放目錄
```

### 環境變數

```shell
$ echo $PATH
```

---

## 檔案與目錄的檢視 (ls)

```
$ ls [-aAdfFhilnrRSt] 檔名或目錄名稱
$ ls [--color={never,auto,always}] 檔名或目錄名稱
$ ls [--full-time] 檔名或目錄名稱
```

`-a` : 全部的檔案，連同隱藏檔( 開頭為 . 的檔案) 一起列出來

`-l` : 長資料串列出，包含檔案的屬性與權限等等資料

`-d` : 僅列出目錄本身，而不是列出目錄內的檔案資料

`-h` : 將檔案容量以人類較易讀的方式(例如 GB, KB 等等)列出來

`-r` : 將排序結果反向輸出，例如：原本檔名由小到大，反向則為由大到小

`-R` : 連同子目錄內容一起列出來，等於該目錄下的所有檔案都會顯示出來

`-S` : 以檔案容量大小排序，而不是用檔名排序

`-t` : 依時間排序，而不是用檔名

`--color=never` : 不要依據檔案特性給予顏色顯示

`--color=always` : 顯示顏色

`--color=auto` : 讓系統自行依據設定來判斷是否給予顏色

`--full-time` : 以完整時間模式 (包含年、月、日、時、分) 輸出

`--time={atime,ctime}` : 輸出 access 時間或改變權限屬性時間 (ctime) 而非內容變更時間 (modification time)

---

## 複製、刪除與移動 (cp, rm, mv)

```
$ cp [-adfilprsu] 來源檔(source) 目標檔(destination)
$ cp [options] source1 source2 source3 .... directory
```

`-a` : 相當於 `-dr --preserve=all` 的意思

`-i` : 若目標檔(destination)已經存在時，在覆蓋時會先詢問動作的進行

`-p` : 連同檔案的屬性(權限、用戶、時間)一起複製過去，而非使用預設屬性

`-r` : 遞迴持續複製，用於目錄的複製行為

`-l` : 進行硬式連結(hard link)的連結檔建立，而非複製檔案本身

```
$ rm [-fir] 檔案或目錄
```

`-f` : 就是 force 的意思，忽略不存在的檔案，不會出現警告訊息

`-r` : 遞迴刪除，常用在目錄的刪除了

`-i` : 互動模式，在刪除前會詢問使用者是否動作

```
$ mv [-fiu] source destination
$ mv [options] source1 source2 source3 .... directory
```

`-f` : force 強制的意思，如果目標檔案已經存在，不會詢問而直接覆蓋

`-i` : 若目標檔案 (destination) 已經存在時，就會詢問是否覆蓋

`-u` : 若目標檔案已經存在，且 source 比較新，才會更新 (update)

---

## 壓縮及解壓縮 (tar)

```
$ tar [-z|-j|-J] [cv] [-f 待建立的新檔名] filename... # 打包與壓縮
$ tar [-z|-j|-J] [tv] [-f 既有的 tar檔名]            # 察看檔名
$ tar [-z|-j|-J] [xv] [-f 既有的 tar檔名] [-C 目錄]   # 解壓縮
```

`-c` : 建立打包檔案，可搭配 `-v` 來察看過程中被打包的檔名(filename)

`-C 目錄` : 在特定目錄解壓縮

`-t` : 察看打包檔案的內容含有哪些檔名，重點在察看『檔名』就是了

`-x` : 解打包或解壓縮的功能，可以搭配 `-C` (大寫) 在特定目錄解開。特別留意 `-c`, `-t`, `-x` 不可同時出現在一串指令列中。

`-z` : 透過 gzip  的支援進行壓縮/解壓縮：此時檔名最好為 `*.tar.gz`

`-j` : 透過 bzip2 的支援進行壓縮/解壓縮：此時檔名最好為 `*.tar.bz2`

`-J` : 透過 xz    的支援進行壓縮/解壓縮：此時檔名最好為 `*.tar.xz` 特別留意， `-z`, `-j`, `-J` 不可以同時出現在一串指令列中

`-v` : 在壓縮/解壓縮的過程中，將正在處理的檔名顯示出來

`-f filename` : 後面要立刻接要被處理的檔名，建議單獨寫一個選項囉

其他後續練習會使用到的選項介紹：

`-p`(小寫) : 保留備份資料的原本權限與屬性，常用於備份(`-c`)重要的設定檔

`-P`(大寫) : 保留絕對路徑，亦即允許備份資料中含有根目錄存在之意

`--exclude=FILE` : 在壓縮的過程中，不要將 FILE 打包

### 打包壓縮

```shell
$ tar -zcvf test.tar.gz dir1
$ tar -zcvf test.tgz dir1
$ tar -jcvf test.tar.bz2 dir1
$ tar -Jcvf test.tar.xz dir2
```

### 解開壓縮

```shell
$ tar -zxvf test.tar.gz
$ tar -zxvf test.tgz
$ tar -zxvf test.tar.gz -C /tmp
$ tar -jxvf test.tar.bz2
$ tar -Jxvf test.tar.xz
```

---

## 尋找檔案 (find)

```shell
$ find $HOME -name '*.mp3'
$ find /etc -iname 'Network'
$ find /var/log -iname '*.log' -type f
$ find /etc -iname 'apache2' -type d
```

*-type*

> b block (buffered) special

> c character (unbuffered) special

> d directory

> p named pipe (FIFO)

> f regular file

> l symbolic link

> s socket

> D door (Solaris)

**指定大小、存取修改時間、建立時間、特定使用者**

```shell
$ find /var -type f -size +50M
$ find /var -type f -size -50M
$ find $HOME -type f -atime -7
$ find $HOME -type f -amin +10
$ find $HOME -type f -amin -10
$ find $HOME -type f -ctime +30
$ find $HOME -type f -user tom
```

例1：同時找兩種檔名樣式的檔案

```shell
$ find $HOME -name '*.mp3' -o -user '*.ogg'
```

例2：同時找兩個擁有者的檔案

```shell
$ find /usr/local -user user1 -o -user user2
```

[https://blog.miniasp.com/post/2010/08/27/Linux-find-command-tips-and-notice.aspx](https://blog.miniasp.com/post/2010/08/27/Linux-find-command-tips-and-notice.aspx)

[https://blog.gtwang.org/linux/unix-linux-find-command-examples/](https://blog.gtwang.org/linux/unix-linux-find-command-examples/)

[Changing chmod for files but not directories](https://stackoverflow.com/questions/1163294/changing-chmod-for-files-but-not-directories)

---

## 磁碟與檔案系統管理 (df, du)

`df` : 列出檔案系統的整體磁碟使用量

```shell
$ df -h     # 將容量結果以易讀的容量格式顯示出來

$ df -aT    # 將系統內的所有特殊檔案格式及名稱都列出來

$ df -ih    # 將目前各個 partition 當中可用的 inode 數量列出
```

`du` : 評估檔案系統的磁碟使用量 (常用於推估目錄所佔容量)

```shell
$ du -a      # 列出目前目錄下的所有檔案容量

$ du -sm /*  # 檢查根目錄底下每個目錄所佔用的容量

$ du -sh     # 計算這個目錄下的所有檔案、資料夾總大小

$ du -h      # 計算『目前目錄』跟『子目錄』的所有資料夾大小
```
*-type*

> -a 顯示目錄中個別檔案的大小

> -b 以bytes為單位顯示

> -c 顯示個別檔案大小與總和

> -D 顯示符號鏈結的來源檔大小

> -h Human readable

> -H 與-h類似, 但是以1000為k的單位而非1024 bytes為區塊的單位

> -l 重複計算鏈結黨所占空間

> -L 符號鏈結 指定符號鏈結檔的大小

> -m 以 MB 為顯示單位

> -s 只顯示總和

> -S 顯示目錄內容時, 不包含子目錄大小.

> -x 若目錄中有不同的檔案系統, 不顯示相異的檔案系統

> --exclude 忽略指定的檔案或目錄

> --max-depth 僅搜尋指定的目錄層級

[https://www.orztw.com/2014/06/linux-command-du.html](https://www.orztw.com/2014/06/linux-command-du.html)

[http://puremonkey2010.blogspot.com/2010/12/linux-du.html](http://puremonkey2010.blogspot.com/2010/12/linux-du.html)

[http://www.runoob.com/linux/linux-comm-du.html](http://www.runoob.com/linux/linux-comm-du.html)

[http://www.cnblogs.com/peida/archive/2012/12/10/2810755.html](http://www.cnblogs.com/peida/archive/2012/12/10/2810755.html)

[https://blog.xuite.net/chingwei/blog/32566618-【系統】使用+du+來看磁碟的使用空間](https://blog.xuite.net/chingwei/blog/32566618-%E3%80%90%E7%B3%BB%E7%B5%B1%E3%80%91%E4%BD%BF%E7%94%A8+du+%E4%BE%86%E7%9C%8B%E7%A3%81%E7%A2%9F%E7%9A%84%E4%BD%BF%E7%94%A8%E7%A9%BA%E9%96%93)

### ncdu

https://blog.myxnova.com/archives/600

---

## 程序管理 (jobs)

`jobs [-lrs]` : 查看目前的背景工作狀態

```shell
$ jobs -l    # 除了列出 job number 與指令串之外，同時列出 PID
$ jobs -r    # 列出正在背景 run 的工作
$ jobs -s    # 列出正在背景當中 stop 的工作
```

### bjobs (IBM Spectrum LSF, Platform Load Sharing Facility)

不加任何參數時，只會顯示自己正在 running 或 pending 中的 job，若要看其他人的 job running 狀態的話，可使用-u 參 數指定 user name 或 all，亦可指定 qname。

```shell
$ bjobs -u   # 指定 user（可省略，預設值是自己）

$ bjobs -u all

$ bjobs -q   # 指定 Queue name

$ bjobs -l   # long format 詳細資料

$ bjobs -p   # 只顯示 pending job
```

https://www.ibm.com/support/knowledgecenter/zh-tw/SSWRJV_10.1.0/lsf_welcome/lsf_kc_cmd_ref.html

---

## 數據重導向 (tee)

`tee` : tee 會同時將資料流分送到檔案 (file) 與螢幕 (screen)，輸出至螢幕實際上就是 stdout

```shell
$ perl hello.pl | & tee log
```

---

## 計算機 (bc)

[Linux 計算機 bc 指令用法教學與範例 - G. T. Wang](https://blog.gtwang.org/linux/linux-bc-command-tutorial-examples/)

[Linux 下的計算器 (bc、expr、dc、echo、awk) 知多少？](https://blog.csdn.net/linco_gp/article/details/4517945)

---

## [Command for Text Processing](https://github.com/meliodaseren/linux-cheat-sheet/blob/master/unix-commands/text-processing.md)

---

## gnome-terminal

https://blog.csdn.net/swust_long/article/details/7285147

https://hk.saowen.com/a/7ce7d16606cab5e0829444f48b8bba6f5b31fffef5f3279c6a0984975afc3aaf
