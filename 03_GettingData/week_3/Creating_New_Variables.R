## Read file
restData <- read.csv("Restaurants.csv")

## Creating sequences
s1 <- seq(1, 10, by = 2) ; s1
s2 <- seq(1,10, length = 3); s2
x <- c(1,3,8,25,100); seq(along = x)

## Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

## Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

## Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

## Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

## Levels of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac = factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref="yes")

as.numeric(yesnofac)


## Cutting produces factor variables (REPEATING)
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

## Using the mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

## Common transforms
# abs(x) absolute value
# sqrt(x) square root
# ceiling(x) ceiling(3.475) is 4
# floor(x) floor(3.475) is 3
# round(x, digits = n) round(3.475, digit = 2) is 3.48
# signif(x, digits = n) signif(3.475, digits = 2) is 3.5
# cos(x), sin(x) etc.
# log(x) natural logarithm
# log2(x), log10(x) other common logs
# exp(x) exponentiating x


