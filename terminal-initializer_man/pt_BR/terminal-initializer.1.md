terminal-initializer(1) - exibe mensagens de texto na inicialização do terminal
================================================================

<!-- Arquivo Markdown escrito para a criação do arquivo de manual (roff manpage) em Português-Brasil usando a ferramenta "ronn"
Comando para converter o .md para .1.gz (na pasta "terminal-initializer_man"):
	ronn -roff pt_BR/terminal-initializer.1.md && gzip -9 pt_BR/terminal-initializer.1 && mv ./pt_BR/terminal-initializer.1.gz ../terminal-initializer/usr/share/man/pt_BR/man1
Para pré-visualizar a página de manual usando o man, digite o comando:
	man ../terminal-initializer/usr/share/man/pt_BR/man1/terminal-initializer.1.gz
-->

## SINOPSE

terminal-initializer <br>
terminal-initializer [OPÇÃO]

## DESCRIÇÃO

**Terminal Initializer** mostra arquivos de texto aleatoriamente na inicialização de terminais BASH do Linux. Inspirado pelo `fortune`, quando o `terminal-initializer` é executado sem argumentos, ele exibe uma mensagem de texto aleatória. No entanto, o `terminal-initializer` é mais flexível que o `fortune` em adicionar arquivos de "epigrama", suporta variáveis específicas (nome do terminal e versão do Kernel do Linux) e é expansível.

O programa vem por padrão com quatro exemplos de "Tux ASCII Art", mas serve pra qualquer dica (texto) que você queira mostrar na inicialização do seu terminal, até mesmo piadas.

### Adicionando novas mensagens de texto
 * Abra a pasta "terminal-initializer", está dentro da pasta pessoal (HOME);
 * Crie um novo arquivo de texto plano na pasta "files";
 * Escreva no arquivo o que você quiser (ASCII Art, epigrama, citação, versículo da Bíblia, etc.)
 * `terminal-initializer` suporta por padrão 2 variáveis em arquivos: <br> **DISTRIB_NOME** (nome da distribuição Linux) e <br> **KERNEL_VERSAO** (versão do Kernel do Linux). Se você quer exibir essas informações no seu novo arquivo, escreva essas variáveis no arquivo.
 * Salve e feche. Na próxima execução do `terminal-initializer` o novo arquivo pode ser exibido.

## OPÇÕES
  * `-h`, `--help`:
    mostra um texto de ajuda de utilização e finaliza

  * `--version`:
    mostra informações de versão e finaliza

## RELATÓRIO DE BUGS
Informe bugs, sugira novas funcionalidades ou melhorias no GitHub: <https://github.com/gustavosotnas/terminal-initializer/issues>

## AUTORES
`Terminal Initializer` foi escrito por Gustavo Moraes e Pedro Henrique.

## COPYRIGHT
Copyright (C) 2014-2015 Gustavo Moraes, Pedro Henrique
    <<gustavosotnas1@gmail.com>>, <<pedrohenriquedrim@gmail.com>>

**Terminal Initializer** é distribuído sob os termos da GNU General Public License, versão 2 ou posterior <<http://gnu.org/licenses/gpl.html>>.
Este é um software livre: você é livre para modificá-lo e redistribuí-lo.
NÃO HÁ GARANTIA, na medida do permitido por lei.
