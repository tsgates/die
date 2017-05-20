MAIN ?= p
DIFF ?= HEAD^
CODE := $(addsuffix .tex,$(filter-out %.tex,$(wildcard code/*)))
FIGS := $(patsubst %.svg,%.pdf,$(wildcard fig/*.svg))
ODGS := $(patsubst %.odg,%.pdf,$(wildcard fig/*.odg))
PLOT := $(patsubst %.gp,%.tex,$(wildcard data/*.gp))
DEPS := rev.tex code/fmt.tex abstract.txt $(CODE) $(FIGS) $(ODGS) $(PLOT)
LTEX := --latex-args="-shell-escape"
BTEX := --bibtex-args="-min-crossrefs=99"
SHELL:= $(shell echo $$SHELL)

all: $(DEPS) ## generate a pdf
	@TEXINPUTS="sty:" bin/latexrun $(LTEX) $(BTEX) $(MAIN)

submit: $(DEPS) ## proposal function
	@for f in $(wildcard submit-*.tex); do \
		TEXINPUTS="sty:" bin/latexrun $$f; \
	done

diff: $(DEPS) ## generate diff-highlighed pdf
	@bin/diff.sh $(DIFF)

help: ## print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

code/%.tex: code/% ## build highlighted tex code from source code
	pygmentize -P tabsize=4 -P mathescape -f latex $^ | mark.py > $@

code/fmt.tex: ## generate color table
	pygmentize -f latex -S default > $@

fig/%.pdf: fig/%.svg ## generate pdf from svg
	inkscape --without-gui -f $^ -D -A $@

fig/%.pdf: fig/%.odg ## generate pdf from LibreOffice Draw
	soffice --convert-to pdf $< --outdir $(@D)
	pdfcrop $@ $@

data/%.tex: data/%.gp ## generate plot
	gnuplot $^

draft: $(DEPS) ## generate pdf with a draft info
	echo -e '\\newcommand*{\\DRAFT}{}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(BTEX) $(MAIN)

watermark: $(DEPS) ## generate pdf with a watermark
	echo -e '\\usepackage[firstpage]{draftwatermark}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(BTEX) $(MAIN)

spell: ## run a spell check
	@for i in *.tex fig/*.tex; do bin/aspell.sh $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex
	@pdftotext $(MAIN).pdf /dev/stdout | grep '??'

clean: ## clean up
	@bin/latexrun --clean
	rm -f abstract.txt

distclean: clean ## clean up completely
	rm -f code/*.tex

abstract.txt: abstract.tex $(MAIN).tex ## generate abstract.txt
	@bin/mkabstract $(MAIN).tex $< | fmt -w72 > $@

.PHONY: all help FORCE draft clean spell distclean init