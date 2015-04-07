terminal-initializer(1) - display text messages in terminal init
================================================================

<!-- Markdown file written to creating application manual file (roff manpage) using "ronn" tool:
Command to convert "*.md" to "*.1.gz" (in the "terminal-initializer_man" folder):
	ronn -roff terminal-initializer.1.md && gzip -9 terminal-initializer.1 && mv terminal-initializer.1.gz ../terminal-initializer/usr/share/man/man1
To preview the man page using man, enter the command:
    man ../terminal-initializer/usr/share/man/man1/terminal-initializer.1.gz
-->

## SYNOPSIS

terminal-initializer <br>
terminal-initializer [OPTION]

## DESCRIPTION

**Terminal Initializer** displays random text files in the initialization of Linux BASH Terminals. Inspired by `fortune`, when `terminal-initializer` is run with no arguments, it prints out a random text message. However, `terminal-initializer` is more flexible than `fortune` in adding "epigram" files, supports specific variables (terminal name and Linux kernel version) and it's easy to expand.

The program comes by default with four examples of "Tux ASCII Art", but serves any hint (text) you want to show on initialization of your terminal, even jokes.

### Adding new text messages
 * Open "terminal-initializer" folder inside your HOME directory;
 * Create a plain-text file inside "files" folder;
 * Write in the file what do you want (ASCII Art, epigram, quote, Bible verse etc.)
 * `terminal-initializer` supports by default 2 variables in files: <br> **DISTRIB_NOME** (Linux distribution name) and <br> **KERNEL_VERSAO** (Linux kernel version). If you want to display that info in your new file, write this variables in the file.
 * Save and close. On the next `terminal-initializer` execution the new file can be displayed.

## OPTIONS
  * `-h`, `--help`:
    display a help text and exit

  * `--version`:
    output version information and exit

## REPORTING BUGS
Report bugs, suggest new features or improvements on GitHub: <https://github.com/gustavosotnas/terminal-initializer/issues>

## AUTHORS
`Terminal Initializer` was written by Gustavo Moraes and Pedro Henrique.

## COPYRIGHT
Copyright (C) 2014-2015 Gustavo Moraes, Pedro Henrique
    <<gustavosotnas1@gmail.com>>, <<pedrohenriquedrim@gmail.com>>

**Terminal Initializer** is distributed under the terms of the GNU General Public License, version 2 or later <<http://gnu.org/licenses/gpl.html>>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
