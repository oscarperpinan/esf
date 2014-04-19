SombraModulo<-read.table('~/Investigacion/Calculo/gnucap/cell_3.dat',header=T,comment.char='');
SombraModulo$v.4.<-SombraModulo$v.4.-SombraModulo$v.3.;
SombraModulo$v.3.<-NULL
names(SombraModulo)<-c('V','V1','V4','It','I1','I4','I11','I12','Vd1','Vd2','Id1','Id2', 'Pd1','Pd2');

trellis.device(postscript,file="~/Docencia/uned/Graficos/CurvaIV_DiodoPaso.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(It+I1+I4+I11+Id1+Id2~V,data=SombraModulo,
		xlab='Tensión (V)', ylab='Corriente (A)',
		type=c('l','g'), ylim=c(0,15), lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.text(x=0.5, y=max(SombraModulo$It), labels=expression(I[r]),pos=3,offset=0,cex=1.5)
				panel.text(x=1.3, y=with(SombraModulo,I1[V==1.3]), labels=expression(I[1]),pos=3,offset=0.5,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo$I4), labels=expression(I[4]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo$I11), labels=expression(I[11]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo$Id2), labels=expression(I[d2]),pos=3,offset=0,cex=1.5)
				})
dev.off()
trellis.device(postscript,file="~/Docencia/uned/Graficos/TensionesCelulasDiodos_DiodoPaso.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(V1+Vd1+V4+Vd2~V,data=SombraModulo,
		ylab='Tensión Célula(V)', xlab='Tensión Modulo (V)',
		type=c('l','g'),  lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.abline(h=0,lwd=1.5);
				panel.text(x=2, y=max(SombraModulo$V1), labels=expression(V[1]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=min(SombraModulo$V4), labels=expression(V[4]),pos=3,offset=0,cex=1.5)
				panel.text(x=2, y=min(SombraModulo$Vd1), labels=expression(V[D1]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo$Vd2), labels=expression(V[D2]),pos=3,offset=0,cex=1.5)
				})
dev.off()

trellis.device(postscript,file="~/Docencia/uned/Graficos/PotenciaCelulas_DiodoPaso.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot((V1*I1)+(V4*I4)+Pd1+Pd2~V,data=SombraModulo,
		ylab='Potencia Célula (W)', xlab='Tensión Modulo (V)',
		type=c('l','g'),  lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.abline(h=0,lwd=1.5);
				panel.text(x=1, y=with(SombraModulo,max(V1*I1)), labels=expression(P[1]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=with(SombraModulo,min(V4*I4)), labels=expression(P[4]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=with(SombraModulo,max(Pd1)), labels=expression(P[D1]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=with(SombraModulo,max(Pd2)), labels=expression(P[D2]),pos=3,offset=0,cex=1.5)
				})
dev.off()
trellis.device(postscript,file="~/Docencia/uned/Graficos/PotenciaModulo.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);

xyplot((V*It)~V,data=SombraModulo, lwd=2, type=c('l','g'), xlab='Tensión Módulo (V)', ylab='Potencia Módulo (W)')
dev.off()


SombraModulo_sinDiodos<-read.table('~/Investigacion/Calculo/gnucap/cell_3_sinDiodos.dat',header=T,comment.char='');
SombraModulo_sinDiodos$v.4.<-SombraModulo_sinDiodos$v.4.-SombraModulo_sinDiodos$v.3.;
SombraModulo_sinDiodos$v.3.<-NULL
names(SombraModulo_sinDiodos)<-c('V','V1','V4','It','I1','I4','I11','I12');

trellis.device(postscript,file="~/Docencia/uned/Graficos/CurvaIV_Sombra.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(It+I1+I4+I11~V,data=SombraModulo_sinDiodos,
		xlab='Tensión (V)', ylab='Corriente (A)',
		type=c('l','g'), ylim=c(0,12), lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.text(x=0.5, y=max(SombraModulo_sinDiodos$It), labels=expression(I[r]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo_sinDiodos$I4), labels=expression(I[1]==I[4]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=max(SombraModulo_sinDiodos$I11), labels=expression(I[11]),pos=3,offset=0,cex=1.5)
				})
dev.off()
trellis.device(postscript,file="~/Docencia/uned/Graficos/TensionCelula_Sombras.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(V1+V4~V,data=SombraModulo_sinDiodos,
		ylab='Tensión Célula(V)', xlab='Tensión Modulo (V)',
		type=c('l','g'),  lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.abline(h=0,lwd=1.5);
				panel.text(x=0.5, y=max(SombraModulo_sinDiodos$V1), labels=expression(V1),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=min(SombraModulo_sinDiodos$V4), labels=expression(V4),pos=3,offset=0,cex=1.5)
				})
dev.off()
trellis.device(postscript,file="~/Docencia/uned/Graficos/PotenciaCelula_Sombra.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot((V1*I1)+(V4*I4)~V,data=SombraModulo_sinDiodos,
		ylab='Potencia Célula (W)', xlab='Tensión Modulo (V)',
		type=c('l','g'),  lwd=2,
		panel = function(...) {
				panel.xyplot(...)
				panel.abline(h=0,lwd=1.5);
				panel.text(x=0.5, y=with(SombraModulo_sinDiodos,max(V1*I1)), labels=expression(P[1]),pos=3,offset=0,cex=1.5)
				panel.text(x=0.5, y=with(SombraModulo_sinDiodos,min(V4*I4)), labels=expression(P[4]),pos=3,offset=0,cex=1.5)
				})
dev.off()
xyplot((V1*I1)~V1,data=SombraModulo_sinDiodos,auto.key=list(space='right'),type=c('l','g'))
xyplot((V4*I4)~V4,data=SombraModulo_sinDiodos,auto.key=list(space='right'),type=c('l','g'))

