#Parámetros para Madrid
f1=-0.2169
f2=-0.7865
u1=-1.2138
u2=-15.280

fLLP<-function(LLP,Cs=seq(1,6,l=100)){
      f=f1+f2*log10(LLP)
      u=exp(u1+u2*LLP)
      
      Ca=f*Cs^(-u)
      result<-data.frame(Cs,Ca,LLP)
      result}
      
#__________________
LLP=c(0.01,0.03,0.05,0.08,0.1)
CurvasLLP<-lapply(LLP,'fLLP')
CurvasLLP<-as.data.frame(do.call("rbind",CurvasLLP))#cambia a data.frame

trellis.device(postscript,file="~/Docencia/ESF/Figuras/CurvasLLP.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(Ca~Cs,groups=LLP,data=CurvasLLP,type='l',lwd=2,
		      xlab=expression(C[s]),ylab=expression(C[A]^'\''),
		      auto.key=list(x=0.8,y=0.95,points=FALSE,lines=TRUE,title='LLP',cex.title=1));
dev.off()

LLP=seq(0.01,0.1,l=100)
CurvasLLP_Cs3<-lapply(LLP,'fLLP',Cs=3)
CurvasLLP_Cs3<-as.data.frame(do.call("rbind",CurvasLLP_Cs3))#cambia a data.frame

#estas funciones sirven para poner escala logarítmica en XYPLOT.
#salen del libro Lattice Ed. Springer, pag. 147
logTicks <- function (lim, loc = c(1, 5)){ 
    ii <- floor(log10(range(lim))) + c(-1, 2) 
    main <- 10^(ii[1]:ii[2]) 
    r <- as.numeric(outer(loc, main, "*")) 
    r[lim[1] <= r & r <= lim[2]] } 
    
xscale.components.log10 <- function(lim, ...) { 
    ans <- xscale.components.default(lim = lim, ...) 
    tick.at <- logTicks(10^lim, loc = 1:9) 
    tick.at.major <- logTicks(10^lim, loc = 1) 
    major <- tick.at %in% tick.at.major 
    ans$bottom$ticks$at <- log(tick.at, 10) 
    ans$bottom$ticks$tck <- ifelse(major, 1.5, 0.75) 
    ans$bottom$labels$at <- log(tick.at, 10) 
    ans$bottom$labels$labels <- as.character(tick.at) 
    ans$bottom$labels$labels[!major] <- "" 
    ans$bottom$labels$check.overlap <- FALSE 
    ans } 
#------------------------------------------------
trellis.device(postscript,file="~/Docencia/ESF/Figuras/CurvasLLP_Cs3.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
xyplot(Ca~LLP,data=CurvasLLP_Cs3,type='l',lwd=2,
	      xlab=LLP,ylab=expression(C[A]^'\''),
	      scales=list(x=list(log=TRUE)),
	      xscale.components = xscale.components.log10,
	      panel=function(x,y,...){
		    panel.xyplot(x,y,...)
		    #Las lineas que vienen a continuación sirven para poner un grid adaptado a la escala logarítmica
		    panel.abline(v=log(logTicks(range(10^x), loc = 2:9),10),lty=3)
		    panel.abline(v=log(logTicks(range(10^x), loc = 1),10),lty=3)}    
		    );
dev.off();


#____________________________________________

LLP0=0.1
Cs0=3
Ca0=fLLP(LLP0,Cs0)$Ca;

L0=3000
Tg=Ca0*L0;
Tb=Cs0*L0;

fConsumoLLP<-function(LLP,Tg,Tb){
      f=f1+f2*log10(LLP)
      u=exp(u1+u2*LLP)
      L=((Tb^u)*(Tg/f))^(1/(1+u));
      result<-data.frame(L,LLP,Tg,Tb)
      result}
LLP<-seq(LLP0/10,0.2,0.001)
ConsumoLLP<-lapply(LLP,fConsumoLLP,Tg=Tg,Tb=Tb)
ConsumoLLP<-as.data.frame(do.call("rbind",ConsumoLLP))#cambia a data.frame
ConsumoLLP$Lr<-ConsumoLLP$L/L0
ConsumoLLP$LLPr<-ConsumoLLP$LLP/LLP0
trellis.device(postscript,file="~/Docencia/ESF/Figuras/ConsumoLLP.ps",width=8,height=6,onefile=FALSE,horizontal=FALSE);
  xyplot(LLPr~Lr,data=ConsumoLLP,type=c('l','g'),lwd=2,ylab=expression(LLP/LLP[base]),xlab=expression(L/L[base]));
dev.off()
