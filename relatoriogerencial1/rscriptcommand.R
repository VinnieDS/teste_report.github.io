library(tidyverse)
library(doParallel)
library(Amelia)
library(caret)
library(xgboost)

df = read.csv2("bikeshare.csv",fileEncoding = "latin1",sep = ",")
df$datetime = as.Date(df$datetime)
df$temp = as.numeric(df$temp)
df$atemp = as.numeric(df$atemp)
df$windspeed = as.numeric(df$windspeed)
knitr::kable(summary(df[1:5]), caption = "Resumo das informações")
str(df)

graf = ts(df %>% select(12),start = min(df$datetime) ,end = max(df$datetime),frequency = 1)
dygraphs::dygraph(graf, main = "Qtd. aluguéis - 2011 a 2012", ylab = "Qtd. aluguéis") 

# Analise exploratoria de dados

```{r, fig.width=8.5,fig.height=6,echo=FALSE,fig.show="hide"}
df = read.csv2("bikeshare.csv",fileEncoding = "latin1",sep = ",")
df$datetime = as.Date(df$datetime)
df$temp = as.numeric(df$temp)
df$atemp = as.numeric(df$atemp)
df$windspeed = as.numeric(df$windspeed)
psych::pairs.panels(df[6:9])
```

M <- cor(df[-1]) %>% View
corrplot::corrplot(M, method = "circle")
str(df)
