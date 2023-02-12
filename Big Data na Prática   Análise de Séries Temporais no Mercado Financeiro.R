
# Big Data na Prática :  Análise de Séries Temporais no Mercado Financeiro.
# Série Temporal é caracterizada por uma sequência de dados ao longo do tempo.

# Instalar e carregar os pacotes

install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)

# Seleção do período de Análise

startDate = as.Date("2018-01-21")
endDate = as.Date("2018-06-21")

# Download dos dados do período

getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, assign = T)

# Checando o tipo de dado retornado

class(PETR4.SA)
is.xts(PETR4.SA)

# Mostra os primeiros registros das ações da Petrobras

head(PETR4.SA)

# Analisando os dados de fechamento

PETR4.SA.Close<-PETR4.SA[ , "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)

head(Cl(PETR4.SA),4)

# Plotando o gráfico da Petrobas

candleChart(PETR4.SA)

# Plot do Fechamento

plot(PETR4.SA.Close ,main = "Fechamento Diário das Ações da Petrobras",
     col = "red", xlab = "Data", ylab = " Preço", major.ticks = "months", minor.ticks = FALSE)



# Adicionando as bandas de bollinger ao gráfico,  com média de 20 periodos e 2 desvios

# Bollinger Band
# Como o desvio Padrão  é uma medida de volatilidade,
# Bollinger Bands ajustam - se as condições do mercado.
# Mercados mais voláteis possuem as bandas mais distantes da média.
# Enquanto , mercados menos voláteis possuem as bandas mais próximas da média.

addBBands( n = 20 , sd = 2)

# Adicionando o indicador ADX , média 11 do tipo exponecial

addADX( n = 11 , maType = "EMA")

# Calculando logs diários

PETR4.SA.ret<-diff(log(PETR4.SA.Close), lag = 1)

# Remove os valores NA na posição 1

PETR4.SA.ret <-PETR4.SA.ret[-1]


# Plotar a taxa de retorno

plot(PETR4.SA.ret, main = "Fechamento Diário das Ações da Petrobras",
     col = "red", xlab = "Data", ylab = "Retorno", major.ticks = "months", minor.ticks = FALSE)

# Calculando algumas medidas estatisticas

statNames<-c("Mean", "Standard Deviation" , "Skweness"," Kurtosis")

PETR4.SA.stats<-c(mean(PETR4.SA.ret),sd(PETR4.SA.ret),skewness(PETR4.SA.ret),kurtosis(PETR4.SA.ret))

names(PETR4.SA.stats)<- statNames

PETR4.SA.stats

# Salvando os dados em um arquivo . rds (arquivo em formato binário do R)

saveRDS(PETR4.SA, file = "PETR4.SA.rds")
Ptr = readRDS("PETR4.SA.rds")
dir()
head(Ptr)

























