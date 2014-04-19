.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	
	Origen:dot;
	Point_(120); source(,AC); rlabel(,,V_{rs}); 
	Vs:dot; llabel(S,,)
	Point_(-120); source(,AC); clabel(V_{st},,); 
	Vt:dot; llabel(T,,)
	right_; source(,AC); rlabel(,V_{tr},); 
	Vr:dot; llabel(,,R)
	
	line up_ dimen_*0.4 from Vs; S1:dot; 
	line down_ dimen_*0.4 from Vr; R1:dot
	line down_ dimen_*0.8 from Vt; T1: dot 
	
	OrigenCarga:dot(at Origen+(dimen_*5,0));
	Point_(120); ebox; b_current(I_F); Cs:dot
	Point_(-120); ebox; Ct:dot
	right_; ebox;  Cr:dot
	
	line up_ dimen_*0.4 from Cs; S2:dot
	line down_ dimen_*0.4 from Cr; R2: dot
	line down_ dimen_*0.8 from Ct; T2: dot
	
	line right_ from R1 to R2; b_current(I_L,,O,E)
	line right_ from S1 to S2; 
	line right_ from T1 to T2; 
	
	gap(up_ from ((R1+R2)/2,R1) to ((R1+R2)/2,S1),,A); 
	rlabel(,U_L,)	
	

	
	
.PE                            # Pic input ends
