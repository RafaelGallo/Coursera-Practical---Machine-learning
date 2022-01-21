### Unsupervised Prediction

library(ggplot2)

data(iris)

inTrain <- createDataPartition(y=iris$Species, p=0.7, list = FALSE)
inTrain

train <- iris[inTrain, ]
test <- iris[-inTrain, ]

dim(train)
dim(test)

# KMEANS
model_kmeans <- kmeans(subset(train, select = -c(Species)), centers = 3)
model_kmeans

clusters <- train$clusters <- as.factor(model_kmeans$cluster)
clusters

qplot(Petal.Width, Petal.Length, colour = clusters, data = train)

table(model_kmeans$centers)

# Model
model_fit <- train(cluster( ~., data = subset(train, select = -c(Species)), method = "rpart"))
