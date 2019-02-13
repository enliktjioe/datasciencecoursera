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
