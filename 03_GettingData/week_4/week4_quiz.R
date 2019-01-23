# ## QUESTION 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

getdata_data_ss06hid <- read.csv("./data/getdata_data_ss06hid.csv")
splitNames <- strsplit(names(getdata_data_ss06hid), "wgtp")
splitNames[[123]]
# Answer = ""   "15"

## QUESTION 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
#   
#   Original data sources:
#   
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 

getdata_data_GDP <- read.csv("./data/getdata_data_GDP.csv", skip = 4, nrows = 190)
gdp_in_millions_dollars <- gsub(",", "", getdata_data_GDP$X.4)
gdp_in_millions_dollars
mean(as.numeric(gdp_in_millions_dollars))
# Answer = 377652.4


## QUESTION 3
# In the data set from Question 2 what is a regular expression that would allow you to count 
# the number of countries whose name begins with "United"? Assume that the variable with the country names 
# in it is named countryNames. How many countries begin with United?
countryNames <- as.character(getdata_data_GDP$X.3) 
countryNames
grep("^United", countryNames)
# Answer = 3 countries


## QUESTION 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Load the educational data from this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
#   
#   Original data sources:
#   
#   http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

library(data.table)
library(dplyr)

gross_domestic_product <- fread("./data/getdata_data_GDP.csv", skip = 4, nrows = 190, 
                                select = c(1,2,4,5), 
                                col.names = c("CountryCode", "Rank", "Economy", "Total"))
educational <- fread("./data/getdata_data_EDSTATS_Country.csv")
mergedData <- merge(gross_domestic_product, educational, by = "CountryCode")
mergedData_with_fiscal_year_end <- grep("Fiscal year end: June", mergedData$`Special Notes`)
mergedData_with_fiscal_year_end
length(mergedData_with_fiscal_year_end)


## QUESTION 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for 
# publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price 
# and get the times the data was sampled.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012? How many values were collected on Mondays in 2012?
library(lubridate)
in_2012 <- (grep("^2012", sampleTimes))
in_2012
length(in_2012)
# ANSWER = 250

monday_in_2012 <- weekdays(as.Date(sampleTimes[in_2012])) == "Monday"
monday_in_2012
sum(monday_in_2012)
# ANSWER = 47


## REFERENCES
# https://rpubs.com/ryantillis/getting_data_4
# https://gist.github.com/mGalarnyk/7b6e31d0df53f2496f602aac496bc0de

# NICE TABLE
# https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz4/quiz4.md
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
