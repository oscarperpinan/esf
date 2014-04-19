
fref=1
x=seq(0,1/fref,l=1000)
wref=2*pi*fref
Vref=sin(wref*x)
Vref2=sin(wref*x+2*pi/3)
Vref3=sin(wref*x-2*pi/3)

mf=31

f=mf*fref
T=1/f;
ma=0.7
Vt=1/ma*(4*abs(x/(2*T)-floor(x/(2*T)+.5))-1)
SPWM=(Vref>Vt)-(Vref<Vt);

#pdf('~/Docencia/uned/Graficos/SPWMMonofasico.pdf');

postscript('~/Docencia/ESF/Figuras/SPWMMonofasico.ps',horizontal=FALSE,onefile=F,paper='special',width=6,height=4.5);
par(mar=c(0.1,0.1,0.1,0.1))#No deja márgenes!!
plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE)
  lines(x,Vref)
  lines(x,SPWM,lwd=3)
dev.off();

postscript('~/Docencia/ESF/Figuras/SPWMTrifasico.ps',horizontal=FALSE,onefile=F,paper='special',width=6,height=4.5);
par(mar=c(0.1,0.1,0.1,0.1))#No deja márgenes!!
  plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE)
  lines(x,Vref)
  lines(x,Vref2)
  lines(x,Vref3)
  lines(x,SPWM,lwd=3)
dev.off();




fc=5*fref
Tc=1/fc;
Vc=4*abs(x/(2*Tc)-floor(x/(2*Tc)+.5))-1
Cuadrada=(Vc>0)-(Vc<0);
postscript('~/Docencia/ESF/Figuras/Cuadrada.ps',horizontal=FALSE,onefile=F,paper='special',width=4,height=3);
par(mar=c(2.1,2.1,0.1,0.1), mgp=c(1,0.3,0.3))
  plot(x,Cuadrada,type='l',xlab='Tiempo',ylab='Tensión',xaxt='n', yaxt='n')#no necesito eje X
dev.off();




