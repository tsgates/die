#!/bin/bash

DIC=$(dirname "$0")/../aspell.words
TEX=$1

# p: skip a param
# P: don't skip a param
# o: skip an optional param
# O: don't skip an optional param
TEXCMD=(--add-tex-command="autoref p"
        --add-tex-command='begin pop'
	      --add-tex-command='bibliography p'
      	--add-tex-command='bibliographystyle p'
      	--add-tex-command='cc p'
      	--add-tex-command='citeauthor p'
      	--add-tex-command='color p'
      	--add-tex-command='definecolor ppp'
      	--add-tex-command='eqref p'
      	--add-tex-command='fvset p'
      	--add-tex-command='hypersetup p'
      	--add-tex-command='lstset p'
      	--add-tex-command='mathit p'
      	--add-tex-command='mathrm p'
      	--add-tex-command='includeplot p'
      	--add-tex-command='includepdf p'
      	--add-tex-command='therev p'
      	--add-tex-command='newcommand pp'
      	--add-tex-command='renewcommand pp'
      	--add-tex-command='usetikzlibrary p'
      	--add-tex-command='DeclareMathOperator pp'
      	--add-tex-command='VerbatimInput p'
        --add-tex-command='includefig pp')

touch $DIC
aspell --lang en -x --mode=tex "${TEXCMD[@]}" -p $(pwd)/$DIC -c $TEX

VER=$(head -1 $DIC)
tail -n +2 $DIC | LC_ALL=C sort > $DIC~

echo $VER > $DIC
cat $DIC~ >> $DIC
