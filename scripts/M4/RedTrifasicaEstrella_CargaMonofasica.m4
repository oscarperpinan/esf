.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
cct_init                       # Set defaults



scale=25.4 #pasa de inches (default) a mm.

	right_
	Neutro:dot; rlabel(,N,);
	{up_; source(,AC); rlabel(,V_{rn},); Vr:Here}
	{Point_(210); source(,AC); clabel(V_{sn},,); Vs:Here}
	{Point_(-30); source(,AC); rlabel(,V_{tn},); Vt:Here}
	
	line up_ dimen_*0.4 from Vr; R:dot;llabel(,R,)
	line down_ dimen_*0.8 from Vs; S:dot;rlabel(,S,)
	line down_ dimen_*0.4 from Vt; T:dot;rlabel(,T,)
	
	right_
	NeutroCarga:dot(at Neutro+(dimen_*7,0)); rlabel(,N,);
	{up_; ebox; line up_ dimen_*0.4; Cr:dot}
	{Point_(210); ebox; line down_ dimen_*0.8; Cs:dot}
	{Point_(-30); ebox; line down_ dimen_*0.4; Ct:dot}
	
	
	
	line right_ from R to Cr; b_current(i_r,,O,E)
	line right_ from S to Cs; b_current(i_s,,O,E)
	line right_ from T to Ct; b_current(i_t,,O,E)
	line right_ from Neutro to NeutroCarga; b_current(i_n,,O,E)
	
	gap(up_ from ((R+Cr)/2,T) to ((R+Cr)/2,R),,A); 
	rlabel(,U_L,)
	gap(up_ from ((R+Cr)/1.5,T) to ((R+Cr)/1.5,Neutro),,A); 
	rlabel(,U_F,)
	
	dot(at ((R+Cr)/1.8,T)); line down_ elen_ 
	ebox(right_ elen_)
	line up_ to (Here,Neutro); dot
	
.PE                            # Pic input ends
