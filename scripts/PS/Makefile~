.PHONY: %.pdf
%.pdf: 
	m4 $*.m4 | dpic -p > Fich.tex
	latex TeX2PS.tex	
	dvips TeX2PS.dvi -E -o $*.ps
	ps2pdf -dEPSCrop $*.ps $@
	rm Fich.tex TeX2PS.aux TeX2PS.dvi TeX2PS.log
