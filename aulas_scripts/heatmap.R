# Carregar pacotes necessários
library(ggplot2)
library(dplyr)
library(tidyr)

# Criar um conjunto de dados de exemplo com mais informações
set.seed(123) # Para reprodutibilidade
anos <- 1928:2003
semanas <- 1:52
estados <- c("ALABAMA", "ALASKA", "ARIZONA", "ARKANSAS", "CALIFORNIA", "COLORADO")

# Expandir grid para criar o dataset
dados_completo <- expand.grid(YEAR = anos, WEEK = semanas, state = estados)

# Função para gerar valores de incidência decrescentes ao longo do tempo
gerar_incidencia <- function(ano) {
  max_incidencia <- 1000
  decaimento <- (1930 - ano) / 75 # Ajustar o fator de decaimento conforme necessário
  return(runif(length(semanas) * length(estados), min = 0, max = max_incidencia * exp(decaimento)))
}

# Aplicar a função para gerar os valores de incidência
dados_completo <- dados_completo %>% 
  group_by(YEAR) %>% 
  mutate(value = gerar_incidencia(YEAR))

# Transformar os dados para o formato longo
dados_long <- dados_completo %>%
  mutate(year = factor(YEAR)) %>%
  mutate(week = factor(WEEK)) %>%
  mutate(value = as.numeric(value))

# Criar o gráfico de calor com ggplot2
p <- ggplot(dados_long, aes(x = year, y = state, fill = value)) +
  geom_tile(colour = "white", size = 0.25) +
  labs(x = "Ano", y = "Estado", title = "Exemplo com Dados Sintéticos") +
  scale_y_discrete(expand = c(0, 0)) +
  scale_x_discrete(expand = c(0, 0), breaks = seq(1930, 2000, by = 10)) +
  scale_fill_gradient(low = "yellow", high = "red", na.value = "grey90", name = "Incidência") +
  theme_grey(base_size = 8) +
  theme(
    legend.text = element_text(face = "bold"),
    axis.ticks = element_line(size = 0.4),
    plot.background = element_blank(),
    panel.border = element_blank(),
    axis.text.x = element_text(angle = 90, hjust = 1)
  )

# Mostrar o gráfico
p
