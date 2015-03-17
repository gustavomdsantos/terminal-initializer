#! /bin/bash
 
# Author: Gustavo Moraes <gustavosotnas@gmail.com>
#
# This file is subject to the terms and conditions of the GNU General Public
# License. See the file COPYING in the main directory of this archive
# for more details.

APP_NAME="Terminal Initializer"
VERSION="0.1.0"
APP_AUTHOR="Copyright (C) 2014-2015 Gustavo Moraes http://about.me/gustavosotnas"

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
