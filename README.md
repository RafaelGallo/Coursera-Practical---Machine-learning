
## Practical Machine-learning - John Hopkins University

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)
[![author](https://img.shields.io/badge/author-RafaelGallo-red.svg)](https://github.com/RafaelGallo?tab=repositories) 
[![](https://img.shields.io/badge/R-3.6.0-red.svg)](https://www.r-project.org/)
[![](https://img.shields.io/badge/ggplot2-white.svg)](https://ggplot2.tidyverse.org/)
[![](https://img.shields.io/badge/dplyr-blue.svg)](https://dplyr.tidyverse.org/)
[![](https://img.shields.io/badge/readr-green.svg)](https://readr.tidyverse.org/)
[![](https://img.shields.io/badge/ggvis-black.svg)](https://ggvis.tidyverse.org/)
[![](https://img.shields.io/badge/Shiny-red.svg)](https://shiny.tidyverse.org/)
[![](https://img.shields.io/badge/plotly-green.svg)](https://plotly.com/)
[![](https://img.shields.io/badge/Caret-orange.svg)](https://caret.tidyverse.org/)

Course 8 in the Data Science Specialization by John Hopkins University
 
- Link - [Data Science - Machine learning John Hopkins University](https://www.coursera.org/learn/practical-machine-learning)


![Logo](https://brand.jhu.edu/assets/uploads/sites/5/2016/01/university.logo_.small_.horizontal.white_.png)


## Stack utilizada

**Machine learning:** R

**Análise de dados:** fancyRpartPlot

**R:** caret, corrplot, rpart, rpart.plot, rattle




## Aprendizados

- O que você aprendeu construindo esse projeto? 

Nesse curso da Universidade Johns Hopkins e um curso aplicado machine learning no R.

- Quais desafios você enfrentou e como você superou-os?

Modelos de machine learning feito na linguagêm r criação modelos de classificação, regressão, aprendizado não supervisionado

## Variáveis de Ambiente

```bash
Renv/activate.r({

bioconductor.version"
  external.libraries
  ignored.packages:
  package.dependency.fields: Imports, Depends, LinkingTo
  r.version:
  snapshot.type: implicit
  use.cache: TRUE
  vcs.ignore.cellar: TRUE
  vcs.ignore.library: TRUE
  vcs.ignore.local: TRUE

```
    
## Instalação

Renv/activate.r

```bash
local({

  # the requested version of renv
  version <- "0.15.0"

  # the project directory
  project <- getwd()

  # figure out path to 'renv' folder from this script
  call <- sys.call(1L)
  if (is.call(call) && identical(call[[1L]], as.symbol("source")))
    Sys.setenv(RENV_PATHS_RENV = dirname(call[[2L]]))

  # figure out whether the autoloader is enabled
  enabled <- local({

    # first, check config option
    override <- getOption("renv.config.autoloader.enabled")
    if (!is.null(override))
      return(override)

    # next, check environment variables
    # TODO: prefer using the configuration one in the future
    envvars <- c(
      "RENV_CONFIG_AUTOLOADER_ENABLED",
      "RENV_AUTOLOADER_ENABLED",
      "RENV_ACTIVATE_PROJECT"
    )

    for (envvar in envvars) {
      envval <- Sys.getenv(envvar, unset = NA)
      if (!is.na(envval))
        return(tolower(envval) %in% c("true", "t", "1"))
    }

    # enable by default
    TRUE

  })

  if (!enabled)
    return(FALSE)

  # avoid recursion
  if (identical(getOption("renv.autoloader.running"), TRUE)) {
    warning("ignoring recursive attempt to run renv autoloader")
    return(invisible(TRUE))
  }

  # signal that we're loading renv during R startup
  options(renv.autoloader.running = TRUE)
  on.exit(options(renv.autoloader.running = NULL), add = TRUE)

  # signal that we've consented to use renv
  options(renv.consent = TRUE)

  # load the 'utils' package eagerly -- this ensures that renv shims, which
  # mask 'utils' packages, will come first on the search path
  library(utils, lib.loc = .Library)

  # check to see if renv has already been loaded
  if ("renv" %in% loadedNamespaces()) {

    # if renv has already been loaded, and it's the requested version of renv,
    # nothing to do
    spec <- .getNamespaceInfo(.getNamespace("renv"), "spec")
    if (identical(spec[["version"]], version))
      return(invisible(TRUE))

    # otherwise, unload and attempt to load the correct version of renv
    unloadNamespace("renv")

  }
```
    
## Exemplo Modelo machine learning no R

```bash
# Modelo machine learning - Decision tree

# Instalando biblioteca
install.packages("rattle")

# Biblioteca
library(rattle)
library(ggplot2)
library(caret)

# Dataset - Iris
data(iris)

# Visualizando 5 primeiras linhas
head(data)

# Classes 
class(data)

# Nome dados
names(iris)

# Nomes das especies de flores
table(iris$Species)

# Conjunto de treino teste dividindo a base de treino e teste
inTrain <- createDataPartition(y=iris$Species,p=0.7,list=FALSE)
inTrain

# Dados de treino
training<-iris[inTrain,]
testing<-iris[-inTrain,]

# Visualizando os dados de treino
dim(training)

# Visualizando os dados de teste
dim(testing)

################## Gráfico ################

# Gráfico das petalas
qplot(Petal.Width, Sepal.Width, colour = Species, data=training)

################## Modelo ################
model <- train(Species ~ ., method = "rpart", data = training)
model
print(model $ finalModel)

# Gráfico árvore - 1
plot(model$finalModel,uniform=TRUE,main="Classification Tree")
text(model$finalModel,use.n=TRUE,all=TRUE,cex=0.8)

# Gráfico árvore - 2
fancyRpartPlot(model$finalModel)

# Previsão do modelo
pred <- predict(model, newdata = testing)
pred


# Confusion Matrix
matrix <- confusionMatrix(testing$Species,predict(model,testing))
matrix
```


## Screenshots

![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)


## Melhorias

Que melhorias você fez no seu código? 

Ex: refatorações, melhorias de performance, acessibilidade, etc


## Suporte

Para suporte, mande um email para rafaelhenriquegallo@gmail.com 
