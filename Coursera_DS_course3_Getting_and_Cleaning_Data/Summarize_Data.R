## Read file
restData <- read.csv("Restaurants.csv")

## Look at a bit of the data
head(restData, n=3)
tail(restData, n=3)

## Make summary
summary(restData)
str(restData)

## Quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))

## Make table
table(restData$zipCode, useNA = "ifany") 
# "ifany" means, is if there are any missing values, 
# they'll be an added column tot his table, which will be NA, 
# and it'll tell you the number of missing values there is.

table(restData$councilDistrict, restData$zipCode)

## Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict)) # look all if there's any NA values
all(restData$zipCode > 0)

## Row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

## Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]

## Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

## Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt

ftable(xt) # more compact and easier to see

## Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")