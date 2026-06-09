# Arquivo: 06-distribuicoes-simulacao.R
# Autor: jennifer xavier 
# Data: 19/05/2026
# Objetivos:
# 1. Compreender as distribuições Bernoulli, Binomial, Poisson e Normal
#    a partir do processo gerador dos dados.
# 2. Usar simulação em R para estudar essas distribuições em
#    cenários típicos de Administração.

# 0. Configurações globais ---------------------------------------------

options(digits = 5, scipen = 999)


# Pacotes usados -------------------------------------------------------

library(tidyverse)


# 1. Simulação Bernoulli: Lei dos Grandes Números -----------------------
# Verifica se a proporção simulada de conversões se aproxima
# da probabilidade teórica p quando o número de ensaios aumenta.

# Fixa a semente para reprodutibilidade
set.seed(1)

# Probabilidade de conversão em cada ensaio
p_conversao <- 0.08

# Simula 10.000 ensaios de Bernoulli independentes.
# Como size = 1, cada sorteio representa um único ensaio:
# 1 = houve conversão; 0 = não houve conversão.
ensaios <- rbinom(n = 10000, size = 1, prob = p_conversao)

# Monta uma tabela para comparar a proporção observada de sucessos
# com a probabilidade teórica p, usando os primeiros 100, 1.000 e
# 10.000 ensaios do mesmo experimento simulado.
tibble(
  n                     = c(100, 1000, 10000),
  proporcao_simulada    = c(
    mean(ensaios[1:100]),    # proporção observada nos 100 primeiros ensaios
    mean(ensaios[1:1000]),   # proporção observada nos 1.000 primeiros ensaios
    mean(ensaios[1:10000])   # proporção observada nos 10.000 ensaios
  ),
  probabilidade_teorica = p_conversao   # valor teórico de referência
)


# 2. Simulação binomial: conversões em e-mail marketing -----------------
# Pergunta: quais conversões semanais são plausíveis para essa campanha?

# Parâmetros do modelo:
# usamos a taxa histórica como estimativa da probabilidade p.
n_emails       <- 500     # tamanho da campanha semanal
prob_conversao <- 0.08    # estimativa de p a partir da taxa histórica
n_semanas      <- 1000    # quantas semanas simular

# Fixa a semente para reprodutibilidade
set.seed(123)

# Simula muitos cenários possíveis da campanha
conversoes <- rbinom(
  n    = n_semanas,
  size = n_emails,
  prob = prob_conversao
)

# Confere o tamanho do vetor criado
length(conversoes)

# Mostra as primeiras semanas simuladas
head(conversoes, 10)


# Centro da distribuição: número médio de conversões por semana
mean(conversoes)

# variação típica em torno da média:
# o desvio-padrão resume o quanto as semanas costumam variar
sd(conversoes)

# Intervalo que contém os 90% centrais das semanas simuladas
faixa_central_conversoes <- quantile(conversoes, c(0.05, 0.95))
faixa_central_conversoes

# Proporção de semanas com resultado abaixo de 30 conversões
prob_abaixo_30 <- mean(conversoes < 30)
prob_abaixo_30

# Proporção de semanas com pelo menos 50 conversões
prob_50_ou_mais <- mean(conversoes >= 50)
prob_50_ou_mais


# Proporção de semanas com resultado abaixo de 25 conversões
prob_abaixo_25 <- mean(conversoes < 25)
prob_abaixo_25


# 3. Simulação Poisson: atendimento em hora de pico ---------------------
# Pergunta: quais demandas por hora são plausíveis no horário de pico?

# Parâmetros do modelo
lambda     <- 25      # média de clientes por hora de pico
capacidade <- 30      # capacidade da operação por hora
n_horas    <- 10000   # quantas horas simular

# Fixa a semente para reprodutibilidade
set.seed(123)

# Simula muitos cenários possíveis de horas de pico
clientes <- rpois(
  n      = n_horas,
  lambda = lambda
)

# Inspeção rápida dos valores simulados
head(clientes, 10)
mean(clientes)   # deve ser próximo de lambda
var(clientes)    # também deve ser próximo de lambda


# Probabilidade de exceder a capacidade
prob_saturacao_atual <- mean(clientes > capacidade)
prob_saturacao_atual

# Capacidade que cobre 95% das horas
capacidade_95 <- quantile(clientes, 0.95)
capacidade_95

# Clientes excedentes esperados por hora
excedente_medio_atual <- mean(
  if_else(clientes > capacidade, clientes - capacidade, 0)
)

# exibe o resultado
excedente_medio_atual



# Capacidades que queremos comparar
capacidades <- c(25, 30, 35, 40)

# Para cada capacidade, verificamos em quais horas a demanda foi maior
# que a capacidade. A média de TRUE/FALSE dá a proporção de horas saturadas.
prob_saturacao <- c(
  mean(clientes > 25),
  mean(clientes > 30),
  mean(clientes > 35),
  mean(clientes > 40)
)

# Em cada hora, se clientes > capacidade, calculamos o excesso
# (clientes - capacidade). Caso contrário, registramos 0.
# A média desse vetor é o excedente médio por hora.
excedente_medio <- c(
  mean(if_else(clientes > 25, clientes - 25, 0)),
  mean(if_else(clientes > 30, clientes - 30, 0)),
  mean(if_else(clientes > 35, clientes - 35, 0)),
  mean(if_else(clientes > 40, clientes - 40, 0))
)

# Em cada hora, se clientes < capacidade, calculamos a capacidade ociosa
# (capacidade - clientes). Caso contrário, registramos 0.
# A média desse vetor é a ociosidade média por hora.
ociosidade_media <- c(
  mean(if_else(clientes < 25, 25 - clientes, 0)),
  mean(if_else(clientes < 30, 30 - clientes, 0)),
  mean(if_else(clientes < 35, 35 - clientes, 0)),
  mean(if_else(clientes < 40, 40 - clientes, 0))
)

# Reune os resultados em uma tabela:
# cada linha representa uma política de capacidade.
politicas_capacidade <- tibble(
  capacidade = capacidades,
  prob_saturacao = prob_saturacao,
  excedente_medio = excedente_medio,
  ociosidade_media = ociosidade_media
)

# exibe o resultado
politicas_capacidade