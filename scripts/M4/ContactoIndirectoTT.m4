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
  line right wMod*2 from M1.end; 
  Pos:dot
  line right wMod from M1.start; 
  Neg:dot
  Rts: resistor(down_ elen_);rlabel(,R_{ts},)
  T2: ground
  Marco: box dashed wid wMod*1.4 ht hMod*1.2 at M1.center
  move to 0.5 between Marco.nw and Marco.sw; dot
  line left wMod*0.6
  Rtp: resistor(down_ elen_);rlabel(,R_{tp},); ground
  move to 0.6 between Marco.ne and Marco.se; 
  ContactoH:dot
  line right from ContactoH to (Pos,ContactoH); 
  Rh: resistor(right_ elen_);rlabel(,R_h,)
  Rp: resistor(down_ elen_);llabel(,R_p,)
  T1: ground
  move to 0.4 between Marco.ne and Marco.se; 
  ContactoISO:dot
  line right from ContactoISO to (Pos,ContactoISO); 
  Riso:resistor(up_ to (Here,Pos)); rlabel(,R_{iso},)
  #arrow from Pos to Neg "$V_g$" ljust
  
.PE