% Windings.m4
ifelse(ifpstricks(T)`'ifmpost(T)`'ifpostscript(T)`'ifpgf(T),,
 `PSTricks, MetaPost, PGF, or Postscript required for this diagram',`dnl
.PS
cct_init
s_init(Windings)
ifdef(`Windings_1',,`sinclude(FWindings.dim)')
sinclude(CMman.dim)
ifdef(`Windings_1',,`sinclude(tst.dim)')

ifelse(ifpstricks(T)`'ifpgf(T),T,`\definecolor{vlight}{rgb}{0.9,0.9,0.9}')
ifpostscript(`define(`vlight',0.9 0.9 0.9)define(`lightgray',0.7 0.7 0.7)')
ifmpost(`define(`vlight',`(0.9,0.9,0.9)')define(`lightgray',`(0.7,0.7,0.7)')')

[ winding ]
  s_box(\tt w{}inding) at last [].s below

[ winding(R) ] with .nw at last [].sw+(0,-0.25)
  s_box(\tt w{}inding(R)) at last [].s below

[ sk = 0.75
  d = 1.5*sk
  p = 0.4*sk
  w = 1*sk

W: winding(L,d,p,4,w,vlight)
  
thinlines_
  dimension_(from W.nw+(p/4,0) right p,0.1,s_box(\tt pitch\strut) above,W)
  dimension_(from W.sw to W.nw,0.2,s_box(\tt diam),H)
  dimension_(from W.e+(-p/2,-w/2) up w,-0.3,,s_ht)
  s_box(\tt\hfill core wid) at W.e ljust
  arrow <- up d-w+0.1 left d/10 from W.ne+(-p/2,-(d-w))
  s_box(\tt core color) at Here+(-0.2,0) ljust above
thicklines_
] with .sw at last [].se+(0.5,0)
  "\tt T1" at last [].W.T1 below
  "\tt T2" at last [].W.T2 below

[
  Q: box invis ht 1 wid 5/4
  g = Q.wid/12
  ironwid = Q.wid/4.5

  line thick ironwid/(1bp__)+linethick from Q.n+(g/2-linethick/2 bp__,0) \
    to Q.ne then to Q.se then to Q.sw then to Q.nw \
    then to Q.n+(-g/2+linethick/2 bp__,0)
  ifmpost(`rgbdraw(0.7,0.7,0.7,')
  line thick ironwid/(1bp__)-linethick outlined "lightgray" \
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
    arrow right to P.T1 "$i_1$" above
    line left ironwid*2/3 from P.T2
    gap(up_ to 2nd last line.end)
    llabel(-,s_box($v_1$),+)
    "$N_1$" at P.e ljust

  up_
  S: winding(L,ironwid*5/4,ironwid/2,4,ironwid,lightgray) at Q.e
    line right ironwid*2/3 from S.T2
    arrow left to S.T2 "$i_2$" above
    line right ironwid*2/3 from S.T1
    gap(up_ to 2nd last line.end)
    rlabel(-,s_box($v_2$),+)
    "$N_2$" at S.w rjust

  box dashed rad ironwid/4 wid Q.wid ht Q.ht at Q
  arrow right arrowht from 0.5 between Q.n and Q.ne
  "$\phi$" ljust at Here+(0,5pt__)

  move up ironwid/2 from Q.n
  move down ironwid/2 from Q.s
] with .sw at last [].se+(0.15,0)

.PE')
