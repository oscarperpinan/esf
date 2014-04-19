.PS                            # Pic input begins with .PS
#Si las tres líneas siguientes dan algún error, ejecutar
#export M4PATH='/usr/share/texmf-texlive/tex/latex/circuit_macros'
#que debiera estar incluido en el .bashrc
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

#Después hay que ejecutar las dos líneas siguientes
#m4 quick.m4> quick.pic
#dpic -p quick.pic > quick.tex
#DPIC se obtiene de la página http://www.ece.uwaterloo.ca/~aplevich/dpic/dpic.tar.gz

cct_init                       # Set defaults

elen = 0.75                    # Variables are allowed; default units are inches
Origen: Here                   # Position names are capitalized
   source(up_ elen); llabel(,V_{PV},+)
   dot
   {                           # Save current position and direction
      Cpv:capacitor(down_ to (Here,Origen))     #(Here,Origin) = (Here.x,Origin.y)
      rlabel(,C_{PV},)
      dot
      }                        # Restore position and direction
   Lb:inductor(right_ ); rlabel(,L,); b_current(i)
   line to Origin
.PE                            # Pic input ends


