.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

Origen: Here
	Il:source(up_ elen_,I); llabel(,I_L,)
	line right_ elen_*0.7
	{diode(down_ elen_); rlabel(,D,);b_current(I_D)}
	line right_ elen_*0.7
	{resistor(down_ elen_); rlabel(,R_p,)}
	Rs:resistor(right_ elen_);llabel(,R_{s},);b_current(I); 
	gap(down_ elen_,,A); llabel(+,V,-)
	line to Origen;
.PE                            # Pic input ends
