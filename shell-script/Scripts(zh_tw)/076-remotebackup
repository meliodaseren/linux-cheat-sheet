#!/bin/bash
# remotebackup--取得檔案及目錄清單，建立單一的壓縮封存檔，然後以
#   電子郵件寄送到遠端的備份網站以便保管。打算每天晚上處理關鍵的
#   使用者檔案，但不想換用更嚴謹的備份方案。

outfile="/tmp/rb.$$.tgz"
outfname="backup.$(date +%y%m%d).tgz"
infile="/tmp/rb.$$.in"

trap "$(which rm) -f $outfile $infile" 0

if [ $# -ne 2 -a $# -ne 3 ] ; then
  echo "執行方式： $(basename $0) backup-file-list remoteaddr {targetdir}" >&2
  exit 1
fi

if [ ! -s "$1" ] ; then
  echo "錯誤：備份清單 $1 是空的或者不存在" >&2
  exit 1
fi

# 掃描所有項目並建立固定的infile清單，會對檔名中的萬用字符及空格
#   以倒斜線進行跳脫處理，將「"this file"」改成「this\ file」，
#   因此不需要使用雙引號。

while read entry; do
 echo "$entry" | sed -e 's/ /\\ /g' >> $infile
done < "$1"

# 建立封存檔、進行編碼及寄送的實際作業。

tar czf - $(cat $infile) | \
  uuencode $outfname | \
  mail -s "${3:-Backup archive for $(date)}" "$2"

echo "完成！$(basename $0) 已備份下列檔案："
sed 's/^/ /' $infile
/bin/echo -n "並寄送到 $2 "

if [ ! -z "$3" ] ; then
  echo "的指定目錄 $3"
else
  echo ""
fi

exit 0
