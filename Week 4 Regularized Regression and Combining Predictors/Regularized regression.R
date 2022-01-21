## Regularized regression

install.packages("ElemStatLearn")

library(ElemStatLearn)

data(prostate)
head(prostate)

str(prostate)

small = prostate[1:5,]
lm(lpsa ~ ., data = small)


