.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos



cct_init                       # Set defaults



Origen: Here
  M1: modulo(up_ elen_)
  line up elen_*0.55 from M1.end 
  line right dimen_*0.5
  Pos:dot;
  line right dimen_*0.5
  resistor(down_ elen_*0.7); llabel(,R_h,);  b_current(I_f)
  resistor(down_ elen_*0.7); llabel(,R_p,)
  resistor(down_ elen_*0.7); llabel(,R_{ts},)
  line left dimen_*0.5 
  Neg: dot
  line left dimen_*0.5 
  line up to M1.start
  arrow dashed from Pos to Neg "$V_g$" ljust
  
.PE