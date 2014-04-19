divert(-1)
   libPV.m4                    M4 macros para fotovoltaica

* Copyright (c) 2009 Oscar Perpiñán, under    *
* the LaTeX Project Public License. The files of this distribution may    *
* be redistributed or modified, provided that this copyright notice is    *
* included and provided that modifications are clearly marked to          *
* distinguish them from this distribution.  There is no warranty          *
* whatsoever for these files.  

define(`modulo',`eleminit_(`$1')
   # Element body height and width
   define(`m4w',`dimen_')dnl
   define(`m4h',`m4w*0.4')dnl
   # Visible lines:
   {line to rvec_(rp_len/2-m4w/2,0) #line to rvec (x,0) draws a line of length x in the current direction
     lbox(m4w,m4h)
     {line from rvec_(0,-m4h/2) to rvec_(-m4w/2,0) then to rvec_(0,m4h/2)}
     line to rvec_(rp_len/2-m4w/2,0) }
   # The invisible body block:
   {[box invis ht_ m4h wid_ m4w ] at rvec_(rp_len/2,0)}
   # The final invisible line:
   line to rvec_(rp_len,0) invis ')
   
divert(0)dnl