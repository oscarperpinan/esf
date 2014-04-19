.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos


cct_init                       # Set defaults


Origen: Here
  M1: modulo(up_ elen_)
  line up elen_/2 from M1.end
  Riso: resistor(right_ elen_); b_current(I_f); llabel(,R_{iso},);
  {Rtp: resistor(down_ elen_*2); llabel(,R_{tp},); dot; ground}
  line right elen_*0.5
  Rh: resistor(down_ elen_); llabel(,R_h,); rarrow(V_c)
  Rp: resistor(down_ elen_); llabel(,R_p,)
  dot;ground;
  line left elen_*0.5
  Rts: resistor(left_ elen_); llabel(,R_{ts},)
  line up to M1.start
  #arrow from Pos to Neg "$V_g$" ljust
  
.PE