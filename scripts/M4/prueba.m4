
.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos

cct_init     
qrt=dimen_/4;
hlf=dimen_/2;
dim=dimen_;
mm=1/25.4;

E1:ellipse dashed 0.2 wid dim ht 3* dim 
C1:circle rad dim/10 at E1.c
L1:line from C1.n up_ dim
L2:line from C1.s down_ dim

.PE
