#    CalcEstVariasInclinaciones.r: calculo de producción para varias inclinaciones
#    Copyright (c) 2009, Oscar Perpiñán Lamigueiro

#    Este programa es software libre: usted puede redistribuirlo y/o modificarlo
#    bajo los términos de la Licencia Pública General GNU publicada
#    por la Fundación para el Software Libre, ya sea la versión 3
#    de la Licencia, o (a su elección) cualquier versión posterior.

#    Este programa se distribuye con la esperanza de que sea útil, pero
#    SIN GARANTÍA ALGUNA; ni siquiera la garantía implícita
#    MERCANTIL o de APTITUD PARA UN PROPÓSITO DETERMINADO.
#    Consulte los detalles de la Licencia Pública General GNU para obtener
#    una información más detallada.

#    Debería haber recibido una copia de la Licencia Pública General GNU
#    junto a este programa.
#    En caso contrario, consulte <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------



soda<-read.table('Datos/soda/Soda_Lat30_50_Lon-10_20.txt');
col_mes=3



#-------------------------------------------
#library(reshape)
source("scriptsR/fSolD.r")
source("scriptsR/fSolI.r")
source("scriptsR/fCompD.r")
source("scriptsR/fCompI.r")
source("scriptsR/fInclin.r")
source("scriptsR/fProd.r")

options(warn=-1); #desactiva los warnings...
#________________________________________
#Crea la Base Temporal
#=======================================
Nm=1
DiasProm<-c(17,14,15,15,15,10,18,18,18,19,18,13);
DiasProm_Ano<-c(17,45,74,105,135,161,199,230,261,292,322,347);


#Genera una secuencia de 12 días promedio
Fecha<-as.POSIXlt(ISOdate(2009,1:12,DiasProm));

BTd<-cbind(IDd=as.numeric(as.numeric((Fecha))),
	  with(Fecha,data.frame(Ano=year+1900,DiaAno=yday+1,Mes=mon+1,DiaMes=mday)))
BTd$DiasMes<-c(31,28,31,30,31,30,31,31,30,31,30,31);
#IDd es el número de segundos desde el 01/01/1970. Lo utilizo como indice de la Base en clave diaria, 
#y me servirá después cuando incorpore Horas y Minutos en fSolI (allí crearé otro llamado IDi)
#Es importante fijar hour=0, para que en fSolI pueda actualizar el valor de IDd
#sumando Hora*3600 y Min*60
#Así, tendré un índice diario (IDd) y un índice instantáneo (IDi). Utilizaré cada uno de ellos según 
#si los resúmenes son en clave diaria o instantánea.



fGefAnual<-function(beta,CompI,lat){
			
			InclinDF<-fInclin(CompI,lat,beta);
			
			#________________________________________
			#Cálculo de valores anuales
			#=======================================

			GefMensual<-aggregate(InclinDF["Gef"],InclinDF["Mes"],function(x){sum(x,na.rm=1)/Nm/1000});
			
			GefAnual=sum(GefMensual$Gef*BTd$DiasMes);
			
			result<-GefAnual
			result
			}
			

BetaOptimDF=data.frame();
GefDF=data.frame()		
Indices=c(1000,2500,4500)
	
#for (i in 1:dim(soda)[1]){
for (i in Indices){
	lat=soda$Lat[i];
	G0dm=as.numeric(soda[i,col_mes:(col_mes+11)]*1000);

	#________________________________________
	#Angulos solares
	#=======================================
	SolD<-fSolD(lat,BTd);

	SolI<-fSolI(lat,SolD,Nm);

	#________________________________________
	G0dDF<-data.frame(BTd,G0d=G0dm,Ktd=G0dm/SolD$Bo0d); #Utilizo sólo las 12 medias mensuales, no genero serie sintética
	G0Anual<-sum(G0dm*BTd$DiasMes)/1000;


	#________________________________________
	#Componentes de irradiación e irradiancia
	#=======================================

	CompD<-fCompD(G0dDF,corr='Page');#Utilizo la correlación de Page
	CompI<-fCompI(CompD,SolI);

	#________________________________________
	#Paso a inclinada
	#=======================================
	print(i)
	BetaOptim=optimize(fGefAnual,interval=c(lat-20,lat+20),CompI=CompI,lat=lat,maximum=TRUE);
	BetaOptimDF=rbind(BetaOptimDF,data.frame(lat,G0Anual,BetaOptim));
						
	Beta=seq(lat-20,lat+20,l=50);
	Gef=sapply(Beta,fGefAnual,CompI,lat);
	GefDF=rbind(GefDF,data.frame(BetaOptim,lat,Beta,Gef))
	}
names(GefDF)[1:2]<-c('BetaOptimo','GefOptimo')	
#Por ejemplo

trellis.device(postscript,file='~/Docencia/ESF/Figuras/PerdidasInclinacionOptima.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,family='URWPalladio',
			title='PerdidasInclinacionOptima_OPerpinanOct09');
			
			xyplot(100*(1-Gef/GefOptimo)~(Beta-BetaOptimo),groups=lat,data=GefDF,
						xlim=c(-15,15),ylim=c(0,3),type=c('l','g'),
						xlab=expression(beta-beta[opt]),ylab=expression(100%.%(1-frac(G[ef],G[efopt]))),
						auto.key=list(x=0.5,y=0.8,lines=TRUE,points=FALSE,title='Latitud'));
dev.off()






