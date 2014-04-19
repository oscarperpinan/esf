.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos

cct_init                       # Set defaults

Origen: Here
  modulo(up_ elen_)
  S1:switch(right_,,D)
  {Bateria:battery(down_ elen_,,R);llabel(+,V_B,-)}
  S2:switch(right_,,D)
  resistor(down_ elen_,E)
  line left_ to Origen
  box dotted wid elen_*1.6 ht elen_*0.3 at (S1+S2)/2
.PE             
 
