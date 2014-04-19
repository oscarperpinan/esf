Y <- c(1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
2007, 2008, 2009)

ESP <- c(0, 1, 0, 2, 9, 10, 6, 26, 88, 560, 2605, 69)
 
GER <- c(10, 12, 40, 78, 80, 150, 600, 850, 850, 1271, 1809, 3806)
 
EEUU <- c(0, 17, 22, 29, 44, 63, 90, 114, 145, 207, 342, 477)
 
JAP <- c(69, 72, 112, 135, 185, 223, 272, 290, 287, 210, 230, 484)
 
RoW <- c(68, 84, 94, 75, 104, 98, 53, 12, 196, 168, 373, 447)
 
Total <- c(155, 197, 278, 334, 439, 594, 1052, 1321, 1603, 2594, 6090, 7203)

dat <- data.frame(cbind(SP, GER, EEUU, JAP, RoW, Total))

datStack <- stack(dat)
names(datStack) <- c('MW', 'Pais')
datStack$Y <- rep(Y, 6)

dat2005 <- subset(datStack, Y>2004)
library(lattice)
library(latticeExtra)
trellis.device(pdf, file='EPIA2010.pdf')
dotplot(reorder(Pais, MW)~MW, groups=Y, data=dat2005, par.settings=custom.theme(pch=19), auto.key=list(x=0.6, y=0.3, title='Año'))
dev.off()
