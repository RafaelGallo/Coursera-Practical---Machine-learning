# Project - M.L 

# Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about 
# personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts 
# Who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. 
# One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, 
# your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. 
# They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. 
# More information is available from the website here: [http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har] 
# (see the section on the Weight Lifting Exercise Dataset).

# Data Preprocessing

# library
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)

# Dataset
url_train = "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
url_test = "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

# Loading the Dataset
train_x <- read.csv(url(url_train))
train_y <- read.csv(url(url_test))

# Data Cleansing
x1 <- createDataPartition(train_x$classe, p=0.7, list=FALSE)
x_train <- train_x[x1,  ]
y_train <- train_y[-x1, ]

# Removing Variables which variance
NSQ <- nearZeroVar(x_train)
x_train <- x_train[, -NSQ]
y_train <- y_train[, -NSQ]

dim(x_train)
dim(y_train)

# Removing Variables NA values
x1 <- apply(x_train, 2, function(x) mean(is.na(x))) > 0.95
x1

# Model test train
x_train <- x_train[, -which(x1, x1 == FALSE)]
y_test <- y_train[, -which(x1, x1 == FALSE)]

x_train <- x_train[ , -(1:5)]
y_test <- y_train[ , -(1:5)]

# Plot correplot
library(corrplot)
corrMat <- cor(x_train[,-54])
corrplot(corrMat, method = "color", type = "lower", tl.cex = 0.8, tl.col = rgb(0,0,0))

######## Model 1 - Decision Tree ########

set.seed(14907)

model_decision_tree <- rpart(classe ~., method = "class", data = x_train)
model_decision_tree
summary(model_decision_tree)

# Plot decision tree
fancyRpartPlot(model_decision_tree)

# Predict - model
pred_model <- predict(model_decision_tree, y_test, type = "class")
pred_model

# Matrix confusion
matrix <- confusionMatrix(pred_model, y_test$classe)
matrix

######## Model 2 - Random Forest ########

set.seed(14501)
model_random_forest <- trainControl(method = "cv", number = 3, verboseIter = FALSE)
model_random_forest_fit <-train(classe ~., trControl = control, data = x_train, method = "rf")
model_random_forest_fit$finalModel
summary(model_random_forest_fit)

# Predict - model
pred <- predict(model_random_forest_fit, y_test)
pred

# Matrix confusion - Random Forest
matrix <- confusionMatrix(pred, y_test$classe)
matrix

######## Model 3 - Generalized boosted ########

set.seed(13908)
model <- trainControl(method = "repeatedcv", number = 5, repeats = 1, verboseIter = FALSE)
model_GBM <- train(classe ~., data = train, trControl = control, method = "gbm", verbose = FALSE)
model_GBM$finalModel

# Predict - model
pred_model <- predict(model_GBM, y_test, type = "class")
pred_model

# Matrix confusion
matrix <- confusionMatrix(pred_model, y_test$classe)
matrix

predict <- predict(model_GBM, y_test)
predict