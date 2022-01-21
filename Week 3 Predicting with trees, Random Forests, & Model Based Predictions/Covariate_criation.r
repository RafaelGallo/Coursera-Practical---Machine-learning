##### Covariate #####

# Biblioteca
library(kernlab)
library(ISLR)
library(caret)
library(splines)

# Base dados
data(Wage)

inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list = FALSE)

training <- Wage[inTrain,]; testing <- Wage[-inTrain]

# Variables
table(training$jobclass)

dummies <- dummyVars(wage ~ jobclass, data = training)
head(predict(dummies, newdata=training))

# Removendo zero "covariates"
nsv <- nearZeroVar(training, saveMetrics = TRUE)
nsv

# Spline
bsBasis <- bs(training$age, df = 3)
bsBasis

# Plot curves splines
lml <- lm(wage ~ bsBasis, data = training)
plot(training$age, training$wage, pch = 19, cex = 0.5)
points(training$age, predict(lml, newdata = training), col="red", pch = 19, cex = 0.5)

# Previsão test set
predict(bsBasis, age=testing$age)
