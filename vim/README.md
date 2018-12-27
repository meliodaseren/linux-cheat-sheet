# vim Cheat Sheet

https://vim.rtorr.com/lang/zh_tw/

## 一般模式

| 按鍵 | 說明 |
| --- | --- |
| 0   | 移動至此行開頭 |
| $   | 移動至此行結尾 |
| 1G  | 移動至檔案的第一行 |
| 5G 或 :5 | 移動至檔案的第五行 |
| G   | 移動至檔案的最後一行 |
| w   | 移動至下一個 word |
| b   | 移動至上一個 word |
| (   | 移動至上一句 (句子表示以『!』、『.』、『?』結束的一串字) |
| )   | 移動至下一句 |
| {   |	移動至段落之首 (段落表示以空白行隔開的文字) |
| }   | 移動至段落之末 |
| %   | 移動至對應符號 () {} [] |
| H   | 移動至螢幕畫面的開頭 |
| M   | 移動至螢幕畫面的中間 |
| L   | 移動至螢幕畫面的結尾 |
| D   | 從游標位置刪除到行末 |
| dd  | 刪除游標所在的那一行 |
| 5dd | 刪除游標開始的 5 行 |
| dw  | 刪除至下一個單字 (delete word) |
| 6.9d | 刪除第 6 到 9 行 |
| yy  | 複製游標所在的一整行 |
| 3yy | 複製游標開始的 3 行 |
| yw  | 複製目前單字 (yank word) |
| p   | 貼上至游標位置的後面 |
| P   | 貼上至游標位置的前面 |
| /   | 往後搜尋字串， n 下一筆， N 上一筆 |
| ?   | 往前搜尋字串 |
| J   | 將目前這行與下一行合併 |
| u   | undo 最後修改 |
| U   | 恢復游標該行之所有改變 |
| Ctrl-r | redo |
| .   | 重複上次動作 |
| gf | 跳到關聯檔 (goto file) |

## 編輯模式

在一般模式輸入 i (insert) 進入編輯模式

## 指令列模式

在一般模式輸入 : 進入指令列模式

| 指令 | 說明 |
| --- | --- |
| h   | help |
| w   | 存擋 |
| w <filename> | 另存新檔 |
| wq 或 zz | 存檔並離開 |
| q!  | 強制離開 |
| 5,9 w <filename> | 將第 5 到 9 行另存檔案 |
| noh | 移除搜尋結果的標示 |
| e <filename> | 進入檔案 |
| Ex <directory> | 進入目錄 |
| sp <filename> | 水平切割並開啟新檔案 |
| vsp <filename> | 垂直切割並開啟新檔案 |

`:%s/old/new/g` 將 old 全部取代為 new

`:%s/old/new/gc` 將 old 逐項取代為 new

`:%s/pattern//gn` 計算指定搜尋字詞 (pattern) 數量

`:%s///gn` 計算搜尋後的光標字詞數量

`:g/^$/d` 刪除沒有內容的空行

`:g/^\s*$/d` 刪除包含有空格組成的空行

`:g/^[ |\t]*$/d` 刪除空格或 tab 開頭到結尾的空行

**刪除重複行**

```vim
:sort
:g/^\(.\+\)$\n\1/d
```

https://lawaymayaw.blogspot.tw/2016/02/vim-remove-dup-line.html

http://vim.wikia.com/wiki/Count_number_of_matches_of_a_pattern

https://stackoverflow.com/questions/23680778/how-do-you-open-a-file-from-within-vim

https://www.openfoundry.org/tw/tech-column/2383-vim--buffers-and-windows

https://segmentfault.com/q/1010000000343626

## 黏貼模式

`:set paste`

`:set nopaste`

https://ruby-china.org/topics/4266

http://bioankeyang.blogspot.tw/2014/12/vim.html

## Cheat Sheet

[Vim 快捷鍵](http://blog.jex.tw/blog/2013/05/15/vim/)

[大家來學VIM（一個歷久彌新的編輯器）](http://www.study-area.org/tips/vim/index.html)

## vim 個人設定檔

vimrc 路徑

```shell
$ vi ~/.vimrc                        # Linux
$ vi C:\Program Files\Git\etc\vimrc  # Windows git bash
$ vi /usr/share/vim/vimrc            # Mac OSX
```

我的設定：https://github.com/meliodaseren/future_docs/blob/master/linux/vim/vimrc

### Color Scheme

https://github.com/tomasr/molokai


### 簡易安裝指南

```shell
$ cp ~/.vimrc vimrc_backup
$ git clone https://github.com/meliodaseren/future_docs/blob/master/linux/vim/vimrc .
$ mv vimrc ~/.vimrc

$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim
```

```vim
:PluginInstall
```

```shell
$ brew install cmake
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.py --clang-completer
```

### Error

[YouCompleteme unavailable : no module named ...](https://github.com/Valloric/YouCompleteMe/issues/2271)

[Ycm doesn't complete thirdparty python module installing without pip.](https://github.com/Valloric/YouCompleteMe/issues/2637)

### Plugin

https://github.com/Valloric/YouCompleteMe

https://zhuanlan.zhihu.com/p/32404185

https://zhuanlan.zhihu.com/p/30022074

http://codingpy.com/article/vim-and-python-match-in-heaven/

http://wen00072.github.io/blog/2018/02/15/vim-setup-for-trace-c-code/#vtr-pkg
