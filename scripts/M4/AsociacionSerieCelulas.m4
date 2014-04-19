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

   line right dimen_*1/3; b_current(I_r)
   Origen: dot  ; rlabel(,-,)
   C1:source(elen_,"$C_1$"); rarrow(I_{C1})
   line right dimen_*1/3
   C2:source(elen_,"$C_2$")
   line right dimen_*1/3
   C3:source(elen_,"$C_3$")
   Serie1:Here
   line right dimen_*1/3
   C4:source(elen_,X); llabel(,C_4,); rarrow(I_{C4})
   line right dimen_*1/3
   C5:source(elen_,"$C_5$")
   line right dimen_*1/3
   C6:source(elen_,"$C_6$");
   Serie2:Here
   dot; rlabel(,+,)
   line right dimen_*2/3   
   
   
   
   
.PE                            # Pic input ends

