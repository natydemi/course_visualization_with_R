## Verificar e instalar pacotes necessários, se não estiverem instalados
if(!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")

# Carregar os pacotes de interesse
library(tidyverse)

#' **Objetivo:**
#' Este script tem como objetivo apresentar algumas das 
#' camadas não-obrigatórias de um `ggplot2`, bem como algumas 
#' discussões relacionadas a como interpretar dados


# como salvar dados -----
# Este bloco demonstra como criar um objeto com um ggplot2 e 
# salva-lo como um arquivo PNG 

p1 <- mtcars |> 
  ggplot(aes(x = mpg)) +
  geom_boxplot()

p2 <- mtcars |> 
  ggplot(aes(x = mpg)) +
  geom_dotplot()

# Salvando o gráfico p1 como um arquivo PNG
ggsave("test.png", plot = p1 )
#sem a especificação do parâmetro `plot` será salvo o último gráfico


# Gráficos de distribuição -----
# Explorando gráficos para entender a distribuição dos dados.
e <- ggplot(mpg, aes(cty, hwy))
e + geom_point()

# Gráfico de boxplot e violino para comparar distribuições
f <- ggplot(mpg, aes(hwy, class))
f + 
  geom_boxplot(alpha = 0.2, width = 0.2) + 
  geom_violin(alpha = 0.4)

diamonds |> ggplot(aes(x = price, y = cut)) + geom_violin() + geom_boxplot(width = 0.1) 

# Gráfico de densidade em cristas (ridges).
ggplot(mpg, aes(hwy, class))+ 
  ggridges::geom_density_ridges_gradient()

# dica: para explorar mais sobre o theme, acesse https://ggplot2tor.com/aesthetics

# Camadas não-obrigatórias do ggplot -----

## coordinate systems -----
# Utilizando sistemas de coordenadas para ajustar a orientação do gráfico
ggplot(mpg, aes(class , hwy, color = class)) + 
  geom_boxplot() +
  coord_flip() 

## theme -----
# Personalizando o tema do gráfico
ggplot(mpg, aes(class , hwy, color = class)) + 
  geom_boxplot() +
  #theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  theme(legend.position = "left") 

# dica: para explorar mais sobre o theme, acesse https://ggplot2tor.com/theme

## labs and legends -----
# Este bloco adiciona rótulos e personaliza o tema do gráfico.
ggplot(mpg, aes(class , hwy, color = class)) + 
  geom_boxplot() +
  labs(x = "New x axis label", y = "New y axis label",
         title ="Add a title above the plot",
         subtitle = "Add a subtitle below title",
         caption = "Add a caption below plot",
         alt = "Add alt text to the plot") 

#Para mais opções de personalização dos dos eixos com o guides
ggplot(mpg, aes(class , hwy, color = class)) + 
  geom_boxplot() +
  guides(x = guide_axis(n.dodge = 2))


## zooming -----
# Como fazer zoom em partes específicas dos dados

t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t

#Com o coord_cartesian temos apenas o zoom, sem o filtro
t + coord_cartesian(ylim = c(10, 20)) + geom_smooth()

#Enquanto que com o ylim temos o zoom junto com o filtro
t + ylim(10, 20) + geom_smooth()

# Note que ao adicionar o filtro aos dados, 
# passamos a ter o mesmo geom_smooth() ajustado 
mpg |> filter(hwy > 10 , hwy < 20 ) |> ggplot(aes(cty, hwy)) + geom_point() + coord_cartesian(ylim = c(10, 20)) + geom_smooth()
mpg |> ggplot(aes(cty, hwy)) + geom_point() + ylim(10, 20) + geom_smooth()


## (carregando dados do gapminder) -----
gapminder <- dados::dados_gapminder |> glimpse()

## facet_grid -----
# Criando múltiplos painéis em uma grade.
gapminder %>% 
  ggplot(aes(x = ano, y = expectativa_de_vida, color = continente))  +
  geom_line(aes(group = pais), color = "gray") +
  geom_smooth() + 
  theme_minimal() +
  facet_grid( continente ~ .)

# O argumento labeller permite rotular os grids,
# como, por exemplo: label_value, label_both, label_parsed
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_grid(cyl ~ drv, labeller = "label_both")

# O argumento scales permite ajustar as escalas dos eixos
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_grid(cyl ~ drv, scales = "free")


## facet_wrap -----
# Similar ao facet_grid, o facet_wrap cria múltiplos painéis
# mas com uma disposição flexível.
gapminder %>% 
  ggplot(aes(x = ano, y = expectativa_de_vida, color = continente))  +
  geom_point(color = "gray") +
  geom_line(aes(group = pais), color = "gray") +
  geom_smooth() +
  facet_wrap(continente ~ . , ncol = 2)


# para casa ----- 

# Explore a versão online da cheatsheet do ggplot2
#https://rstudio.github.io/cheatsheets/html/data-visualization.html 




