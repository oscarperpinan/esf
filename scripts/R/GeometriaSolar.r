library(solaR)

library(lattice)
library(latticedl)

options(warn=-1); #desactiva los warnings...    .

Nm=6;

#--------------------------------
#Crea la Base Temporal
DiasProm<-c(17,14,15,15,15,10,18,18,18,19,18,13);
DiasProm_Ano<-c(17,45,74,105,135,161,199,230,261,292,322,347);
Meses=c('Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');
Fecha<-as.POSIXlt(seq(ISOdate(2009,1,1,hour=0),ISOdate(2009,12,31,hour=0),by="1 day"))

#BTd<-cbind(IDd=as.numeric(as.numeric((Fecha))),
#	  with(Fecha,data.frame(Ano=year+1900,DiaAno=yday+1,Mes=mon+1,DiaMes=mday)))
	  
#DiasMes=as.numeric(tapply(BTd$DiaMes,BTd$Mes,max));

dn=1:365
M=2*pi/365.24*dn
EoT=229.18*(-0.0334*sin(M)+0.04184*sin(2*M+3.5884)


trellis.device(postscript,file='~/Docencia/ESF/Figuras/EoT.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='EoT_OPerpinanAbr10');
	xyplot(EoT~dn, xlab='Dia del año',ylab='Ecuación del tiempo (min.)', type=c('l', 'g'));
dev.off()


trellis.device(postscript,file='~/Docencia/ESF/Figuras/DuracionDia.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='DuracionDia_OPerpinanOct09');
	dibujo<-xyplot(12/pi*2*abs(ws)~DiaAno,data=SolD,groups=Lat, xlab='Dia del año',ylab='Duración del Día (h)', type='l')
								#auto.key=list(space='right',lines=TRUE,points=FALSE));
	print(direct.label(dibujo,method=last.points));
dev.off()



#-----------------------------------------
tolerance = .Machine$double.eps^0.5

SolD<-data.frame()
SolI<-data.frame()

for (i in c(-60,-40,-20,0,20,40,60)){
	
	if (i>0) {NomLat=paste(i,'N',sep='')} else 
	if (i<0) {NomLat=paste(abs(i),'S',sep='')} else
	NomLat="0";
	SolDaux<-fSolD(lat=i,BTd=fBTd(Modo='Serie'));
	SolIaux<-fSolI(SolDaux,Nm);
	SolD<-rbind(SolD,data.frame(SolDaux,Lat=NomLat));
	SolI<-rbind(SolI,data.frame(SolIaux,Lat=NomLat));}
	
	
trellis.device(postscript,file='~/Docencia/ESF/Figuras/Declinacion.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='Declinacion_OPerpinanOct09');
	xyplot(180/pi*decl~DiaAno,data=SolD, subset=(Lat=="40N"),xlab='Dia del año',ylab='Declinación (º)', type='l');
dev.off()
trellis.device(postscript,file='~/Docencia/ESF/Figuras/DuracionDia.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='DuracionDia_OPerpinanOct09');
	dibujo<-xyplot(12/pi*2*abs(ws)~DiaAno,data=SolD,groups=Lat, xlab='Dia del año',ylab='Duración del Día (h)', type='l')
								#auto.key=list(space='right',lines=TRUE,points=FALSE));
	print(direct.label(dibujo,method=last.points));
dev.off()



TrayectoriaSolar<-function(Latitud){
	SolI2=subset(SolI,Lat==Latitud)
	trellis.device(postscript,file=paste('~/Docencia/ESF/Figuras/TrayectoriaSolar',Latitud,'.ps',sep=''),
					width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
					title=paste('TrayectoriaSolar',Latitud,'OPerpinanOct09',sep='_'));
	p<-xyplot(AlS*180/pi~AzS*180/pi,data=SolI2, 
					#main=paste('Trayectoria Solar: Lat=',Latitud,sep=''), 
					xlab=expression(psi[s]),ylab=expression(gamma[s]),
					Mes=unique(SolI2$Mes),
					Dias=SolI2$DiaAno%in%DiasProm_Ano,
					w5=abs((abs(SolI2$w*12/pi)-5))<=tolerance,
					w4=abs((abs(SolI2$w*12/pi)-4))<=tolerance,
					w3=abs((abs(SolI2$w*12/pi)-3))<=tolerance,
					w2=abs((abs(SolI2$w*12/pi)-2))<=tolerance,
					w1=abs((abs(SolI2$w*12/pi)-1))<=tolerance,
					panel=function(x,y,Dias,Mes,w1,w2,w3,w4,w5){
							panel.xyplot(x[Dias],y[Dias],type='l')
							panel.xyplot(x[w5],y[w5],type='p')
							panel.text(max(x[w5],na.rm=1),max(y[w5],na.rm=1),labels=expression(omega==5),pos=4)
							panel.xyplot(x[w4],y[w4],type='p')
							panel.text(max(x[w4],na.rm=1),max(y[w4],na.rm=1),labels=expression(omega==4),pos=4)
							panel.xyplot(x[w3],y[w3],type='p')
							panel.text(max(x[w3],na.rm=1),max(y[w3],na.rm=1),labels=expression(omega==3),pos=4)
							panel.xyplot(x[w2],y[w2],type='p')
							panel.text(max(x[w2],na.rm=1),max(y[w2],na.rm=1),labels=expression(omega==2),pos=4)
							panel.xyplot(x[w1],y[w1],type='p')
							panel.text(max(x[w1],na.rm=1),max(y[w1],na.rm=1),labels=expression(omega==1),pos=4)
							AlturaSolar=subset(y,(x==0)&Dias);
							panel.text(x=0,y=AlturaSolar,labels=Meses[Mes],cex=0.7,pos=3,offset=0.1)
							})
	print(p)
dev.off()

   }
  
TrayectoriaSolar('60N')
TrayectoriaSolar('40N')
TrayectoriaSolar('20N')
TrayectoriaSolar('20S')
TrayectoriaSolar('40S')
TrayectoriaSolar('60S')

AlSmax=with(SolI,ave(AlS,Lat,FUN=function(x)max(x,na.rm=1)))
SolI$AlSr=SolI$AlS/AlSmax

trellis.device(postscript,file='~/Docencia/ESF/Figuras/AlturaSolarMediodiaNORTE.ps',
				width=6,height=4.5,onefile=FALSE,horizontal=FALSE,family='URWPalladio',
				title='AlturaSolarMediodiaNORTE_OPerpinanOct09');
			SolI2=subset(SolI,(w==0)&(Lat%in%c('20N','40N','60N')));
			SolI2$Lat=SolI2$Lat[,drop=TRUE];#Sirve para eliminar los niveles de latitud que no utilizamos en la gráfica
			p<-xyplot(AlSr~DiaAno,groups=Lat,data=SolI2,
										  #auto.key=list(space='right',lines=TRUE,points=FALSE), 
										  type=c('l','g'), lwd=2.5,
										  #main='Variacion de la Altura al Mediodia (Hemisferio Norte)',
										  xlab='Dia',ylab='Altura Solar relativa');
			print(direct.label(p,method=last.points));
dev.off();  

trellis.device(postscript,file='~/Docencia/ESF/Figuras/AlturaSolarMediodiaSUR.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,family='URWPalladio',
			title='AlturaSolarMediodiaSUR_OPerpinanOct09');
			SolI2=subset(SolI,(w==0)&(Lat%in%c('20S','40S','60S')));
			SolI2$Lat=SolI2$Lat[,drop=TRUE];#Sirve para eliminar los niveles de latitud que no utilizamos en la gráfica
			dibujo<-xyplot(AlSr~DiaAno,data=SolI2, groups=Lat,
										  #auto.key=list(space='right',lines=TRUE,points=FALSE), 
										  type=c('l','g'), lwd=2.5,
										  #main='Variacion de la Altura al Mediodia (Hemisferio Sur)',
										  xlab='Dia',ylab='Altura Solar relativa');
			direct.label(dibujo,method=list(dl.indep(d[which.min(d$y),]),vjust=1.2))
dev.off();  

#-----------------------------
#Angulos de generador
Beta=45;
Alfa=0;
lat=40;
SolI2=subset(SolI,Lat=='40N')



fTheta<-function(lat,decl,w,aman,Alfa,Beta){
		lat=lat*pi/180
		Beta=Beta*pi/180
		Alfa=Alfa*pi/180
		t1=sin(decl)*sin(lat)*cos(Beta);      
		t2=-sign(lat)*sin(decl)*cos(lat)*sin(Beta)*cos(Alfa); 
		t3=cos(decl)*cos(w)*cos(lat)*cos(Beta);   
		t4=sign(lat)*cos(decl)*cos(w)*sin(lat)*sin(Beta)*cos(Alfa); 
		t5=cos(decl)*sin(w)*sin(Alfa)*sin(Beta);   
		cosTheta=t1+t2+t3+t4+t5;
		cosTheta[!aman]<-NA;
		cosTheta=cosTheta*(cosTheta>0)}

AngulosGenerador<-within(SolI2,{
                      BetaDoble = 90-AlS*180/pi;
                      BetaAzimutal=Beta;
                      BetaEst=Beta;
                      BetaHoriz=atan(abs(sin(AzS)/tan(AlS)))*180/pi;
                    
                      AlfaDoble=AzS*180/pi;                          
                      AlfaAzimultal=AzS*180/pi;
                      AlfaEst=Alfa;
                      AlfaHoriz=90*sign(AzS);
                      
                      cosThetaDoble=1;
                      cosThetaAzimutal= cos(Beta*pi/180-(pi/2-AlS));
                      cosThetaEst=fTheta(lat,decl,w,aman,Alfa,Beta);
                      
                      
                      #long_w=length(unique(w));
                      #decl_rep=rep(decl,each=long_w);
                      cosThetaHoriz=cos(decl)*sqrt(sin(w)^2+(cos(lat*pi/180)*cos(w)+tan(decl)*sin(lat*pi/180))^2);
                      cosThetaHoriz[!aman]<-NA;})
                     

library(vcd)
paleta=heat_hcl(100, h = c(10, 100), c. = c(100, 20), l = c(40, 100), power = c(1/5, 1.5));
paleta2=diverge_hcl(100);


DibujaAngulo<-function(Angulo,Titulo,NomFichero){
	postscript(paste('~/Docencia/ESF/Figuras/',NomFichero,'.ps',sep=''),
				horizontal=FALSE,onefile=F,paper='special',width=6,height=6,family='URWPalladio',
				title=paste(NomFichero,'OPerpinan_Oct09'));
		p<-levelplot(AngulosGenerador[[Angulo]]~(w*180/pi)*DiaAno,data=AngulosGenerador,xlab='Hora Solar (grados)', ylab='Dia del Año',
                          col.regions=paleta,pretty=T, contour=T, cuts=10, labels=list(cex=0.7), main=Titulo)
		print(p);
	dev.off();}

DibujaAngulo('AlfaDoble','','AlfaDoble_40N');
DibujaAngulo('BetaDoble','','BetaDoble_40N');
DibujaAngulo('BetaHoriz','','BetaHoriz_40N');
DibujaAngulo('cosThetaAzimutal','','cosThetaAzimutal_40N');
DibujaAngulo('cosThetaHoriz','','cosThetaHoriz_40N');
DibujaAngulo('cosThetaEst','','cosThetaEst_40N');

