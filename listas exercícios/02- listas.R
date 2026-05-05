# Arquivo: 02-lista.R
# Autor(a): jennifer xavier 
# Data: 07/04/2026
# Objetivo:
# 1. Resolver os exercícios da lista 2


# Configurações globais ---------------------------------------------------

# Configura o número de dígitos a serem exibidos
options(digits = 5, scipen = 999)

# carrega os pacotes necessários






# Exercicio 1 -------------------------------------------------------------


## a)library(here) # para usar caminhos relativos
library(tidyverse) # carrega o dplyr, readr, ggplot2, etc.
library(janitor) # para limpar os nomes das colunas


## b)importa o arquivo usando a função read_csv do pacote readr
dados_marketing <- read_csv(here("dados", "brutos", "dados-marketing.csv"))

## c)verifica a estrutura dos dados
glimpse(dados_marketing)



# Exercicio 2 -------------------------------------------------------------

## a) Cada linha do arquivo representa uma semana de observação. 
## Assim, as observações não correspondem a vendas individuais, 
## mas a registros semanais com informações sobre investimentos 
## em diferentes canais de marketing, ocorrência de promoção, atividade concorrente e receita de vendas.


## b) variáveis = 9 (colunas)
##    observação = 156 (linhas )


# Exercicio 3 -------------------------------------------------------------

## a)
dados_marketing_limpos <- clean_names(dados_marketing)



## b)
names(dados_marketing)



# Exercicio 4 -------------------------------------------------------------
dados_marketing_limpos |>
  select(data, mes,gasto_tv, gasto_radio, promocao, receita_vendas)


# Exercicio 5 -------------------------------------------------------------
dados_marketing_limpos <- dados_marketing_limpos %>%
  mutate(gasto_total = gasto_tv + gasto_radio + gasto_redes_sociais + gasto_email)
dados_marketing_limpos |>
  select(data, mes, gasto_total, receita_vendas)

View(dados_marketing_limpos)

# Exercicio 6 -------------------------------------------------------------
dados_marketing_limpos <- dados_marketing_limpos %>%
  mutate(
    # Cria status_promocao baseado em promocao (assumindo 1=Sim, 0=Não)
    status_promocao = ifelse(promocao == 1, "Com promoção", "Sem promoção"),
    
    # Cria status_concorrencia baseado em atividade_concorrente (assumindo 1=Sim, 0=Não)
    status_concorrencia = ifelse(atividade_concorrente == 1, "Com concorrência", "Sem concorrência")
  )
View(dados_marketing_limpos)



# Exercicio 7 -------------------------------------------------------------
write_rds(dados_marketing_limpos, "dados/limpos/dados_marketing_limpos.rds")
dados_verificacao <- read_rds("dados/limpos/dados_marketing_limpos.rds")
glimpse(dados_verificacao) # Mostra estrutura, tipos de dados e novas colunas
head(dados_verificacao)    # Mostra as primeiras 6 linhas


# Exercicio 8 -------------------------------------------------------------
resultado <- dados_marketing_limpos %>%
  filter(status_promocao == "Com promoção", receita_vendas > 1000) %>%
  select(data, mes, receita_vendas, status_promocao)

print(resultado)

dados_marketing_limpos %>% filter(status_promocao == "Com promoção") %>% nrow()
dados_marketing_limpos %>% filter(receita_vendas > 1000) %>% nrow()




# Exercicio 9 -------------------------------------------------------------

resumo_mensal <- dados_marketing_limpos |>
  group_by(mes) |>
  summarise(
    receita_media = mean(receita_vendas),
    receita_total = sum(receita_vendas),
    gasto_total_medio = mean(gasto_total),
    semanas_com_promocao = sum(promocao)
  ) |>
  arrange(desc(receita_media))

# mostra o resultado ordenado
resumo_mensal

# visualiza o resultado no RStudio
View(resumo_mensal)

# os tres meses com maior receita media sao:
# mes 12, mes 11 e mes 10