# ============================================================
# Makefile for building both versions of the notes:
#   notes.pdf           -- original version   (notes.tex,     pdflatex)
#   dyslexic.pdf        -- accessible version (dyslexic.tex,   xelatex)
#   solutions.pdf       -- just the solutions section, standalone
#
# Usage (from a terminal, in this folder):
#   make              build both PDFs
#   make notes        build only notes.pdf
#   make dyslexic     build only dyslexic.pdf
#   make solutions    build only solutions.pdf
#   make clean        remove build junk (.aux, .log, .idx, ...)
#   make distclean    also remove the PDFs
#
# Requires latexmk (bundled with TeX Live / MacTeX / MiKTeX).
# latexmk reruns pdflatex/xelatex as many times as needed and
# runs bibtex/makeindex automatically -- that's what actually
# resolves references, the bibliography and the index correctly,
# so avoid calling pdflatex/xelatex directly.
#
# The "solutions" target is the one deliberate exception: it needs
# raw control over solutions-only.aux (seeding it with notes.aux
# before every pdflatex pass, since pdflatex overwrites \jobname.aux
# at the end of each run) so the \sol{...} blocks can resolve the
# exercise labels defined in notes.tex's other chapters. latexmk
# would manage that aux itself and undo the seeding, so this target
# calls pdflatex directly on purpose. It depends on "notes" so that
# notes.aux (and the .aux files of any \include'd chapters, e.g.
# 06.aux, 09.aux) are present and up to date first. Requires
# solutions-only.tex to exist alongside notes.tex.
# ============================================================

NOTES     := notes
DYSLEXIC  := dyslexic
SOLUTIONS := solutions

.PHONY: all notes dyslexic solutions clean distclean

all: notes dyslexic

notes:
	latexmk -pdf -interaction=nonstopmode $(NOTES).tex

dyslexic:
	latexmk -lualatex -interaction=nonstopmode $(DYSLEXIC).tex

# Rebuild notes.aux (and friends) first, then seed solutions.aux
# from it before each pdflatex pass so \ref/\sol lookups resolve.
solutions: notes
	cp $(NOTES).aux $(SOLUTIONS).aux
	pdflatex -interaction=nonstopmode -jobname=$(SOLUTIONS) $(SOLUTIONS).tex
	cp $(NOTES).aux $(SOLUTIONS).aux
	pdflatex -interaction=nonstopmode -jobname=$(SOLUTIONS) $(SOLUTIONS).tex

clean:
	latexmk -c $(NOTES).tex
	latexmk -c $(DYSLEXIC).tex
	rm -f $(SOLUTIONS).aux $(SOLUTIONS).log $(SOLUTIONS).out $(SOLUTIONS).fls $(SOLUTIONS).fdb_latexmk

distclean:
	latexmk -C $(NOTES).tex
	latexmk -C $(DYSLEXIC).tex
	rm -f $(SOLUTIONS).aux $(SOLUTIONS).log $(SOLUTIONS).out $(SOLUTIONS).fls $(SOLUTIONS).fdb_latexmk $(SOLUTIONS).pdf
