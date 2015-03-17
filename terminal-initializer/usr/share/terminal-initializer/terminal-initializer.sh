#! /bin/bash
 
# Author: Gustavo Moraes <gustavosotnas@gmail.com>
#
# This file is subject to the terms and conditions of the GNU General Public
# License. See the file COPYING in the main directory of this archive
# for more details.

APP_NAME="Terminal Initializer"
VERSION="0.2.1"
APP_AUTHOR="Copyright (C) 2014-2015 Gustavo Moraes, Pedro Henrique 
    <gustavosotnas1@gmail.com>, <pedrohenriquedrim@gmail.com>"
APP_CMD_NAME="terminal-initializer"

function setText_PTBR()
{
	# Padrão de lista de ajuda: 1 TAB antes do nome da opção e 5 TAB antes da descrição da opção
	HELP_TEXT="
Uso:
	$APP_CMD_NAME
	$APP_CMD_NAME [OPÇÃO]

$APP_NAME é um pequeno programa para exibir arquivos de texto 
aleatoriamente no Terminal. O programa vem por padrão com quatro 
exemplos de \"Tux ASCII Art\", mas serve qualquer dica (texto) 
que queira mostrar ao logar no seu terminal, até mesmo piadas.
Basta colocar algum arquivo de texto na pasta \"$APP_CMD_NAME\" 
localizada na sua pasta inicial e pronto.

Opções:
	-h, --help				Mostra esta ajuda e finaliza
	--version				Mostra informações de versão e finaliza

$APP_AUTHOR
"
	ERROR_OPTION_TEXT="Esta opção não está disponível. Use --help para ver todas as opções disponíveis."
}

function detectSystemLanguage()
{
	case $LANG in
		*pt*) setText_PTBR;; # Texto do programa em português
		*) setText_PTBR;;
	esac;
}

function displayHelp()
{
	echo "$HELP_TEXT";
}

function displayVersion()
{
	echo "$APP_VERSION";
}

function displayOptionError()
{
	>&2 echo "$ERROR_OPTION_TEXT";
}

function exec_dicas()
{
	# ls → lista os arquivos do diretório, um arquivo por linha e wc -l → conta a qtd de linhas
	QTD_LINHAS=$(ls -1 $HOME/terminal-initializer/files/ | wc -l);

	# sorteia um número aleatório limitado à quantidade de arquivos do diretório de dicas
	LINHA=$[RANDOM%$QTD_LINHAS+1];

	# lista novamente os arquivos, e recupera o nome do arquivo na linha sorteada
	ARQ=$(ls -1 $HOME/terminal-initializer/files/ | tail -n $LINHA | head -n 1);

	# lê o arquivo da dica
	TEXTO="`cat "$HOME/terminal-initializer/files/$ARQ"`";

	# obtem as informacoes do nome da distribuição e do kernel Linux
	DISTRIB_NOME=$(lsb_release -sd);
	KERNEL_VER=$(uname -r);

	# substitui as palavras-chave no arquivo pelo conteúdo das variáveis
	TEXTOA="`echo "${TEXTO//DISTRIB_NOME/$DISTRIB_NOME}"`";
	FINAL="`echo "${TEXTOA//KERNEL_VERSAO/$KERNEL_VER}"`";

	# mostra na tela
	echo "$FINAL";
}

###### "MAIN" ######

if [ -z $* ] # se nenhum parâmetro foi passado para o programa
then
	exec_dicas; # executa a funcionalidade principal
else
	detectSystemLanguage;
	case $1 in
		"-h") displayHelp;;
		"--help") displayHelp;;
		"--version") displayVersion;;
		*) displayOptionError;;
	esac;
fi