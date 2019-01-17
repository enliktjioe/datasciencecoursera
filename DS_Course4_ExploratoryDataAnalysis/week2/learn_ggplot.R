library(ggplot2)
qplot(displ, hwy, data = mpg) # dataset "mpg" was pre-loaded in RStudio

# using Facets - splitout into 3 parts
qplot(displ, hwy, data = mpg, facets = . ~ drv)


# Code for Final Plot
g <- ggplot(maacs)
