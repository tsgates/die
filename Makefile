MAIN ?= p
DEPS := rev.tex code/fmt.tex abstract.txt

all: $(DEPS)
	@bin/build.sh $(MAIN)

.PHONY: help
help:
	echo "..."

.PHONY: FORCE
rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

code/fmt.tex:
	pygmentize -f latex -S default > $@

.PHONY: draft
draft: $(DEPS)
	echo -e '\\newcommand*{\\DRAFT}{}' >> rev.tex
	@bin/build.sh $(MAIN)

.PHONY: spell
spell:
	@for i in *.tex *.bbl; do bin/aspell.sh aspell.words $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex

.PHONY: clean
clean:
	bin/latexmk -C p
	rm -f abstract.txt

.PHONY: distclean
distclean: clean
	rm -f code/*.tex

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
