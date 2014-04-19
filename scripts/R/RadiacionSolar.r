
source("scriptsR/fAguiar.r")
source("scriptsR/fSol.r")
source("scriptsR/fDM.r")
source("scriptsR/fComp.r")
source("scriptsR/fInclin.r")
source("scriptsR/fTheta.r")
source("scriptsR/fProd.r")

library(lattice)

options(warn=-1); #desactiva los warnings...    .


#----------------
#Variabilidad de la radiación solar
#-----------------

Ghist<-read.table('~/Investigacion/Calculo/Datos/Carmona/Tomejil2001-2008.txt',head=T);
Ghist$DiaMes=strptime(Ghist$Fecha,format="%d/%m/%Y")$mday;
Ghist$Mes=strptime(Ghist$Fecha,format="%d/%m/%Y")$mon+1;
Ghist$Ano=strptime(Ghist$Fecha,format="%d/%m/%Y")$year+1900;

#Anos<-2002:2008; #El 2001 y el 2008 están incompletos, pero necesito el 2008 para validar con datos reales
#Ghist<-Ghist[Ghist$Ano %in% Anos,]
completo<-aggregate(Ghist$Ano,list(Ano=Ghist$Ano),function(x)(length(x)>=365))
Ghist<-merge(Ghist,completo);
names(Ghist)[7]<-'AnoCompleto';


Gdia<-summaryBy(G~DiaAno,data=Ghist,FUN=c(mean,median,IQR,sd),na.rm=1);
Gdia$G.nDesv=with(Gdia,G.sd/G.mean);

Gmensual<-summaryBy(G~Mes,data=Ghist,FUN=c(mean,median,IQR,sd),na.rm=1);
Gmensual$G.nDesv=with(Gmensual,G.sd/G.mean);

Ganual<-summaryBy(G~Ano,data=Ghist,FUN=sum,na.rm=1,keep.names=T);
Ganual[completo$x==F,]$G<-NA; #solo entran en esta operación los años completos

MediaGAnual<-mean(Ganual$G,na.rm=1)
DesvGAnual<-sd(Ganual$G,na.rm=1)
nDesvGAnual<-DesvGAnual/MediaGAnual

postscript("~/Docencia/ESF/Figuras/VariabilidadRadiacionDiario.ps",
			width=6,height=4.5,onefile=FALSE,horizontal=FALSE,
			family='URWPalladio');
layout(c(1,2,3));

par(mar=c(3,3,1,0),mgp=c(1.3,0.4,0))
#Con mar controlo los márgenes (abajo, izquierda, arriba, derecha)
#con mgp controlo la separación de los títulos de los ejes y de las marcas númericas

plot(G.nDesv~DiaAno,data=Gdia,type='h',
          #main=expression(G[d](0)),
          xlab='Día del año',ylab=expression(sigma["G0d"]/bar("Gd(0)")))

plot(G.nDesv~Mes,data=Gmensual,type='o',
          #main=expression(G[m](0)),
          xlab='Mes',ylab=expression(sigma["G0m"]/bar("Gm(0)")))

plot(G~Ano,data=Ganual[completo$x==T,],
	#main=expression(G[y](0)),
	xlab='Año',ylab=expression(G[y](0)(kWh/m^2)),type='o');
abline(h=MediaGAnual)
text(y=MediaGAnual,x=2003,pos=3,as.expression(substitute(bar(G)["y"]==Ganual, list(Ganual=signif(MediaGAnual,6)))),cex=1)
abline(h=MediaGAnual+DesvGAnual,lty=2)
text(y=MediaGAnual+DesvGAnual,x=2003,pos=3,as.expression(substitute(sigma["Gy"]/bar(G)["y"]==DesvG, list(DesvG=signif(nDesvGAnual,2)))),cex=1)
abline(h=MediaGAnual-DesvGAnual,lty=2)
#text(y=MediaGAnual-DesvGAnual,x=2003,pos=3,as.expression(substitute(sigma["Gy"]/bar(G)["y"]==DesvG, list(DesvG=signif(nDesvGAnual,2)))),cex=1)

dev.off();
#------------------------------
Nm=6;
lat=40;
lat=lat*pi/180;
dn=1:365;

decl=23.45*sin(2*pi*(dn+284)/365);
eo=1+0.033*cos(2*pi*dn/365);
decl=pi/180*decl; #Paso a radianes
ws=-acos(-tan(decl)*tan(lat)); #Amanecer

dw=pi/(12*Nm);# Una hora equivale a 15º de movimiento aparente del sol
w=seq(-pi,pi-dw,dw);

Bo=1367;
Bo0d=-24/pi*Bo*eo*(ws*sin(lat)*sin(decl)+cos(lat)*cos(decl)*sin(ws))

a=0.409-0.5016*sin(ws+pi/3);
b=0.6609+0.4767*sin(ws+pi/3);

Dia=261;
rd<-pi/(24*Nm)*(cos(w)-cos(ws[Dia]))/(ws[Dia]*cos(ws[Dia])-sin(ws[Dia]))
rd[rd<0]<-0; #aun no ha amanecido
rg<-rd*(a[Dia]+b[Dia]*cos(w));
RdRg<-data.frame(rd=rd[abs(w)<abs(ws[Dia])],rg=rg[abs(w)<abs(ws[Dia])],w=w[abs(w)<abs(ws[Dia])]);
trellis.device(postscript,file='~/Docencia/ESF/Figuras/RgRd.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,family='URWPalladio',
			title='GeneradorEmpiricoCollaresRabl_OPerpinanOct09');
xyplot(rd+rg~w*12/pi,data=RdRg, type=c('l','g'), 
				auto.key=list(text=c(expression(r[D]),expression(r[G])),x=0.8,y=0.8,lines=TRUE,points=FALSE),
				#main='Evolución diaria de las relaciones Irradiancia-Irradiación',
				xlab='Hora Solar (h)',ylab=expression(r["D"], r["G"]))
