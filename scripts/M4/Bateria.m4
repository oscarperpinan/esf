.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

cct_init                       # Set defaults

elen = 0.75                    # Variables are allowed; default units are inches
Origen: Here                   # Position names are capitalized
   Vb:battery(up_ elen); llabel(,V_{BI},)
   Rb:resistor(right_ elen);llabel(,R_{BI},);b_current(I_d,below_); b_current(I_c,below_,,E);
   gap(down_ elen,,A);llabel(+,V_B,-)
   line to Origen;
   
.PE                            # Pic input ends


