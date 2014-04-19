.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos


cct_init                       # Set defaults


wMod= dimen_*2/3

Origen: Here
  M1: modulo(up_ elen_)
  line right wMod from M1.end; 
  Pos:dot
  line right wMod*0.9;
  Rh: resistor(down_ elen_);llabel(,R_h,)
  Rp: resistor(down_ elen_);llabel(,R_p,)
  T1: ground
  line right wMod from M1.start; 
  Neg:dot
  Rts: resistor(down_ elen_);rlabel(,R_{ts},)
  T2: ground
  Marco: box dashed wid wMod*1.4 ht dimen_*1.2 at M1.center
  move to 0.5 between Marco.nw and Marco.sw; dot
  line left wMod*0.6
  Rtp: resistor(down_ elen_);rlabel(,R_{tp},)
  ground
  arrow dashed from Pos to Neg "$V_g$" ljust
  
.PE