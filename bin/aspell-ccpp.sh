#!/bin/bash

DIC=$(dirname "$0")/../aspell.words
CCPP=$1

touch $DIC
aspell --lang en -x --mode=ccpp -p $(pwd)/$DIC -c $CCPP

VER=$(head -1 $DIC)
tail -n +2 $DIC | LC_ALL=C sort > $DIC~

echo $VER > $DIC
cat $DIC~ >> $DIC
