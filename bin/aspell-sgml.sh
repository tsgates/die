#!/bin/bash

DIC=$(dirname "$0")/../aspell.words
SGML=$1

touch $DIC
aspell --lang en -x --mode=sgml -p $(pwd)/$DIC -c $SGML

VER=$(head -1 $DIC)
tail -n +2 $DIC | LC_ALL=C sort > $DIC~

echo $VER > $DIC
cat $DIC~ >> $DIC
