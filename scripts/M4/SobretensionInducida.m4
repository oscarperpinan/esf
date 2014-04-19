.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos

cct_init                       # Set defaults


sepDescarga=elen_/2
rElipse=sepDescarga+elen_*1.1

Origen: Here
R1:[for i=1 to 3 do {modulo(up_ elen_)}]
move right_ elen_*0.8
R2:[for i=1 to 3 do {modulo(down_ elen_)}]
line from R1.n to R2.n
line from R1.s right_ elen_*0.2 then down_ elen_*0.2; 
A: dot
line from R2.s left_ elen_*0.2 then down_ elen_*0.2; 
B: dot;
arrow dashed from A to B "$V_{ind}$" below
arrow  dashed from R2.n+(sepDescarga,0) to R2.s+(sepDescarga,0) "$I_{des}$" ljust
E:ellipse dashed wid rElipse ht elen_/3 at R2.c+(sepDescarga,0)
arrow dashed from E.e up_ elen_/3 right_ elen_/3 
arrow dashed from E.w down_ elen_/3 left_ elen_/3 "$\vec{B}\ $" rjust


.PE