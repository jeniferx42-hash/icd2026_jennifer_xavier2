# carrega os pacotes usados no script
library(here)
library(tidyverse)

# define o caminho relativo do arquivo de agências
caminho_agencias <- here::here("dados/brutos/agencias.csv")

# importa o arquivo de agências
agencias <- readr::read_csv(caminho_agencias, show_col_types = FALSE)

# define o caminho relativo do arquivo de crédito
caminho_credito <- here::here("dados/brutos/credito_trimestral.csv")

# importa o arquivo de crédito
credito <- readr::read_csv(caminho_credito, show_col_types = FALSE)

# reorganiza os trimestres em uma coluna de identificação
dados_credito_longo <- credito |>
  pivot_longer(
    cols = T1:T4,
    names_to = "trimestre",
    values_to = "volume_credito"
  )

# combina os dados de crédito com os dados das agências
dados_completos <- dados_credito_longo |>
  left_join(agencias, by = "codigo_agencia")

# define o caminho relativo do arquivo de saída
caminho_limpos <- here("dados/limpos/dados_completos_limpos.rds")

# salva a base analítica limpa para uso no relatório
write_rds(dados_completos, caminho_limpos)
