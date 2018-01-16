all: recollement_cotorsion.pdf

%.pdf: %.tex
	pdflatex $^
	bibtex $(basename $^)
	pdflatex $^
	pdflatex $^
