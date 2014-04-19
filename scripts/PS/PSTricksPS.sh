#!/bin/bash

#$1 es el nombre del fichero TEX, pero sin .tex!!!
cp $1.tex Fich.tex
latex PSTricksPS.tex
dvips PSTricksPS.dvi -E -o ../Figuras/$1.ps
ps2pdf -dEPSCrop $1.ps $1.pdf
rm PSTricksPS.aux PSTricksPS.dvi PSTricksPS.log Fich.tex

