library(reshape2)
head(mtcars)

## Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), 
                  measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)

## Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)  #recast data frame into particular shape
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)  #recast data frame into particular shape
cylData

## Averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

## Another ways - split
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount = lapply(spIns, sum)
sprCount

## Anothey way - combine
unlist(sprCount)
sapply(spIns, sum)

## Another way - plyr package
library(plyr)
ddply(InsectSprays,.(spray), summarize, sum = sum(count))

## Creating a new variable
spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN=sum))
dim(spraySums)
head(spraySums)
