# Regular Expression

正規表示法很常用在處理字串，幾乎是每個工程師必學的技能之一。

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

## 個人遇到的問題整理

1. `^`, `$`, `\A`, `\Z`, `\z`之間的差別是什麼？

```
^ Matches the beginning of a line.

$ Matches the end of a line.

\A Matches the beginning of the string.

\z Matches the end of the string.

\Z Matches the end of the string unless the string ends with a "\n", in which case it matches just before the "\n".
```

https://stackoverflow.com/questions/577653/difference-between-a-z-and-in-ruby-regular-expressions

2. 正規表示法的 Lazy 和 Greddy 特性

Lazy 表示正規表示法會匹配到最短可能的字串。

Greddy 表示正規表示法會匹配到最長可能的字串。

```
+-------------------+-----------------+------------------------------+
| Greedy quantifier | Lazy quantifier |        Description           |
+-------------------+-----------------+------------------------------+
| *                 | *?              | Star Quantifier: 0 or more   |
| +                 | +?              | Plus Quantifier: 1 or more   |
| ?                 | ??              | Optional Quantifier: 0 or 1  |
| {n}               | {n}?            | Quantifier: exactly n        |
| {n,}              | {n,}?           | Quantifier: n or more        |
| {n,m}             | {n,m}?          | Quantifier: between n and m  |
+-------------------+-----------------+------------------------------+
```

[Lazy and Greddy](https://stackoverflow.com/questions/2301285/what-do-lazy-and-greedy-mean-in-the-context-of-regular-expressions)

## 其他常用網站

1. [Regex 101](https://regex101.com/)

很好用的測試網站

2. [RegexOne](https://regexone.com/)

互動式教學網站

3. [正規表示式 Regular Expression](https://atedev.wordpress.com/2007/11/23/%E6%AD%A3%E8%A6%8F%E8%A1%A8%E7%A4%BA%E5%BC%8F-regular-expression/)

簡單的正規表示法介紹

4. [第十一章、正規表示法與文件格式化處理](http://linux.vbird.org/linux_basic/0330regularex.php)

鳥哥的正規表示法介紹