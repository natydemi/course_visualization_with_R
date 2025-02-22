## Verificar e instalar pacotes necessários, se não estiverem instalados
if(!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if(!requireNamespace("dados", quietly = TRUE)) install.packages("tidyverse")
if(!requireNamespace("patchwork", quietly = TRUE)) install.packages("patchwork")


# Carregar os pacotes de interesse
library(tidyverse)
library(dados)
library(patchwork)


mpg |> janitor::tabyl(fl, drv)

#alternativa: (s <- ggplot(mpg, aes(fl, fill = drv)))




#exemplo patchwork  -----

s <- ggplot(mpg, aes(x = fl, fill = drv))


p1 <- s + geom_bar() + theme(legend.position = "none")
#s + geom_bar(position = "stack")
p2 <- s + geom_bar(position = "fill")+ theme(legend.position = "none")
p3 <- s + geom_bar(position = "dodge") 


p1 + 
  p2 + 
  p3 +
  patchwork::plot_annotation(title = "gráficos de barra")


(p1 + p2) / p3 



#camada scale -----

mpg |> 
  janitor::tabyl(drv) |> 
  mutate(percent = scales::percent(percent))

ggplot(mpg, aes(x = fl, fill = drv)) + 
  geom_bar(position = "fill") +
  scale_fill_brewer(palette = 'Dark2')
  scale_fill_hue(c = 30)
  scale_fill_grey()
  scale_fill_viridis_d(direction = -1, option = 'A') +
  # scale_fill_manual(values = c("#ff4d4d", "lightblue", "yellow2"),
  #                   breaks = c('4', 'f'), na.value = 'green') + 
  scale_y_continuous(labels = scales::percent) +
  theme_light()
  
#pacote scales -----
  

