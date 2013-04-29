#!/bin/bash
#
# http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/
#
 
weasels="many|various|very|fairly|several|extremely\
|exceedingly|quite|remarkably|few|surprisingly\
|mostly|largely|huge|tiny|((are|is) a number)\
|excellent|interestingly|significantly\
|substantially|clearly|vast|relatively|completely"
 
if [ "$1" = "" ]; then
    echo "usage: `basename $0` <file> ..."
    exit
fi

for F in "$@";
do
    cat $F | grep -v ^% | tr \\n\\r '  ' |
    egrep -i --color=always "\\b($weasels)\\b" |
    fmt -w70 | awk '{print "'$F':", $0;}' | grep ''
done

exit 0

