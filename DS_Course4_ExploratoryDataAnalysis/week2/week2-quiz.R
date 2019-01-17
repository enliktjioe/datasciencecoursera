# Question 7
# I am interested in examining how the relationship between ozone and wind speed 
# varies across each month. 
# What would be the appropriate code to visualize that using ggplot2? 

library(ggplot2)
data("airquality")

str(airquality)

qplot(Wind, Ozone, data = airquality)
qplot(Wind, Ozone, data = airquality, geom = "smooth")

# CORRECT ANSWER:
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)


qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))


# Question 9
library(ggplot2)
library(ggplot2movies)
g <- ggplot(movies, aes(votes, rating))
print(g)

