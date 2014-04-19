IV_Rsh<-read.table('~/Docencia/ESF/scriptsGNUCap/InfluenciaResistenciaParalelo.dat')
names(IV_Rsh)<-c('Rsh','V','I')

sp <- list(superpose.line =  list(lwd=2,lty=3:1)) 


trellis.device(postscript,file='~/Docencia/ESF/Figuras/InfluenciaRsh_IV.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='InfluenciaRsh_OPerpinanNov09');
xyplot(I~V,groups=Rsh,data=IV_Rsh, type='l', ylab='Corriente (A)', xlab='Tensión (V)',
			auto.key=list(x=0.3,y=0.6,points=FALSE,lines=TRUE,title=expression(R[p](Omega)),cex.title=1.2),
			par.settings=sp);
dev.off()

trellis.device(postscript,file='~/Docencia/ESF/Figuras/InfluenciaRsh_Potencia.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='InfluenciaRsPotencia_OPerpinanNov09');
xyplot((I*V)~V,groups=Rsh,data=IV_Rsh, type='l',ylab='Potencia (W)', xlab='Tensión (V)',
			auto.key=list(x=0.3,y=0.6,points=FALSE,lines=TRUE,title=expression(R[p](Omega)),cex.title=1.2),
			par.settings=sp);
dev.off()

IV_Rs<-read.table('~/Docencia/ESF/scriptsGNUCap/InfluenciaResistenciaSerie.dat')
names(IV_Rs)<-c('Rs','V','I')

trellis.device(postscript,file='~/Docencia/ESF/Figuras/InfluenciaRs_IV.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='InfluenciaRs_OPerpinanNov09');
xyplot(I~V,groups=Rs,data=IV_Rs, type='l',ylab='Corriente (A)', xlab='Tensión (V)', lwd=2,
			auto.key=list(x=0.3,y=0.6,points=FALSE,lines=TRUE,title=expression(R[s](Omega)),cex.title=1.2));
dev.off()

trellis.device(postscript,file='~/Docencia/ESF/Figuras/InfluenciaRs_Potencia.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='InfluenciaRsPotencia_OPerpinanNov09');
xyplot((I*V)~V,groups=Rs,data=IV_Rs, type='l',ylab='Potencia (W)', xlab='Tensión (V)', lwd=2,
			auto.key=list(x=0.3,y=0.6,points=FALSE,lines=TRUE,title=expression(R[s](Omega)),cex.title=1.2));
dev.off()

