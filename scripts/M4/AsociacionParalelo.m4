.PS                            # Pic input begins with .PS
define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)



cct_init                       # Set defaults

scale=25.4 #pasa de inches (default) a mm.


  
  Origen:Here
  gap(down_ elen_ ,,A); 
  rlabel(+,u(t),-)
  line right_ elen_ from Origen; b_current(i(t),,O,E) 
  {R1: resistor(down_ elen_); rlabel(,R_1,); b_current(i_1(t)); }
  line right_ dimen_
  {R2: resistor(down_ elen_); rlabel(,R_2,); b_current(i_2(t));}
  line right_ dimen_
  R3: resistor(down_ elen_); rlabel(,R_3,); b_current(i_3(t));
  line left_ to (Origen,Here)
  Fin: Here
  
  
  
  
  
  Final:dot
 
  
   
	
   
   
.PE                            # Pic input ends

