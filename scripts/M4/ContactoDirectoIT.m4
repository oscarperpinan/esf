.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

cct_init                       # Set defaults

hgt = elen_
ewd = elen_*0.9

define(`seccion',`source(right_ ewd);llabel(,V_m,+);
		  {dot;
		  resistor(down_ hgt); rlabel(,R_{iso}^{(m)})
		   dot; ground; }
		  line right_ hgt*0.25')
Neg: dot
for i=1 to 2 do {seccion}
line dotted right_ dimen_/2
seccion
Pos: dot
.PE
