.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	
	diode(right_ elen_*1.5); rlabel(+,,-);llabel(Anodo,,Catodo);
	line right_ elen_*0.7; b_current(I_D)
	
.PE                            # Pic input ends
