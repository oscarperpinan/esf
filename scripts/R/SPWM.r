
fref=1
x=seq(0,1/fref,l=1000)
wref=2*pi*fref
Vref=sin(wref*x)

mf=31

f=mf*fref
T=1/f;
ma=0.7
Vt=1/ma*(4*abs(x/(2*T)-floor(x/(2*T)+.5))-1)

SPWM=(Vref>Vt)-(Vref<Vt);

#pdf('~/Docencia/uned/Graficos/SPWMMonofasico.pdf');
## Monofásicos

Vref=sin(wref*x)
SPWM=(Vref>Vt)-(Vref<Vt);

pdf('../../figs/SPWMMonofasico.pdf')
par(mar=c(0.1,0.1,0.1,0.1))#No deja márgenes!!
plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "darkred")
lines(extendrange(x), c(0, 0))
lines(x,Vref, col = "midnightblue")
lines(x,SPWM,lwd=2)
dev.off();

## Trifásicos
Vref1=sin(wref*x)
SPWM1=(Vref1>Vt)-(Vref1<Vt);

Vref2=sin(wref*x-2*pi/3)
SPWM2=(Vref2>Vt)-(Vref2<Vt);

Vref3=sin(wref*x+2*pi/3)
SPWM3=(Vref3>Vt)-(Vref3<Vt);

pdf('../../figs/SPWMTrifasico.pdf')

par(mar=c(0.1,0.1,0.1,0.1), mfrow = c(3, 1))#No deja márgenes!!

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "darkred")
lines(extendrange(x), c(0, 0))
lines(x,Vref1, col = "midnightblue")
lines(x,SPWM1,lwd=2)

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "darkred")
lines(extendrange(x), c(0, 0))
lines(x,Vref2, col = "midnightblue")
lines(x,SPWM2,lwd=2)

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "darkred")
lines(extendrange(x), c(0, 0))
lines(x,Vref3, col = "midnightblue")
lines(x,SPWM3,lwd=2)

dev.off();

pdf('../../figs/SPWMTrifasico_shaded.pdf')

par(mar=c(0.1,0.1,0.1,0.1), mfrow = c(3, 1))#No deja márgenes!!

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "gray")
lines(extendrange(x), c(0, 0))
lines(x,Vref1, col = "gray")
lines(x,SPWM1,lwd=2)

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "gray")
lines(extendrange(x), c(0, 0))
lines(x,Vref2, col = "gray")
lines(x,SPWM2,lwd=2)

plot(x,Vt,type='l',axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "gray")
lines(extendrange(x), c(0, 0))
lines(x,Vref3, col = "gray")
lines(x,SPWM3,lwd=2)

dev.off()


## fc=5*fref
## Tc=1/fc;
## Vc=4*abs(x/(2*Tc)-floor(x/(2*Tc)+.5))-1
## Cuadrada=(Vc>0)-(Vc<0);
## postscript('~/Docencia/ESF/Figuras/Cuadrada.ps',horizontal=FALSE,onefile=F,paper='special',width=4,height=3);
## par(mar=c(2.1,2.1,0.1,0.1), mgp=c(1,0.3,0.3))
##   plot(x,Cuadrada,type='l',xlab='Tiempo',ylab='Tensión',xaxt='n', yaxt='n')#no necesito eje X
## dev.off();




