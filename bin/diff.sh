#!/bin/bash

HERE=$(pwd)
TMPD=$(mktemp -d /tmp/latexdiff.XXXXXXXXXX)
NEWD=$(pwd)
OLDD=$TMPD/old

if [[ ! -e $HERE/.git ]]; then
  echo "please run on git repo"
  exit 1
fi

git clone $NEWD $OLDD

cd $OLDD
git checkout $1

make
latexdiff --flatten p.tex $NEWD/p.tex > diff.tex

make MAIN=diff
cp -f diff.pdf $NEWD/diff.pdf