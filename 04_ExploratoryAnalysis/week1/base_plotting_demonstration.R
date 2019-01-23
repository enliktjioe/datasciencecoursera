x <- rnorm(100)
hist(x)

y <- rnorm(100)
plot(x, y)

#example("points")

plot(x,y, pch = 20)
title("Scatterplot")
text(-2,-2, "Label")
legend("topleft", legend = "Data")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
abline(fit, lwd = 3)