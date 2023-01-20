f1 <- 1
tt <- seq(0, 1/fref, l = 1000)
w1 <- 2*pi*f1
V1 <- sin(w1*tt)

arm <- seq(5, 33, by = 4)
weights <- 1/arm * sin(arm*pi/2)
warm <- arm*w1
Varm <- matrix(nrow = length(tt), ncol = length(arm))
for (i in seq_along(arm))
    Varm[, i] <- weights[i] * sin(warm[i]*tt)
Vd <- V1 + rowSums(Varm)

pdf('../../figs/DistorsionArmonica.pdf')
par(mar=c(0.1,0.1,0.1,0.1))#No deja márgenes!!

plot(tt, Vd, type = "l", axes=FALSE,frame.plot=TRUE,ann=FALSE, col = "midnightblue")
lines(extendrange(x), c(0, 0))
for (i in seq_along(arm))
    lines(tt, Varm[, i], col = "darkgray")
lines(tt, V1, col = "darkred")

dev.off()


