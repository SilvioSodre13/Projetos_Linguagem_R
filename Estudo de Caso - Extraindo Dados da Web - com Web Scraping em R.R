# Estudo de Caso : Extraindo Dados da Web com Web Scraping em R

# Objetivo: Acessar página do New York Times e coletar as mentiras do Trump e entregar isso de forma organizada.

# Link da Materia : https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html

############################################ T r u m p ’ s   L i e s#########################################################

setwd("C:/BigDataAnalytics_R_AzureMachineLearning/Cap07")
getwd()

# Desativar warnings

options(warn = -1)

# instalando os pacotes
install.packages("rvest")
install.packages("xml2")
library(xml2)
library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)

# Leitura da web page - Retorna em XML

webpage<-read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
webpage

# Extraindo os registros

results<-webpage %>% html_nodes(".short-desc")
results

# Construindo os datasets

records<-vector("list",length = length(results))


for (i in seq_along(results)) {
  date <- str_c(results[i] %>% 
                  html_nodes("strong") %>% 
                  html_text(trim = TRUE), ', 2017')
  
  lie <- str_sub(xml_contents(results[i])[2] %>% html_text(trim = TRUE), 2, -2)
  
  explanation <- str_sub(results[i] %>% 
                           html_nodes(".short-truth") %>% 
                           html_text(trim = TRUE), 2, -2)
  
  url <- results[i] %>% html_nodes("a") %>% html_attr("href")
  
  records[[i]] <- data_frame(date = date, lie = lie, explanation = explanation, url = url)
}

# Dataset Final

df<-bind_rows(records)

# Transformando o campo data para o formato Date em R

df$date <-mdy(df$date)

# Exportando para csv

write.csv(df, "mentiras_trump.csv")

# Lendo os dados

read_csv("mentiras_trump.csv")
View(df)



























