## Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housing.csv", method = "curl")
list.files("./data")

## How many properties are worth $1,000,000 or more?
housing <- read.csv("./data/housing.csv")
head(housing$VAL)


## Reference from: https://github.com/zezutom/datasciencecoursera/tree/master/getcleandata/quiz1
answer1 <- nrow(subset(housing, VAL == 24))
answer1


## Question 3
library(openxlsx)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl3, destfile = "./data/ngap.xlsx", method = "curl")
list.files("./data")

dat <- read.xlsx("./data/ngap.xlsx", sheet = 1, rows = 18:23, cols = 7:15)

## What is the value of sum(dat$Zip*dat$Ext,na.rm=T)?
answer3 <- sum(dat$Zip*dat$Ext,na.rm=T)
answer3


## Question 4
library(XML)
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl4, destfile = "./data/baltimore_restaurants.xml", method = "curl")
list.files("./data")

baltimore_restaurants <- xmlParse("./data/baltimore_restaurants.xml")

## How many restaurants have zipcode 21231?
answer4 <- length(xpathApply(baltimore_restaurants, "//zipcode[text()='21231']",
                             xmlValue))
answer4


## Question 5
fileUrl5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl5, destfile = "./data/download_microdata_survey.csv", method = "curl")
list.files("./data")

# download_microdata_survey <- read.csv("./data/download_microdata_survey.csv")
## faster using fread()
DT <- fread(input = "./data/download_microdata_survey.csv", sep=",")
head(download_microdata_survey)

## question: Using the data.table package, which will deliver the fastest user time?
funs <- list(
  fun1 = function() { sapply(split(DT$pwgtp15,DT$SEX),mean) },
  fun2 = function() { tapply(DT$pwgtp15,DT$SEX,mean) },
  fun3 = function() { mean(DT$pwgtp15,by=DT$SEX) },
  fun4 = function() { DT[,mean(pwgtp15),by=SEX] },
  fun5 = function() { rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] },
  fun6 = function() { mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) }
)

## set to FALSE if you want to remove verbose logs below
isDebug <- TRUE

fastest <- NULL
min <- .Machine$integer.max

lapply(funs, function(FUN) {
  if(isDebug) print(FUN)
  st <- system.time(x <- try(FUN(), silent = TRUE))
  if (inherits(x, "try-error")) {
    if(isDebug) print("run-time error, skipping..")
  } 
  else {
    et <- st[3]
    if (et < min) {
      min <<- et
      fastest <<- FUN
    }
    if (isDebug) {
      print(paste("elapsed time:", sprintf("%.10f", et)))
      print(x)
    }
  }
})

## The function 'mean(DT$pwgtp15, by=DT$SEX)' should be the fastest one.
print("The fastest calculation is:")
print(fastest)
message("with running time of", sprintf("%.10f", min), "seconds")


## Test lain untuk question 5
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))

