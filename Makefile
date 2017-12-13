all: recollement_cotorsion.pdf

%.pdf: %.tex
	pdflatex $@
	bibtex $@
	pdflatex $@
	pdflatex $@
