aula 03

Explorando diferentes tipos de gráficos
Gráficos de barras: Demonstre como criar gráficos de barras para comparar diferentes categorias ou mostrar a evolução de uma variável ao longo do tempo. Você pode usar geom_bar() ou geom_col().

Histogramas: Explique como construir histogramas para visualizar a distribuição de uma variável numérica. Use geom_histogram().

Boxplots: Mostre como criar boxplots para comparar a distribuição de uma variável numérica entre diferentes grupos. Use geom_boxplot().

Gráficos de linha: Demonstre como criar gráficos de linha para visualizar a evolução de uma variável numérica ao longo do tempo ou para mostrar a relação entre duas variáveis numéricas. Use geom_line().

na.omit(starwars) |> ggplot(aes(height, gender)) + geom_boxplot()
na.omit(starwars) |> ggplot(aes(height, gender)) + geom_violin()
na.omit(starwars) |> ggplot(aes(height, gender)) + geom_bin2d()
na.omit(starwars) |> ggplot(aes(height, gender)) + geom_violin() + geom_boxplot(width = 0.1)

ggplot2::midwest |> ggplot(aes(height, gender)) + geom_boxplot()

dplyr::storms |>  glimpse()

dplyr::storms |> ggplot(aes(wind, status)) + geom_boxplot()
dplyr::storms |> ggplot(aes(wind, status)) + geom_violin()

titanic::titanic_train |>  glimpse()

p <- titanic::titanic_train |> 
  mutate(Survived = ifelse(Survived == 1, "sim", "nao")) |> 
  ggplot(aes(Age, Survived)) 

p + geom_violin() + geom_dotplot(stackdir = "center")
p + geom_violin() + geom_boxplot(width = 0.1)
p + geom_bin2d() + geom_boxplot() 
p + geom_col() + geom_violin()
p + geom_violin() + geom_tile()


# Propondo exercício 7 ----
# Criando um gráfico de barras empilhadas para mostrar a distribuição populacional por continente em 2007
gapminder |> 
  filter(ano == 2007) |> 
  ggplot(aes(x = continente, fill = continente)) +
  geom_bar(position = "stack") +
  labs(
    title = "Distribuição Populacional por Continente em 2007",
    x = "Continente",
    y = "População",
    fill = "Continente"
  ) +
  theme_minimal()

2. Personalizando a aparência dos gráficos
Temas: Explore os diferentes temas disponíveis no ggplot2 
(ex: theme_bw(), theme_classic(), theme_minimal()) e como 
personalizá-los para deixar os gráficos mais bonitos e adequados para diferentes contextos.

Rótulos e títulos: Ensine como adicionar e personalizar rótulos nos eixos, títulos e legendas.

Cores e escalas: Explique como usar diferentes escalas de cores (ex: scale_color_brewer(), scale_fill_viridis()) e como personalizar as cores dos elementos do gráfico.



3. Adicionando anotações e informações extras
Anotações: Mostre como adicionar anotações (textos, setas, etc.) 
aos gráficos para destacar informações importantes.

Linhas e áreas: Explique como adicionar linhas horizontais ou 
verticais e áreas sombreadas para destacar regiões específicas do gráfico.

4. Interatividade
ggiraph: Introduza o pacote ggiraph para criar gráficos interativos em HTML, que podem ser explorados com o mouse.
5. Prática com um conjunto de dados diferente
Escolha um conjunto de dados interessante: Explore um conjunto de dados diferente do gapminder, que seja relevante para seus alunos. Pode ser um conjunto de dados sobre esportes, filmes, música, etc.
Desafio: Peça aos alunos para criarem diferentes tipos de gráficos com esse conjunto de dados, explorando as funcionalidades do ggplot2 que você ensinou.