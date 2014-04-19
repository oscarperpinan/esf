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
  line left elen_*0.5
  line down elen_/2 from M1.start then right elen_*0.5; dot
  #arrow from Pos to Neg "$V_g$" ljust
  
.PE