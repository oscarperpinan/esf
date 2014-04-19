.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults




Origen: Here
  M1: modulo(up_ elen_)
  Riso: resistor(right_ elen_ from M1.end); b_current(I_f); llabel(,R_{iso},);
  {Corto: dot; line down elen_; dot}
  Rh: resistor(right_ elen_); llabel(,R_h,); rarrow(V_c)
  Rp: resistor(down_ elen_); llabel(,R_p,)
  dot;ground;
  Rts: resistor(left_ elen_); llabel(,R_{ts},)
  R: resistor(left_ elen_); llabel(,R,)
  line up to M1.start
  #arrow from Pos to Neg "$V_g$" ljust
  
.PE