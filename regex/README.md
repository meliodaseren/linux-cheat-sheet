# Regular Expression

| Regex | 意義 |
| ----- | ----- |
| `^word` | 行首 |
| `word$` | 行尾 |
| `\A` | 字串行首 |
| `\z` | 字串行尾 |
| `.`     | 一個任意字元  |
| `\`     | 跳脫字符 |
| `*`     | 重複零個至多個的前一個字元 |
| `[list]`  | 想要擷取的字元 `l`, `i`, `s`, `t` |
| `[n1-n2]` | 想要擷取的字元範圍 |
| `[^list]` | 列出不要的字串或範圍 |
| `\{n,m\}` | 連續 n 到 m 個的『前一個 RE 字符』 |
| `d` | 數字 |
| `D` | 非數字 |
| `w` | 數字、字母、底線 |
| `W` | 非數字、字母、底線 |
| `s` | 空白 |
| `S` | 非空白 |
| `a?` | 零或一個 `a` |
| `a+` | 一或多個 `a` |
| `a*` | 零或多個 `a` |
| `a{4}` | 四個 `a` |
| `a{5,10}` | 五至十個 `a` |
| `a{5,}` | 至少五個 `a` |
| `a{,3}` | 最多三個 `a` |
| `a.{5}b` | `a` 和 `b` 中間夾五個任意字元 |

https://stackoverflow.com/questions/577653/difference-between-a-z-and-in-ruby-regular-expressions

## 參考

[RegexOne](https://regexone.com/)

[Regex 101](https://regex101.com/)

[正規表示式 Regular Expression](https://atedev.wordpress.com/2007/11/23/%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%A4%BA%E5%BC%8F-regular-expression/)

[第十一章、正規表示法與文件格式化處理](http://linux.vbird.org/linux_basic/0330regularex.php)

[Lazy and Greddy](https://stackoverflow.com/questions/2301285/what-do-lazy-and-greedy-mean-in-the-context-of-regular-expressions)
