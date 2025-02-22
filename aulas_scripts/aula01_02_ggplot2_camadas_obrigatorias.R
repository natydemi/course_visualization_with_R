## Verificar e instalar pacotes necessários, se não estiverem instalados
if(!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if(!requireNamespace("dados", quietly = TRUE)) install.packages("dados")
if(!requireNamespace("GGally", quietly = TRUE)) install.packages("GGally")

# Carregar os pacotes de interesse
library(tidyverse)

#' **Objetivo:**
#' Este script tem como objetivo principal apresentar as 
#' camadas obrigatórias de um `ggplot2` 


# Intro: Camadas do ggplot ---- 

# dados %>% 
#   ggplot(aesthetics()) +
#   geometries(statistics()) +
#   facets() +
#   themes() +
#   coord() +
#   scales()


#dados -----
gapminder <- dados::dados_gapminder |> glimpse()


#ex.1 -----
# Criação de um gráfico de dispersão básico
gapminder |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida))  +
  geom_point()

#note que existem as alternativas
# ggplot(data = gapminder, 
#        aes(x = pib_per_capita, y = expectativa_de_vida)) + geom_point()
# ggplot(data = gapminder, 
#        mapping = aes(x = pib_per_capita, y = expectativa_de_vida)) + geom_point()
# ggplot(gapminder, 
#        aes(x = pib_per_capita, y = expectativa_de_vida)) + geom_point()


#ex.2 -----
# Adicionando transparência e cor aos pontos, e uma linha de tendência linear
gapminder |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida))  +
  geom_point(alpha = 0.5, colour = "pink")  
  geom_smooth(method = "lm")

  
#ex.3 -----
# Colorindo os pontos por continente e adicionando uma linha de tendência
gapminder |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida, colour = continente))  +
  geom_point(alpha = 0.5) + 
  geom_smooth()

  
#ex.4 -----
# Definindo a cor dos pontos dentro de 'aes'
gapminder |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida))  +
  geom_point(aes(colour = continente), alpha = 0.5) + 
  geom_smooth()


#ex.5 -----
# Adicionando rótulos aos pontos
gapminder |> 
  filter(ano == 2007) |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida, colour = continente))  +
  geom_point(alpha = 0.5) + 
  geom_text(aes(label = pais))
  
  
#ex.6 -----
# Filtrando os dados para rotular apenas os países da Oceania
gapminder |> 
  filter(ano == 2007) |> 
  ggplot(aes(x = pib_per_capita, y = expectativa_de_vida, colour = continente))  +
  geom_point(alpha = 0.5) + 
  geom_text(data = gapminder |> 
              filter(ano == 2007) |> 
              filter(continente %in% c("Oceania")), 
            aes(label = pais))

  

# para casa: avalie este código ---- 
#' Criando um gráfico com facetas por continente, 
#' mostrando a expectativa de vida ao longo dos anos
  gapminder %>% 
    ggplot(aes(x = ano, y = expectativa_de_vida, color = continente))  +
    geom_point(color = "gray") +
    geom_line(aes(group = pais), color = "gray") +
    geom_smooth() + 
    theme_minimal() +
    facet_grid( continente ~ .)

