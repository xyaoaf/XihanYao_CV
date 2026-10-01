# Documents in this repo. Plain `make` builds all of them.
DOCS = cv resume resume_ExxonMobil resume_ReadyNet
PDFS = $(addsuffix .pdf,$(DOCS))

# These sources load fontspec + xeCJK, so they need XeLaTeX. Plain pdfLaTeX
# (the -pdf flag the upstream template used) cannot compile them.
LATEXMK = latexmk -xelatex -interaction=nonstopmode

all: $(PDFS)

%.pdf: %.tex citations.bib
	$(LATEXMK) $<

# Shortcuts: `make cv`, `make resume`, ...
$(DOCS): %: %.pdf

clean:
	latexmk -c $(addsuffix .tex,$(DOCS)) 2>/dev/null || true
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.toc *.xdv *~

distclean: clean
	rm -f $(PDFS)

.PHONY: all clean distclean $(DOCS)
