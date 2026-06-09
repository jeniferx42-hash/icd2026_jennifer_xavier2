# Arquivo: revisao-probabilidade.R
# Autor: Jennifer Xavier 
# Data: 08/06/2026
# Objetivos:
# Exercícios de revisão para a avaliação 2

# Configurações globais -------------------------------------------

# exibe números sem notação científica
options(digits = 5, scipen = 999)

# Orientação:
# Nos Exercícios 1, 2 e 3, escreva as respostas como comentários.
# No Exercício 4, complete e execute o código em R.


# Exercício 1 -----------------------------------------------------
# Experimento, evento e variável aleatória

# a) S={realizou a compra, não realizou a compra}


# b) A= realizou a compra 


# c)P(A) ou P(realizou compra)


# d) Antes de definir uma variável aleatória, o resultado observado não é
# diretamente numérico.
# Ele é qualitativo/binário: compra ou não compra.
# Ele só passa a ser representado numericamente depois que definimos X.


# e) Uma variável aleatória indicadora adequada é:
# X = 1 se o cliente realiza compra;
# X = 0 se o cliente não realiza compra.
#
# Com essa definição, o evento A = {compra} também pode ser escrito
# como X = 1. Assim, P(A) = P(X = 1).


# Exercício 2 -----------------------------------------------------
# Valor esperado em uma decisão simples

# a) Valores possíveis de X:500
#                         X:0


# b) P(X = 500) = Quando a garantia é acionada (P(X=500) = 0,04$ (ou 4%))


# c) P(X = 0) =  Quando a garantia não for acionada (P(X=0) = 1 - 0,04 = 0,96)


# d) Valor esperado de X:
# E(X) = X1 * P(X = 500) + X2 * P(X = 0)
# E(X) = 500 * 0,04 + 0 * 0,96 
# E(X) = R$ 20

# e) Interpretação do valor esperado:
# O custo esperado da garantia é R$ 20 por produto vendido.
# Isso não significa que cada produto terá custo de R$ 20.
# Individualmente, o custo será R$ 0 ou R$ 500.
# O valor esperado resume o custo médio por produto quando pensamos
# em muitos produtos vendidos sob as mesmas condições.


# Exercício 3 -----------------------------------------------------
# Escolha de distribuição de probabilidade

# a) Bernoulli: há uma única observação com dois resultados possíveis
#    compra ou não compra.

# b) Binomial: conta o número de sucessos em um número fixo de tentativas
#    semelhantes, neste caso 300 clientes contatados.

# c) Poisson: conta ocorrências em um intervalo fixo de tempo,
#    neste caso o número de chegadas em uma hora de pico.

# d) Normal: variável numérica contínua, com valores aproximadamente
#    simétricos em torno de uma média.



# Exercício 4 -----------------------------------------------------
# Simulação com distribuição de Poisson
# escreva, complete e execute o código fornecido

# fixa a semente para que a simulação possa ser reproduzida 
# Exercício 4 ------------------------------------------------

# fixa a semente para reprodutibilidade
set.seed(123)

# define os parâmetros da simulação
lambda <- 12
capacidade <- 15
n_simulacoes <- 1000

# item a) simula 1.000 realizações de X
# cada valor é uma contagem de clientes em uma hora de pico
clientes <- rpois(n = n_simulacoes, lambda = lambda)
# exibe as primeiras contagens simuladas de clientes
head(clientes)

# item b) calcula a média simulada de clientes por hora de pico
media_simulada <- mean(clientes)
media_simulada


# item c) calcula a proporção de simulações em que a capacidade
# de 15 clientes foi excedida pela contagem de clientes
prop_acima_capacidade <- mean(clientes > capacidade)
prop_acima_capacidade


# item d) calcula o percentil 95 da contagem de clientes por hora de pico
percentil_95 <- quantile(clientes, 0.95)
percentil_95
 