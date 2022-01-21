###### Data slicing ######

# Biblioteca
library(caret)
library(kernlab)

# Carregando dataset
data(spam)

# Dataset
data_set <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
data_set

# Visualizando linhas e colunas
dim(data_set)

# Treinamento do modelo
train <- spam[data_set,]
test <- spam[-data_set,]

# Visualizando os dados de treino
dim(train)

# Visualizando os dados de teste
dim(test)

# K-fold
set.seed(32323)
k_folds <- createFolds(y=spam$type, 
                       k=10, list = TRUE, 
                       returnTrain = TRUE)
k_folds
sapply(k_folds, length)

k_folds[[1]][1:10]

# Return test
set.seed(32323)
kfolds <- createFolds(y=spam$type,
                      k=10, list = TRUE,
                      returnTrain = FALSE)
kfolds
sapply(kfolds, length)

# Resampling
set.seed(32323)
folds <- createResample(y=spam$type, times = 10,
                        list = TRUE)
sapply(folds, length)

# Time slices
set.seed(32323)
tme <- 1:1000
k_folds <- createTimeSlices(y=tme, initialWindow = 20, horizon = 10)
names(k_folds)
