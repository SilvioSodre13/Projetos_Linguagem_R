# Estudo de Caso - Limpando, Transformando e Manipulando Dados de Voos

# Dados de Voo do Aeroporto de Houston

setwd("G:/Meu Drive/R_ESTUDIO/Cap07")
getwd()

# Instalando pacote hflights(Dados de Voo de Houston)

install.packages("hflights")

library(hflights)
library (dplyr)

View(hflights)

# Criando um objeto tbl
?tbl_df

flights<-tbl_df(hflights)
flights
View(flights)

str(hflights)
glimpse(hflights)


#Visualizando como dataframe

data.frame(head(flights))

# Filtrando os dados com slice

flights[ flights$Month == 1 & flights$DayOfWeek == 1,]



# Aplicando Filter

filter(flights, Month == 1 & DayOfWeek == 1)
filter(flights, UniqueCarrier == "AA" | UniqueCarrier == "UA")
filter(flights, UniqueCarrier %in% c("AA","UA"))


# Select

select(flights,Year:DayofMonth , contains("Taxi"), contains("Delay"))


# Organizando os dados

flights %>% 
  select(UniqueCarrier,DepDelay) %>% 
  arrange(DepDelay) 
  
flights %>% 
  select(Distance, AirTime) %>% 
  mutate(Speed = Distance/AirTime*60)


head(with(flights,tapply(ArrDelay, Dest, mean, na.rm = TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))

flights %>% 
  group_by(Month,DayofMonth) %>% 
  tally(sort = TRUE)





























































