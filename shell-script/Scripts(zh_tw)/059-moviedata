#!/bin/bash
# moviedata--指定電影或電視標題，回傳符合的清單，如果使用者指定
#   IMDb的索引編號，則回傳該電影劇情介紹。使用網際網路電影資料庫
#   ：DMDb：Internet Movie Database。

titleurl="http://www.imdb.com/title/tt"
 imdburl="http://www.imdb.com/find?s=tt&exact=true&ref_=fn_tt_ex&q="
 tempout="/tmp/moviedata.$$"
 
summarize_film()
{
  # 產生保存的影集清單。

  grep "<title>" $tempout | sed 's/<[^>]*>//g;s/(more)//'

  grep --color=never -A2 '<h5>Plot:' $tempout | tail -1 | \
    cut -d\< -f1 | fmt | sed 's/^/ /'

  exit 0
}

trap "rm -f $tempout" 0 1 15

if [ $# -eq 0 ] ; then
  echo "執行方式： $0 {movie title | movie ID}" >&2
  exit 1
fi

#########
# 檢查是否指定的是IMDb的電影代號

nodigits="$(echo $1 | sed 's/[[:digit:]]*//g')"

if [ $# -eq 1 -a -z "$nodigits" ] ; then
  lynx -source "$titleurl$1/combined" > $tempout
  summarize_film
  exit 0
fi

##########
# 不是 IMDb 的電影代號，所以要執行搜尋作業...

fixedname="$(echo $@ | tr ' ' '+')" # for the URL

url="$imdburl$fixedname"

lynx -source $imdburl$fixedname > $tempout

# 找不到?

fail="$(grep --color=never '<h1 class="findHeader">No ' $tempout)"

# 如果有多筆符合時...

if [ ! -z "$fail" ] ; then
  echo "查詢失敗： 沒有任何電影符合 $1"
  exit 1
elif [ ! -z "$(grep '<h1 class="findHeader">Displaying' $tempout)" ] ; then
  grep --color=never '/title/tt' $tempout | \
  sed 's/</\
</g' | \
  grep -vE '(.png|.jpg|>[ ]*$)' | \
  grep -A 1 "a href=" | \
  grep -v '^--$' | \
  sed 's/<a href="\/title\/tt//g;s/<\/a> //' | \
  awk '(NR % 2 == 1) { title=$0 } (NR % 2 == 0) { print title " " $0 }' | \
  sed 's/\/.*>/: /' | \
  sort
fi

exit 0
