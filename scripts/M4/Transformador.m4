.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



#scale=25.4 #pasa de inches (default) a mm.

	Origen:source(up_ elen_);llabel(,,+);
	P1:line right_ elen_; b_current(i_p(t),,O,E) 
	A: transformer(down_ elen_,,,W) with .P1 at Here; rlabel(,u_p(t),); llabel(,u_s(t),)
	P2:line left_ elen_ from A.P2; 
	S1:line right_ elen_ from A.S1; b_current(i_s(t),,I,S)
	ebox(down_ elen_)  
	S2:line left_ elen_ to A.S2; 
	gap(from P1 to P2,,A); 
	gap(from S1 to S2,,A)

	
	
.PE                            # Pic input ends
