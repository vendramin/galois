# ============================================================
# Makefile for building both versions of the notes:
#   notes.pdf     -- original version   (notes.tex,     pdflatex)
#   dyslexic.pdf  -- accessible version (dyslexic.tex,   xelatex)
#
# Usage (from a terminal, in this folder):
#   make              build both PDFs
#   make notes        build only notes.pdf
#   make dyslexic     build only dyslexic.pdf
#   make clean        remove build junk (.aux, .log, .idx, ...)
#   make distclean    also remove the PDFs
#
# Requires latexmk (bundled with TeX Live / MacTeX / MiKTeX).
# latexmk reruns pdflatex/xelatex as many times as needed and
# runs bibtex/makeindex automatically -- that's what actually
# resolves references, the bibliography and the index correctly,
# so avoid calling pdflatex/xelatex directly.
# ============================================================

NOTES    := notes
DYSLEXIC := dyslexic

.PHONY: all notes dyslexic clean distclean

all: notes dyslexic

notes:
	latexmk -pdf -interaction=nonstopmode $(NOTES).tex

dyslexic:
	latexmk -pdf -interaction=nonstopmode $(DYSLEXIC).tex

clean:
	latexmk -c $(NOTES).tex
	latexmk -c $(DYSLEXIC).tex

distclean:
	latexmk -C $(NOTES).tex
	latexmk -C $(DYSLEXIC).tex
