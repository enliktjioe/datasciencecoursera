library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)