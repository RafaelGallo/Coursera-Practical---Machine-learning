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