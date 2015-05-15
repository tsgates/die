MAIN ?= p
DIFF ?= HEAD^
CODE := $(addsuffix .tex,$(filter-out %.tex,$(wildcard code/*)))
FIGS := $(patsubst %.svg,%.pdf,$(wildcard fig/*.svg))
PLOT := $(patsubst %.gp,%.tex,$(wildcard data/*.gp))
DEPS := rev.tex code/fmt.tex abstract.txt $(CODE) $(FIGS) $(PLOT)
BTEX := --bibtex-args="-min-crossrefs=99"

all: $(DEPS)
	@TEXINPUTS="sty:" bin/latexrun $(BTEX) $(MAIN)

submit: $(DEPS)
	@for f in $(wildcard submit-*.tex); do \
		TEXINPUTS="sty:" bin/latexrun $$f; \
	done

diff: $(DEPS)
	@bin/diff.sh $(DIFF)

help:
	echo "..."

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

code/%.tex: code/%
	pygmentize -P tabsize=4 -P mathescape -f latex $^ > $@

code/fmt.tex:
	pygmentize -f latex -S default > $@

fig/%.pdf: fig/%.svg
	inkscape --without-gui -f $^ -D -A $@

data/%.tex: data/%.gp
	gnuplot $^

draft: $(DEPS)
	echo -e '\\newcommand*{\\DRAFT}{}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(BTEX) $(MAIN)

watermark: $(DEPS)
	echo -e '\\usepackage[firstpage]{draftwatermark}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(BTEX) $(MAIN)

spell:
	@for i in *.tex fig/*.tex; do bin/aspell.sh $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex
	@pdftotext $(MAIN).pdf /dev/stdout | grep '??'

clean:
	@bin/latexrun --clean
	rm -f abstract.txt

distclean: clean
	rm -f code/*.tex

init:
	rm -f {code,fig,data}/ex-*
	perl -pi -e 's/^\\input{ex}/% \\input{ex}/g' $(MAIN).tex

abstract.txt: abstract.tex $(MAIN).tex
	@bin/mkabstract $(MAIN).tex $< > $@

.PHONY: all help FORCE draft clean spell distclean init
