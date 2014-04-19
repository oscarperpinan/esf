.PS                            # Pic input begins with .PS
#Si las tres líneas siguientes dan algún error, ejecutar
#export M4PATH='/usr/share/texmf-texlive/tex/latex/circuit_macros'
#que debiera estar incluido en el .bashrc
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)



cct_init                       # Set defaults

scale=25.4 #pasa de inches (default) a mm.
elen = sourcerad_*15#Tamaño de los elementos
sep = dimen_*1.25#Separación entre algunos componentes
sepBox= sep/6#Separación del cajeado con el sistema a resaltar

Origen: Here                   # Position names are capitalized
   gap(up_ elen);
   line right_ elen_/2
   
   #Empieza el Convertidor DC/DC Boost
   BoostInput: dot
   {Cpv:capacitor(down_ to (Here,Origen)); llabel(,C_{PV},)}
   Lb: inductor(right_ elen/2); rlabel(,L_B,); dot
   {Sb: switch(down_ to (Here,Origen),,D); rlabel(,S_B,)}
   Db:diode(right_ elen/2); rlabel(,D_B,); dot
   {Cdc:capacitor(down_ to (Here,Origen)); rlabel(,C_{DC},)}
   BoostOutput:Here
   
   line right_ elen_/2; dot;
   gap(down_ elen); line to Origen;
   
   
   
   
.PE                            # Pic input ends


