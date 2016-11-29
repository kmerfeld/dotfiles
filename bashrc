#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#set editor
export EDITOR=vim

#this makes it run with 256 colors
export TERM="xterm-256color"

#colorize ls
alias ls='ls --color=auto'

alias notifi="python ~/dotfiles/scripts/note/notifi"

#set terminal colors
export PS2="\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h\[$(tput setaf 6)\] \W \$ \[$(tput sgr0)\]"
set -o vi

export PATH="$HOME/.cargo/bin:$PATH"


tempvarignore="$(cat /etc/*-release | grep ID_LIKE)"
tempvarignore2="$(cat /etc/*-release | grep DISTRIB_ID)"
if [[ $tempvarignore == "ID_LIKE=\"arch\"" ]] || [[ $tempvarignore2 -eq "DISTRUB_ID=Arch" ]]
then
	alias pacuar="pacaur"
	alias pacman-clean=" sudo  pacman -Rns $(pacman -Qtdq); sudo pacman -Sc"
	alias vim="nvim"
	alias vi="/usr/bin/vim"
fi
