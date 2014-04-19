fBateria<-function(CorrienteTemperatura,C10=300){
    Corriente=CorrienteTemperatura[[1]];#extrayendo con [[]] evito el warning message "row names were found from a short 
    #variable and have been discarded" cuando entrego result
    Temperatura=CorrienteTemperatura[[2]];
    DeltaT=Temperatura-25;


    I10=C10/10;


    C=C10*1.67/(1+0.67*(Corriente/I10))*(1+0.005*DeltaT)


    tiempo=seq(0,40,l=100); #Tiempo del proceso, en horas
    Q=Corriente*tiempo;#carga entrante en cada instante

    SOC=0#Estado de carga inicial
    DeltaQu=0#Incremento de carga útil inicial
    etac=1-exp(-20.73/(Corriente/I10+0.55));#eficiencia farádica para SOC=0

    Vg=(2.24+1.97*log(1+Corriente/C10))*(1-0.002*DeltaT)
    Vf=(2.45+2.011*log(1+Corriente/C10))*(1-0.002*DeltaT)
    Tau=17.3/(1+852*(Corriente/C10)^1.67)


    for (i in 2:length(tiempo)){#empiezo en 2 para obviar t=0
	DeltaQu=c(DeltaQu,Corriente*etac[i-1]);
	SOC=c(SOC,SOC[i-1]+DeltaQu[i]/C);
	etac=c(etac,1-exp(20.73*(SOC[i]-1)/(Corriente/I10+0.55)));#eficiencia farádica: relación entre la corriente de descarga y la de 
	#carga. Por tanto, es una medida de la corriente que debe entrar para alcanzar un estado de carga es constante=1 hasta 
	#aproximadamente SOC=0.8(revisar)
			      }
    Qu=cumsum(DeltaQu); #Carga almacenada en la batería según el SOC

    #Tensión de carga
    Vc=(2+0.16*SOC)+Corriente/C10*(6/(1+Corriente^0.86)+0.48/(1-SOC)^1.2+0.036)*(1-0.025*DeltaT);


    #Qug=cumsum(DeltaQu[Vc>Vg]);#Carga almacenada en la batería durante el gaseo
    tg=min(tiempo[Vc>Vg]);#momento en el que empieza el gaseo
    Vc[Vc>Vg]=Vg+(Vf-Vg)*(1-exp(-(tiempo[Vc>Vg]-tg)/Tau));#formulación según Ec.4.12 de Modelado de Carmen Alonso EOI 2007-2008.
    #plot(tiempo,Vc);
    #Tensión de descarga
    Vd=(2.085-0.12*(1-SOC))-Corriente/C10*(4/(1+Corriente^1.3)+0.27/SOC^1.2+0.02)*(1-0.007*DeltaT);
    result<-data.frame(Vc,Vd,SOC,C,tiempo,DeltaQu,Qu,etac,Temperatura,Corriente,C10);}
    
IT<-expand.grid(Corriente=c(5,8,12),Temperatura=c(10,25,35));
Bateria<-apply(IT,1,fBateria,C10=300);#entrega el resultado en forma de lista
Bateria<-as.data.frame(do.call("rbind",Bateria))#cambia a data.frame
trellis.device(postscript,file="~/Docencia/uned/Graficos/Bateria_CorrYTemp.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
  xyplot(Vc~tiempo|Temperatura,groups=Corriente,data=Bateria,type='l',lwd=2,
		      layout=c(3,1,1),strip=strip.custom(strip.names=TRUE,strip.levels=TRUE),
		      xlab='Tiempo de carga (horas)',ylab='Tensión de Carga (V)',
		      auto.key=list(x=0.8,y=0.9,points=FALSE,lines=TRUE,title='Corriente (A)',cex.title=1));
dev.off();

#qplot(tiempo,Vc,data=Bateria,facets=.~Temperatura,shape=factor(Corriente))

C10=300
IT<-expand.grid(Corriente=seq(C10/100,C10/20,l=15),Temperatura=c(0,10,20,30,40));
Bateria<-apply(IT,1,fBateria,C10=C10);#entrega el resultado en forma de lista
Bateria<-as.data.frame(do.call("rbind",Bateria))#cambia a data.frame
trellis.device(postscript,file="~/Docencia/uned/Graficos/Bateria_Capacidad.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
  xyplot(C~C10/Corriente,groups=Temperatura,data=Bateria,type='l',lwd=2,
		      xlab='Regimen de descarga (horas)',ylab='Capacidad (Ah)',
		      auto.key=list(x=0.1,y=0.95,points=FALSE,lines=TRUE,title='Temperatura (ºC)',cex.title=1));
dev.off();

trellis.device(postscript,file="~/Docencia/uned/Graficos/Bateria_SOCyDescarga.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(Vd~1-SOC,subset=(Corriente==C10/100&Temperatura==20),data=Bateria,type='l', 
	      xlab='Profundidad de descarga (PD)',ylab='Tensión de descarga (V)',)
dev.off();
