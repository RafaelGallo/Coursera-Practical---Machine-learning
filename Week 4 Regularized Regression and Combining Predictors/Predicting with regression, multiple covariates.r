## Predicting with regression, multiple covariates

library(ISLR)
library(ggplot2)
library(caret)


data(Wage)

Wage<-subset(Wage,select=-c(logwage))

summary(Wage)

inTrain<-createDataPartition(y=Wage$wage,p=0.7,list=FALSE)

training<-Wage[inTrain,]
testing<-Wage[-inTrain,]

dim(training)
dim(testing)


#### Feature plot on the wages dataset
featurePlot(x=training[,c("age","education","jobclass")],y=training$wage,plot="pairs")

#### Plot age vs. wage
qplot(age,wage,data=training)

#### Plot age vs wage, color by jobclass
qplot(age,wage,color=jobclass,data=training)

#### Plot age vs. wage, color by education
qplot(age,wage,color=education,data=training)

#### Fit a linear model
modFit <-train(wage~age+jobclass+education,method="lm",data=training)
modFit

finMod <-modFit$finalModel
finMod

print(modFit)

plot(finMod,1,pch=19,cex=0.5,col="#00000010")



#### Color by variables not used in the model
qplot(finMod$fitted,finMod$residuals,color=race,data=training)

#### Plot by index (i.e. which rows in the dataframe they are at)
plot(finMod$residuals,pch=19)

#### Predicted vs. truth in test set
pred<-predict(modFit,testing)
pred

qplot(wage,pred,color=year,data=testing)

### If you want to use all covariates (variables)
modFitAll <- train(wage~.,data=training,method="lm")
modFitAll

pred<-predict(modFitAll,newdata=testing)
pred

qplot(wage,pred,data=testing)