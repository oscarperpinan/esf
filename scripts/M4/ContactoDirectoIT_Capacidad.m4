.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

cct_init                       # Set defaults

hgt = elen_*1.5
ewd = elen_*0.9

define(`seccion',`source(right_ ewd);llabel(,V_m,+);
		  {dot; line down_ hgt*0.25; dot
		  gpar_(resistor(down_ hgt*0.5); rlabel(,R_{iso}^{(m)}),
			capacitor(down_ hgt*0.5); rlabel(,C_{iso}^{(m)}))
		  dot; ground; }
		  line right_ hgt*0.25')
Neg: dot
for i=1 to 2 do {seccion}
line dotted right_ dimen_/2
seccion
Pos: dot
line right_ ewd
resistor(down_ hgt*0.75); rlabel(,R_h)
ground
.PE
