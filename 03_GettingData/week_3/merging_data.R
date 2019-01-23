reviews <- read.csv("reviews.csv"); solutions <- read.csv("solutions.csv")
head(reviews, 2)
head(solutions, 2)

names(reviews)
names(solutions)

## Merging data - merge()
# important parameters: x, y, by, by.x, by.y, all

mergedData = merge(reviews, solutions, by.x="solution_id", 
                      by.y = "id", all = TRUE)
head(mergedData)

## Default- merge all common column names
intersect(names(solutions), names(reviews))

mergedData2 = merge(reviews, solutions, all = TRUE)
head(mergedData2)

## Using join in the plyr package
# Faster, but less full featured
library(plyr)
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
arrange(join(df1,df2), id)

## If you have multiple data frames
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
df3 = data.frame(id=sample(1:10), z = rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)

## More on merging data
# The quick R data merging page, statmethods.net
# plyr information plyr.had.co.nz
# Type of joins, wikipedia Join(SQL)