dev.off()

#----------------------------------
#SUCIEDAD e INCIDENCIA NO PERPENDICULAR

Suc=rbind(c(1, 0.17, -0.069),c(0.98,.2,-0.054),c(0.97,0.21,-0.049),c(0.92,0.27,-0.023));
Theta=seq(0,pi/2,by=.01)
iS=1; 
f.FTb=function(Theta,iS){
		cosTheta=cos(Theta)
		Suciedad=c('Limpio','Bajo','Medio','Alto')
		data.frame(FTb=(exp(-cosTheta/Suc[iS,2])-exp(-1/Suc[iS,2]))/(1-exp(-1/Suc[iS,2])),Suciedad=Suciedad[iS],Theta=Theta)}

FTb=rbind(f.FTb(Theta,1), f.FTb(Theta,2), f.FTb(Theta,3),f.FTb(Theta,4))


FTd=exp(-1/Suc[iS,2]*(4/(3*pi)*(sin(Beta)+(pi-Beta-sin(Beta))/(1+cos(Beta)))+Suc[iS,3]*(sin(Beta)+(pi-Beta-sin(Beta))/(1+cos(Beta)))^2));
FTr=exp(-1/Suc[iS,2]*(4/(3*pi)*(sin(Beta)+(Beta-sin(Beta))/(1-cos(Beta)))+Suc[iS,3]*(sin(Beta)+(Beta-sin(Beta))/(1-cos(Beta)))^2));
trellis.device(postscript,file='~/Docencia/ESF/Figuras/Suciedad.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,family='URWPalladio',
			title='Suciedad_OPerpinanOct09');
xyplot(FTb~Theta*180/pi,groups=Suciedad,data=FTb, type='l',xlab='Ángulo de Incidencia (grados)',
				auto.key=list(title='Grado de Suciedad',cex.title=1.1,x=0.2,y=0.5,lines=TRUE,points=FALSE))
dev.off()

#------------------------------

#UTILIZAR AbacoOrientacionInclinacion.r

#-------------------------------------

#IES
IES<-read.table('~/Investigacion/Calculo/Datos/ies/IESDiarios_01012004_27092009.txt',header=T)
IES[,2:8]<-IES[,2:8]/1000#Cambio las unidades para que sean kWh/m2
IES[(IES$G0>10)|(IES$G41>3*IES$G0)|(IES$G41<0.7*IES$G0),2:8]<-NA


Fecha=strptime(IES$Fecha,format="%Y/%m/%d")
BTd<-cbind(IDd=as.numeric(as.numeric((Fecha))),
	  with(Fecha,data.frame(Ano=year+1900,DiaAno=yday+1,Mes=mon+1,DiaMes=mday)))

IES<-cbind(BTd,IES[,2:8])




lat=41;
lat=lat*pi/180;
dn=IES[["DiaAno"]]#as.numeric(as.vector(IESDiario$DiaAno))
decl=23.45*sin(2*pi*(dn+284)/365);
eo=1+0.033*cos(2*pi*dn/365);
decl=pi/180*decl; #Paso a radianes
ws=-acos(-tan(decl)*tan(lat)); #Amanecer


Bo=1367;
Bo0d=-24/pi*Bo*eo*(ws*sin(lat)*sin(decl)+cos(lat)*cos(decl)*sin(ws))/1000;
IES$Bo0d=Bo0d;
IES$Kt=IES$G0/Bo0d;
IES$Kt[IES$Kt<0|IES$Kt>1]<-NA;

IES$Fd=with(IES,D0/G0);
IES$Fd[IES$Fd<0.006|IES$Fd>1]<-NA; #estos registros parecen estar mal.


Kt_CPR=seq(0,0.8,.01);
Fd_CPR<-0.99*(Kt_CPR<=0.17)+(1.188-2.272*Kt_CPR+9.473*Kt_CPR^2-21.856*Kt_CPR^3+14.648*Kt_CPR^4)*(Kt_CPR>0.17);
trellis.device(postscript,file='~/Docencia/ESF/Figuras/FdKtDiario.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,
			title='FdKtDiario_OPerpinanOct09');
	xyplot(Fd~Kt,data=IES,
					#main='Fracción difusa de la radiación global diaria\nfrente al índice de claridad diario',
                    xlab=expression(K[Td]), ylab=expression(F[Dd]),
                    cex=0.3,
					panel=function(x,y,...){
						panel.xyplot(x,y,...);
						panel.xyplot(Kt_CPR,Fd_CPR,type='l',lwd=2);}
						)
dev.off();

library(doBy)
IESMes<-summaryBy(G0+D0+Bo0d~Mes+Ano,data=IES,FUN=function(x)mean(x,na.rm=1),keep.names=T);
IESMes$Kt<-with(IESMes,G0/Bo0d);
IESMes$Fd<-with(IESMes,D0/G0);

IESMes$Fd[1:3]<-NA; #los tres primeros registros parecen erroneos
IESMes$Fd[IESMes$Fd>1]<-NA

trellis.device(postscript,file='~/Docencia/ESF/Figuras/FdKtMensual.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,
			title='FdKtMensual_OPerpinanOct09');
	xyplot(Fd~Kt,data=IESMes, ylim=c(0,0.8),
					#main='Fracción difusa de la radiación global diaria\nfrente al índice de claridad diario',
                    xlab=expression(K[Tm]), ylab=expression(F[Dm]),
                    cex=0.6,
					panel=function(x,y,...){
						panel.xyplot(x,y,...);
						panel.xyplot(Kt,1-1.13*Kt,type='l',lwd=2);}
						)
dev.off();



