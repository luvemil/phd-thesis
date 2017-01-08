BDIR=.aux_files/
TEXOP=-output-directory $(BDIR)

%: %.tex
	pdflatex $(TEXOP) $@
	biber $(TEXOP) $@
	pdflatex $(TEXOP) $@
	pdflatex $(TEXOP) $@
	cp $(BDIR)/$@.pdf .

all: torsion_theories

new: general_torsion

clean:
	rm *.aux *.bcf *.log *.blg *.bbl *.out *.run.xml
