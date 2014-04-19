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

  line up dimen_*1/3;
  Origen: dot ;
  F1: fuse(up_ elen_, B)
  M1:modulo(up_ elen_)
  M2:modulo(up_ elen_)
  M3:modulo(up_ elen_)
  F2: fuse(up_ elen_, B)
  Final:dot
 
  
   
	line dashed from M1.start right_ elen_*1/3
	D1_1:diode(up_ elen_*0.5 to (Here,M1.c)); 
	D2_1:diode(up_ elen_*0.5 to (Here,M1.end)); 
	D1_2:diode(up_ elen_*0.5 to (Here,M2.c)); 
	D2_2:diode(up_ elen_*0.5 to (Here,M2.end)); 
	D1_3:diode(up_ elen_*0.5 to (Here,M3.c)); 
	D2_3:diode(up_ elen_*0.5 to (Here,M3.end)); 
	
	line dashed from D1_1.end to M1.c; dot;
	line dashed from D2_1.end to M1.end; dot; 
	line dashed from D1_2.end to M2.c; dot;
	line dashed from D2_2.end to M2.end; dot; 
	line dashed from D1_3.end to M3.c; dot;
	line dashed from D2_3.end to M3.end; dot; 
	
	
	
	line from Origen right_ elen_
	F1_2: fuse(up_ elen_, B)
	M4:modulo(up_ elen_)
	M5:modulo(up_ elen_)
	M6:modulo(up_ elen_)
	F2_2: fuse(up_ elen_, B)
	line to Final
	line up dimen_*1/3;
	
	
	line dashed from M4.start right_ elen_*1/3
	D1_4:diode(up_ elen_*0.5 to (Here,M4.c)); 
	D2_4:diode(up_ elen_*0.5 to (Here,M4.end)); 
	D1_5:diode(up_ elen_*0.5 to (Here,M5.c)); 
	D2_5:diode(up_ elen_*0.5 to (Here,M5.end)); 
	D1_6:diode(up_ elen_*0.5 to (Here,M6.c)); 
	D2_6:diode(up_ elen_*0.5 to (Here,M6.end)); 
	
	line dashed from D1_4.end to M4.c; dot;
	line dashed from D2_4.end to M4.end; dot; 
	line dashed from D1_5.end to M5.c; dot;
	line dashed from D2_5.end to M5.end; dot; 
	line dashed from D1_6.end to M6.c; dot;
	line dashed from D2_6.end to M6.end; dot;
	
	
	
	
   
   
   
   
.PE                            # Pic input ends

