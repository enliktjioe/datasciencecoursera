library(UsingR)
data(galton)
library(reshape) 
long <- melt(galton) 
g <- ggplot(long, aes(x = value, fill = variable)) 
g <- g + geom_histogram(colour = "black", binwidth=1) 
g <- g + facet_grid(. ~ variable) 
g

# Take the Galton dataset and find the mean, standard deviation and correlation between the parental and child heights. Watch a video solution.
summary(galton)
cor(galton)


x <- galton$parent
y <- galton$child
