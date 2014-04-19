#Ecuación de Shockley

Vt=25.85e-3
Io=1e-9
V=seq(-0.1,0.7,l=100);
I=Io*(exp(V/Vt)-1)

postscript('~/Docencia/ESF/Figuras/EcuacionDiodo.ps',
				horizontal=FALSE,onefile=F,paper='special',width=6,height=6,family='URWPalladio',
				title='EcuacionDiodoOPerpinan_Oct09');
par(mar=c(4.1,4.1,0.1,0.1));
plot(V,I,type='l',yaxt='n',xlab='Tensión (V)',ylab='Corriente')

dev.off()


Vocn=0.6;
Iscn=4.7;
Vmn=0.48;
Imn=4.35;

fCelulaSolar<-function(G, Ta, Vocn,Iscn,Vmn,Imn){

      CoefVT=0.0023;
      Gnominal=1000;

      TONC=47;
      Ct=(TONC-20)/800;
      Tc=Ta+Ct*G;

      FF=(Vmn*Imn)/(Vocn*Iscn);
      Vtn=0.025*(273+25)/300;

      Vt=0.025*(Tc+273)/300;

      Voc=Vocn-CoefVT*(Tc-25);
      Isc=Iscn*G/Gnominal;

      voc=Voc/Vt;
      FFo=(voc-log(voc+0.72))/(voc+1);

      Rs=(1-FF/FFo)*Voc/Isc;

      rs=1-FF/FFo;

      #a=voc+1-2*voc*rs;
      #b=a/(1+a);

      #Impp=Isc*(1-a^(-b)))
      #Vmpp=Voc*(1-b/voc*log(a)-rs*(1-a^(-b)));

      Dm0=(voc-1)/(voc-log(voc));
      Dm=Dm0+2*rs*Dm0^2;

      Impp=Isc*(1-Dm/voc);
      Vmpp=Voc*(1-log(voc/Dm)/voc-rs*(1-Dm/voc));


      Pmpp=Impp*Vmpp;
      v1=seq(rs,1,length=1000);#v1 es la tensión intrínseca, v=v1-i*rs, luego v será 0 en v1=i*rs, y en ese punto i=1 (i=I/Isc)
      i1=1-exp(-voc*(1-v1))-exp(-voc*(1-rs));
      v=v1-i1*rs;
      V=v*Voc;
      I=i1*Isc;
      P=V*I;
      result=list(Parametros=data.frame(Isc=Isc,Voc=Voc,Impp=Impp,Vmpp=Vmpp,Pmpp=Pmpp),Curva=data.frame(I,V,P));}#data.frame(Voc,Isc,Vmpp,Impp,Pmpp)}
      
Ta=seq(0,40,by=20)
G=seq(200,1000,by=200)
IVCurva<-data.frame();
IVParametros<-data.frame();
for (i in 1:length(Ta)){
      for (j in 1:length(G)){
          IVtemp<-fCelulaSolar(Ta=Ta[i],G=G[j], Vocn=Vocn,Vmn=Vmn,Iscn=Iscn,Imn=Imn);
          IVParametros<-rbind(IVParametros,data.frame(Ta=Ta[i],G=G[j],IVtemp$Parametros));
          IVCurva<-rbind(IVCurva,data.frame(Ta=Ta[i],G=G[j],IVtemp$Curva));}}


          
trellis.device(postscript,file='~/Docencia/ESF/Figuras/CurvaIV_Ta20_G800.ps',
			horizontal=FALSE,onefile=F,width=6,height=4.5,family='URWPalladio',
			title='CurvaIV_Ta20_G800_OPerpinanMar10');
				
