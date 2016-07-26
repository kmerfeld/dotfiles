#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim

#this makes it run with 256 colors
export TERM="xterm-256color"
alias ls='ls --color=auto'
alias w3m='w3m duckduckgo.com'
alias notifi="python ~/dotfiles/scripts/note/notifi"
export PS2="\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h\[$(tput setaf 6)\] \W \$ \[$(tput sgr0)\]"
set -o vi
export PATH="$HOME/.cargo/bin:$PATH"

tempvarignore="$(cat /etc/*-release | grep ID_LIKE)"
if [ $tempvarignore == "ID_LIKE=\"arch\"" ]
then
	alias pacuar="pacaur"
	alias pacman-clean=" sudo  pacman -Rns $(pacman -Qtdq); sudo pacman -Sc"
	alias vim="nvim"
	export EDITOR=vim
fi
