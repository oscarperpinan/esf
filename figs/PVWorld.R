library(zoo)
library(lattice)
library(directlabels)
library(RColorBrewer)
library(latticeExtra)

pvCum <- read.zoo('PVWorld.csv', sep = ';', header = TRUE, dec = ',')
pv <- diff(pvCum)

pdf('../figs/PVWorld.pdf')
p <- xyplot(pv, superpose = TRUE, type = 'b',
            ylab = 'Potencia FV (MW)',
            par.settings = custom.theme.2(cex = 0.3, pch = 21))
direct.label(p, "top.points")
dev.off()
