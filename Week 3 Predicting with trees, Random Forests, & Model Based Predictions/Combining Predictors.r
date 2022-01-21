# Combining Predictors

library(ISLR)
library(ggplot2)
library(caret)

data("Wage")
head(data)

str(data)

Wage <- subset(Wage, select = -c(logwage))
Wage

# Validation set
inBluid <- createDataPartition(y=Wage$wage,
                               p=0.7, list = FALSE)

# Validatio
validation <- Wage[-inBluid,];
buildData <- Wage[inBluid,]

# Train test model
inTrain <- createDataPartition(y = buildData$wage, p=0.7, list = FALSE)
inTrain

training <- buildData[inTrain,]
testing <- buildData[-inTrain,]

dim(training)
dim(testing)
dim(validation)

# Model
model_1 <- train(wage ~., method = "glm", data = training)
model_1
summary(model_1)

model_2 <- train(wage ~., method = "rf", data = training, trControl = trainControl(method = "cv"), number = 3)
model_2
summary(model_2)

# Predict 
pred_1 <- predict(model_1, testing)
pred_1

pred_2 <- predict(model_2, testing)
pred_2

# Gráfico
qplot(pred_1, pred_2, color = wage, data = testing)

# Previsao do modelo
pred <- data.frame(pred_1, pred_2, wage=testing$wage)
combModFit <- train(wage ~., method = "gam", data = pred)
combPred <- predict(combModFit, pred)
combPred

# Erros do modelo
sqrt(sum((pred-testing$wage)^2))
sqrt(sum((pred_2-testing$wage)^2))
sqrt(sum((combPred-testing$wage)^2))

pred_1 <- predict(model_1, validation)
pred_2 <- predict(model_2, validation)
predx <- data.frame(pred=pred_1, pred_2 = pred_2)
combx <- predict(combModFit, predx)
combx

sqrt(sum((pred_1-validation$wage)^2))
sqrt(sum((pred_2-validation$wage)^2))
sqrt(sum((combx-validation$wage)^2))
