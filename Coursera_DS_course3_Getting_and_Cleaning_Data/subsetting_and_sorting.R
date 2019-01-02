# Setup dataframe
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10),
                  "var3" = sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

# Sorting
x <- c(5,NA,3,1,2,4,NA,NA)
sort(x)
sort(x, na.last = TRUE)
sort(x, decreasing = TRUE)

# Ordering
X[order(X$var1),]
X[order(X$var1, X$var3),]

# Ordering with plyr
library(plyr)
arrange(X, var1)
arrange(X, desc(var1))
X$var4 <- rnorm(5)
X
Y <- cbind(X, rnorm(5))
Y








