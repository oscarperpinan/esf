.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	right_
	Neutro:dot; clabel(N,,);
	{up_; source(,AC); rlabel(,V_{rn},); Vr:Here}
	{Point_(210); source(,AC); clabel(V_{sn},,); Vs:Here}
	{Point_(-30); source(,AC); rlabel(,V_{tn},); Vt:Here}
	
	line up_ dimen_*0.4 from Vr; R:dot;llabel(,R,)
	line down_ dimen_*0.8 from Vs; S:dot;rlabel(,S,)
	line down_ dimen_*0.4 from Vt; T:dot;rlabel(,T,)
	
	Tr:dot(at Vr+(dimen_*7,0));
	Ts:dot(at Vs+(dimen_*7,0));
	Tt:dot(at Vt+(dimen_*7,0));
	ebox(from Tr to Ts); b_current(I_F); 
	ebox(from Ts to Tt);
	ebox(from Tt to Tr);  
	line up_ dimen_*0.4 from Tr 
	line left_ to R; b_current(I_L,,I,E)
	line down_ dimen_*0.8 from Ts then to S; 
	line down_ dimen_*0.4 from Tt then to T; 
	
	gap(up_ from ((R+Tr)/2,T) to ((R+Tr)/2,R),,A); 
	rlabel(,U_L,)
	# gap(up_ from (Neutro,S) to Neutro,,A); 
	# rlabel(,U_F,)
	
.PE                            # Pic input ends
