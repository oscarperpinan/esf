Ki = c(0.01,0.025,0.05); 
ki0=Ki[1];
ki1=Ki[2];
ki2=Ki[3];

PdcN=seq(0,1,.01)

A=ki2;
B=ki1+1
C=ki0-(PdcN);


PacN=(-B+sqrt(B^2-4*A*C))/(2*A);
PacN[PacN<0]<-NA;
#PacN[PacN>1]<-1;


EffI=PacN/PdcN;

postscript('~/Docencia/ESF/Figuras/CurvaInversor.ps',horizontal=FALSE,onefile=F,paper='special',width=6,height=4.5);
par(mar=c(4.1,4.1,0.1,0.1))#No deja márgenes!!
plot(PacN,EffI,xlab='Potencia AC normalizada',ylab='Eficiencia',type='l',lwd=3)
grid()
dev.off()
