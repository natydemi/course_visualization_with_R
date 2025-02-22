## Verificar e instalar pacotes necessários, se não estiverem instalados
if(!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if(!requireNamespace("patchwork", quietly = TRUE)) install.packages("patchwork")
if(!requireNamespace("janitor", quietly = TRUE)) install.packages("janitor")
if(!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

# Carregar os pacotes de interesse
library(tidyverse)
library(patchwork)

#' **Objetivo:**
#' Este script tem como objetivo demonstrar as diferentes opções do argumento position no ggplot2,
#' explorar o uso do pacote patchwork para combinar múltiplos gráficos em layouts organizados e
#' apresentar funções de escalas do pacote scales aplicadas a diferentes estéticas dos gráficos.
mpg |> janitor::tabyl(fl, drv)

#alternativa: (s <- ggplot(mpg, aes(fl, fill = drv)))


# Exemplo do uso do pacote patchwork para combinar múltiplos gráficos -----

# Criando um gráfico base e armazenando na variável 's'
# O gráfico tem o eixo X representando o tipo de combustível (fl)
# e as barras preenchidas de acordo com o tipo de tração (drv)
s <- ggplot(mpg, aes(x = fl, fill = drv))
s
# Criando variações do gráfico base

# p1: Gráfico de barras padrão (posição empilhada por padrão)
# O tema é ajustado para remover a legenda
p1 <- s + geom_bar() + theme(legend.position = "none")
p1
# p2: Gráfico de barras normalizado (proporcional), usando position = "fill"
# As barras são ajustadas para representar a proporção dentro de cada categoria
p2 <- s + geom_bar(position = "fill") + theme(legend.position = "none")
p2
# p3: Gráfico de barras com barras lado a lado, usando position = "dodge"
# Cada categoria de 'drv' é exibida separadamente dentro de cada tipo de combustível
p3 <- s + geom_bar(position = "dodge")
p3

# Combinando os três gráficos usando o pacote patchwork
# O operador "+" do patchwork permite combinar múltiplos gráficos lado a lado
p1 + 
  p2 + 
  p3 +
  patchwork::plot_annotation(title = "Gráficos de Barra")  # Adiciona um título geral à composição

# Outra disposição dos gráficos usando patchwork
# (p1 + p2) são organizados lado a lado na primeira linha
# p3 é colocado abaixo, formando um layout com duas linhas
(p1 + p2) / p3  



#camada scale -----

# Criando uma tabela com a contagem de veículos por tipo de tração (drv)
mpg |> 
  janitor::tabyl(drv)   # Conta valores únicos de 'drv'

# Criando um gráfico de barras normalizado
ggplot(mpg, aes(x = fl, fill = drv)) + 
  geom_bar(position = "fill") +  # Barras empilhadas proporcionalmente
  
  scale_fill_brewer(palette = 'Dark2')+  # Definir paleta de cores
  
  scale_fill_hue(c = 30)+  # Cores com base no espectro de matiz (saturação)
  
  scale_fill_grey()+  # Escala de tons de cinza
  
  scale_fill_viridis_d(direction = -1, option = 'A') +  # Paleta Viridis (color blind-friendly)

  # scale_fill_manual(values = c("#ff4d4d", "lightblue", "yellow2"),  # Define cores "manualmente"
  #                   breaks = c('4', 'f'), na.value = 'green')  # Define cor para valores ausentes
  
  theme_light() 

#pacote scales -----

# Adicionando o uso do pacote scales para otimizar a formatação
mpg |> 
  janitor::tabyl(drv) |>  # Conta valores únicos de 'drv'
  mutate(percent = scales::percent(percent))  # Converte para formato percentual

# Adicionando a estilização do eixo y
ggplot(mpg, aes(x = fl, fill = drv)) + 
  geom_bar(position = "fill") +  # Barras empilhadas proporcionalmente
  scale_fill_viridis_d(direction = -1, option = 'A') +  # Paleta Viridis (color blind-friendly)
  theme_light() +
  scale_y_continuous(labels = scales::percent)  # Formata o eixo Y como percentual
   


