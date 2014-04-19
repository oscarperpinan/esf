.PS                            # Pic input begins with .PS

define(`HOMELIB_',`')
include(libcct.m4)
include(pstricks.m4)
include(libPV.m4)#Mi libreria de elementos fotovoltaicos
sinclude(Transformador2.dim)#sirve para s_box
s_init(transformador2)
cct_init                       # Set defaults

ifelse(ifpstricks(T)`'ifpgf(T),T,`\definecolor{vlight}{rgb}{0.9,0.9,0.9}')
ifpostscript(`define(`vlight',0.9 0.9 0.9)define(`lightgray',0.7 0.7 0.7)')
ifmpost(`define(`vlight',`(0.9,0.9,0.9)')define(`lightgray',`(0.7,0.7,0.7)')')


[
  Q: box invis ht 1 wid 5/4
  g = Q.wid/12
  ironwid = Q.wid/4.5

  line thick ironwid/(1bp__)+linethick from Q.n+(g/2-linethick/2 bp__,0) \
    to Q.ne then to Q.se then to Q.sw then to Q.nw \
    then to Q.n+(-g/2+linethick/2 bp__,0)
  ifmpost(`rgbdraw(0.7,0.7,0.7,')
  line thick ironwid/(1bp__)-linethick colored "lightgray" \
    from Q.n+(g/2+linethick/2 bp__,0) \
    to Q.ne then to Q.se then to Q.sw then to Q.nw \
    then to Q.n+(-g/2-linethick/2 bp__,0)
  ifmpost(`)')

thinlines_
  dimension_(from Q.n+(-g/2,-ironwid/2) right g,-ironwid/4,
    "$g$" below,1,2pt__)
thicklines_

  down_
  P: winding(R,ironwid*5/4,ironwid/2,4,ironwid,lightgray) at Q.w
    line left ironwid*2/3 from P.T1
    arrow right to P.T1 "$i_p$" above
    line left ironwid*2/3 from P.T2
    gap(up_ to 2nd last line.end)
    llabel(-,s_box($u_p$),+)
    "$N_p$" at P.e ljust

  up_
  S: winding(L,ironwid*5/4,ironwid/2,4,ironwid,lightgray) at Q.e
    line right_ ironwid*2/3 from S.T2; b_current(i_s)
  
    line right ironwid*2/3 from S.T1
    gap(up_ to 2nd last line.end)
    rlabel(-,s_box($u_s$),+)
    "$N_s$" at S.w rjust

  box dashed rad ironwid/4 wid Q.wid ht Q.ht at Q
  arrow right arrowht from 0.5 between Q.n and Q.ne
  "$\phi$" ljust at Here+(0,5pt__)

  move up ironwid/2 from Q.n
  move down ironwid/2 from Q.s
] with .sw at last [].se+(0.15,0)

.PE')
