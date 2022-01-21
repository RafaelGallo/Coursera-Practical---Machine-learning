### Predicting with Regression

library(caret)

data(faithful)

set.seed(333)

inTrain<-createDataPartition(y=faithful$waiting,p=0.5,list=FALSE)
inTrain

trainFaith<-faithful[inTrain,]
trainFaith

testFaith<-faithful[-inTrain,]
testFaith

head(trainFaith)


#### Plot eruption duration vs. waiting time.
# You can see that there's a roughly linear relationship between the two variables. 

plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="waiting",ylab="eruption duration")


# Fit a linear regression model
lm1<-lm(eruptions~waiting,data=trainFaith)
lm1
summary(lm1)

#### Plot model fit
plot(trainFaith$waiting,trainFaith$eruptions,
     pch = 19, 
     col = "blue",
     xlab="waiting",
     ylab="eruption duration")
lines(trainFaith$waiting,lm1$fitted,lwd=3)

#### Predicting a new value with the linear regression model
newdata <- data.frame(waiting=80)
newdata
predict(lm1,newdata)

#### Plot predictions - training vs testing set
par(mfrow=c(1,2))
par

# training
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,
     col="blue",main="training",
     xlab="waiting",
     ylab="eruption duration")
lines(trainFaith$waiting,predict(lm1),lwd=3)

# testing
plot(testFaith$waiting,testFaith$eruptions,
     pch=19,col="blue",
     main="testing",
     xlab="waiting",
     ylab="eruption duration")
lines(testFaith$waiting,predict(lm1,newdata=testFaith),lwd=3)


#### Get training & testing errors
# RMSE on training
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))

# RMSE on testing
sqrt(sum((predict(lm1,newdata=testFaith)-testFaith$eruptions)^2))


#### Prediction intervals
pred1<-predict(lm1,newdata=testFaith,interval="prediction")
pred1

ord<-order(testFaith$waiting)
ord

plot(testFaith$waiting,
     testFaith$eruptions,pch=19,
     col="blue")
matlines(testFaith$waiting[ord],pred1[ord,],type="l",col=c(1,2,2),lty=c(1,1,1),lwd=3)

#### Same process with caret
modFit<-train(eruptions~waiting,data=trainFaith,method="lm")
modFit

summary(modFit$finalModel)
