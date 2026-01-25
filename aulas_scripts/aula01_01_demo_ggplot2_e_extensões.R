## Verificar e instalar pacotes necessários, se não estiverem instalados
if(!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if(!requireNamespace("ggridges", quietly = TRUE)) install.packages("ggridges")
if(!requireNamespace("janitor", quietly = TRUE)) install.packages("janitor")
if(!requireNamespace("GGally", quietly = TRUE)) install.packages("GGally")

# Carregar os pacotes de interesse
library(tidyverse)

#' **Objetivo:**
#' Este script tem como objetivo principal apresentar as 
#' capacidades de visualização utilizando o pacote `ggplot2` 
#' e suas extensõesde dados que podem ser alcançadas ao final do curso.



#dados -----
ggridges::lincoln_weather |> 
  skimr::skim()
  
#aplicando alguns ajustes
dados <- ggridges::lincoln_weather |> 
  janitor::clean_names() |> 
  mutate(media_temperatura_c = (mean_temperature_f - 32)/1.8) 


#ex. 1 -----
dados |> 
  ggplot(aes(
    x = media_temperatura_c, 
    y = month, 
    fill = stat(x))) + 
  ggridges::geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_fill_viridis_c(name = "Temp. [C]", option = "C") +
  coord_cartesian(clip = "off") +
  labs(title = 'Temperaturas em Lincoln (USA-NE) no ano de 2016')  +
  ggridges::theme_ridges(font_size = 13, grid = TRUE) +
  theme(axis.title.y = element_blank())


#ex. 2 -----
dados |> 
  select(where(is.numeric)) |> 
  select(contains("mean_")) |> 
  GGally::ggpairs(progress = TRUE) + 
    labs(title = 'Título')
  
