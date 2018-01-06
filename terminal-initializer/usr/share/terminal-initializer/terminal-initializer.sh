#! /bin/bash
 
# Author: Gustavo Moraes <gustavosotnas@gmail.com>
#
# This file is subject to the terms and conditions of the GNU General Public
# License. See the file COPYING in the main directory of this archive
# for more details.

APP_NAME="Terminal Initializer"
VERSION="1.1.0"
APP_AUTHOR="Copyright (C) 2014-2015 Gustavo Moraes, Pedro Henrique 
    <gustavosotnas1@gmail.com>, <pedrohenriquedrim@gmail.com>"
APP_CMD_NAME="terminal-initializer"

# Cores para o terminal
fundoCyan="\033[46;1;37m"
endCor="\033[0m"

function setText_PTBR()
{
	CMD_OF_THE_DAY_TEXT="Comando do dia"
	# Padrão de lista de ajuda: 1 TAB antes do nome da opção e 5 TAB antes da descrição da opção
	HELP_TEXT="
Uso:
	$APP_CMD_NAME
	$APP_CMD_NAME [OPÇÃO]

$APP_NAME é um pequeno programa para exibir arquivos de texto e
um \"comando do dia\" aleatoriamente no Terminal. O programa vem
por padrão com quatro exemplos de \"Tux ASCII Art\", mas serve
qualquer dica (texto) que queira mostrar ao logar no seu terminal,
até mesmo piadas.
Basta colocar algum arquivo de texto na pasta \"$APP_CMD_NAME\" 
localizada na sua pasta inicial e pronto.

Opções:
	-h, --help			Mostra esta ajuda e finaliza
	--version			Mostra informações de versão e finaliza

$APP_AUTHOR
"
	ERROR_OPTION_TEXT="Esta opção não está disponível. Use --help para ver todas as opções disponíveis."
}

function setText_ES()
{
	CMD_OF_THE_DAY_TEXT="Comando del día";
	# Padrão de lista de ajuda: 1 TAB antes do nome da opção e 5 TAB antes da descrição da opção
	HELP_TEXT="
Uso:
	$APP_CMD_NAME
	$APP_CMD_NAME [OPCIÓN]

$APP_NAME es un pequeño programa para visualizar archivos de texto y
un \"comando del día\" aleatoriamente en el Terminal. El programa viene
de fábrica con cuatro ejemplos de \"Tux arte ASCII\", pero sirve
cualquier información (texto) que desea mostrar en el log in en su
terminal, incluso chistes.
Simplemente poner algún archivo de texto en la carpeta \"$APP_CMD_NAME\"  
que se encuentra en su carpeta de inicio y listo.

Opciones:
	-h, --help			Muestra esta ayuda y finaliza
	--version			Muestra información de versión y finaliza

$APP_AUTHOR
"
	ERROR_OPTION_TEXT="Esta opción no está disponible. Use --help para ver todas las opciones disponibles."
}

