#!/bin/bash
# rotatelogs--循環封存在/var/log的日誌檔案，以確保檔案不會太大而難以
#   管理。此腳本使用一支設定檔，用來自行指定每支日誌檔的循環週期，設
#   定檔以「日誌檔名=循環週期」格式記錄，循環週期的單位為「日」，沒有
#   在設定檔中指定的日誌檔，則 rotatelogs 會以7天為週期循環封存這些
#   檔案。如果循環週期設為 0，腳本會略過而不處理此日誌檔的循環封存。

logdir="/var/log"             # 您的日誌檔案所在目錄可能不同。
config="$logdir/rotatelogs.conf"
mv="/bin/mv"
default_duration=7            # 預設循環週期為 7 天。
count=0

duration=$default_duration

if [ ! -f $config ] ; then
  # 找不到此腳本的設定檔？就結束執行，也可以移除此段檢查程式，當找不到
  #   設定檔時，直接忽略自定規則。
  echo "$0: 找不到設定檔，無法繼續處理。" >&2
  exit 1
fi

if [ ! -w $logdir -o ! -x $logdir ] ; then
  # -w是寫入權限，-x是執行權限，需要這兩個權限才能在Unix或Linux目錄
  #   中建立新檔案，如果沒有這兩個權限，執行就會失敗。
  echo "$0: 你沒有 $logdir 的適當權限。" >&2
  exit 1
fi

cd $logdir

# 雖然我們想在 find 中使用標準化的集合符號，如：digit：，但許多版本的
#   find不支援POSIX 的字元識別符號，像這裡用的 [0-9]。

# 這是一組非常粗糙的find 敘述，稍後會進一步說明，覺得好奇就請繼續閱讀！
for name in $(find . -maxdepth 1 -type f -size +0c ! -name '*[0-9]*' \
    ! -name '\.*' ! -name '*conf' -print | sed 's/^\.\///')
do
  count=$(( $count + 1 ))
  # 從設定檔中取得符合特定日誌檔的項目。
  duration="$(grep "^${name}=" $config|cut -d= -f2)"

  if [ -z "$duration" ] ; then
    duration=$default_duration    # 若無符合項目，就採用預設循環週期。
  elif [ "$duration" = "0" ] ; then
    echo "循環週期設為0：將略過 $name"
    continue
  fi

  # 設置循環封存的檔案名稱，真的很簡單：

  back1="${name}.1"; back2="${name}.2";
  back3="${name}.3"; back4="${name}.4";

  # 如果最近循環封存的檔案（back1）在特定時程內已修改，它就還未到循環
  #   時間， 這可以用 find 指定「-mtime修改時間」選項找到它。
  if [ -f "$back1" ] ; then
    if [ -z "$(find \"$back1\" -mtime +$duration -print 2>/dev/null)" ]
    then
      /bin/echo -n "$name 的最近備份日期至今未滿 $duration"
      echo "天：本筆略過。" ; continue
    fi
  fi

  echo "循環封存 $name 日誌（以 $duration天為週期）"

  # 從最早的部份開始循環封存，但要小心一個或多個檔案不存在的情形。
  if [ -f "$back3" ] ; then
    echo "... $back3 -> $back4" ; $mv -f "$back3" "$back4"
  fi
  if [ -f "$back2" ] ; then
    echo "... $back2 -> $back3" ; $mv -f "$back2" "$back3"
  fi
  if [ -f "$back1" ] ; then
    echo "... $back1 -> $back2" ; $mv -f "$back1" "$back2"
  fi
  if [ -f "$name" ] ; then
    echo "... $name -> $back1" ; $mv -f "$name" "$back1"
  fi
  touch "$name"
  chmod 0600 "$name"    # 最後一步： 將檔案的 rw屬性改為私有
done

if [ $count -eq 0 ] ; then
  echo "毋須處理： 沒有日誌檔是夠大或夠舊，所以不處理。"
fi

exit 0
