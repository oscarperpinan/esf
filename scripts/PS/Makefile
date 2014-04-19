.PHONY: %.pdf
%.pdf: 
	cp $*.tex Fich.tex
	latex PSTricksPS.tex
	dvips PSTricksPS.dvi -E -o $*.ps
	ps2pdf -dEPSCrop $*.ps $@
	rm PSTricksPS.aux PSTricksPS.dvi PSTricksPS.log Fich.tex
