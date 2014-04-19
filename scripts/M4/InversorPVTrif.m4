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

scale=25.4 #pasa de inches (default) a mm.
elen = sourcerad_*15#Tamaño de los elementos
sep = dimen_*1.25#Separación entre algunos componentes
sepBox= sep/6#Separación del cajeado con el sistema a resaltar

Origen: Here                   # Position names are capitalized
   
   InvInput: Here
   S1: igbt(up_ elen/2) with .C at InvInput; rlabel(,S_1,);
   S2: igbt(up_ elen/2) with .C at S1.E; rlabel(,S_2,);
   S3: igbt(up_ elen/2) with .C at S1.C+(sep,0); rlabel(,S_3,);
   S4: igbt(up_ elen/2) with .C at S3.E; rlabel(,S_4,);
   S5: igbt(up_ elen/2) with .C at S3.C+(sep,0); rlabel(,S_5,);
   S6: igbt(up_ elen/2) with .C at S5.E; rlabel(,S_6,);
   line from S3.C to BoostOutput
   line from S4.E to Origen
   A: dot(at S1.E-(0,dimen_/8));
   B: dot(at S3.E+(0,dimen_/8));
   line right_ sep/2 from B  \
	then up_ InvInput.y-B.y 
   Linv:inductor(right_ elen/2); rlabel(,L_{inv},); 
   Trafo:transformer(down_ elen,,,AW) with .P1 at Here; rlabel(,T_{inv},)
   line right_ 3*sep/2 from A \
	then down_ A.y-Origen.y \
	then to Trafo.P2;
   #Hago un marco con linea discontinua alrededor del Inversor
   dInv=Trafo.S1.x-S1.G.x;
   hInv=Trafo.S1.y-Origen.y;
   line dashed from (S1.G,InvInput)+(-sepBox,sepBox) right_ dInv+2*sepBox \
		then down_ hInv+2*sepBox \
		then left_ dInv+2*sepBox "Inversor DC/AC" below
   line dashed from Here up_ hInv+2*sepBox;#Parece que al poner texto hay que empezar otra linea
   
   #Fin del inversor. Red eléctrica
   line right_ sep from Trafo.S1
   line right_ sep from Trafo.S2

   source(up_ elen,AC); rlabel(,V_{red},)
   
.PE                            # Pic input ends


