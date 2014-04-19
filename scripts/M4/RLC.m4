.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)

cct_init                       # Set defaults

elen = 0.75                    # Variables are allowed; default units are inches
Origen: Here                   # Position names are capitalized
# # Rg: resistor(up_ elen); llabel(,R_g,);
# # V: source(up_ elen*2, AC); llabel(,V,);
V: source(up_ elen*3, AC); llabel(,V,);

#V: source(up_ elen*3, P); llabel(,V,);
line right_ elen/2; dot; line right_ elen/2;   

  R:resistor(down_ elen); llabel(,R,); dot;
  C:capacitor(down_ elen); llabel(,C,); dot;
L:inductor(down_ elen); llabel(,L,); 
line left_ elen/2; dot; ground; line left_ elen/2;
line to Origen;
   
.PE                            # Pic input ends


