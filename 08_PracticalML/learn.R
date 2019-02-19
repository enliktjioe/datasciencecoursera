library(caret); library(kernlab); data(spam)

inTrain <- createDataPartition(y=spam$type,
                               p=0.75,
                               list = F)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
dim(testing)


# SPAM Example: Fit a model
library(e1071)
set.seed(32343)
modelFit <- train(type ~ ., 
                  data = training, 
                  method = "glm")
modelFit


# SPAM Example: Prediction
predictions <- predict(modelFit, newdata = testing)
predictions

# SPAM Example: Confusion Matrix
confusionMatrix(predictions, testing$type)

############################################################
##                                                        ##
############################################################

# Predicting with Regression
## Example: Old faithful eruptions
data("faithful")
set.seed(333)
inTrain <- createDataPartition(y = faithful$waiting,
                               p = 0.5,
                               list = F)
trainFaith <- faithful[inTrain,]
testFaith <- faithful[-inTrain,]
head(trainFaith)


# Eruption duration versus waiting time
plot(trainFaith$waiting, trainFaith$eruptions,
     pch = 19, col = "blue",
     xlab = "Waiting", ylab = "Duration")

# Fit a linear model
lm1 <- lm(eruptions ~ waiting, data = trainFaith)
summary(lm1)

# Predict a new value
coef(lm1)[1] + coef(lm1)[2] * 80

newdata <- data.frame(waiting=80)
predict(lm1, newdata)


# Plot predictions - training and test
par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruptions,
     pch = 19, col = "blue",
     xlab = "Waiting", ylab = "Duration")
lines(trainFaith$waiting, predict(lm1), lwd = 3)
plot(testFaith$waiting, testFaith$eruptions,
     pch = 19, col = "blue",
     xlab = "Waiting", ylab = "Duration")
lines(testFaith$waiting, predict(lm1, newdata = testFaith),
      lwd = 3)


# Get training set / test set errors
# Calculate RMSE (R Mean Square Error) on traing
sqrt(sum((lm1$fitted - trainFaith$eruptions) ^ 2))

# Calculate RMSE on test
sqrt(sum((predict(lm1, newdata = testFaith) - testFaith$eruptions) ^ 2))


# Prediction intervals
pred1 <- predict(lm1, newdata = testFaith, interval = "prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions,
     pch = 19, col = "blue")
matlines(testFaith$waiting[ord], pred1[ord,],
         type = "l",, col = c(1,2,2), lty = c(1,1,1),
         lwd = 3)


# Same process with caret
modFit <- train(eruptions ~ waiting, data = trainFaith,
                method = "lm")
summary(modFit$finalModel)

############################################################
##                                                        ##
############################################################

# Predicting with Regression Multiple Covariates
# Example: Wage Data
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)

Wage <- subset(Wage, select = -c(logwage))
summary(Wage)

# Get training/test sets
inTrain <- createDataPartition(y = Wage$wage,
                               p = 0.7, list = F)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training)
dim(testing)


# Feature plot
featurePlot(x = training[,c("age", "education","jobclass")],
            y = training$wage,
            plot = "pairs")


# QUIZ 2
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[-trainIndex,]
testing = adData[-trainIndex,]
summary(training)
summary(testing)


# 2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
