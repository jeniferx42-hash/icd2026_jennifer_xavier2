# Arquivo: 05-probabilidade.R
# Autor: jennifer xavier 
# Data: 11/05/2026
# Objetivos:
# 1. Praticar cálculos básicos de probabilidades
# 2. Praticar conceitos básicos de simulação de Monte Carlo

# Configuracoes globais -----------------------------------------------

# exibe números sem notação científica
options(digits = 5, scipen = 999)


# Pacotes usados ------------------------------------------------------

library(tidyverse)
library(probs) # instale esse pacote


# espaço amostral do lançamento de uma moeda 2 vezes
tosscoin(times = 3)