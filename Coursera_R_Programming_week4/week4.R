outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## Make a simple histogram of the 30-day death rates from heart
## attack (column 11 in the outcome dataset)
## we need to coerce the column to be numeric,
## because originally we read the data in as character
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])