alfa=c(1.54375, 5.19972,12.6908,5.70134)
beta=c(0.77244, 1.88185, 4.14096, 1.64963)


fConsumo<-function(alfa,beta){
    deltax<-.01
    x=seq(0,10,by=deltax)
    result<-beta^alfa*x^(alfa-1)*exp(-beta*x)/gamma(alfa);
    result}
fMediaConsumo<-function(alfa,beta){
    media=alfa/beta
    prob=beta^alfa*media^(alfa-1)*exp(-beta*media)/gamma(alfa)
    result=c(media,prob)
    result}

prob<-as.data.frame(mapply(fConsumo,alfa,beta))
names(prob)<-c('Vale do Ribeira','Pedra Branca','Vera Cruz','Pruno');
library(reshape)
prob<-melt(prob)
names(prob)<-c('Localidad','Probabilidad')
prob$x<-seq(0,10,by=.01)

MediaConsumo<-as.data.frame(t((mapply(fMediaConsumo,alfa,beta))))
names(MediaConsumo)<-c('Media','Probabilidad');
MediaConsumo$Localidad<-c('Vale do Ribeira','Pedra Branca','Vera Cruz','Pruno');

library(latticedl)
trellis.device(postscript,file="~/Docencia/ESF/Figuras/ConsumoGamma.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
p<-xyplot(Probabilidad~x,groups=Localidad,data=prob, ,type='l',lwd=2,
		      xlab='Consumo (kWh/mes)',ylab='Probabilidad',
		      #auto.key=list(x=0.7,y=0.95,points=FALSE,lines=TRUE,title='Localidad',cex.title=1.5),
		      panel=function(x,y,...){
			    panel.xyplot(x,y,...)
			    panel.xyplot(MediaConsumo$Media,MediaConsumo$Probabilidad,
					  type='p',col='black',fill='darkgray',pch=21);
			    panel.abline(h=MediaConsumo$Probabilidad,v=MediaConsumo$Media,lty=3,col='gray')})
print(direct.label(p,method=list(top.points,rot=15)));
dev.off();
