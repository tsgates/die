#!/bin/bash

git stash push
perl -pi -e 's/^\\input{ex}/% \\input{ex}/g' p.tex

make clean
tar -czvf /tmp/release-$(date +%Y-%m-%d).tar.gz . \
    --exclude=.git/ \
    --exclude=refs/ \
    --exclude=fig/ex-* \
    --exclude=code/ex-* \
    --exclude=data/ex-* \
    --exclude=NOTE \
    --exclude=release.sh \
    --exclude=*.tar.gz

git checkout p.tex
git stash pop