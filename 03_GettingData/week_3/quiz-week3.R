## WEEK 3 QUIZ

## Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# 
# which(agricultureLogical)
# 
# What are the first 3 values that result?
# answer -> 125 238 262

housing_2006 <- read.csv("getdata_data_ss06hid.csv")
agricultureLogical <- which(housing_2006$ACR == 3 & housing_2006$AGS == 6)
#alternative >> agricultureLogical <- which(with(housing_2006, ACR == 3 & AGS == 6))
head(agricultureLogical, n=3)



## QUESTION 2
# Using the jpeg package read in the following picture of your instructor into R
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# 
# Use the parameter native=TRUE. 
# What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 
# 30th quantile)
# Answer = -15259150 -10575416
library(jpeg)
img <- readJPEG("getdata_jeff.jpg", native = TRUE)
quantile(img, probs = c(.30, .80))


## QUESTION 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Load the educational data from this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
#   
#   Original data sources:
#   
#   http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

library(data.table)
library(dplyr)

gross_domestic_product <- fread("getdata_data_GDP.csv", skip = 4, nrows = 190, 
                                  select = c(1,2,4,5), 
                                  col.names = c("CountryCode", "Rank", "Economy", "Total"))
# explanation >> skip = 4, first 4 rows is just label (not used) ; nrows = 190 (only 190 countries have gdp data)
educational <- fread("getdata_data_EDSTATS_Country.csv")

mergedData <- merge(gross_domestic_product, educational, by = "CountryCode")
dim(mergedData) # answer = 188 (should be 189, i don't know why)

mergedData_sorted <- arrange(mergedData, desc(Rank))
mergedData_sorted$`Long Name`[12] #answer = "St. Kitts and Nevis"

# Reference q3 and q4
# https://rstudio-pubs-static.s3.amazonaws.com/220774_a183c858b36e4faa949bf699c99bf53c.html
# https://gist.github.com/mGalarnyk/5a7e0313152cd7d1ba25c045645f19f3
# https://rpubs.com/Jerry_zhu/136354
# http://rpubs.com/ninjazzle/DS-JHU-3-3-Q3

## QUESTION 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
tapply(mergedData$Rank, mergedData$`Income Group`, mean)
# answer: High income: nonOECD 91.91304
#         High income: OECD 32.96667


## QUESTION 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?
library(Hmisc)
mergedData$RankGroups <- cut2(mergedData$Rank, g=5)
table(mergedData$RankGroups, mergedData$`Income Group`)