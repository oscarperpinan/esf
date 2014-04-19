.PS                            # Pic input begins with .PS
#Si las tres líneas siguientes dan algún error, ejecutar
#export M4PATH='/usr/share/texmf-texlive/tex/latex/circuit_macros'
#que debiera estar incluido en el .bashrc
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

cct_init                       # Set defaults

scale=25.4 #pasa de inches (default) a mm.
elen = sourcerad_*15#Tamaño de los elementos
sep = dimen_*1.25#Separación entre algunos componentes
sepBox= sep/6#Separación del cajeado con el sistema a resaltar

Origen: Here                   # Position names are capitalized
   source(up_ elen); llabel(,V_{PV},+)
   line right_ sep
   
   #Empieza el Convertidor DC/DC Boost
   BoostInput: dot
   {Cpv:capacitor(down_ to (Here,Origen)); llabel(,C_{PV},)}
   Lb: inductor(right_ elen/2); rlabel(,L_B,); 
   dot
   {Sb: igbt(up_ elen) with .C at Here; rlabel(,S_B,)}
   Db:diode(right_ elen/2); rlabel(,D_B,)
   {Cdc:capacitor(down_ to (Here,Origen)); rlabel(,C_{DC},)}
   BoostOutput:Here
   
   #Hago un marco con linea discontinua alrededor del Boost
   #Creo que también se puede hacer con BOX!!
   dBoost=BoostOutput.x-BoostInput.x;
   hBoost=BoostOutput.y-Origen.y;
   line dashed from BoostInput+(-sepBox,sepBox) right_ dBoost+2*sepBox \
		then down_ hBoost+2*sepBox \
		then left_ dBoost+2*sepBox "Convertidor DC/DC (Boost)" below
   line dashed from Here up_ hBoost+2*sepBox;#Parece que al poner texto hay que empezar otra linea
   
   #Empieza el inversor
   InvInput: dot(at BoostOutput+(sep,0));
   S1: igbt(up_ elen/2) with .C at InvInput; rlabel(,S_1,);
   S2: igbt(up_ elen/2) with .C at S1.E; rlabel(,S_2,);
   S3: igbt(up_ elen/2) with .C at S1.C+(sep,0); rlabel(,S_3,);
   S4: igbt(up_ elen/2) with .C at S3.E; rlabel(,S_4,);
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


