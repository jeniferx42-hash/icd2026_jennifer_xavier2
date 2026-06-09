# Arquivo: 04-lista-resolucao.R
# Autor(a): jennifer xavier 
# Data: 18/05/26
# Objetivo: Resolução da Lista de Exercícios 4

# Configurações globais --------------------------------------

# exibe números sem notação científica
options(digits = 5, scipen = 999)


# Pacotes usados ------------------------------------------------------

library(tidyverse)
library(probs) # instale esse pacote


# espaço amostral do lançamento de uma moeda 2 vezes
#solução exemplo 1 -  função tosscoin simula o lançamento de moedas, simula o lançamento de 3 moedas
tosscoin(times = 3)



# Exercício 2 ------------------------------------------------

# a)
# total de conjuntos diferentes de 20 números sorteados entre 100
total_resultados <- choose(100,20)
total_resultados


# b)
# resultados favoráveis: os 20 números sorteados precisam estar
# dentro dos 50 números escolhidos na aposta
resultados_favoraveis <- choose(50,20)
resultados_favoraveis


# c)
# probabilidade de acertar os 20 números
prob_acertar_20 <- resultados_favoraveis / total_resultados
prob_acertar_20

# forma alternativa de interpretação: uma chance em quantas apostas?
uma_chance_em <- 1 / 20
uma_chance_em


# d)
# Escreva sua interpretação como comentário.

#ESTA PROBABILIDADE É EXTREMANTE BAIXA, A CHANCE DE ACERTAR OS 20 NUMEROS COM UM UNICO JOGO
#É DE APENAS UMA EM CASA 11,3 MILHOES DE TENTIVAS

# Exercício 3 ------------------------------------------------

# probabilidade teórica do evento A: obter 5 ou 6
prob_teorica <- 2 / 6
prob_teorica

# resultados possíveis do dado
dado <- 1/6

# número de lançamentos
n <- 100

# fixa a semente para reprodutibilidade
set.seed(123)

# simula os lançamentos
# dica: em um dado equilibrado, todas as faces têm a mesma probabilidade
lancamentos <- sample(
  x = dado,
  size = n,
  replace = TRUE,
  prob = rep(1 / 6,6)
)

# evento A: resultado maior ou igual a 5
evento_A <- lancamentos >= 5

# número de lançamentos favoráveis ao evento A
favoraveis <- sum(evento_A)
favoraveis

# frequência relativa do evento A
freq_relativa <- mean (evento_A)
freq_relativa

# Depois de completar para n = 100, altere n para 1000 e 10000.



# Exercício 5 ------------------------------------------------


# Cálculo do valor esperado com R

# parâmetros do modelo
prob_incendio <- 0.01
indenizacao <- 150000
carregamento <- 0.25

# valor esperado de indenização por residência
valor_esperado <- prob_incendio * indenizacao

# exibe o resultado
valor_esperado

# prêmio anual por residência com acréscimo
premio <- valor_esperado * (1 + carregamento)

# exibe o resultado
premio


# a) REPRESENTA O CUSTO MÉDIO DE SINISTRO POR RESIDENCIA A LONGO PRAZO


# b) PQ A INDENIZAÇÃO É UMA VARIAVEL ALEATORIA QUE SÓ ASSUME DOIS VALORES OU O CLIENTE RECEBE R$ 1500.00
#(se incendio) OU RECEBE r$ 0 (SE NADA ACONTECER)


# c) UMA SEGURADORA REAL PRECISA CALCULAR CADA COMPONENTE DE CUSTO SEPARADAMENTE 
#ATRAVES DE NOTAS TECNICAS ATUARIAS



# Exercício 6 ------------------------------------------------

# fixa a semente para obter os mesmos resultados ao reexecutar
set.seed(2)

# tamanho da carteira de residências seguradas
n <- 100

# simula a indenização de cada residência: 0 ou valor total da indenização
indenizacoes <- sample(
  x = c(0, indenizacao),
  size = n,
  replace = TRUE,
  prob = c(1 - prob_incendio, prob_incendio)
)

# média das indenizações por residência na carteira simulada
media_indenizacoes <- mean(indenizacoes)
media_indenizacoes

# total de indenizações pagas pela seguradora
total_indenizacoes <- sum(indenizacoes)
total_indenizacoes

# total arrecadado com os prêmios cobrados
total_premios <- n * premio
total_premios

# resultado simplificado da carteira: prêmios recebidos menos indenizações pagas
resultado_carteira <- total_premios - total_indenizacoes
resultado_carteira

# Depois de completar para n = 100, altere n para 10000 e 100000.

# a) A MEDIDA QUE N AUMENTA AS OSCILAÇÕES BRUSCAS NA MEDIA DIMINUEM DRASTICAMENTE


# b) ELE TENDE A SE APROXIMAR DO VALOR ESPERADO TEORICO, QUE FOI CALCULADO NO EXERCICIO
#ANTERIOR R$ 1.500.000. VEJA COM N = 100.000 A MEDIA SIMULADA R$ 1.503.00
#FICOU QUASE IDENTICA AO VALOR TEORICO


# c) ISSO ACONTECE POR CAUSA DO PRINCIPIO ESTATISTICO CHMADO LEI DOS GRANDES NUMEROS.


# d) A LEI DOS GRANDES NUMEROS PROTEGE A SEGURADORA CONTRA DESVIOS CAUSADOS PELO PURO ACASO
#EM EVENTOS INDEPENDETES, MAS ELE NÃO ELIMINA O RISCO POR DOIS MOTIVOS PRINCIPAIS: 
#1 RISCO CORRELACIONADOS  E 2 ERRO DE MODELAGEM