LTMK := bin/latexmk
DEPS := rev.tex code/fmt.tex abstract.txt

define latexmk =
	$(LTMK) -silent -pdf "$1" &>/dev/null \
	  || (bin/parse-latex-log.py "$1.log"; exit 1)
endef

all: $(DEPS)
	$(call latexmk,p)

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

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

code/fmt.tex:
	pygmentize -f latex -S default > $@

draft: $(DEPS)
	echo -e '\\newcommand*{\\DRAFT}{}' >> rev.tex
	$(call latexmk,p)

.PHONY: spell clean distclean FORCE
spell:
	@for i in *.tex *.bbl; do bin/aspell.sh aspell.words $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex

clean:
	$(LTMK) -C p
	rm -f abstract.txt

distclean: clean
	rm -f $(patsubst %.c,%.tex,$(wildcard code/*.c))

FORCE: