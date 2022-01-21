####### Data Splitting #######

# Bibliotecas 
library(caret)
library(kernlab)

# Lendo dataset - SPAM
data(spam)

# Creando uma participação dos dados
inTrain <- createDataPartition(y=spam$type, p=0.75, list = FALSE)
inTrain

# Treinamento do modelo
train <- spam[inTrain,]
test <- spam[-inTrain,]

# Visualizando os dados de treino
dim(train)

# Visualizando os dados de teste
dim(test)

# Seed do modelo
set.seed(32343)

# Modelo
modelo_fit <- train(type ~. ,data = train, method = "glm")
modelo_fit

# Modelo - final model
modelo2_fit <- train(type ~., data = train, method = "glm")
modelo2_fit$finalModel

# Previsao do modelo
pred <- predict(modelo_fit, newdata=test)
pred

# Confusion matrix
confusionMatrix(pred, test$type)