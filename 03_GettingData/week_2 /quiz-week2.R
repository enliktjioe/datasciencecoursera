## QUESTION 1 - Github API
library(httr)
library(jsonlite)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app(appname = "coursera-github",
                   key = "b5156716a3f049a39681",
                   secret = "07914b6bebd4a03b204b813d793d268cc5b06267"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 


# 1. Question 1
# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio. 
# Answer: 
# 2013-11-07T13:25:07Z



## QUESTION 2 - sqldf package
# download .csv file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "data_week2.csv", method = "curl")
list.files()

library(sqldf)
acs <- read.csv("data_week2.csv")
head(sqldf("select pwgtp1 from acs where AGEP < 50"))


# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
# Download the American Community Survey data and load it into an R object called
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# Question Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
# Answer:
# sqldf("select pwgtp1 from acs where AGEP < 50")


## Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# Answer:
# sqldf("select distinct AGEP from acs")


## Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#   
#   http://biostat.jhsph.edu/~jleek/contact.html
# 
# (Hint: the nchar() function in R may be helpful)
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))


## Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12",
             "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler",
             "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])