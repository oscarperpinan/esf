library(zoo)
library(lattice)
library(directlabels)
library(RColorBrewer)
library(latticeExtra)

pvCum <- read.zoo('PVWorld.csv', sep = ';', header = TRUE)

pdf('../figs/PVWorld.pdf')
p <- xyplot(pvCum/1000, superpose = TRUE, type = 'b',
            ylab = 'Potencia FV (GW)',
            par.settings = custom.theme.2(cex = 0.3,
                                          lwd = 2.5,
                                          pch = 21))
direct.label(p)#, "top.points")
dev.off()

