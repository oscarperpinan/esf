Aranjuez<-read.table('http://www.mapa.es/siar/exportador.asp?T=DD&P=28&E=3&I=01/01/2004&F=31/12/2008',header=T,skip=1,fill=T,dec=',')

#con colClasses se selecciona las columnas que no se quieren leer (NULL), y character es para las fechas.
#Radiacion<-read.table('XXXXX.txt',fill=T,colClasses=c('NULL','character','NULL','NULL','numeric'),dec=',')
Fecha=strptime(Aranjuez$Fecha,format="%d/%m/%Y")
BTd<-cbind(IDd=as.numeric(as.numeric((Fecha))),
	  with(Fecha,data.frame(Ano=year+1900,DiaAno=yday+1,Mes=mon+1,DiaMes=mday)))
Aranjuez$G<-Aranjuez$Radiacion/3.6#Cambio de unidades
Aranjuez$Radiacion<-NULL#eliminamos esta variable
Aranjuez<-cbind(BTd,Aranjuez)


IES<-read.table('~/Investigacion/Calculo/Datos/ies/IESDiarios_01012004_27092009.txt',header=T)
IES[,2:7]<-IES[,2:7]/1000#Cambio las unidades para que sean kWh/m2
Fecha=strptime(IES$Fecha,format="%Y/%m/%d")
BTd<-cbind(IDd=as.numeric(as.numeric((Fecha))),
	  with(Fecha,data.frame(Ano=year+1900,DiaAno=yday+1,Mes=mon+1,DiaMes=mday)))

IES<-cbind(BTd,IES[,2:7])
