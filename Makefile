# Documents in this repo. Plain `make` builds all of them.
DOCS = cv resume resume_ExxonMobil resume_ReadyNet
PDFS = $(addsuffix .pdf,$(DOCS))

# `make private` builds the same documents with the phone number included,
# for copies sent directly to people. They are written as <doc>_private.pdf so
# the publish step in CI, which copies cv.pdf and resume.pdf by name, can never
# pick them up. Like every PDF here they are gitignored.
PRIVATE = $(addsuffix _private.pdf,$(DOCS))

# These sources load fontspec + xeCJK, so they need XeLaTeX. Plain pdfLaTeX
# (the -pdf flag the upstream template used) cannot compile them.
LATEXMK = latexmk -xelatex -interaction=nonstopmode

all: $(PDFS)

private: $(PRIVATE)

# Listed before the generic rule below so make never tries to build
# cv_private.pdf from a nonexistent cv_private.tex.
%_private.pdf: %.tex citations.bib
	$(LATEXMK) -jobname=$*_private -usepretex='\def\PrivateBuild{1}' $<

%.pdf: %.tex citations.bib
	$(LATEXMK) $<

# Shortcuts: `make cv`, `make resume`, ...
$(DOCS): %: %.pdf

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.toc *.xdv *~

distclean: clean
	rm -f $(PDFS) $(PRIVATE)

.PHONY: all private clean distclean $(DOCS)
