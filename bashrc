#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#set editor
export EDITOR=vim

#this makes it run with 256 colors
export TERM=screen-256color-bce
#colorize ls
alias ls='ls --color=auto'

alias notifi="python ~/dotfiles/scripts/note/notifi"

#set terminal colors
export PS2="\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h\[$(tput setaf 6)\] \W \$ \[$(tput sgr0)\]"
set -o vi

export PATH="$HOME/dotfiles/scripts:$HOME/.cargo/bin:$PATH"

# if we are running on arch
if [[ -f /etc/pacman.conf ]]
then
	alias pacuar="pacaur"
	alias pacman-clean=" sudo  pacman -Rns \$(pacman -Qtdq); sudo pacman -Sc"
	alias vim="nvim"
	alias vi="/usr/bin/vim"
	alias git-shove="git add .;git commit . -m notes; git push"
fi
