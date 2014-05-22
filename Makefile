MAIN ?= p
DIFF ?= HEAD^
DEPS := rev.tex code/fmt.tex abstract.txt

all: $(DEPS)
	@bin/build.sh $(MAIN)

diff: $(DEPS)
	@bin/diff.sh $(DIFF)

help:
	echo "..."

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

code/fmt.tex:
	pygmentize -f latex -S default > $@

draft: $(DEPS)
	echo -e '\\newcommand*{\\DRAFT}{}' >> rev.tex
	@bin/build.sh $(MAIN)

spell:
	@for i in *.tex *.bbl; do bin/aspell.sh aspell.words $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex

clean:
	bin/latexmk -C p
	rm -f abstract.txt

distclean: clean
	rm -f code/*.tex

init:
	rm -f {code,fig,data}/ex-*
	perl -pi -e 's/^\\input{ex}/% \\input{ex}/g' $(MAIN).tex

SYS := $(shell sed -n -e 's/\\newcommand{\\sys}{\\mbox{\\textsc{\([^}]*\)}.*/\1/p' $(MAIN).tex)
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

.PHONY: all help FORCE draft clean spell distclean init
