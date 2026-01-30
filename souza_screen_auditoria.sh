#!/bin/bash

PASTA="$1"
LIMITE_MIN=60

# CORES
VERDE="\033[1;32m"
VERMELHO="\033[1;31m"
AMARELO="\033[1;33m"
AZUL="\033[1;34m"
CIANO="\033[1;36m"
BRANCO="\033[1;37m"
RESET="\033[0m"

clear

echo -e "${VERDE}"
echo "███████╗ ██████╗ ██╗   ██╗███████╗ █████╗ "
echo "██╔════╝██╔═══██╗██║   ██║╚══███╔╝██╔══██╗"
echo "███████╗██║   ██║██║   ██║  ███╔╝ ███████║"
echo "╚════██║██║   ██║██║   ██║ ███╔╝  ██╔══██║"
echo "███████║╚██████╔╝╚██████╔╝███████╗██║  ██║"
echo "╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo -e "${RESET}"

echo -e "${CIANO}>> Souza Screen — Auditoria Técnica de Diretórios${RESET}"
echo "======================================================"

if [ -z "$PASTA" ]; then
  echo -e "${VERMELHO}[ERRO] Caminho não informado${RESET}"
  echo "Uso: bash souza_screen_auditoria.sh /caminho/da/pasta"
  exit 1
fi

# Data e hora atual
DATA_ATUAL=$(date +"%d/%m/%Y")
HORA_ATUAL=$(date +"%H:%M:%S")

# Datas da pasta
CRIACAO=$(stat -c %w "$PASTA" 2>/dev/null)
MOD_DATA=$(stat -c %y "$PASTA" 2>/dev/null | cut -d'.' -f1)
MOD_EPOCH=$(stat -c %Y "$PASTA" 2>/dev/null)
AGORA_EPOCH=$(date +%s)

if [ -z "$MOD_EPOCH" ]; then
  echo -e "${VERMELHO}[ACESSO NEGADO] Sem permissão para analisar esta pasta${RESET}"
  exit 1
fi

# Se criação não existir, marcar como indisponível
if [ "$CRIACAO" = "-" ] || [ -z "$CRIACAO" ]; then
  CRIACAO="Não disponível no Android"
fi

DIF_MIN=$(( (AGORA_EPOCH - MOD_EPOCH) / 60 ))

echo -e "${AZUL}[INFORMAÇÕES GERAIS]${RESET}"
echo -e "${BRANCO}Pasta analisada        :${RESET} $PASTA"
echo -e "${BRANCO}Data atual             :${RESET} $DATA_ATUAL"
echo -e "${BRANCO}Hora atual             :${RESET} $HORA_ATUAL"
echo "------------------------------------------------------"

echo -e "${AZUL}[REFERÊNCIA DE INSTALAÇÃO]${RESET}"
echo -e "${BRANCO}Data de criação        :${RESET} $CRIACAO"
echo -e "${AMARELO}(Usada como referência técnica de instalação)${RESET}"
echo "------------------------------------------------------"

echo -e "${AZUL}[MODIFICAÇÕES]${RESET}"
echo -e "${BRANCO}Última modificação     :${RESET} $MOD_DATA"
echo -e "${BRANCO}Diferença de tempo     :${RESET} $DIF_MIN minutos"
echo "------------------------------------------------------"

if [ "$DIF_MIN" -le "$LIMITE_MIN" ]; then
  echo -e "${VERMELHO}██████████████████████████████████████${RESET}"
  echo -e "${VERMELHO}⚠ MODIFICAÇÃO ENCONTRADA${RESET}"
  echo -e "${VERMELHO}⚠ APLIQUE O W.O${RESET}"
  echo -e "${VERMELHO}██████████████████████████████████████${RESET}"
else
  echo -e "${VERDE}[STATUS] Nenhuma modificação recente detectada${RESET}"
fi

echo "======================================================"
echo -e "${VERDE}[FINALIZADO] Auditoria concluída — Souza Screen${RESET}"
