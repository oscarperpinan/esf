.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
sinclude(Transistor.dim)#sirve para s_box
s_init(transistor)
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	
	T:igbt(up_ elen_,,LD); 
	s_box($C$) at T.C above
	s_box($B$) at T.B above
	s_box($E$) at T.E below

	
	
.PE                            # Pic input ends
