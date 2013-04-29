#!/bin/bash

DIC=$1
TEX=$2

TEXCMD=(--add-tex-command="autoref p"
        --add-tex-command='begin pp'
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
      	--add-tex-command='newcommand pp'
      	--add-tex-command='renewcommand pp'
      	--add-tex-command='usetikzlibrary p'
      	--add-tex-command='DeclareMathOperator pp'
      	--add-tex-command='VerbatimInput p')

aspell -t "${TEXCMD[@]}" -p $DIC -c $TEX
(head -1 aspell.words; tail -n +2 $DIC | LC_ALL=C sort) > $DIC
