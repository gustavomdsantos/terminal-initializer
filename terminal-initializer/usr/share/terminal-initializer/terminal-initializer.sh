#! /bin/bash
 
# Author: Gustavo Moraes <gustavosotnas@gmail.com>
#
# This file is subject to the terms and conditions of the GNU General Public
# License. See the file COPYING in the main directory of this archive
# for more details.

APP_NAME="Terminal Initializer"
VERSION="1.0.1"
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

function setText_ES()
{
	# Padrão de lista de ajuda: 1 TAB antes do nome da opção e 5 TAB antes da descrição da opção
	HELP_TEXT="
Uso:
	$USER_INSTALL_HOME_NAME
	$USER_INSTALL_HOME_NAME [OPCIÓN]

$APP_NAME es un pequeño programa para visualizar archivos de texto 
aleatoriamente en el Terminal. El programa viene de fábrica con cuatro 
ejemplos de \"Tux arte ASCII\", pero sirve cualquier información (texto) 
que desea mostrar en el log in en su terminal, incluso chistes.
Simplemente poner algún archivo de texto en la carpeta \"$USER_INSTALL_HOME_NAME\" 
que se encuentra en su carpeta de inicio y listo.

Opciones:
	-h, --help				Muestra esta ayuda y finaliza
	--version				Muestra información de versión y finaliza

$APP_AUTHOR
"
	ERROR_OPTION_TEXT="Esta opción no está disponible. Use --help para ver todas las opciones disponibles."
}

function setText_EN()
{
	HELP_TEXT="
Usage:
	$USER_INSTALL_HOME_NAME
	$USER_INSTALL_HOME_NAME [OPTION]

$APP_NAME is a small program to display random text files 
in Terminal. The program comes by default with four 
examples of \"Tux ASCII Art\", but serves any hint (text) 
you want to show at the log in of your terminal, even jokes. 
Just put some text file in the folder \"$USER_INSTALL_HOME_NAME\" 
located in your HOME folder and ready.

Options:
	-h, --help				Display this help and exit
	--version				Output version information and exit

$APP_AUTHOR
"
	ERROR_OPTION_TEXT="This option is not available. Use --help to see all available options."
}

function detectSystemLanguage()
{
	case $LANG in
		*en*) setText_EN;;
		*es*) setText_ES;;
		*pt*) setText_PTBR;;
		*) setText_EN;;
	esac;
}

function displayHelp()
{
	echo "$HELP_TEXT";
}

function displayVersion()
{
	echo "$VERSION";
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