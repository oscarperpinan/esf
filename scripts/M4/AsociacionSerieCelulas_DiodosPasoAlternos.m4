.PS                            # Pic input begins with .PS
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)



cct_init                       # Set defaults

scale=25.4 #pasa de inches (default) a mm.
elen = sourcerad_*15#Tamaño de los elementos
sep = dimen_*1.25#Separación entre algunos componentes
sepBox= sep/6#Separación del cajeado con el sistema a resaltar

   line right dimen_*1/3; 
   Origen: dot  ; llabel(,-,)
   C1:source(elen_,"$C_1$"); 
   line dotted right_ dimen_*2/3
   C12:source(elen_,"$C_{12}$")
   Serie1:dot
   line right_ dimen_*1/3
   C13:source(elen_,"$C_{13}$"); 
   line dotted right_ dimen_*2/3
   C24:source(elen_,"$C_{24}$")
   Serie2:dot
   line right_ dimen_*1/3
   C25:source(elen_,"$C_{25}$"); 
   line dotted right_ dimen_*2/3
   C36:source(elen_,"$C_{36}$")
   Serie3: dot; rlabel(,+,)
   line right_ dimen_*2/3
	
	line from Origen down dimen_*2/3
	D1:diode(right_ to (Serie2,Here)); rlabel(,D_1,); 
	line down_ from D1.end to Serie2; dot;
	
	line from Serie1 up dimen_*2/3
	D2:diode(right_ to (Serie3,Here)); llabel(,D_2,);
	
	line down_ from D2.end to Serie3; dot;
   
   
   
   
   
.PE                            # Pic input ends

