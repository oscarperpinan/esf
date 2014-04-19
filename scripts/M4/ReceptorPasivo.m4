.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	Pos:line right_ elen_*0.7; b_current(i(t))
	ebox(down_ elen_,,,0.5); llabel(+,v(t),-);
	Neg:line left_ elen_*0.7; 
	
.PE                            # Pic input ends
