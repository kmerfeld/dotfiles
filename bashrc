#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim

#this makes it run with 256 colors
export TERM="xterm-256color"

alias ls='ls --color=auto'
alias w3m='w3m duckduckgo.com'
alias pacuar="pacaur"
alias notifi="python ~/dotfiles/scripts/note/notifi"
alias vim="nvim"

export PS2="\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h\[$(tput setaf 6)\] \W \$ \[$(tput sgr0)\]"
set -o vi

export PATH="$HOME/.cargo/bin:$PATH"
