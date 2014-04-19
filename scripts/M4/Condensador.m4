.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	capacitor(right_ elen_);b_current(i(t));rlabel(+,u(t),-);llabel(,C,)
	
	
.PE                            # Pic input ends
