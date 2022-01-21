######## Plotting predictors ########


# Instalando biblioteca
install.packages("ISLR")
install.packages("Hmisc")


# Biblioteca
library(ISLR)
library(ggplot2)
library(caret)

# Carregando dataset
data(Wage)
summary(Wage)

# Dataset
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=F)

# Treinamento do modelo
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

# Visualizando os dados de treino
dim(training)

# Visualizando os dados de teste
dim(testing)

# Matriz 
featurePlot(x=training[, c("age", "education", "jobclass")],
            y=training$wage, plot="pairs")

# Gráfico de classe de trabalho
qplot(age, wage, data=training)
qplot(age, wage, color=jobclass, data=training)

# Gráfico de regressão  
qq <- qplot(age, wage, color=education, data=training)
qq + geom_smooth(method='lm', formula=y~x)

library(Hmisc)

# Dados de treinamento
cutWage <- cut2(training$wage, g=3)
table(cutWage)

# Gráfico de boxplot
p1 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot"))
p2 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot", "jitter"))


library(gridExtra)
library(ggplot2)

# Grid dos gráficos
grid.arrange(p1, p2, ncol=2)

# Tables
t1 <- table(cutWage, training$jobclass)
t1

prop.table(t1, 1)

# Gráfico de densidade plots
qplot(wage, color=education, data=training, geom="density")
  