aux=IVParametros[IVParametros$Ta==20&IVParametros$G==800,]
#p=data.frame(I=c(aux$Isc,aux$Impp),V=c(aux$Voc,aux$Vmpp));
xyplot(P+I~V,data=IVCurva,subset=(Ta==20&G==800), #ylim=c(0,1.1*aux$Isc),
                    type='l',lwd=2, ylab='',xlab='Tensión de célula (V)',
                    auto.key=list(x=0.1,y=0.5,lines=TRUE,points=FALSE,text=c('Potencia (W)','Corriente (A)'),cex=1.2),
                    panel=function(x,y,...){
                      panel.xyplot(x,y,...);
                      panel.text(x=0,y=aux$Isc,'Isc',pos=3, offset=0.2)
                      panel.text(x=0,y=aux$Impp,'Impp',pos=1, offset=0.2)
                      panel.text(x=aux$Voc, y=0,'Voc', pos=4, offset=0.1)
                      panel.text(x=aux$Vmpp, y=0, 'Vmpp',pos=2, offset=0.1)
                      panel.text(x=aux$Vmpp,y=aux$Pmpp, 'MPP', pos=4, offset=0.7)
                      panel.abline(h=c(aux$Isc,aux$Impp),v=(c(aux$Voc,aux$Vmpp)),lty=2);
                      panel.xyplot(c(aux$Vmpp,aux$Vmpp),c(aux$Impp,aux$Pmpp),pch=21,cex=1.2,col='black',fill='gray')})
dev.off();

trellis.device(postscript,file='~/Docencia/ESF/Figuras/CurvaIV_Ta20.ps',
			horizontal=FALSE,onefile=F,width=8,height=6,family='URWPalladio',
			title='CurvaIV_Ta20_OPerpinanOct09');
#sp <- list(superpose.line =  list(col = heat.colors(length(Ta)),lwd=3,lty=1)) 
			xyplot(I~V,groups=G,data=IVCurva,subset=(Ta==20), lwd=1.6, xlab='Tensión (V)', ylab='Corriente (A)',
                     type=c('l','g'),#par.settings=sp,
                     auto.key=list(x=.2,y=.25,points=FALSE,lines=TRUE,title=expression(G (W/m^2)),cex.title=1))

                     
dev.off()


trellis.device(postscript,file='~/Docencia/ESF/Figuras/CurvaPV_Ta20.ps',
			horizontal=FALSE,onefile=F,width=8,height=6,family='URWPalladio',
			title='CurvaPV_Ta20_OPerpinanMar10');
#sp <- list(superpose.line =  list(col = heat.colors(length(Ta)),lwd=3,lty=1)) 
			xyplot(P~V,groups=G,data=IVCurva,subset=(Ta==20), lwd=1.6, xlab='Tensión (V)', ylab='Potencia (W)',
                     type=c('l','g'),#par.settings=sp,
                     auto.key=list(x=.2,y=.85,points=FALSE,lines=TRUE,title=expression(G (W/m^2)),cex.title=1))

                     
dev.off()

trellis.device(postscript,file='~/Docencia/ESF/Figuras/CurvaIV_G800.ps',
			horizontal=FALSE,onefile=F,width=8,height=6,family='URWPalladio',
			title='CurvaIV_G800_OPerpinanOct09');

#sp <- list(superpose.line =  list(col = heat.colors(length(Ta)),lwd=3,lty=1)) 
xyplot(I~V,groups=Ta,data=IVCurva, subset=(G==800),
                     type=c('l','g'), lwd=1.6, xlab='Tensión (V)', ylab='Corriente (A)',
                     #par.settings=sp,
                     auto.key=list(x=.2,y=.25,points=FALSE,lines=TRUE,title=expression(T[a](degree*C)),cex.title=1))
dev.off();

trellis.device(postscript,file='~/Docencia/ESF/Figuras/CurvaPV_G800.ps',
			horizontal=FALSE,onefile=F,width=8,height=6,family='URWPalladio',
			title='CurvaPV_G800_OPerpinanMar10');
xyplot(P~V,groups=Ta,data=IVCurva, subset=(G==800),
                     type=c('l','g'), lwd=1.6, xlab='Tensión (V)', ylab='Potencia (W)',
                     #par.settings=sp,
                     auto.key=list(x=.2,y=.25,points=FALSE,lines=TRUE,title=expression(T[a](degree*C)),cex.title=1))
dev.off()
