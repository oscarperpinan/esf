.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos


cct_init                       # Set defaults

hMod = dimen_
wMod= dimen_*2/3



Origen: Here
  M1: modulo(up_ elen_)
  line right elen_*1.2 from M1.end; 
  Pos:dot
  line right elen_*1.2 from M1.start; 
  Neg:dot
  Marco: box dashed wid wMod*1.4 ht hMod*1.2 at M1.center
  A: dot(at Marco.sw)
  line down elen_ from Marco.sw 
  B:dot
  Rts:resistor(down_ elen_); rlabel(,R_{ts},); ground
  R: resistor(right_ elen_ from B); rlabel(,R,); 
  line up to (Here,Neg)
  move to 0.6 between Marco.ne and Marco.se; 
  ContactoH:dot
  line right from ContactoH to (Pos,ContactoH); 
  Rh: resistor(right_ elen_);rlabel(,R_h,)
  Rp: resistor(down_ elen_);llabel(,R_p,)
  T1: ground
  move to 0.4 between Marco.ne and Marco.se; 
  ContactoISO:dot
  #line right from ContactoISO to (Pos,ContactoISO); 
  Riso:resistor(right_ elen_*0.6); llabel(,R_{iso},)
  line up to (Here,Pos); dot
  #arrow from Pos to Neg "$V_g$" ljust
  
.PE