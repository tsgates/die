LATEXMK=bin/latexmk
ASPELL_CMDS=\
	--add-tex-command="autoref p"				\
	--add-tex-command='begin pp'				\
	--add-tex-command='bibliography p'			\
	--add-tex-command='bibliographystyle p'		\
	--add-tex-command='cc p'					\
	--add-tex-command='citeauthor p'			\
	--add-tex-command='color p'					\
	--add-tex-command='definecolor ppp'			\
	--add-tex-command='eqref p'					\
	--add-tex-command='fvset p'					\
	--add-tex-command='hypersetup p'			\
	--add-tex-command='lstset p'				\
	--add-tex-command='mathit p'				\
	--add-tex-command='mathrm p'				\
	--add-tex-command='newcommand pp'			\
	--add-tex-command='renewcommand pp'			\
	--add-tex-command='usetikzlibrary p'		\
	--add-tex-command='DeclareMathOperator pp'	\
	--add-tex-command='VerbatimInput p'			\

all: code/fmt.tex abstract.txt
	$(LATEXMK) -silent -pdf p &>/dev/null || (bin/parse-latex-log.py p.log; exit 1)

code/fmt.tex:
	pygmentize -f latex -S default > $@

SYS = $(shell sed -n -e 's/\\newcommand{\\sys}{\\mbox{\\textsc{\([^}]*\)}.*/\1/p' cmds.tex)
abstract.txt: abstract.tex
	@cat $<                         \
	    | grep -v '{abstract}'      \
	    | sed -e 's/\\emph//g'      \
	    | sed -e 's/{//g'           \
	    | sed -e 's/}//g'           \
	    | sed -e 's/---/ -- /g'     \
	    | sed -e 's/~/ /g'          \
	    | sed -e 's/\\sys/${SYS}/g' \
	    | fmt -w72 > $@

clean:
	$(LATEXMK) -C p
	rm -f abstract.txt

distclean: clean
	rm -f $(patsubst %.c,%.tex,$(wildcard code/*.c))

draft: code/fmt.tex
	printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' `git rev-parse --short HEAD` "`git log -1 --format='%ci' HEAD`" > rev.tex
	echo '\\newcommand*{\\DRAFT}{}' >> rev.tex
	<$(LATEXMK) -pdf p

spell:
	@ for i in *.tex *.bbl; do aspell -t $(ASPELL_CMDS) -p ./aspell.words -c $$i; done
	@ for i in *.tex; do bin/double.pl $$i; done
	@ for i in *.tex; do bin/abbrv.pl  $$i; done
	@ bash bin/hyphens.sh *.tex
	@ ( head -1 aspell.words ; tail -n +2 aspell.words | LC_ALL=C sort ) > aspell.words~
	@ mv aspell.words~ aspell.words