function setText_EN()
{
	CMD_OF_THE_DAY_TEXT="Command of the day"
	HELP_TEXT="
Usage:
	$APP_CMD_NAME
	$APP_CMD_NAME [OPTION]

$APP_NAME is a small program to display random text files and
a \"command of the day\" in Terminal. The program comes by
default with four examples of \"Tux ASCII Art\", but serves
any hint (text) you want to show at the log in of your terminal,
even jokes. 
Just put some text file in the folder \"$APP_CMD_NAME\" 
located in your HOME folder and ready.

Options:
	-h, --help			Display this help and exit
	--version			Output version information and exit

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

function sorteiaComandoDoDia()
{
	local TODOS_COMANDOS=$(compgen -c | sort);
	local CMD_QTD_LINHAS=$(echo "$TODOS_COMANDOS" | wc -l);
	local CMD_LINHA_SORTEADA=$[RANDOM%$CMD_QTD_LINHAS+1];
	CMD_DO_DIA=$(echo "$TODOS_COMANDOS" | tail -n $CMD_LINHA_SORTEADA | head -n 1);
}

function displayCommandOfTheDay()
{
	sorteiaComandoDoDia;
	WHATIS_TMP=$(whatis -l $CMD_DO_DIA 2>/dev/null); # Caso haja mensagem no stderr, manda para o "buraco negro"
	WHATIS_RETURN_CODE=$?;

	# -5 = um " " antes, outro " " depois do texto e "..." no final
	TERM_WIDTH=$(( $(tput cols) - 5 ));

	# sed = remove "man section", " (1)" por exemplo; tail = pega apenas uma linha da string; cut = deixa String com tamanho máximo de uma linha do term.
	WHATIS_TMP2=$(echo "$WHATIS_TMP" | sed -e 's/ (.)//g' -e 's//N/g' | tail -n 1 | cut -c 1-$TERM_WIDTH);
	
	if [ ${#WHATIS_TMP2} -ge 69 ] # -ge = maior ou igual (">=")
	then
		WHATIS_CMD=$(echo ${WHATIS_TMP2}...); # imprime reticências quando o cut cortou uma String muito longa
	else
		WHATIS_CMD=$(echo $WHATIS_TMP2);
	fi
	
	if [ $WHATIS_RETURN_CODE -eq 0 ] # RETURN CODE do whatis == 0
	then
		for (( i = 0; i < ${#WHATIS_CMD}; i++ ))
		do
			WHATIS_SPACES="$WHATIS_SPACES ";
		done

		for (( i = 0; i < ${#WHATIS_CMD}-${#CMD_OF_THE_DAY_TEXT}; i++ ))
		do
			WHATIS_SPACES_INTEXT="$WHATIS_SPACES_INTEXT ";
		done
		echo -e -n "$fundoCyan";
		echo -e -n " $WHATIS_SPACES \n ";
		echo -n -e "$CMD_OF_THE_DAY_TEXT:$WHATIS_SPACES_INTEXT\n";
		echo -e -n " $WHATIS_SPACES \n ";
		echo -e -n "$WHATIS_CMD ";
		echo -e -n "\n $WHATIS_SPACES $endCor";
		echo -e "\n";
	else
		displayCommandOfTheDay; # chamada recursiva!
	fi
}

function exec_dicas()
{
	# limpa o Terminal antes de começar a imprimir
	clear;

	echo $CMD_QTD_LINHAS;
	# lista os arquivos do diretório, um arquivo por linha
	DIR_ARQUIVOS=$(ls -1 $HOME/terminal-initializer/files/);

	# conta a qtd de linhas
	QTD_LINHAS=$(echo "$DIR_ARQUIVOS" | wc -l);

	# sorteia um número aleatório limitado à quantidade de arquivos do diretório de dicas
	#O random aumenta +2 por incluir o screenfetch
	LINHA=$[RANDOM%$QTD_LINHAS+2];

	#A $LINHA+1 corresponde ao screenfetch
	if [ $LINHA == $(($QTD_LINHAS+1)) ] && [ -f /usr/bin/screenfetch ];
	then
	   screenfetch;
	else
	
       # lista novamente os arquivos, e recupera o nome do arquivo na linha sorteada
	   ARQ=$(echo "$DIR_ARQUIVOS" | tail -n $LINHA | head -n 1);

	   # lê o arquivo da dica
	   TEXTO="`cat "$HOME/terminal-initializer/files/$ARQ"`";

       # obtem as informacoes do nome da distribuição e do kernel Linux
	   DISTRIB_NOME=$(lsb_release -sd);
       KERNEL_VER=$(uname -r);

	   # substitui as palavras-chave no arquivo pelo conteúdo das variáveis
	   TEXTOA="`echo "${TEXTO//DISTRIB_NOME/$DISTRIB_NOME}"`";
	   FINAL="`echo "${TEXTOA//KERNEL_VERSAO/$KERNEL_VER}"`";

	   # mostra texto na tela
	   echo "$FINAL";

    fi

	# mostra "comando do dia"
	displayCommandOfTheDay;
	
}

###### "MAIN" ######

detectSystemLanguage;
if [ -z $* ] # se nenhum parâmetro foi passado para o programa
then
	exec_dicas; # executa a funcionalidade principal
else
	case $1 in
		"-h") displayHelp;;
		"--help") displayHelp;;
		"--version") displayVersion;;
		*) displayOptionError;;
	esac;
fi