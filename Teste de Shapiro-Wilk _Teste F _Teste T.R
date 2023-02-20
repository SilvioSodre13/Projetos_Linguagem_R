# Estatístca na Pratica 2 - Big Data Analytics com R e Microsoft Azure - Data Science Academy

# Teste de Shapiro - Wilk , Teste F , Teste T

# Os pacientes foram separados em 2 grupos
# e cada grupo recebeu um medicamento diferente para tratar distúrbios no sono 
# e ajudar a aumentar o tempo dormindo.

# Objetivo : “Existe diferença significativa na média de sono dos 2 grupos de pacientes, 
# ou seja, há diferença significativa entre os dois medicamentosque ajudam no distúrbio do sono?


# Pacotes

library(car)
library(tidyverse)

# Dicionário dos dados

# Extra –Variável numérica que indica quantas horas a mais ou a menos 
# o paciente dormiu após receber o medicamento.Esta será a nossa variável dependente.

# group – Variável do tipo fator (categórica) que indica o medicamento usado pelo paciente (1 ou 2).
# Esta será a nossa variável independente.

# ID – Identificação do paciente



# Visualizando os dados 

View(sleep)


# Como são apenas dois grupos podemos aplicar o teste T para calculo das médias de cada grupo.
# Para aplicar o Teste T precisamos validar as suposições do teste T. A saber :

# 1 . Os dados são aleatórios e representativos da população; ( dados coletados por pesquisadores,
#     entende-se que foram respeitadas as boas praticas nas coletas dos dados)

# 2 . A variável dependente é continua; ( observando a coluna extra verifica-se que os dados assumem diversos valores.)

# 3 . Ambos os grupos são independentes (ou seja, exaustivos e excludentes); (  )

# 4 . Os residuos do modelo são normalmente distribuidos; e (seguem uma distribuição normal)

# 5 . A variância residual é homogênea (principio da homocestadicidade) ( As duas amostras tem a mesma variância)


# Para o estudo de caso vamos considerar como verdadeiras a  suposições de 01 a 03 e validaremos 4 e 5.
# Para suposição 04 usaremos o Teste de Shapiro-Wilk e para 05 usaremos o Teste F.



# Extraindo os dados de um dos grupos

grupo_dois = sleep$group == 2

# Validando a suposição 4 com qqplot

qqPlot(sleep$extra[grupo_dois])
qqPlot(sleep$extra[!grupo_dois]) # negação filtrara os dados do grupo 1

# Conclusão: Após o plot dos dados da variavel "extra" de ambos os grupos os pontos de dados 
# ficaram dentro da faixa sombreada (area  de confiança).
# Indicando que as variavel segue uma distribuição normal.

# Validando a suposição 4 com o teste de normalidade de shapiro.test()
# para dizer que uma distribuição é normal, o valor-p precisa ser maior que 0,05.
# H0 = Os dados seguem uma distribuição normal

shapiro.test(sleep$extra[grupo_dois]) # p-value = 0.3511 > 0.05
shapiro.test(sleep$extra[!grupo_dois]) #  p-value = 0.4079 >0.05

# O valor p-teste de cada grupo é maior que 0.05 e então falhamos em rejeitar H0.
# Podemos assumir que os dados seguem uma distribuição normal.



# Validando a Suposição 5 com teste F.

# Primeiro verificamos se há valores ausente

colSums(is.na(sleep))

# Vejamos um resumo estatítico do dataset

sleep %>% group_by(group) %>% 
  summarise(
    count = n(),
    mean = mean(extra,na.rm = TRUE),
    sd = sd(extra, na.rm = TRUE)
  )

# Para rejeitar a hipotese nula que a média dos grupos são iguais, precisamos de um valor F alto.

# H0 = As médias dos dados extraídos de uma população normalmente distribuidas tem a mesma variancia.

resultado_test_F <- var.test(extra~group, data = sleep)
resultado_test_F

# O valor-p é de 0.7427, logo, maior que 0.05. Falhamos em rejeitar H0.
# Não há variância significativa  entre as variâncias dos dois grupos.

# Suposições validadas. Agora sim podemos aplicar o teste t.

# Aplicamos o teste t para responder a questão :

# H0 - Não há diferença significativa entre as médias dos grupos.

resultado_test_t <-t.test(extra~group,data = sleep , var.equal = TRUE)
resultado_test_t



# Análise Final

# O valor-p do teste é 0.07919 maior que 0.05. Falhamos em rejeitar H0.
# Podemos concluir que os dois grupos não tem diferença significativa
# Não há diferença significativa para tratar distúrbios do sono.







































































