.PS                            # Pic input begins with .PS
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)



cct_init                       # Set defaults

scale=25.4 #pasa de inches (default) a mm.


  
  Origen: dot; 
  line up_ dimen_
  R1: resistor(right_ elen_); rlabel(+,u_1(t),-); llabel(,R_1,);b_current(i(t)); 
  R2: resistor(right_ elen_); rlabel(+,u_2(t),-); llabel(,R_2,);
  R3: resistor(right_ elen_); rlabel(+,u_3(t),-); llabel(,R_3,);
  line down_ dimen_; 
  Fin: dot
  gap(right_ from Origen to Fin,,A); 
  rlabel(+,u(t),-)
  
  
  Final:dot
 
  
   
	
   
   
.PE                            # Pic input ends

