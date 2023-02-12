#Carregando e Analisando Dados do MySQL em R

setwd("C:/BigDataAnalytics_R_AzureMachineLearning/Cap06/32-Cap06")
getwd()


install.packages("RMySQL")
install.packages("ggplot2")
install.packages("dbplyr")

library(RMySQL)
library(ggplot2)
library(dbplyr)

con = dbConnect(MySQL(),user = "root", password = "12345", dbname = "titanicDB", host = "localhost")

# Query
qry <- "select pclass,survived,avg(age) as media_idade from titanic where survived = 1 group by pclass ,survived ;"
dbGetQuery(con , qry)

# Plot
dados <-dbGetQuery(con,qry)
head(dados)
class (dados)
ggplot(dados, aes(pclass,media_idade)) + geom_bar(stat = "identity")


#Trabalhando com R e SQLITE

install.packages("RSQLite")
library(RSQLite)

# Remove o banco SQLite, caso exista não é obrigatório
system("del.exemplo.db") # -> no Windows
#sistem("rm exemplo.db") # -> no Mac

# Criando driver e a conexão ao banco de dados
drv = dbDriver("SQLite")
con = dbConnect(drv, dbname = "exemplo.db")
dbListTables(con)

# Criando uma tabela e carregando com dados do dataset mtcars

dbWriteTable(con,"mtcars",mtcars , row.names = TRUE )

# Listando uma tabela

dbListTables(con)
dbExistsTable(con,"mtcars")
dbExistsTable(con, "mtcars2")
dbListFields(con, "mtcars")

# Lendo o conteudo da tabela

dbReadTable(con,"mtcars")

# Criando apenas a definição da tabela

dbWriteTable(con , "mtcars3", mtcars[0,],row.names = TRUE )
dbListTables(con)
dbReadTable(con,"mtcars3")


# Executando consultas no banco de dados

query = "select row_names from mtcars"
rs = dbSendQuery(con , query)
dados = fetch(rs, n= -1)
dados
class (dados)


# Execultando consultas no banco de dados

query = "select row_names from mtcars"
rs = dbSendQuery(con, query)
while (!dbHasCompleted(rs))
{ dados = fetch(rs , n=1)
  print(dados$row_names)
  }

#  Execultando consulta dos dados 

query = "select row_names, avg(hp) from mtcars group by row_names"
rs = dbSendQuery(con, query)
dados = fetch( rs, n = - 1)
dados

# Criando uma tabela a partir de um arquivo

dbWriteTable(con, "iris4","iris.csv",sep = ",",header = T)
dbListTables(con)
dbReadTable(con,"iris4")

# Encerrando a conexão

dbDisconnect(con)

# Carregando dados do banco de dados

# Criando driver e conexão ao banco de dados

drv = dbDriver("SQLite")
con = dbConnect(drv,dbname = "exemplo.db")
dbWriteTable(con,"indices","indice.csv",
             sep = "|" , header = T)

dbRemoveTable(con, "indices")

dbListTables(con)
dbReadTable(con, "indices")

df <-dbReadTable(con, "indices")
df
str(df)
sapply(df,class)

hist(df$dezembro)
df_mean <-unlist(lapply(df[,c(4,5,6,7,8)],mean))
df_mean

dbDisconnect(con)



































